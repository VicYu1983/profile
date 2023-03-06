package webgl.shaders.greenFieldDiorama;

import webgl.WebglShader;

class GFDBufferBShader extends WebglShader {
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

        uniform float u_time;
		uniform sampler2D u_bufferA;
		uniform sampler2D u_bufferB;

		#define BLOOM_SIZE (0.5)
		#define BLOOM_THRESHOLD (1.01)
		#define BLOOM_RANGE (0.3)
		#define BLOOM_FRAME_BLEND (0.2)

        out vec4 outColor;
		vec3 makeBloom(float lod, vec2 offset, vec2 bCoord, vec2 aPixelSize)
		{
			offset += aPixelSize;
		
			float lodFactor = exp2(lod);
		
			vec3 bloom = vec3(0.0);
			vec2 scale = lodFactor * aPixelSize;
		
			vec2 coord = (bCoord.xy-offset)*lodFactor;
			float totalWeight = 0.0;
		
			if (any(greaterThanEqual(abs(coord - 0.5), scale + 0.5)))
				return vec3(0.0);
		
			for (int i = -3; i < 3; i++) 
			{
				for (int j = -3; j < 3; j++) 
				{
					float wg = pow(1.0-length(vec2(i,j)) * 0.125, 6.0); //* 0.125, 6.0
					vec3 lTextureColor = textureLod(u_bufferA, vec2(i,j) * scale + lodFactor * aPixelSize + coord, lod).rgb;
					lTextureColor = (any(greaterThan(lTextureColor, vec3(BLOOM_THRESHOLD)))) ? lTextureColor * BLOOM_SIZE : vec3(0.0);
					lTextureColor = pow(lTextureColor, vec3(2.2)) * wg;
					bloom = lTextureColor + bloom;
		
					totalWeight += wg;
					
				}
			}
		
			bloom /= totalWeight;
		
			return bloom;
		}

        void main(){
            // 計算一個pixel的uv距離
			vec2 iResolution = vec2(1024.0, 768.0);
            vec2 fragCoord = v_texcoord * iResolution;
            float iTime = u_time * 0.0001;
            float iFrame = u_time * .1;

			vec2 uv = fragCoord.xy / iResolution.xy;
			vec2 pixelSize = 1.0 / iResolution.xy;
			vec4 lInputColor0 = texture(u_bufferB, uv);

			vec3 lBlur  = makeBloom(2., vec2(0.0, 0.0), uv, pixelSize);
			lBlur += makeBloom(3., vec2(0.3, 0.0), uv, pixelSize);
			lBlur += makeBloom(4., vec2(0.0, 0.3), uv, pixelSize);
			lBlur += makeBloom(5., vec2(0.1, 0.3), uv, pixelSize);
			lBlur += makeBloom(6., vec2(0.2, 0.3), uv, pixelSize);

			vec4 lOutputColor = vec4(clamp(pow(lBlur, vec3(1.0 / 2.2)), vec3(0), vec3(100)), 1.0);
			outColor = mix(lInputColor0, lOutputColor, BLOOM_FRAME_BLEND); 
        }
        ';

	}
}
