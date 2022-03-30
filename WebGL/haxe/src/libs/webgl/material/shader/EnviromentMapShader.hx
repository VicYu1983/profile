package libs.webgl.material.shader;

class EnviromentMapShader extends Shader{
    override function getVS():String {
        var s = "#version 300 es
        
                in vec3 a_vertex;
                in vec2 a_texcoord;
                in vec3 a_normal;

                uniform mat4 u_modelMat;
                uniform mat4 u_viewMat;
                uniform mat4 u_projectMat;

                out vec3 v_worldVertex;
                out vec3 v_worldNormal;
                
                void main(){
                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;
                    gl_Position = mvp * vec4(a_vertex, 1.);

                    v_worldVertex = (u_modelMat * vec4(a_vertex, 1.)).xyz;
                    v_worldNormal = mat3(u_modelMat) * a_normal;
                }
                ";
        return s;
    }

    override function getFS():String {
        var s = "#version 300 es
                precision highp float;
                
                in vec3 v_worldVertex;
                in vec3 v_worldNormal;

                uniform samplerCube u_texture;
                uniform vec3 u_viewWorldPos;
                
                out vec4 outColor;
                void main() {
                    vec3 worldNormal = normalize(v_worldNormal);
                    vec3 eyeToSurfaceDir = normalize(v_worldVertex - u_viewWorldPos);
                    vec3 direction = reflect(eyeToSurfaceDir,worldNormal);
                    outColor = texture(u_texture, normalize(direction));
                    // outColor = vec4(direction, 1.0);
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat','u_texture', 'u_viewWorldPos'];
    }
}