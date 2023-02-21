package webgl.shaders.smokingDuck;

import webgl.WebglShader;

class SmokingDuckBufferD extends WebglShader {
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
            'u_bufferC' => 'sampler2D',
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
        uniform sampler2D u_bufferC;

        uniform float u_time;

        out vec4 outColor;

        float div(int x,int y)
        {
            return texelFetch(u_bufferC, ivec2(gl_FragCoord.xy) + ivec2(x,  y) , 0).y;
        }
        
        float pre(int x,int y)
        {
            return texelFetch(u_bufferC, ivec2(gl_FragCoord.xy) + ivec2(x,  y) , 0).x;
        }
        
        float getPre( void )
        {
            float p = 0.;
            p += 1.*pre(-10, 0);
            p += 10.*pre(-9, -1);
            p += 10.*pre(-9, 1);
            p += 45.*pre(-8, -2);
            p += 100.*pre(-8, 0);
            p += 45.*pre(-8, 2);
            p += 120.*pre(-7, -3);
            p += 450.*pre(-7, -1);
            p += 450.*pre(-7, 1);
            p += 120.*pre(-7, 3);
            p += 210.*pre(-6, -4);
            p += 1200.*pre(-6, -2);
            p += 2025.*pre(-6, 0);
            p += 1200.*pre(-6, 2);
            p += 210.*pre(-6, 4);
            p += 252.*pre(-5, -5);
            p += 2100.*pre(-5, -3);
            p += 5400.*pre(-5, -1);
            p += 5400.*pre(-5, 1);
            p += 2100.*pre(-5, 3);
            p += 252.*pre(-5, 5);
            p += 210.*pre(-4, -6);
            p += 2520.*pre(-4, -4);
            p += 9450.*pre(-4, -2);
            p += 14400.*pre(-4, 0);
            p += 9450.*pre(-4, 2);
            p += 2520.*pre(-4, 4);
            p += 210.*pre(-4, 6);
            p += 120.*pre(-3, -7);
            p += 2100.*pre(-3, -5);
            p += 11340.*pre(-3, -3);
            p += 25200.*pre(-3, -1);
            p += 25200.*pre(-3, 1);
            p += 11340.*pre(-3, 3);
            p += 2100.*pre(-3, 5);
            p += 120.*pre(-3, 7);
            p += 45.*pre(-2, -8);
            p += 1200.*pre(-2, -6);
            p += 9450.*pre(-2, -4);
            p += 30240.*pre(-2, -2);
            p += 44100.*pre(-2, 0);
            p += 30240.*pre(-2, 2);
            p += 9450.*pre(-2, 4);
            p += 1200.*pre(-2, 6);
            p += 45.*pre(-2, 8);
            p += 10.*pre(-1, -9);
            p += 450.*pre(-1, -7);
            p += 5400.*pre(-1, -5);
            p += 25200.*pre(-1, -3);
            p += 52920.*pre(-1, -1);
            p += 52920.*pre(-1, 1);
            p += 25200.*pre(-1, 3);
            p += 5400.*pre(-1, 5);
            p += 450.*pre(-1, 7);
            p += 10.*pre(-1, 9);
            p += 1.*pre(0, -10);
            p += 100.*pre(0, -8);
            p += 2025.*pre(0, -6);
            p += 14400.*pre(0, -4);
            p += 44100.*pre(0, -2);
            p += 63504.*pre(0, 0);
            p += 44100.*pre(0, 2);
            p += 14400.*pre(0, 4);
            p += 2025.*pre(0, 6);
            p += 100.*pre(0, 8);
            p += 1.*pre(0, 10);
            p += 10.*pre(1, -9);
            p += 450.*pre(1, -7);
            p += 5400.*pre(1, -5);
            p += 25200.*pre(1, -3);
            p += 52920.*pre(1, -1);
            p += 52920.*pre(1, 1);
            p += 25200.*pre(1, 3);
            p += 5400.*pre(1, 5);
            p += 450.*pre(1, 7);
            p += 10.*pre(1, 9);
            p += 45.*pre(2, -8);
            p += 1200.*pre(2, -6);
            p += 9450.*pre(2, -4);
            p += 30240.*pre(2, -2);
            p += 44100.*pre(2, 0);
            p += 30240.*pre(2, 2);
            p += 9450.*pre(2, 4);
            p += 1200.*pre(2, 6);
            p += 45.*pre(2, 8);
            p += 120.*pre(3, -7);
            p += 2100.*pre(3, -5);
            p += 11340.*pre(3, -3);
            p += 25200.*pre(3, -1);
            p += 25200.*pre(3, 1);
            p += 11340.*pre(3, 3);
            p += 2100.*pre(3, 5);
            p += 120.*pre(3, 7);
            p += 210.*pre(4, -6);
            p += 2520.*pre(4, -4);
            p += 9450.*pre(4, -2);
            p += 14400.*pre(4, 0);
            p += 9450.*pre(4, 2);
            p += 2520.*pre(4, 4);
            p += 210.*pre(4, 6);
            p += 252.*pre(5, -5);
            p += 2100.*pre(5, -3);
            p += 5400.*pre(5, -1);
            p += 5400.*pre(5, 1);
            p += 2100.*pre(5, 3);
            p += 252.*pre(5, 5);
            p += 210.*pre(6, -4);
            p += 1200.*pre(6, -2);
            p += 2025.*pre(6, 0);
            p += 1200.*pre(6, 2);
            p += 210.*pre(6, 4);
            p += 120.*pre(7, -3);
            p += 450.*pre(7, -1);
            p += 450.*pre(7, 1);
            p += 120.*pre(7, 3);
            p += 45.*pre(8, -2);
            p += 100.*pre(8, 0);
            p += 45.*pre(8, 2);
            p += 10.*pre(9, -1);
            p += 10.*pre(9, 1);
            p += 1.*pre(10, 0);
            return  p / 1048576.;
        }

