package libs.webgl;

class AObject{
    public var name:String;
    public function new(name:Null<String> = null) {
        this.name = (name != null) ? name : '';
    }
}