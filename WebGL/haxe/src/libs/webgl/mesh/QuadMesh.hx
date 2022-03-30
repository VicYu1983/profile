package libs.webgl.mesh;

import js.lib.Float32Array;

class QuadMesh extends Mesh{
    override function getVertices():Array<Float> {
        return [
            -1, -1,
            1, -1,
            -1,  1,
            -1,  1,
            1, -1,
            1,  1,
        ];
    } 

    override function getBindingInfo():Array<Dynamic> {
        var gl:Dynamic = Engine.inst().gl;
        
        return [
            ['a_vertex', 2, gl.FLOAT, false, 0, 0, new Float32Array(getVertices())]
        ];
    }

    override function getCount():Int {
        return getVertices().length;
    }

    override function getIndices():Array<Int> {
        return [];
    }

    override function getTexCoords():Array<Float> {
        return [];
    }
}