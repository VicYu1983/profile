package libs.webgl.actor;

import libs.webgl.component.Component;
import libs.webgl.component.TransformComponent;

 
class Actor extends AObject{

    private var components:Array<Component> = [];
    public var transform(default, null):TransformComponent = new TransformComponent();

    public function addComponent(component:Component) {
        if(components.indexOf(component) == -1){
            components.push(component);
            component.owner = this;
        }
    }

    public function getComponent<T>(clz:Class<T>):Null<T> {
        var ret:Null<Dynamic> = null;
        for (index => value in components) {
            if(Std.isOfType(value, clz)) {
                ret = value;
                break;
            }
        }
        return ret;
    }

    public function getComponents():Array<Component> {
        return components;
    }

    public function update(time:Float) {
        for (index => value in this.components) {
            value.update(time);
        }
    }
}