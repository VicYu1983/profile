package webgl;

class WebglMaterial {
	public final geometrys:Array<String> = [];
	public final textures:Array<String> = [];
	public final uniform:Map<String, Dynamic> = [];

	public var shaderId:Null<String> = null;

	public function new(shaderId:String) {
		this.shaderId = shaderId;
	}
}
