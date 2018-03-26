Shader "CookbookShaders/MeltyBoi" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NoiseTex ("Albedo (RGB)", 2D) = "white" {}

		_YMelt ("Y Melt", Range(-5,5)) = 0
		_YMeltDistance ("Y Melt Distance", Range(0,5)) = 0.5
//		_MeltCurve("Melt Curve", Range(1.0,10.0)) = 2.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CelShadingForward vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _NoiseTex;
		float _YMelt;
		float _YMeltDistance;
//		float _MeltCurve;

		struct Input {
			float2 uv_NoiseTex;
			float3 worldPos;
		};

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float4 world_space_vertex = mul(unity_ObjectToWorld, v.vertex);
			float4 world_space_normal = mul(unity_ObjectToWorld, v.normal);
			float4 noise = tex2Dlod (_NoiseTex, float4(v.texcoord.xy, 0, 0));

			if(world_space_vertex.y <= _YMelt + _YMeltDistance) {
				float melt = ( pow(world_space_vertex.y, 10) - _YMelt) / _YMeltDistance;
				melt = 1 - saturate( melt );
				melt = pow( melt, 10 );
				v.vertex.xz += v.normal.xz * ((world_space_vertex.y - _YMeltDistance)/(_YMelt - _YMeltDistance)) * (melt*3) * (noise.r);
			}

//			if(world_space_vertex.y <= _YMeltDistance) {
//				v.vertex.x += v.vertex.x * pow( melt, world_space_vertex );
//				v.vertex.z += v.vertex.z * pow( melt, world_space_vertex );
//			}
		}

		void surf (Input IN, inout SurfaceOutput o) {
//			fixed4 c = tex2D (_NoiseTex, IN.uv_NoiseTex) * _Color;
			fixed4 c =_Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;

			clip(IN.worldPos.y - _YMelt);
		}

		half4 LightingCelShadingForward (SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir);
			if (NdotL <= -0.4) NdotL = 0;
			else NdotL = 1;
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 2);
			c.a = s.Alpha;
			return c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
