Shader "CookbookShaders/MaterializeTest" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Speed ("Wave Speed", Range(0.1,80)) = 5
		_Frequency ("Wave Frequency", Range(0,10)) = 2
		_Amplitude ("Wave Amplitude", Range(-1,1)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Unlit vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		fixed4 _Color;
		float _Speed;
		float _Frequency;
		float _Amplitude;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
//			float time = _Time;
//			float4 world_space_vertex = mul( unity_ObjectToWorld, v.vertex );
//
//			if( world_space_vertex.y < sin(time * 10)*2 + 0.1 && world_space_vertex.y > sin(time * 10)*2 - 0.1 ) {
////				v.vertex.x = v.vertex.x + sin(time*10 + v.vertex.x)/10;
////				v.vertex.z = v.vertex.z + cos(time*10 + v.vertex.z)/10;
//			}

//			v.vertex.xyz = float3(v.vertex.x + (v.normal.x * waveValue), v.vertex.y, v.vertex.z + (v.normal.z * waveValue));
//			v.normal = normalize(float3(v.normal.x, v.normal.y + waveValue, v.normal.z));
//			o.vertColor = float3(waveValue, waveValue, waveValue);

			float time = _Time * _Speed;
			float waveValueA = sin(time + v.vertex.x * _Frequency * 1.5) * _Amplitude;
			float waveValueB = cos(time + v.vertex.x * _Frequency) * _Amplitude;

			v.vertex.xyz = float3( v.vertex.x + (waveValueA * waveValueB), v.vertex.y, v.vertex.z + (waveValueA * waveValueB));
			//v.normal = normalize(float3(v.normal.x, v.normal.y, v.normal.z));
		}

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;

			float time = _Time;
			if( fmod(IN.worldPos.y * sin(IN.worldPos.x*30) + cos(IN.worldPos.y*30) + time*50, 5) > 2 ) {
				o.Albedo = 1.0 - c.rgb;
			}
		}

		half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) {
			return half4(s.Albedo, s.Alpha);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
