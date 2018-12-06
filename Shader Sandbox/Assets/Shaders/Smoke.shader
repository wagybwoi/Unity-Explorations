Shader "CookbookShaders/Smoke" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_Direction ("Direction Vector", Vector) = (1, 0, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque"  }
		LOD 200
		Cull Off

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CelShadingForward vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _NoiseTex;
		float4 _Direction;
		float _CelShadingLevels;

		struct Input {
			float2 uv_NoiseTex;
			float2 worldNormal;
			float3 viewDir;
		};

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float time = _Time[1];
			float4 world_space_normal = mul( unity_ObjectToWorld, v.normal );
			float NdotD = dot(_Direction.xyz, world_space_normal.xyz);
			float4 noiseTex = tex2Dlod (_NoiseTex, float4(v.texcoord.x + (time/4), v.texcoord.y, 0, 0));

			if(NdotD > 0) {
				// v.vertex.xyz += normalize(_Direction.xyz) * noiseTex.r * (NdotD*5);
				v.vertex.xyz +=
					normalize(v.normal)
					* noiseTex.r
					* (NdotD
					* distance(
						float4(v.vertex.xyz, 0),
						float4(0,0,0,0)*10)
					);
			}
		}

		void surf (Input IN, inout SurfaceOutput o) {
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}

		half4 LightingCelShadingForward (SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir);
			if (NdotL <= 0) NdotL = 0;
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