        const float dissipation 	= 0.95;

        const float ballRadius		= 0.09;
        const float fogHeigth		= ballRadius * 3.;
        const int	nbSlice			= 24;
        const float fogSlice		= fogHeigth / float(nbSlice);
        const int	nbSphere 		= 1;
        const float shadowDensity 	= 15.;
        const float fogDensity 		= 5.;
        const float lightHeight     = 2.0;
        const float waterHeight     = 0.2;
        const float waterScale      = 0.025;
        const float duckScale       = 0.25;
        const vec3  lightPos        = vec3(0.5, lightHeight, 0.5);

        const vec2 iResolution = vec2(1024.0, 768.0);
        
        vec2 duckPosition(float fframe, float aspectRatio)
        {
            float s = 0.02;
            return vec2(cos(fframe * s * 0.5) * aspectRatio, sin(fframe * s)) * 0.7;
        }

        float beak(vec3 p, float s)
        {
            float k = max(length(p)-s, -(length(p+vec3(-0.15,-0.2,-0.1))-0.25));
            k = max(k, -(length(p+vec3(0.12,-0.2,-0.1))-0.25));
            return k < 0.0 ? 0.0 : k;
        }
        
        float duckBeak(vec3 p)
        {
            float k = 12.0;
            float a = 0.;
            
            a += exp(-k * beak(p + vec3(0, -0.55, -0.1), 0.15));
        
            return -log(a) / k;
        }

        // Box SDF by IQ https://iquilezles.org/articles/distfunctions/distfunctions.htm
        float sdSphere( vec3 p, float s )
        {
            return length(p)-s;
        }

        vec4 nearest(vec4 d1, vec4 d2)
        {
            return (d1.x<d2.x) ? d1 : d2;
        }


        // Duck model from Jimmi: https://www.shadertoy.com/view/4lsSDl

        float duckBody(vec3 p) {
            float k = 6.0;
            float a = 0.;
            
            //p.x = abs(p.x);
            
            a += exp(-k * sdSphere(p + vec3(0.11, 0, 0.1), 0.06));
            a += exp(-k * sdSphere(p + vec3(-0.11, 0, 0.1), 0.06));
            a += exp(-k * sdSphere(p + vec3(0.2, 0, 0.3), 0.1));
            a += exp(-k * sdSphere(p + vec3(-0.2, 0, 0.3), 0.1));
            a += exp(-k * sdSphere(p + vec3(0.2, 0, 0.55), 0.07));
            a += exp(-k * sdSphere(p + vec3(-0.2, 0, 0.55), 0.07));
            a += exp(-k * sdSphere(p + vec3(-0.00, 0, 0.72), 0.1));
            
            a += exp(-k * sdSphere(p + vec3(0, -0.39, 0.8), 0.01));
        
            a += exp(-k * sdSphere(p + vec3(0, -0.7, 0.1), 0.15));
            a += exp(-k * sdSphere(p + vec3(0, -0.65, -0.05), 0.07));
        
            return -log(a) / k;
        }

