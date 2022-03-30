package libs.webgl.component;

import js.html.PaintRequestList;
import mme.math.glmatrix.Quat2;
import mme.math.glmatrix.Quat2Tools;
import mme.math.glmatrix.Quat;
import mme.math.glmatrix.Vec3Tools;
import mme.math.glmatrix.QuatTools;
import mme.math.glmatrix.Mat4Tools;
import mme.math.glmatrix.Mat4;
import mme.math.glmatrix.Vec3;

class TransformComponent extends Component{

    public var position:Vec3 = new Vec3();
    public var rotation:Vec3 = new Vec3();
    public var scale:Vec3 = new Vec3();
    public var parent(default, set):Null<TransformComponent>;

    var positionMatrix:Mat4 = new Mat4();
    var rotateMatrix:Mat4 = new Mat4();
    var scaleMatrix:Mat4 = new Mat4();
    var globalMatrix:Mat4 = new Mat4();
    var localMatrix:Mat4 = new Mat4();
    var parentMatrix:Mat4 = new Mat4();

    private var direction:Vec3 = new Vec3();
    // public var quaternion:Quat = new Quat();

    override public function new() {
        super();
        scale.x = scale.y = scale.z = 1.0;
    }

    public function set_parent(?p:TransformComponent) {

        if(p == null){
            if(parent != null){
                // back to global 
                parent = null;
            }
        }else{
            var localMat = Mat4Tools.multiply(Mat4Tools.invert(p.getMatrix()), getMatrix());
            var localPos = Mat4Tools.getTranslation(localMat);
            position.x = localPos.x;
            position.y = localPos.y;
            position.z = localPos.z;

            var euler = toEulerAngles(Mat4Tools.getRotation(localMat));
            rotation.x = euler.x;
            rotation.y = euler.y;
            rotation.z = euler.z;

            parent = p;
        }
        return p;
    }

    // function toEulerAngles(q:Quat):Vec3 {
    //     var angles = new Vec3();
    
    //     // roll (x-axis rotation)
    //     var sinr_cosp = 2 * (q.w * q.x + q.y * q.z);
    //     var cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y);
    //     angles.x = Math.atan2(sinr_cosp, cosr_cosp) / Math.PI * 180;
        
    //     // pitch (y-axis rotation)
    //     var sinp = 2 * (q.w * q.y - q.z * q.x);
    //     if (Math.abs(sinp) >= 1.0){
    //         angles.y = Math.sin(Math.PI / 2) / Math.PI * 180; // use 90 degrees if out of range
    //     }else{
    //         angles.y = Math.sin(sinp) / Math.PI * 180;
    //     }
            
    //     // yaw (z-axis rotation)
    //     var siny_cosp = 2 * (q.w * q.z + q.x * q.y);
    //     var cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z);
    //     angles.z = Math.atan2(siny_cosp, cosy_cosp) / Math.PI * 180;
    
    //     return angles;
    // }

    function toEulerAngles(q1:Quat):Vec3 {
        var angles = new Vec3();
        var test = q1.x*q1.y + q1.z*q1.w;
        if (test > 0.499) { // singularity at north pole
            angles.y = 2 * Math.atan2(q1.x,q1.w);
            angles.z = Math.PI/2;
            angles.x = 0;
            return angles;
        }
        if (test < -0.499) { // singularity at south pole
            angles.y = -2 * Math.atan2(q1.x,q1.w);
            angles.z = - Math.PI/2;
            angles.x = 0;
            return angles;
        }
        var sqx = q1.x*q1.x;
        var sqy = q1.y*q1.y;
        var sqz = q1.z*q1.z;
        angles.y = Math.atan2(2*q1.y*q1.w-2*q1.x*q1.z , 1 - 2*sqy - 2*sqz);
        angles.z = Math.asin(2*test);
        angles.x = Math.atan2(2*q1.x*q1.w-2*q1.y*q1.z , 1 - 2*sqx - 2*sqz);

        angles.x = angles.x / Math.PI * 180;
        angles.y = angles.y / Math.PI * 180;
        angles.z = angles.z / Math.PI * 180;
        return angles;
    }

