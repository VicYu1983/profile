package libs.webgl.component;

class CircleMoveComponent extends Component{

    public var speed:Float = 1.0;
    public var range:Float = 10.0;

    override function update(time:Float) {
        super.update(time);

        owner.transform.position.x = Math.cos(time / 1000 * speed) * range;
        owner.transform.position.z = Math.sin(time / 1000 * speed) * range;
    }
}