        float duckMap(in vec3 p)
        {
            p /= duckScale;
            return min(duckBody(p), duckBeak(p)) * duckScale;
        }


        vec4 duckMapColor(vec3 p)
        {
            p /= duckScale;
            p.x = abs(p.x);
            vec4 res = vec4(duckBody(p), vec3(1, 1, 0));
            res = nearest(res, vec4(duckBeak(p), vec3(1, 0, 0)));
            res = nearest(res, vec4(sdSphere(p-vec3(0.09, 0.62, 0.14), 0.06), vec3(0.0, 0, 0.3)));
            res.x *= duckScale;
            return res;
        }

        vec3 calcNormalDuck(in vec3 p)	
        { 
            const vec2 k = vec2(0.0001,-0.0001);
            return normalize( k.xyy * duckMap(p + k.xyy) + k.yyx * duckMap(p + k.yyx) + k.yxy * duckMap(p + k.yxy) + k.xxx * duckMap(p + k.xxx) );	
        }
        

        float sceneIntersection(in vec3 ro,in vec3 rd, out vec3 inter, out vec3 normal, out vec3 color, in float far)
        {
            float d = far;
            inter = vec3(0);
            normal = vec3(0);
            color = vec3(0);
            float iFrame = u_time * .1;
        
        
               // Duck
            vec2 p = duckPosition(iFrame, iResolution.x / iResolution.y);
            vec2 op = duckPosition(iFrame + 1.0, iResolution.x / iResolution.y);
            vec2 dir = normalize(p - op);
            vec3 y = vec3(0, 1, 0);
            vec3 z = vec3(-dir.x, 0, -dir.y);
            vec3 x = cross(z, y);
        
            mat4 mr = mat4(
            x.x,		y.x,		z.x,         0,
            x.y,		y.y,		z.y,         0,
            x.z,		y.z,		z.z,         0,
            0,	        0,	        0,           1.0 );
        
            mat4 mt = mat4(
            1.0,		0.0,		0.0,         0.0,
            0.0,		1.0,		0.0,         0.0,
            0.0,		0.0,		1.0,         0.0,
            -p.x,	0,	-p.y,     1.0 );
        
            mat4 tr= mr * mt;
        
            float t = 0.0;
            vec3 tp;
            for( int j = 0; j < 32; j++ )
            {
                vec3	p = ro + t*rd;
                tp = vec3(tr * vec4(p, 1.0));
                float	h = duckMap(tp);
                if( abs(h) < 0.001)
                {
                    break;
                }
                t += h;
            }
            if(t < d)
            {
                d = t;
                normal = (inverse(tr) * vec4(calcNormalDuck(tp), 0)).xyz;
                color = duckMapColor(tp).yzw;
            }
            
            // Plane
            
            return d;
        }
        
        float sampleFog(in vec3 pos)
        {
            vec2 uv = pos.xz;
            uv.x *= iResolution.y / iResolution.x;
            uv = uv * 0.5 + 0.5;
            if(max(uv.x, uv.y) > 1. || min(uv.x, uv.y) < 0.)
            {
                return 0.;
            }
            return texture(u_bufferA, uv).z;
        }
        
        float height(in float y)
        {
            y = clamp(y / fogHeigth, 0.0, 1.0);
            return (1.0 - sin(acos(abs(y) * 2.0 - 1.0))) * fogHeigth;
        }
        
        float getWaterHeight(in vec3 pos)
        {
            vec2 uv = pos.xz;
            uv.x *= iResolution.y / iResolution.x;
            uv = uv * 0.5 + 0.5;
            uv = clamp(uv, 0.0, 1.0);
            return texture(u_bufferA, uv).w * waterScale;
        }
        
        vec3 getWaterNormal(in vec3 p)
        {
            vec2 d = 1.0 / iResolution.xy;
            float hMid = getWaterHeight(p);
            float hRight = getWaterHeight(p + vec3(d.x, 0, 0));
            float hTop = getWaterHeight(p + vec3(0, 0, d.y));
            return normalize(cross(vec3(0, hTop - hMid, d.y), vec3(d.x, hRight - hMid, 0)));
        }
        
