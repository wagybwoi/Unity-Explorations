Shader "CookbookShaders/FireTest1" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_GradientTex ("Gradient Texture", 2D) = "white" {}

		_Speed ("Speed", Range(0,10)) = 5.0
		_Threshold ("Threshold", Range(0,1)) = 0.5
	}
	SubShader {
		Tags { 
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Unlit fullforwardshadows alpha:blend vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NoiseTex;
		sampler2D _GradientTex;
		fixed4 _Color;
		float _Speed;
		float _Threshold;

		struct Input {
			float2 uv_NoiseTex;
			float2 uv_GradientTex;
		};

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float time = _Time;
			v.vertex.x = v.vertex.x + sin(v.vertex.y * time);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			float time = _Time;
			fixed4 noise = tex2D (_NoiseTex, float2(IN.uv_NoiseTex.x, IN.uv_NoiseTex.y + time * _Speed));
			fixed4 gradient = tex2D (_GradientTex, IN.uv_NoiseTex);

			o.Albedo = _Color.rgb;

			if(noise.r < _Threshold * (gradient.a*2)) {
				o.Alpha = 0;
			} else {
				o.Alpha = 1;
			}

		}

		half4 LightingUnlit (SurfaceOutput s, half3 lightDir, half atten) {
			return half4(s.Albedo, s.Alpha);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
