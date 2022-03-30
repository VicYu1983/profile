package libs.webgl.component;

import mme.math.glmatrix.Mat4;

class CameraComponent extends Component{

    public var fieldOfView:Float = 40;
    // public var aspect:Float = 1;
    public var near:Float = 1;
    public var far:Float = 100;
    public var canvasWidth:Int = 512;
    public var canvasHeight:Int = 512;
    
    public function getProjectMatrix():Mat4 {
        var aspect = canvasWidth / canvasHeight;
        var radian = fieldOfView / 180 * Math.PI;
		var f = Math.tan(Math.PI * 0.5 - 0.5 * radian);
		var rangeInv = 1.0 / (near - far);
        var mat:Mat4 = Mat4.fromArray([
			f / aspect, 0, 0, 0,
			0, f, 0, 0,
			0, 0, (near + far) * rangeInv, -1,
			0, 0, near * far * rangeInv * 2, 0
		]);
        return mat;
    }
}