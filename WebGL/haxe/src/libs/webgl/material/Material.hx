package libs.webgl.material;

import libs.webgl.material.shader.OutlineShader;
import libs.webgl.component.MeshRenderComponent;
import libs.webgl.actor.Actor;
import haxe.Constraints.Function;
import libs.webgl.material.shader.Shader;

class Material extends AObject{

    public var textures:Array<Dynamic> = [];
    public var uniforms:Array<Dynamic> = [];
    public var nodes:Array<Actor> = [];
    public var shader(default, default):Shader;
    public var autoAssignToMeshRender:Bool = true;

    public function new(shader:Shader, name:Null<String> = null) {
        super(name);
        this.shader = shader;
    }
    public function clearTextures() {
        textures = [];
    }
    public function pushTexture(name:String, t:Dynamic, type:Dynamic ) {
        textures.push([name, t, type]);
    }
    public function pushUniform(location:Dynamic, value:Dynamic) {
        uniforms.push([location, value]);
    }

    public function clearNodes() {
        while(nodes.length > 0){
            nodes.remove(nodes[0]);
        }
    }

    public function pushNode(node:Actor){
        if(node.getComponent(MeshRenderComponent) != null){
            if(nodes.indexOf(node) == -1){
                nodes.push(node);

                if(autoAssignToMeshRender){
                    node.getComponent(MeshRenderComponent).material = this;
                }
            }
        }
    }

    public function removeNode(node:Actor) {
        if(nodes.indexOf(node) > -1){
            nodes.remove(node);
        }
    }

    public function glSetTextureAndUniform() {
        var gl = Engine.inst().gl;

        for (index => value in textures) {
            var locationKey = value[0];
            var texture = value[1];
            var type = value[2];
            var location = Reflect.field(shader.uniformKey, locationKey);
            gl.uniform1i(location, index);
            gl.activeTexture(gl.TEXTURE0 + index);
            gl.bindTexture(type, texture);
        }
        
        for (index => item in uniforms) {
            var location = Reflect.field(shader.uniformKey, item[0]);
            var value:Dynamic = item[1];
            if(Type.getClass(value) == Array){
                gl.uniform3fv(location, value);
            }else{
                gl.uniform1f(location, value);
            }
        }
    }
}