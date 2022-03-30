package libs.webgl.material.shader;

class Shader extends AObject{

    public var program(default, null):Dynamic;
    public var uniformKey(default, null):Dynamic = {};
    var gl:Dynamic;
    
    public function new(name:Null<String> = null) {
        super(name);

        gl = Engine.inst().gl;
        program = gl.createProgram();
        var vertexShader = Shader.createShader(gl, gl.VERTEX_SHADER, getVS());
        var fragmentShader = Shader.createShader(gl, gl.FRAGMENT_SHADER, getFS());
        gl.attachShader(program, vertexShader);
        gl.attachShader(program, fragmentShader);
        gl.linkProgram(program);
        gl.useProgram(program);

        // 開啓shader裏的uniform參數，類似於var的參數，不被shader修改的
        // 把uniform的指標記下來，繪製前拿來賽資料用
        var uniformList = getUniformList();
        for (index => value in uniformList) {
            var uniformName = uniformList[index];
            var uniform = gl.getUniformLocation(program, uniformName);
            // 把uniform對象存下來，在繪製前塞資料
            Reflect.setField(uniformKey, uniformName, uniform);
        }
    }

    public static function createShader(gl, type, source):Dynamic {
        var shader = gl.createShader(type);
        gl.shaderSource(shader, source);
        gl.compileShader(shader);
        var success = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
        if(success) return shader;
        trace(gl.getShaderInfoLog(shader));
        gl.deleteShader(shader);
        return null;
    }

    @:abstract function getVS():String {
        throw ('plz override this function!');
    }

    @:abstract function getFS():String {
        throw ('plz override this function!');
    }

    @:abstract function getUniformList():Array<String> {
        throw ('plz override this function!');
    }
}