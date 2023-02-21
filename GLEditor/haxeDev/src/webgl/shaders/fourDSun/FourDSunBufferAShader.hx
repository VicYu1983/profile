package webgl.shaders.fourDSun;

import webgl.WebglShader;

class FourDSunBufferAShader extends WebglShader {
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

        out vec4 outColor;

        const float PI = 3.14159265359;
        const int SAMPLES = 4;        
        const float motionBlurAmount = 5.0;
        const float nearZ = 2.0;       
        const vec3 sunCol = vec3(0.9, 0.55, 0.1)*9.0;
        const vec3 subCol = vec3(0.5, 0.8, 0.9)*0.5;
        const float sunRadius = 2.0;
        const float sunExponent = -40.0;
        const float timeScale = 3.0;
        float time;

        mat2 rot(float a){
            // vec4 res = vec4(a) + PI*0.5*vec4(0,1,3,0);
            // return vec2(1,1);
            return mat2(cos(vec4(a) + PI*0.5*vec4(0,1,3,0)));
        }

        vec3 hash33(vec3 p3) {
            p3 = fract(p3 * vec3(.1031, .1030, .0973));
            p3 += dot(p3, p3.yxz+33.33);
            return fract((p3.xxy + p3.yxx)*p3.zyx);
        }
        
        vec3 hash( in vec3 center ) {
            return center + (hash33(center)-0.5) * 0.5;
        }
        
        float B2( vec2 _P ) {
            return mod( 2.0*_P.y + _P.x + 1.0, 4.0 );
        }
        
        float B8( vec2 _P ) {
            vec2	P1 = mod( _P, 2.0 );					// (P >> 0) & 1
            vec2	P2 = floor( 0.5 * mod( _P, 4.0 ) );		// (P >> 1) & 1
            vec2	P4 = floor( 0.25 * mod( _P, 8.0 ) );	// (P >> 2) & 1
            return 4.0*(4.0*B2(P1) + B2(P2)) + B2(P4);
        }
        
        vec3 voronoi( in vec3 uv, in vec3 no, inout float rough ) {
            
            vec3 center = floor(uv) + 0.5;
            vec3 bestCenterOffset = vec3(0);
            float bestDist = 9e9;
            vec3 bestCenterOffset2 = vec3(0);
            float bestDist2 = 9e9;
            
            for (float x = -0.5 ; x < 1.0 ; x+=1.0)
            for (float y = -0.5 ; y < 1.0 ; y+=1.0)
            for (float z = -0.5 ; z < 1.0 ; z+=1.0) {
                vec3 offset = vec3(x, y, z);
                vec3 newCenter = center + offset;
                vec3 newCenterOffset = hash(newCenter);
                vec3 temp = newCenterOffset - uv;
                float distSq = dot(temp, temp);
                if (distSq < bestDist) {
                    bestCenterOffset2 = bestCenterOffset;
                    bestDist2 = bestDist;
                    bestCenterOffset = newCenterOffset;
                    bestDist = distSq;
                } else if (distSq < bestDist2) {
                    bestCenterOffset2 = newCenterOffset;
                    bestDist2 = distSq;
                }
            }
            
            vec3 n1 = normalize(no + hash33(bestCenterOffset)-0.5);
            vec3 n2 = normalize(no + hash33(bestCenterOffset2)-0.5);
            float d = (sqrt(bestDist)-sqrt(bestDist2));
            float aad = 0.02;
            return mix(n1, n2, smoothstep(-aad, +aad, d*2.0));
        }
        
        float smin( float d1, float d2, float k ) {
            float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
            return mix( d2, d1, h ) - k*h*(1.0-h); 
        }
        
        float cross4D(vec4 p) {
            float aa = length(p.xy)-0.1;
            float bb = length(p.zw)-0.02;
            float cc = length(p.yw)-0.03;
            float de = smin(smin(aa, bb, 0.1), cc, 0.1)-0.03;
            return de;
        }
        
        float de4d(vec4 p) {
            p.zw *= rot(time*0.148);
            p.xz *= rot(time*0.241);
            p.wy *= rot(time*0.187);
            p.x += time*3.687;
            p.y -= time*0.37454;
            vec4 inG = (fract(p) - 0.5);
            return cross4D(inG);
        }
        
