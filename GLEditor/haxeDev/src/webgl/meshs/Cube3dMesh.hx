package webgl.meshs;

class Cube3dMesh extends WebglMesh {
	public function new(numInstances = 0) {
		super(numInstances);
	}

	// 0 -100.0, -100.0, 100.0,
	// 1 -100.0, 100.0, 100.0,
	// 2 -100.0, -100.0, -100.0,
	// 3 -100.0, 100.0, -100.0,
	// 4 100.0, -100.0, 100.0,
	// 5 100.0, 100.0, 100.0,
	// 6 100.0, -100.0, -100.0,
	// 7 100.0, 100.0, -100.0,
	// 0,4,1,1,4,5
	// 2,0,3,3,0,1
	// 6,2,7,7,2,3
	// 4,6,5,5,6,7
	// 0,2,4,4,2,6
	// 5,7,1,1,7,3
	override function getPosition():Array<Float> {
		return [
			-100.0, -100.0, 100.0, 100.0, -100.0, 100.0, -100.0, 100.0, 100.0, -100.0, 100.0, 100.0, 100.0, -100.0, 100.0, 100.0, 100.0, 100.0, -100.0,
			-100.0, -100.0, -100.0, -100.0, 100.0, -100.0, 100.0, -100.0, -100.0, 100.0, -100.0, -100.0, -100.0, 100.0, -100.0, 100.0, 100.0, 100.0, -100.0,
			-100.0, -100.0, -100.0, -100.0, 100.0, 100.0, -100.0, 100.0, 100.0, -100.0, -100.0, -100.0, -100.0, -100.0, 100.0, -100.0, 100.0, -100.0, 100.0,
			100.0, -100.0, -100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, -100.0, -100.0, 100.0, 100.0, -100.0, -100.0, -100.0, 100.0, -100.0,
			-100.0, -100.0, 100.0, -100.0, 100.0, 100.0, -100.0, 100.0, -100.0, -100.0, -100.0, 100.0, -100.0, -100.0, 100.0, 100.0, 100.0, 100.0, 100.0,
			-100.0, -100.0, 100.0, 100.0, -100.0, 100.0, 100.0, 100.0, 100.0, -100.0, -100.0, 100.0, -100.0
		];
	}

	override function getTexcoord():Array<Float> {
		var out = [];
		for (i in 0...6) {
			out = out.concat([
				0.0, 0.0,
				1.0, 0.0,
				0.0, 1.0,

				0.0, 1.0,
				1.0, 0.0,
				1.0, 1.0,
			]);
		}
		return out;
	}

	override function getNormal():Array<Float> {
		final normals = [];
		for (i in 0...6) {
			normals.push(0.0);
			normals.push(0.0);
			normals.push(1.0);
		}

		for (i in 0...6) {
			normals.push(-1.0);
			normals.push(0.0);
			normals.push(0.0);
		}

		for (i in 0...6) {
			normals.push(0.0);
			normals.push(0.0);
			normals.push(-1.0);
		}

		for (i in 0...6) {
			normals.push(1.0);
			normals.push(0.0);
			normals.push(0.0);
		}

		for (i in 0...6) {
			normals.push(0.0);
			normals.push(-1.0);
			normals.push(0.0);
		}

		for (i in 0...6) {
			normals.push(0.0);
			normals.push(1.0);
			normals.push(0.0);
		}

		return normals;
	}

	override function getColor():Array<Float> {
		return super.getColor();
	}

	override function is2d():Bool {
		return false;
	}
}