        vec3 getSkyColor(vec3 rd)
        {
            vec3 blue = smoothstep(.2, 1., rd.y) * vec3(0, 0, .5);
            vec3 highlight = vec3(pow(clamp(dot(rd, normalize(vec3(1, 1, 0))), 0., 1.), 100.) * 2.0)
                           + vec3(pow(clamp(dot(rd, normalize(vec3(-0.5, 1, 0.5))), 0., 1.), 100.) * 2.0);
            return blue + highlight;
        }
        
        // Caustic inspired by Dave Hoskins https://www.shadertoy.com/view/MdKXDm
        
        float F(inout vec3 key, in float R)
        {
            key *=mat3(-2,-1,2, 3,-2,1, 1,2,2) * R;
            return length(.5-fract(key));
        }
        
        float caustic(vec3 p)
        {
            float iTime = u_time * 0.001;
            vec3 key = vec3(p * 2.0) + iTime * 0.2;
            return pow(min(min(F(key,.5),F(key,.4)),F(key,.3)), 7.)*25.0;
        }
        // https://iquilezles.org/articles/boxfunctions

        vec2 boxIntersection( in vec3 ro, in vec3 rd, in vec3 rad, in vec3 center,out vec3 oN ) 
        {
            ro -= center;
            vec3 m = 1.0/rd;
            vec3 n = m*ro;
            vec3 k = abs(m)*rad;
            vec3 t1 = -n - k;
            vec3 t2 = -n + k;
        
            float tN = max( max( t1.x, t1.y ), t1.z );
            float tF = min( min( t2.x, t2.y ), t2.z );
            
            if( tN>tF || tF<0.0) return vec2(-1.0); // no intersection
            
            oN = -sign(rd)*step(t1.yzx,t1.xyz)*step(t1.zxy,t1.xyz);
        
            return vec2( tN, tF );
        }

        bool floorIntersect(in vec3 ro, in vec3 rd, in float floorHeight, out float t) 
        {
            ro.y -= floorHeight;
            if(rd.y < -0.01)
            {
                t = ro.y / - rd.y;
                return true;
            }
            return false;
        } 

        // Fog by IQ https://iquilezles.org/articles/fog

        vec3 applyFog( in vec3  rgb, vec3 fogColor, in float distance)
        {
            float fogAmount = exp( -distance );
            return mix( fogColor, rgb, fogAmount );
        }
        float dist2(vec3 v)
        {
            return dot(v, v);
        }
        // https://www.shadertoy.com/view/4djSRW

