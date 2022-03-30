package libs.webgl.component;

import libs.webgl.material.Material;
import libs.webgl.mesh.Mesh;

class MeshRenderComponent extends Component{
    
    public var mesh:Mesh;
    public var material(default, default):Null<Material>;

    public function new(?mesh:Mesh) {
        super();
        this.mesh = mesh;
    }

    // public function set_material(material:Material) {
    //     return material;

    //     if(this.material != null){
    //         this.material.removeNode(owner);
    //     }
    //     material.pushNode(owner);
    //     return material;
    // }
}