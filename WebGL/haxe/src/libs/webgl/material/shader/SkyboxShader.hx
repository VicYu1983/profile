package libs.webgl.material.shader;

class SkyboxShader extends Shader{
    override function getVS():String {
        var s = "#version 300 es
        
                in vec3 a_vertex;

                uniform mat4 u_modelMat;
                uniform mat4 u_viewMat;
                uniform mat4 u_projectMat;

                out vec3 v_vertex;
                out mat4 v_mat;
                
                void main(){
                    v_vertex = a_vertex;
                    gl_Position = vec4(a_vertex.xy, -.9, 1.);

                    // 環境貼圖不需要平移，所以這裏把攝像機的坐標設爲0
                    mat4 ignoreTransformViewMat = u_viewMat;
                    ignoreTransformViewMat[3][0] = 0.0;
                    ignoreTransformViewMat[3][1] = 0.0;
                    ignoreTransformViewMat[3][2] = 0.0;

                    // 把投影空間坐標xyz為-1~1轉換囘3d坐標的矩陣
                    v_mat = ignoreTransformViewMat * inverse(u_projectMat);
                }
                ";
        return s;
    }

    override function getFS():String {
        var s = "#version 300 es
                precision highp float;
                
                in vec3 v_vertex;
                in mat4 v_mat;

                uniform samplerCube u_texture;
                
                out vec4 outColor;
                void main() {

                    vec4 t = v_mat * vec4(v_vertex, 1.0);
                    outColor = texture(u_texture, normalize(t.xyz / t.w));
                }
                ";
        return s;
    }

    override function getUniformList():Array<String> {
        return ['u_modelMat', 'u_viewMat', 'u_projectMat','u_texture'];
    }
}