package libs.webgl.material.shader;

class ColorShader extends Shader{
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
                
                void main(){
                    mat4 fixScaleMatrix = transpose(inverse(u_modelMat));
                    v_worldNormal = normalize((fixScaleMatrix * vec4(a_normal, 0)).xyz);
                    v_worldPos = (fixScaleMatrix * vec4(a_vertex, 1)).xyz;
                    
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
                
                uniform vec3 u_lightWorldPos;
                uniform vec3 u_viewWorldPos;
                uniform vec3 u_lightColor;
                uniform vec3 u_diffuseColor;
                uniform vec3 u_specColor;
                uniform float u_gloss;
                
                out vec4 outColor;
                void main() {
                    vec3 worldLightDir = normalize( u_lightWorldPos - v_worldPos);
                    vec3 worldViewDir = normalize( u_viewWorldPos - v_worldPos);
                    vec3 worldNormal = normalize(v_worldNormal);
                    vec3 albedo = u_diffuseColor;
                    vec3 ambient = vec3(.2) * albedo;
                    vec3 diffuse = u_lightColor * albedo * max(0., dot(worldNormal, worldLightDir));
                    vec3 halfDir = normalize( worldLightDir + worldViewDir );
                    vec3 specualr = u_lightColor * u_specColor * pow(max(0., dot(worldNormal, halfDir)), u_gloss);
                    outColor = vec4(ambient + diffuse + specualr,1);
                    //outColor = vec4(u_specColor, 1.);
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat', 'u_viewWorldPos', 'u_lightWorldPos', 'u_lightColor', 'u_diffuseColor', 'u_specColor', 'u_specColor', 'u_gloss'];
    }
}