        float hash12(vec2 p)
        {
            vec3 p3  = fract(vec3(p.xyx) * .1031);
            p3 += dot(p3, p3.yzx + 33.33);
            return fract((p3.x + p3.y) * p3.z);
        }
        vec3 Render(in vec3 ro,in vec3 rd,in float far, float fudge)
        {
            vec3  inter;
            vec3  normal;
            vec3  baseColor; 
            float mint = sceneIntersection(ro, rd, inter, normal, baseColor, far);
            
            vec3 color = mint != far ? baseColor * (0.2 + 0.8 * max(0.0, dot(normal, normalize(ro * mint - lightPos)))) +  getSkyColor(reflect(rd, normal)) : vec3(0.25);
                
            vec3 n;
            float aspecRatio = iResolution.x / iResolution.y;  
        
            vec2 ret = boxIntersection(ro, rd, vec3(aspecRatio, waterHeight * 2.0, 1), vec3(0, 0, 0), n);
            if(ret.x > 0.0 && ret.x < mint)
            {
                vec3 pi = ro + rd * ret.x;
                float wt = ret.x;
                float h = getWaterHeight(pi);
                vec3 waterNormal;
                if(pi.y < h)
                {
                    waterNormal = n;
                }
                else
                {
                    for (int i = 0; i < 80; i++)
                    {
                        vec3 p = ro + rd * wt;
                        float h = p.y - getWaterHeight(p);
                        if (h < 0.0002 || wt > min(mint, ret.y))
                            break;
                        wt += h * 0.5;
                    }
                    waterNormal = getWaterNormal(ro + rd * wt);
                }
                
                if(wt < ret.y && wt < mint)
                {
                    // refract
                    vec3 enter = ro + rd * wt;
                    vec3 refr = -refract(rd, waterNormal, 0.8);
                    vec3 refn;
                    vec2 ret2 = boxIntersection(enter, refr, vec3(aspecRatio, waterHeight * 2.0, 1), vec3(0, 0, 0), refn);
                    vec3 exit = enter + refr * ret2.x;
                    float dist = distance(enter, exit);
                    color = vec3(1) * (0.2 + 0.8 * max(0.0, dot(-refn, normalize(ro * dist - lightPos))));
                    color += caustic(exit + getWaterNormal(exit)) * 0.7;
                    color = applyFog( color, vec3(0, 0, 1), dist * 3.0);
                    color += getSkyColor(reflect(rd, waterNormal));
                }  
            }
            
            // Compute Fog
            float t;
            if(floorIntersect(ro, rd, fogHeigth, t))
            {
                vec3 curPos = ro + rd * t;
                vec3 fogStep = (fogHeigth / float(nbSlice)) * rd / abs(rd.y);
                curPos += fudge * fogStep;  // fix banding issue
                float stepLen = length(fogStep);
                float curDensity = 0.;
                float transmittance = 1.;
                float lightEnergy = 0.;
                for(int i = 0; i < nbSlice; i++)
                {
                    if( dot(curPos - ro, rd) > mint)
                        break;
                    float curHeigth = sampleFog(curPos) * fogHeigth;
                    float curSample = min(max(0., curHeigth - height(curPos.y)), fogSlice) * stepLen / fogSlice;
                    if(curSample > 0.001)
                    {
                        vec3 lightDir = normalize(lightPos - curPos);
                        vec3 shadowStep = (fogHeigth / float(nbSlice)) * lightDir / lightDir.y;
                        float lightDist2 = dist2(lightPos - curPos);
                        vec3 shadowPos = curPos + shadowStep * fudge;
                        float shadowDist = 0.;
        
                        for (int j = 0; j < nbSlice; j++)
                        {
                            shadowPos += shadowStep;
                            float curHeight = sampleFog(shadowPos) * fogHeigth;
                             shadowDist += min(max(0., curHeight - height(shadowPos.y)), fogSlice) * length(shadowStep) / fogSlice;
                       }
        
                        
                        float shadowFactor = exp(-shadowDist * shadowDensity);
                        curDensity = curSample * fogDensity;
                        float absorbedlight =  shadowFactor * (1. * curDensity);
                        lightEnergy += absorbedlight * transmittance;
                        transmittance *= 1. - curDensity;	
                    }
                    curPos+= fogStep;       
                }
                color = mix(color, vec3(lightEnergy * 1.8), 1. - transmittance);
            }  
            
            
            return color;
        }
        
        vec3 vignette(vec3 color, vec2 q, float v)
        {
            color *= 0.3 + 0.8 * pow(16.0 * q.x * q.y * (1.0 - q.x) * (1.0 - q.y), v);
            return color;
        }
        
        mat3 setCamera( in vec3 ro, in vec3 ta )
        {
            vec3 cw = normalize(ta-ro);
            vec3 up = vec3(0, 1, 0);
            vec3 cu = normalize( cross(cw,up) );
            vec3 cv = normalize( cross(cu,cw) );
            return mat3( cu, cv, cw );
        }

        void main(){
            // 計算一個pixel的uv距離
			
            vec2 fragCoord = v_texcoord * iResolution;
            vec2 iMouse = vec2( 0, 0);
            float iTime = u_time * 0.001;
            float iFrame = u_time * .1;

            vec3 tot = vec3(0.0);
        
            vec2 p = (-iResolution.xy + 2.0*fragCoord)/iResolution.y;

            // camera       
            float theta	= radians(360.)*(iMouse.x/iResolution.x-0.5) + radians(90.);
            float phi	= - radians(45.);
            vec3 ro = 2. * vec3( sin(phi)*cos(theta),cos(phi),sin(phi)*sin(theta));
            vec3 ta = vec3( 0 );
            // camera-to-world transformation
            mat3 ca = setCamera( ro, ta );

            vec3 rd =  ca*normalize(vec3(p,1.5));        

            vec3 col = Render(ro ,rd, 6., hash12(fragCoord + iTime));


            tot += col;
                    
            tot = vignette(tot, fragCoord / iResolution.xy, 0.6);
            
            float pr = getPre() - div(0,0);
            outColor = vec4( tot, pr );
            
            // outColor = vec4(1,0,0,1);
        }
        ';

	}
}
