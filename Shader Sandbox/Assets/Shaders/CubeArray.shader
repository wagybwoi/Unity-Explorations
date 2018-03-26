Shader "CookbookShaders/CubeArray" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_HeightMapTex ("Height Map)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _HeightMapTex;

		struct Input {
			float2 uv_HeightMapTex;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float time = _Time;
			float4 world_space_vertex = mul( unity_ObjectToWorld, v.vertex );
			float cubeArraySize = 50;
			float2 new_uv = float2(
				floor(((world_space_vertex.x - (-cubeArraySize/2))/(cubeArraySize/2 - (-cubeArraySize/2)))*cubeArraySize + 0.5)/cubeArraySize,
				floor(((world_space_vertex.z - (-cubeArraySize/2))/(cubeArraySize/2 - (-cubeArraySize/2)))*cubeArraySize + 0.5)/cubeArraySize
			);
			float3 heightMap = tex2Dlod(_HeightMapTex, float4(new_uv.x, new_uv.y + time*2, 0, 0));

			if(world_space_vertex.y > 0) {
				world_space_vertex.y = (heightMap.r*2);
			}

			v.vertex.y = mul(unity_WorldToObject, world_space_vertex).y;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 c = _Color;
			o.Albedo = c.rgb * IN.worldPos.y;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
