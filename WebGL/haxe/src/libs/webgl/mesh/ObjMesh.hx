package libs.webgl.mesh;

class ObjMesh extends Mesh{

    var obj:Dynamic;
    public function new(obj) {
        this.obj = obj;
        super();
    }

    override function getTexCoords():Array<Float> {
        return obj.texcoord;
    }

    override function getNormals():Array<Float> {
        return obj.normal;
    }

    override function getCount():Int {
        return obj.position.length;
    }

    override function getGLVertices():Array<Float> {
        return obj.position;
    }
}