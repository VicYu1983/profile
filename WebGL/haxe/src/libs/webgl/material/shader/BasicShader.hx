package libs.webgl.material.shader;

class BasicShader extends Shader{
    override function getVS():String {
        var s = "#version 300 es
        
                in vec3 a_vertex;
                in vec2 a_texcoord;
                in vec3 a_normal;
                in vec3 a_tangent;
                
                uniform mat4 u_modelMat;
                uniform mat4 u_viewMat;
                uniform mat4 u_projectMat;
                uniform vec3 u_lightWorldPos;
                uniform vec3 u_viewWorldPos;

                out vec3 v_worldNormal;
                out vec3 v_worldPos;
                out vec3 v_worldTangent;
                out vec3 v_worldBinormal;
                out vec2 v_uv;
                out vec3 v_tangent;
                out mat3 v_tangentMat;
                out vec3 v_lightDir;
                out vec3 v_viewDir;

                uniform mat4 u_lightViewMat;
                uniform mat4 u_lightProjectMat;
                out vec4 v_projectedTexcoord;
                
                void main(){
                    mat4 fixScaleMatrix = transpose(inverse(u_modelMat));
                    v_worldNormal = normalize((fixScaleMatrix * vec4(a_normal, 0)).xyz);
                    v_worldPos = (u_modelMat * vec4(a_vertex, 1)).xyz;
                    v_worldTangent = normalize((fixScaleMatrix * vec4(a_tangent, 0)).xyz);
                    v_worldBinormal = normalize(cross(v_worldNormal, v_worldTangent));
                    
                    v_uv = a_texcoord;

                    // 把物件的點坐標轉換成燈光的局部坐標，拿來檢查是否產生陰影
                    mat4 lightMvp = u_lightProjectMat * inverse(u_lightViewMat) * u_modelMat;
                    v_projectedTexcoord = lightMvp * vec4(a_vertex, 1.);
                    
                    vec3 binormal = cross(normalize(a_normal), normalize(a_tangent));
                    v_tangentMat = mat3(a_tangent, binormal, a_normal);
                    
                    vec4 localLightDir = inverse(u_modelMat) * vec4(normalize(u_lightWorldPos - v_worldPos), 0);
                    v_lightDir = inverse(v_tangentMat) * localLightDir.xyz;
                    
                    vec4 localViewDir = inverse(u_modelMat) * vec4(normalize(u_viewWorldPos - v_worldPos), 0);
                    v_viewDir = inverse(v_tangentMat) * localViewDir.xyz;
                    
                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;
                    gl_Position = mvp * vec4(a_vertex, 1.);
                }
                ";
        return s;
    }

    override function getFS():String {
        var s = "#version 300 es
                precision highp float;
                
                in vec3 v_worldNormal;
                in vec3 v_worldPos;
                in vec3 v_worldTangent;
                in vec3 v_worldBinormal;
                in vec2 v_uv;
                in vec3 v_lightDir;
                in vec3 v_viewDir;

                in vec4 v_projectedTexcoord;
                
                uniform vec3 u_lightColor;
                uniform vec3 u_lightWorldPos;
                uniform vec3 u_lightWorldDirection;
                uniform float u_lightInner;
                uniform float u_lightOuter;
                
                uniform vec3 u_viewWorldPos;
                uniform vec3 u_diffuseColor;
                uniform vec3 u_specularColor;
                uniform float u_gloss;
                uniform float u_bump;
                uniform sampler2D u_diffuseMap;
                uniform sampler2D u_normalMap;
                uniform sampler2D u_depthMap;
                
                out vec4 outColor;

                float getShadowLight(vec3 projectUv){
                    vec3 projectedDepth = texture(u_depthMap, projectUv.xy).rgb;
                    bool inRange = 
                        projectUv.x >= .0 && 
                        projectUv.x <= 1.0 &&
                        projectUv.y >= .0 &&
                        projectUv.y <= 1.0;
                    float shadowLight = (inRange && projectedDepth.r <= projectUv.z) ? 0.0 : 1.0;
                    return shadowLight;
                }

                void main() {
                    
                    vec3 worldLightDir = normalize( u_lightWorldPos - v_worldPos);
                    vec3 worldViewDir = normalize( u_viewWorldPos - v_worldPos);
                    vec3 tangentNormal = texture( u_normalMap, v_uv ).rgb;
                    tangentNormal.rg *= 2.0;
                    tangentNormal.rg -= 1.0;
                    tangentNormal.b = sqrt( 1.0 - clamp( dot( tangentNormal.xy, tangentNormal.xy ), 0., 1.));
                    tangentNormal.xy *= u_bump;
                    vec3 worldNormal = mat3(v_worldTangent, v_worldBinormal, v_worldNormal ) * tangentNormal;
                    worldNormal = normalize(worldNormal);
                    
                    float dotFromDirection = dot(worldLightDir, -normalize(u_lightWorldDirection));
                    float limitRange = u_lightOuter - u_lightInner;
                    float inLight = smoothstep(u_lightInner, u_lightOuter, dotFromDirection);
                    float light = inLight * max(0., dot(worldNormal, worldLightDir));
                    vec3 albedo = texture( u_diffuseMap, v_uv ).rgb * u_diffuseColor;
                    vec3 ambient = vec3(.0) * albedo;
                    vec3 diffuse = u_lightColor * albedo * light;
                    vec3 halfDir = normalize( worldLightDir + worldViewDir );
                    vec3 specualr = u_lightColor * u_specularColor * pow(max(0., dot(worldNormal, halfDir)), u_gloss);
                    vec3 col = ambient + diffuse + specualr;

                    vec3 projectUv = v_projectedTexcoord.xyz; // 此時拿到的投影坐標還不是-1~1
                    projectUv /= v_projectedTexcoord.w; // 把各分量除以w之後才會得到-1~1
                    projectUv *= .5; // 轉換為-0.5~0.5
                    projectUv += .5; // 轉換為0~1
                    projectUv.z += -0.005; // 做一點偏離，解決阴影痤疮（shadow acne）
                    
                    // 假的pcss
                    // float radius = smoothstep(.91, .93, projectUv.z) * 1.0 / 512.0;
                    float radius = 1.0 / 512.0;

                    // 軟陰影計算PCF
                    float factor = 0.0;
                    int calcuCount = 0;
                    for (int y = -3; y <= 3; y++ ){
                        for( int x = -3; x <= 3; x++){
                            vec3 offsets = vec3(float(x) * radius, float(y) * radius, 0.0);
                            vec3 uvc = projectUv + offsets;

                            // 得到燈光投影的深度圖，用以上得出的uv坐標
                            factor += getShadowLight(uvc);
                            calcuCount += 1;
                        }
                    }
                    factor /= float(calcuCount);
                    outColor = vec4(vec3(factor * col), 1.0);


                    // outColor = vec4(vec3(smoothstep(.91, .93, projectUv.z)), 1.0);
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat', 'u_viewWorldPos', 'u_lightViewMat', 'u_lightProjectMat', 'u_lightWorldPos', 'u_lightWorldDirection', 'u_lightOuter', 'u_lightInner', 'u_lightColor', 'u_diffuseColor', 'u_specularColor', 'u_gloss', 'u_bump', 'u_diffuseMap', 'u_normalMap', 'u_depthMap'];
    }
}