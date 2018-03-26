Shader "CookbookShaders/TerrainTest" {
	Properties {
		_NoiseTex("Noise Tex", 2D) = "gray" {}
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NoiseTex;
		fixed4 _Color;

		struct Input {
			float2 uv_NoiseTex;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float time = _Time;
			float3 disp = tex2Dlod(_NoiseTex, float4(v.texcoord.xy, 0, 0));
			float4 world_space_vertex = mul( unity_ObjectToWorld, v.vertex );
//			v.vertex.y = v.normal.y * disp.r * 0.1;
			v.vertex.xyz = float3( 
				sin(time * disp.r * 30 + disp.r)*10,
				v.vertex.y * 30,
				cos(time * disp.r * 30 + disp.r)*10
			);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float3 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
//			o.Albedo = c.rgb;
			o.Albedo = noise.rgb * _Color.rgb * (IN.uv_NoiseTex.x * 3);
//			o.Alpha = c.a;
			o.Alpha = 1.0;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