        float de(vec3 p) {
            #ifdef complex
            float d = dot(p, p);
            d = de4d(vec4(p/d, d))*d;
            #else
            vec4 pp = vec4(p, length(p));
            float d = dot(pp, pp);
            d = de4d(pp/d)*d;
            #endif
            return d;
        }
        
        vec3 getNormal(vec3 p) {
            vec3 e = vec3(0.0, 0.001, 0.0);
            return normalize(vec3(
                de(p+e.yxx)-de(p-e.yxx),
                de(p+e.xyx)-de(p-e.xyx),
                de(p+e.xxy)-de(p-e.xxy)));	
        }
        
        float DistributionGGX(vec3 N, vec3 H, float roughness) {
            float a = roughness*roughness;
            float a2 = a*a;
            float NdotH = max(dot(N, H), 0.0);
            float NdotH2 = NdotH*NdotH;
            float num = a2;
            float denom = (NdotH2 * (a2 - 1.0) + 1.0);
            denom = PI * denom * denom;
            return num / denom;
        }
        
        float GeometrySchlickGGX(float NdotV, float roughness) {
            float r = (roughness + 1.0);
            float k = (r*r) / 8.0;
            float num = NdotV;
            float denom = NdotV * (1.0 - k) + k;
            return num / denom;
        }
        
