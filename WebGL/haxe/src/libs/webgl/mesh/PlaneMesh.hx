package libs.webgl.mesh;

class PlaneMesh extends Mesh{
    override function getVertices():Array<Float> {
        return [
            0.5, 0, 0.5, 
            0.5, 0, -0.5, 
            -0.5, 0, -0.5, 
            -0.5, 0, 0.5,
        ];
    } 

    override function getIndices():Array<Int> {
        return [
            0, 1, 3, 1, 2, 3
        ];
    }

    override function getTexCoords():Array<Float> {
        return [
            1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0,
        ];
    }

    override function getNormals():Array<Float> {
        return [
            0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0,
        ];
    }
}