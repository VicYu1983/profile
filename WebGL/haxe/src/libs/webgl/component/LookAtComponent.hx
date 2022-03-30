package libs.webgl.component;

import mme.math.glmatrix.Mat4;
import mme.math.glmatrix.Mat4Tools;
import mme.math.glmatrix.Vec3;
import mme.math.glmatrix.Vec3Tools;
import libs.webgl.actor.Actor;

class LookAtComponent extends Component{

    public var target:Null<Actor>;

    public var upDir:Vec3 = new Vec3();

    public function new() {
        super();
        upDir.y = 1.0;
    }

    override function update(time:Float) {
        super.update(time);

        if(target != null){
            lookAt(target.transform.position, upDir);   
        }
    }

    public function lookAt( target:Vec3, ?up:Vec3 = null ) {

        var position = owner.transform.position;
        var zDir = Vec3Tools.subtract(target, position);
        zDir = Vec3Tools.normalize(zDir);
        zDir = Vec3Tools.negate(zDir);

        var temp = ( up != null ) ? up : Vec3.Y_AXIS;
        var xDir = Vec3Tools.cross(temp, zDir);
        xDir = Vec3Tools.normalize(xDir);

        var yDir = Vec3Tools.cross(zDir, xDir);
        yDir = Vec3Tools.normalize(yDir);

        var mat:Mat4 = Mat4Tools.create();
        mat[0] = xDir.x;
        mat[1] = xDir.y;
        mat[2] = xDir.z;

        mat[4] = yDir.x;
        mat[5] = yDir.y;
        mat[6] = yDir.z;

        mat[8] = zDir.x;
        mat[9] = zDir.y;
        mat[10] = zDir.z;

        var euler = rotationMatrixToEuler(mat.toArray());
        owner.transform.rotation.x = euler.x;
        owner.transform.rotation.y = euler.y;
        owner.transform.rotation.z = euler.z;
    }

    function rotationMatrixToEuler( m ) {

		// assumes the upper 3x3 of m is a pure rotation matrix (i.e, unscaled)

		var te = m;
		var m11 = te[ 0 ], m12 = te[ 4 ], m13 = te[ 8 ];
		var m21 = te[ 1 ], m22 = te[ 5 ], m23 = te[ 9 ];
		var m31 = te[ 2 ], m32 = te[ 6 ], m33 = te[ 10 ];

        var angles = new Vec3();
		angles.y = Math.asin( clamp( m13, - 1, 1 ) );
        if ( Math.abs( m13 ) < 0.9999999 ) {

            angles.x = Math.atan2( - m23, m33 );
            angles.z = Math.atan2( - m12, m11 );

        } else {

            angles.x = Math.atan2( m32, m22 );
            angles.z = 0;
        }

        angles.x = angles.x / Math.PI * 180;
        angles.y = angles.y / Math.PI * 180;
        angles.z = angles.z / Math.PI * 180;

        return angles;
	}

    function clamp(m13, arg1:Int, arg2:Int):Float {
		return m13;
	}
}