    public function getLocalMatrix() {
        Mat4Tools.identity(positionMatrix);
        Mat4Tools.identity(rotateMatrix);
        Mat4Tools.identity(scaleMatrix);
        Mat4Tools.identity(localMatrix);
        
        Mat4Tools.translate(positionMatrix, position, positionMatrix);
        Mat4Tools.rotateX(rotateMatrix, rotation.x / 180 * Math.PI, rotateMatrix);
        Mat4Tools.rotateY(rotateMatrix, rotation.y / 180 * Math.PI, rotateMatrix);
        Mat4Tools.rotateZ(rotateMatrix, rotation.z / 180 * Math.PI, rotateMatrix);
        Mat4Tools.scale(scaleMatrix, scale, scaleMatrix);
        
        Mat4Tools.multiply(localMatrix, positionMatrix, localMatrix);
        Mat4Tools.multiply(localMatrix, rotateMatrix, localMatrix);
        Mat4Tools.multiply(localMatrix, scaleMatrix, localMatrix);
        return Mat4Tools.clone(localMatrix);
    }

    public function getMatrix():Mat4{
        Mat4Tools.identity(globalMatrix);
        if(parent != null){
            parentMatrix = Mat4Tools.clone(parent.getMatrix());
        }
        Mat4Tools.multiply(globalMatrix, parentMatrix, globalMatrix);
        Mat4Tools.multiply(globalMatrix, getLocalMatrix(), globalMatrix);
        return Mat4Tools.clone(globalMatrix);
    }

    // function rotationMatrixToEuler( m ) {

	// 	// assumes the upper 3x3 of m is a pure rotation matrix (i.e, unscaled)

	// 	var te = m;
	// 	var m11 = te[ 0 ], m12 = te[ 4 ], m13 = te[ 8 ];
	// 	var m21 = te[ 1 ], m22 = te[ 5 ], m23 = te[ 9 ];
	// 	var m31 = te[ 2 ], m32 = te[ 6 ], m33 = te[ 10 ];

    //     var angles = new Vec3();
	// 	angles.y = Math.asin( clamp( m13, - 1, 1 ) );
    //     if ( Math.abs( m13 ) < 0.9999999 ) {

    //         angles.x = Math.atan2( - m23, m33 );
    //         angles.z = Math.atan2( - m12, m11 );

    //     } else {

    //         angles.x = Math.atan2( m32, m22 );
    //         angles.z = 0;
    //     }

    //     angles.x = angles.x / Math.PI * 180;
    //     angles.y = angles.y / Math.PI * 180;
    //     angles.z = angles.z / Math.PI * 180;

    //     return angles;
	// }

    // public function lookAt( target:Vec3, ?up:Vec3 = null ) {
    //     var zDir = Vec3Tools.subtract(target, position);
    //     zDir = Vec3Tools.normalize(zDir);
    //     zDir = Vec3Tools.negate(zDir);

    //     var temp = ( up != null ) ? up : Vec3.Y_AXIS;
    //     var xDir = Vec3Tools.cross(temp, zDir);
    //     xDir = Vec3Tools.normalize(xDir);

    //     var yDir = Vec3Tools.cross(zDir, xDir);
    //     yDir = Vec3Tools.normalize(yDir);

    //     var mat:Mat4 = Mat4Tools.create();
    //     mat[0] = xDir.x;
    //     mat[1] = xDir.y;
    //     mat[2] = xDir.z;

    //     mat[4] = yDir.x;
    //     mat[5] = yDir.y;
    //     mat[6] = yDir.z;

    //     mat[8] = zDir.x;
    //     mat[9] = zDir.y;
    //     mat[10] = zDir.z;

    //     var euler = rotationMatrixToEuler(mat.toArray());
    //     rotation.x = euler.x;
    //     rotation.y = euler.y;
    //     rotation.z = euler.z;

    // }

    public function getForward():Vec3 {
        direction.x = globalMatrix[0];
        direction.y = globalMatrix[1];
        direction.z = globalMatrix[2];
        return direction;
    }

    public function getRight():Vec3 {
        direction.x = globalMatrix[8];
        direction.y = globalMatrix[9];
        direction.z = globalMatrix[10];
        return direction;
    }

    public function getUp():Vec3 {
        direction.x = globalMatrix[4];
        direction.y = globalMatrix[5];
        direction.z = globalMatrix[6];
        return direction;
    }

    public function getBackward() {
        getForward();
        return Vec3Tools.scale(direction, -1);
    }

    public function getLeft() {
        getRight();
        return Vec3Tools.scale(direction, -1);
    }

    public function getDown() {
        getUp();
        return Vec3Tools.scale(direction, -1);
    }


	// function clamp(m13, arg1:Int, arg2:Int):Float {
	// 	return m13;
	// }
}