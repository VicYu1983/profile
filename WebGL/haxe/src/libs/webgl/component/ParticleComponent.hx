package libs.webgl.component;

import mme.math.glmatrix.Vec3Tools;
import mme.math.glmatrix.Vec3;

class ParticleComponent extends Component{


    var acc = new Vec3(); 
    var vel = new Vec3(); 
    var rotAcc = new Vec3(); 
    var rotVel = new Vec3(); 
    
    public function applyForce(force:Vec3) {
        Vec3Tools.add(acc, force, acc);
    }

    public function applyTorque(force:Vec3) {
        Vec3Tools.add(rotAcc, force, rotAcc);
    }

    override function update(time:Float) {
        super.update(time);

        var pos:Vec3 = owner.transform.position;
        Vec3Tools.add(vel, acc, vel);
        Vec3Tools.scale(vel, .8, vel);
        Vec3Tools.add(pos, vel, pos);
        Vec3Tools.zero(acc);

        var rot:Vec3 = owner.transform.rotation;
        Vec3Tools.add(rotVel, rotAcc, rotVel);
        Vec3Tools.scale(rotVel, .8, rotVel);
        Vec3Tools.add(rot, rotVel, rot);
        Vec3Tools.zero(rotAcc);
    }
}