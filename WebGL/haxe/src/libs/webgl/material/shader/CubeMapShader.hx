package libs.webgl.material.shader;

class CubeMapShader extends Shader{
    override function getVS():String {
        var s = "#version 300 es
        
                in vec3 a_vertex;
                in vec2 a_texcoord;

                uniform mat4 u_modelMat;
                uniform mat4 u_viewMat;
                uniform mat4 u_projectMat;

                out vec3 v_normal;
                
                void main(){
                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;
                    gl_Position = mvp * vec4(a_vertex, 1.);

                    v_normal = normalize(a_vertex);
                }
                ";
        return s;
    }

    override function getFS():String {
        var s = "#version 300 es
                precision highp float;
                
                in vec3 v_normal;

                uniform samplerCube u_texture;
                
                out vec4 outColor;
                void main() {
                    outColor = texture(u_texture, normalize(v_normal));
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat','u_texture'];
    }
}