        float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness) {
            float NdotV = max(dot(N, V), 0.0);
            float NdotL = max(dot(N, L), 0.0);
            float ggx2 = GeometrySchlickGGX(NdotV, roughness);
            float ggx1 = GeometrySchlickGGX(NdotL, roughness);
            return ggx1 * ggx2;
        }
        
        vec3 fresnelSchlick(float cosTheta, vec3 F0) {
            return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
        }
        
        vec3 computeLighting(in vec3 normal, in vec3 viewDir,
                             in vec3 albedo, in float metallic, in float roughness,
                             in vec3 lightDir, in vec3 radiance) {
            vec3 result = vec3(0);
            vec3 halfwayDir = normalize(viewDir + lightDir);
            vec3 F0 = vec3(0.04);
            F0 = mix(F0, albedo, metallic);
            float NDF = DistributionGGX(normal, halfwayDir, roughness);
            float G = GeometrySmith(normal, viewDir, lightDir, roughness);
            vec3 F = fresnelSchlick(max(dot(halfwayDir, viewDir), 0.0), F0);
            vec3 kS = F;
            vec3 kD = 1.0 - kS;
            kD *= 1.0 - metallic;
            vec3 numerator = NDF * G * F;
            float denominator = 4.0 * max(dot(normal, viewDir), 0.0) * max(dot(normal, lightDir), 0.0);
            vec3 specular = numerator / max(denominator, 0.001);
            float NdotL = max(dot(normal, lightDir), 0.0);
            result += (kD * albedo / PI + specular) * radiance * NdotL;
            return result;
        }
        
        // fake subsurface scattering
        vec3 computeSSS(in vec3 normal, in vec3 viewDir, 
                        in vec3 albedo, in float trans, in float index,
                        in vec3 lightDir, in vec3 radiance) {
            float add = 1.0 - index;
            add *= add;
            add *= add;
            add *= add;
            add *= add;
            float fr = dot(viewDir, normal)*0.5+0.5;
            float lu = dot(viewDir, lightDir)*-0.5+0.5;
            add *= fr*fr;
            add *= lu;
            return radiance*add*1.0*trans*albedo;
        }
        
        // approximation of the error function
        float erf( in float x ) {
            //return tanh(1.202760580 * x);
            float sign_x = sign(x);
            float t = 1.0/(1.0 + 0.47047*abs(x));
            float result = 1.0 - t*(0.3480242 + t*(-0.0958798 + t*0.7478556))*exp(-(x*x));
            return result * sign_x;
        }
        
        float getIntegral(vec3 start, vec3 dir, float dist) {
            const float a = sunExponent;
            const float b = sunRadius;
            float k = start.x;
            float l = dir.x;
            float m = start.y;
            float n = dir.y;
            float o = start.z;
            float p = dir.z;
            float res = sqrt(PI);
            res *= exp(b+a*(+k*k*(n*n+p*p)
                            -m*m*(-1.0+n*n)
                            -o*o*(-1.0+p*p)
                            -2.0*k*l*o*p
                            -2.0*m*n*(k*l+o*p) ));
            res *= - erf(sqrt(-a)*dot(start, dir)) + erf(sqrt(-a)*(dot(start, dir)+dist));
            res /= 2.0 * sqrt(-a);
            res *= 500.0;
            return res;
        }

        void main(){
            // 計算一個pixel的uv距離
			vec2 iResolution = vec2(1024.0, 768.0);
            vec2 fragCoord = v_texcoord * iResolution;
            float iTime = u_time * 0.0001;
            float iFrame = u_time * .1;

            

            vec3 acc = vec3(0);
    
            for (int i = min(0, int(iFrame)) ; i < SAMPLES ; i++) {
                
                float bay = B8(floor(fragCoord))/64.0;
                
                // #if SAMPLES > 1
                vec3 rnd = hash33(vec3(fragCoord, int(iFrame)*SAMPLES+i));
                bay = rnd.z;
                // #endif
                
                time = (iTime + (1.0/120.0)*bay*motionBlurAmount)*timeScale;
        
                vec2 uv = (fragCoord - iResolution.xy * 0.5) / iResolution.y;
                // #if SAMPLES > 1
                uv += (rnd.xy-0.5) / iResolution.y;
                // #endif
                
                vec3 from = vec3(0, 0, -1.4);
                vec3 dir = normalize(vec3(uv*0.5, 1.0));
                
                mat2 rotxz = rot(time*0.3);
                mat2 rotxy = rot(sin(time*0.1));
                // if (iMouse.z > 0.5) {
                //     vec2 delt = iMouse.xy-iMouse.zw;
                //     rotxz *= rot(-delt.x*0.01);
                //     rotxy *= rot(delt.y*0.01);
                // }
                
                from.zy *= rotxy;
                from.xz *= rotxz;
                dir.zy  *= rotxy;
                dir.xz  *= rotxz;
        
                float totdist = 0.0;
                totdist += (0.1+pow(bay, 0.2)*0.4)*nearZ;
                totdist += de(from+dir*totdist)*bay;
        
                float ao = 0.0;
                for (int steps = min(0, int(iFrame)) ; steps < 150 ; steps++) {
                    vec3 p = from + totdist * dir;
                    float dist = de(p);
                    totdist += dist*(0.65+bay*0.1);
                    if (dist < 0.0001 || length(p) > 1.4) {
                        ao = float(steps)/149.0;
                        break;
                    }
                }
        
                vec3 result = vec3(0);
                vec3 p = from + totdist * dir;
        
                if (length(p) < 1.4) {
        
                    vec3 n = -getNormal(p);
        
                    vec3 sunDir = normalize(p);
                    const vec3 subDir = normalize(vec3(2, -7, 3));
        
                    float rough = 0.0;
                    vec3 vor = voronoi(p*600.0, n, rough);
                    n = normalize(n+vor*0.5);
        
                    vec4 albedo = vec4(0.98, 0.8, 0.5, 0.4);
        
                    result += computeLighting(n, dir, albedo.rgb, 0.9, albedo.a, sunDir, sunCol);
                    result += computeLighting(n, dir, albedo.rgb, 0.9, albedo.a, subDir, subCol);
                    result += computeSSS(n, dir, albedo.rgb, albedo.a, ao, sunDir, sunCol);
                    result += computeSSS(n, dir, albedo.rgb, albedo.a, ao, subDir, subCol);
        
                } else {
        
                    // background
                    float rough = 0.0;
                    vec3 vor = voronoi(dir*800.0, vec3(0), rough);
                    result = vec3(pow(abs(vor.x), 500.0))*3.0;
        
                }
        
                outColor.rgb = result;
                float sun = getIntegral(from, dir, totdist);
                outColor.rgb += sun*0.005*sunCol;
                
                acc += outColor.rgb;
                
            }
            
            acc /= float(SAMPLES);
            outColor.rgb = clamp(acc, vec3(0), vec3(10));
            // outColor.r = 1.0;
            
            // outColor = vec4( 0, 1,1,1);
        }
        ';

	}
}
