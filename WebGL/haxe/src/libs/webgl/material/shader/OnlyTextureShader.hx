package libs.webgl.material.shader;

class OnlyTextureShader extends Shader{
    override function getVS():String {
        var s = "#version 300 es
        
                in vec3 a_vertex;
                in vec2 a_texcoord;
                
                uniform mat4 u_modelMat;
                uniform mat4 u_viewMat;
                uniform mat4 u_projectMat;

                out vec2 v_uv;
                
                void main(){
                    mat4 mvp = u_projectMat * inverse(u_viewMat) * u_modelMat;
                    gl_Position = mvp * vec4(a_vertex, 1.);

                    v_uv = a_texcoord;
                }
                ";
        return s;
    }

    override function getFS():String {
        var s = "#version 300 es
                precision highp float;

                in vec2 v_uv;

                uniform sampler2D u_texture;
                
                out vec4 outColor;
                void main() {
                    outColor = vec4( texture(u_texture, v_uv).rrr, 1.);
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat','u_texture'];
    }
}