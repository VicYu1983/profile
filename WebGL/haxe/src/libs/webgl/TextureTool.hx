package libs.webgl;

import js.Browser;
import mme.math.glmatrix.Vec2;
import js.Syntax;

class TextureTool{

	public static function createDepthTexture(gl:Dynamic, width:Int = 128, height:Int = 128) {
        var texture:Dynamic = gl.createTexture();
        gl.bindTexture(gl.TEXTURE_2D, texture);
        gl.texImage2D(
            gl.TEXTURE_2D,      // target
            0,                  // mip level
            gl.DEPTH_COMPONENT32F, // internal format
            width,   // width
            height,   // height
            0,                  // border
            gl.DEPTH_COMPONENT, // format
            gl.FLOAT,           // type
            null);              // data
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.bindTexture(gl.TEXTURE_2D, null);
        return texture;
    }

	public static function createTexture(gl:Dynamic, image:Dynamic):Dynamic {
        var texture:Dynamic = gl.createTexture();
        gl.bindTexture(gl.TEXTURE_2D, texture);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
        var mipLevel = 0; // the largest mip
        var internalFormat = gl.RGBA; // format we want in the texture
        var srcFormat = gl.RGBA; // format of data we are supplying
        var srcType = gl.UNSIGNED_BYTE; // type of data we are supplying
        gl.texImage2D(gl.TEXTURE_2D, mipLevel, internalFormat, srcFormat, srcType, image);
        gl.bindTexture(gl.TEXTURE_2D, null);
        return texture;
    }

	public static function createCubeMap(gl:Dynamic, width:Int = 128, height:Int = 128, showInBrowser:Bool = false){
		function generateFace(ctx, faceColor, textColor, text) {
			var width = ctx.canvas.width;
			var height = ctx.canvas.height;
			ctx.fillStyle = faceColor;
			ctx.fillRect(0, 0, width, height);
			ctx.font = '{' + width * 0.7 + '}px sans-serif';
			ctx.textAlign = 'center';
			ctx.textBaseline = 'middle';
			ctx.fillStyle = textColor;
			ctx.fillText(text, width / 2, height / 2);
		}

		var ctx:Dynamic = Syntax.code('document.createElement("canvas").getContext("2d")');

		var texture = gl.createTexture();
		gl.bindTexture(gl.TEXTURE_CUBE_MAP, texture);

		ctx.canvas.width = width;
		ctx.canvas.height = height;

		var faceInfos = [
			{ target:gl.TEXTURE_CUBE_MAP_POSITIVE_X, faceColor: '#F00', textColor: '#0FF', text: '+X' },
			{ target:gl.TEXTURE_CUBE_MAP_NEGATIVE_X,faceColor: '#FF0', textColor: '#00F', text: '-X' },
			{ target:gl.TEXTURE_CUBE_MAP_POSITIVE_Y,faceColor: '#0F0', textColor: '#F0F', text: '+Y' },
			{ target:gl.TEXTURE_CUBE_MAP_NEGATIVE_Y,faceColor: '#0FF', textColor: '#F00', text: '-Y' },
			{ target:gl.TEXTURE_CUBE_MAP_POSITIVE_Z,faceColor: '#00F', textColor: '#FF0', text: '+Z' },
			{ target:gl.TEXTURE_CUBE_MAP_NEGATIVE_Z,faceColor: '#F0F', textColor: '#0F0', text: '-Z' },
		];
		for (index => faceInfo in faceInfos) {
			var target = faceInfo.target;
			var faceColor = faceInfo.faceColor;
			var textColor = faceInfo.textColor;
			var text = faceInfo.text;
			generateFace(ctx, faceColor, textColor, text);

			gl.texImage2D(target, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, ctx.canvas);
			
			if(showInBrowser){
				ctx.canvas.toBlob(function(blob){
					var img:Dynamic = Syntax.code('new Image();');
					img.src = Syntax.code('URL.createObjectURL')(blob);
					Browser.window.document.body.appendChild(img);
				});
			}
		}
		gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
		gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR);

		gl.bindTexture(gl.TEXTURE_CUBE_MAP, null);
		return texture;
	}

    public static function createCubeMapByURL(gl:Dynamic, width:Int = 128, height:Int = 128, posXUrl:String, negXUrl:String, posYUrl:String, negYUrl:String, posZUrl:String, negZUrl:String):Dynamic {

		var texture = gl.createTexture();
		gl.bindTexture(gl.TEXTURE_CUBE_MAP, texture);
	   
		var faceInfos:Array<Dynamic> = [
			{
				target: gl.TEXTURE_CUBE_MAP_POSITIVE_X,
				url: posXUrl,
			},
			{
				target: gl.TEXTURE_CUBE_MAP_NEGATIVE_X,
				url: negXUrl,
			},
			{
				target: gl.TEXTURE_CUBE_MAP_POSITIVE_Y,
				url: posYUrl,
			},
			{
				target: gl.TEXTURE_CUBE_MAP_NEGATIVE_Y,
				url: negYUrl,
			},
			{
				target: gl.TEXTURE_CUBE_MAP_POSITIVE_Z,
				url: posZUrl,
			},
			{
				target: gl.TEXTURE_CUBE_MAP_NEGATIVE_Z,
				url: negZUrl,
			},
		];
		for (index => faceInfo in faceInfos) {
			
			var target = faceInfo.target;
			var url = faceInfo.url;
            
			// Upload the canvas to the cubemap face.
			var level = 0;
			var internalFormat = gl.RGBA;
			var format = gl.RGBA;
			var type = gl.UNSIGNED_BYTE;
		
			// setup each face so it's immediately renderable
			gl.texImage2D(target, level, internalFormat, width, height, 0, format, type, null);
            
			// Asynchronously load an image
			var image:Dynamic = Syntax.code('new Image()');
			image.src = url;
			image.addEventListener('load', function() {
				// Now that the image has loaded make copy it to the texture.
				gl.bindTexture(gl.TEXTURE_CUBE_MAP, texture);
				gl.texImage2D(target, level, internalFormat, format, type, image);
				gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
			});
		}
		gl.generateMipmap(gl.TEXTURE_CUBE_MAP);
		gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_LINEAR);
		gl.bindTexture(gl.TEXTURE_CUBE_MAP, null);
        return texture;
	}
}