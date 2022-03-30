package libs.webgl.mesh;

import js.lib.Float32Array;

class Mesh{

    public var vao(default, null):Dynamic;
    public var tangents = [];
    public var bitangents = [];

    public function new() {
        createVAO();
    }

    public function createVAO(){
        calculateTangent();
        
        var gl:Dynamic = Engine.inst().gl;

        // 開始創建vao
        vao = gl.createVertexArray();
        gl.bindVertexArray(vao);

        // 開啓shader裏的attribute參數，這裏開啓的參數都是用buffer傳進來的，例如vertex, index
        var bindingInfo:Array<Dynamic> = getBindingInfo();
        
        for (index => info in bindingInfo) {
            var attriName = info[0];
            var bufferData = info[6];
            // 和BasicShader約定好了，所以就不需要從program裏面檢查
            var attriLocation = index;
            gl.enableVertexAttribArray(attriLocation);
            
            // 這裏創建的buffer是給下一個api：gl.vertexAttribPointer用，這個api會預設抓取這裏創建的buffer來用
            gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
            gl.bufferData(gl.ARRAY_BUFFER, bufferData, gl.STATIC_DRAW);
            var size = info[1]; // 2 components per iteration
            var type = info[2]; // the data is 32bit floats
            var normalize = info[3]; // don't normalize the data
            var stride = info[4]; // 0 = move forward size * sizeof(type) each iteration to get the next position
            var offset = info[5]; // start at the beginning of the buffer
            gl.vertexAttribPointer(attriLocation, size, type, normalize, stride, offset);
            gl.bindBuffer(gl.ARRAY_BUFFER, null);
        }
        gl.bindVertexArray(null);
    }

    function getBindingInfo():Array<Dynamic> {
        var gl:Dynamic = Engine.inst().gl;
        
        return [
            ['a_vertex', 3, gl.FLOAT, false, 0, 0, new Float32Array(getGLVertices())],
            ['a_texcoord', 2, gl.FLOAT, false, 0, 0, new Float32Array(getTexCoords())],
            ['a_normal', 3, gl.FLOAT, false, 0, 0, new Float32Array(getNormals())],
            ['a_tangent', 3, gl.FLOAT, false, 0, 0, new Float32Array(getTangents())],
            ['a_bitangent', 3, gl.FLOAT, false, 0, 0, new Float32Array(getBITangents())]
        ];
    }

    @:abstract function getVertices():Array<Float> {
        throw ('plz override getVertices!');
    }

    @:abstract function getIndices():Array<Int> {
        throw ('plz override getIndices!');
    }
    @:abstract function getTexCoords():Array<Float> {
        throw ('plz override getTexCoords!');
    }
    @:abstract function getNormals():Array<Float> {
        throw ('plz override getNormals!');
    }
    function getTangents():Array<Float>{
        return tangents;
    }
    function getBITangents():Array<Float>{
        return bitangents;
    }
    
    function calculateTangent(){
        tangents = [];
        bitangents = [];
        var verts:Array<Float> = getGLVertices();
        var uvs = getTexCoords();
        var triangleId:Int = 0;

        var total = verts.length;
        var step = 9;
        var i = 0;
        while(i < total) {
            triangleId = Math.floor(i / 9);
            var v0 = [verts[i], verts[i+1], verts[i+2]];
            var v1 = [verts[i+3], verts[i+4], verts[i+5]];
            var v2 = [verts[i+6], verts[i+7], verts[i+8]];
            
            var uvId = triangleId * 6;
            var uv0 = [uvs[uvId], uvs[uvId+1]];
            var uv1 = [uvs[uvId+2], uvs[uvId+3]];
            var uv2 = [uvs[uvId+4], uvs[uvId+5]];
            
            var deltaPos1 = [v1[0]-v0[0],v1[1]-v0[1],v1[2]-v0[2]];
            var deltaPos2 = [v2[0]-v0[0],v2[1]-v0[1],v2[2]-v0[2]];
            
            var deltaUv1 = [uv1[0]-uv0[0], uv1[1]-uv0[1]];
            var deltaUv2 = [uv2[0]-uv0[0], uv2[1]-uv0[1]];
            
            var r = 1.0 / (deltaUv1[0] * deltaUv2[1] - deltaUv1[1] * deltaUv2[0]);
            var tangent = [
                (deltaPos1[0] * deltaUv2[1] - deltaPos2[0] * deltaUv1[1]) * r, 
                (deltaPos1[1] * deltaUv2[1] - deltaPos2[1] * deltaUv1[1]) * r, 
                (deltaPos1[2] * deltaUv2[1] - deltaPos2[2] * deltaUv1[1]) * r
            ];
            
            var bitangent = [
                (deltaPos2[0] * deltaUv1[0] - deltaPos1[0] * deltaUv2[0]) * r, 
                (deltaPos2[1] * deltaUv1[0] - deltaPos1[1] * deltaUv2[0]) * r, 
                (deltaPos2[2] * deltaUv1[0] - deltaPos1[2] * deltaUv2[0]) * r
            ];
            
            tangents = tangents.concat(tangent);
            tangents = tangents.concat(tangent);
            tangents = tangents.concat(tangent);
            bitangents = bitangents.concat(bitangent);
            bitangents = bitangents.concat(bitangent);
            bitangents = bitangents.concat(bitangent);

            i += step;
        }
    }
    
    @:abstract public function getCount() {
        return getIndices().length;
    }

    @:abstract function getGLVertices():Array<Float> {
        return getDrawArrayData(getVertices(), 3);
    }

    function getDrawArrayData(list, count):Array<Float> {
        var ary = [];
        var indices = getIndices();
        for (index => value in indices) {
            var start = indices[index] * count;
            for (j in 0...count) {
                ary.push(list[start + j]);
            }
        }
        return ary;
    }
}