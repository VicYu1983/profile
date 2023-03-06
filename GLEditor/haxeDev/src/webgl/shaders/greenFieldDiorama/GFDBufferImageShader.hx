package webgl.shaders.greenFieldDiorama;

import webgl.WebglShader;

class GFDBufferImageShader extends WebglShader {
	public function new() {
		super();
	}

	override function getAttributes() {
		return ['position' => 'vec2', 'texcoord' => 'vec2', 'color' => 'vec3'];
	}

	override function getUniforms() {
		return [
			'u_matrix' => 'mat3',
			'u_modelMatrix' => 'mat3',
			'u_bufferA' => 'sampler2D',
			'u_bufferB' => 'sampler2D',
			'u_time' => 'float'
		];
	}

	override function getVertexShaderSource():String {
		return '#version 300 es

        in vec2 position;
		in vec2 texcoord;
		in vec3 color;

		uniform mat3 u_matrix;
		uniform mat3 u_modelMatrix;

		out vec2 v_texcoord;

        void main(){
			
			// 投影矩陣把y做了反向，所以這裏的y要乘上-1
            gl_Position = vec4((u_matrix * u_modelMatrix * vec3(position, 1.0)).xy  * vec2(1,-1), 0, 1);
			v_texcoord = texcoord;
        }
        ';

	};

	override function getFragmentShaderSource():String {
		return '#version 300 es
        precision highp float;

		in vec2 v_texcoord;

		uniform sampler2D u_bufferA;
		uniform sampler2D u_bufferB;
        uniform float u_time;

        out vec4 outColor;

		#define BLOOM_SIZE (0.5)
		#define BLOOM_THRESHOLD (1.01)
		#define BLOOM_RANGE (0.3)
		#define BLOOM_FRAME_BLEND (0.2)

		vec3 aces_tonemap(vec3 color){	
			mat3 m1 = mat3(
				0.59719, 0.07600, 0.02840,
				0.35458, 0.90834, 0.13383,
				0.04823, 0.01566, 0.83777
			);
			mat3 m2 = mat3(
				1.60475, -0.10208, -0.00327,
				-0.53108,  1.10813, -0.07276,
				-0.07367, -0.00605,  1.07602
			);
			vec3 v = m1 * color;    
			vec3 a = v * (v + 0.0245786) - 0.000090537;
			vec3 b = v * (0.983729 * v + 0.4329510) + 0.238081;
			return pow(clamp(m2 * (a / b), 0.0, 1.0), vec3(1.0 / 2.2));	
		}
		
		vec3 bloomTile(float lod, vec2 offset, vec2 uv)
		{
			return textureLod(u_bufferB, uv * exp2(-lod) + offset, 0.0).rgb;
		}
		
		vec3 getBloom(vec2 uv)
		{
			vec3 blur = vec3(0.0);
			vec2 lOffsetFix = vec2(0.00025, 0.0005);
			blur = pow(bloomTile(2., vec2(0.0, 0.0) + lOffsetFix, uv),vec3(2.2))       	   	+ blur;
			blur = pow(bloomTile(3., vec2(0.3, 0.0) + lOffsetFix, uv),vec3(2.2)) * 1.3        + blur;
			blur = pow(bloomTile(4., vec2(0.0, 0.3) + lOffsetFix, uv),vec3(2.2)) * 1.6        + blur;
			blur = pow(bloomTile(5., vec2(0.1, 0.3) + lOffsetFix, uv),vec3(2.2)) * 1.9 	   	+ blur;
			blur = pow(bloomTile(6., vec2(0.2, 0.3) + lOffsetFix, uv),vec3(2.2)) * 2.2 	   	+ blur;
		
			return blur * BLOOM_RANGE;
		}

        void main(){
            // 計算一個pixel的uv距離
			vec2 iResolution = vec2(1024.0, 768.0);
            vec2 fragCoord = v_texcoord * iResolution;
            float iTime = u_time * 0.0001;
            float iFrame = u_time * .1;

			vec4 col = texture(u_bufferA, v_texcoord);
			col.rgb += getBloom(v_texcoord);
    		col.rgb = aces_tonemap(col.rgb);
            outColor = vec4(col.rgb, 1.0);
        }
        ';

	}
}
