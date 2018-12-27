Shader "CookbookShaders/Lit Toon" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" "LightsMode"="ForwardBase" }
		LOD 200
		Cull Off
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CelShadingForward addshadow

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		half4 LightingCelShadingForward (SurfaceOutput s, half3 lightDir, half atten) {
			// half NdotL = dot(s.Normal, lightDir);
 			// NdotL = 1 + clamp(floor(NdotL), -1, 0);
			half NdotL = 1.0;
			// NdotL = smoothstep(0, 0.025f, NdotL);

			half4 c;
			c.rgb =
				s.Albedo
				*_LightColor0.rgb
				* NdotL * (atten + 0.4) * 2;

			c.a = s.Alpha;
			return c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
