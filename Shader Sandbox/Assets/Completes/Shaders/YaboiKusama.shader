Shader "Custom/YaboiKusama" {
	Properties {
		_PrimaryColor ("Primary Color", Color) = (1,1,1,1)
		_SecondaryColor ("Secondary Color", Color) = (0,0,0,0)
		_DotSize ("Dot Size", Range(0,1)) = 0.1
		_X ("X", Range(0,10)) = 2.0
		_Y ("Y", Range(0,10)) = 2.0
         _MainTex("Texture1", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf NoLighting
 
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _PrimaryColor;
		fixed4 _SecondaryColor;
		fixed4 _Color;
		half _DotSize;
		half _X;
		half _Y;
		
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c;
			// if( distance(IN.uv_MainTex, float2(_DotSize*_X, _DotSize*_Y)) > _DotSize ) {
			if( distance(IN.uv_MainTex, float2(_DotSize*_X, _DotSize*_Y)) > _DotSize ) {
				0.1 -> 0.16 > 0.1 + .5
				c = _PrimaryColor;
			} else {
				c = _SecondaryColor;
			}
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten) {
			return float4(s.Albedo.r, s.Albedo.g, s.Albedo.b, s.Alpha);
		}


		ENDCG
	}
	FallBack "Diffuse"
}
