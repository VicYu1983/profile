package libs.webgl.actor;

import libs.webgl.mesh.CubeMesh;
import libs.webgl.component.MeshRenderComponent;
import libs.webgl.component.CameraComponent;
import libs.webgl.component.LightComponent;

class LightActor extends Actor{
    public function new(name:String) {
        super(name);
        
        addComponent(new MeshRenderComponent(Engine.inst().objMeshs[1]));
        addComponent(new CameraComponent());
        addComponent(new LightComponent());

        getComponent(CameraComponent).fieldOfView = 100.0;
    }
}