Shader "CookbookShaders/Lit Toon Smoke Trail" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_Direction ("Direction Vector", Vector) = (1, 0, 0, 0)
		_VertexMultiplier ("Vertex Multiplier", Range (0, 10)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" "LightsMode"="ForwardBase" }
		LOD 200
		Cull Off
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf CelShadingForward vertex:vert addshadow

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _NoiseTex;
		float4 _Direction;
		float _VertexMultiplier;

		struct Input {
			float2 uv_NoiseTex;
			float2 worldNormal;
			float3 viewDir;
		};
		
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void vert (inout appdata_full v) {
			float time = _Time[0];
			float4 world_space_normal = mul( unity_ObjectToWorld, v.normal );
			float3 local_space_normal = v.normal;
			float NdotD = clamp(dot(_Direction.xyz, local_space_normal.xyz), 0, 10);
			float4 noiseTex = tex2Dlod (_NoiseTex, float4(/*v.texcoord.x*/v.vertex.z + (time*2), /*v.texcoord.y*/v.vertex.x + (time*2), 0, 0));

			if(v.vertex.y > 0) 
			v.vertex.xyz =
				v.vertex.xyz
				+ _Direction.xyz 
				* noiseTex.r 
				// * distance( float4(v.vertex.xyz, 0), float4(0,0,0,0)*10 ) 
				* _VertexMultiplier
				;
  
			// float4 position = v.vertex;
			// float4 bitangent = float4( cross( v.normal, v.tangent ), 0 );
			// float4 positionAndTangent = v.vertex + v.tangent * 0.01;
			// float4 positionAndBitangent = v.vertex + bitangent * 0.01; 
			// float4 newTangent = ( positionAndTangent - position ); // leaves just 'tangent'
			// float4 newBitangent = ( positionAndBitangent - position ); // leaves just 'bitangent'
			// v.normal = cross( newTangent, newBitangent );
		}

		void surf (Input IN, inout SurfaceOutput o) {
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}

		half4 LightingCelShadingForward (SurfaceOutput s, half3 lightDir, half atten) {
			// half NdotL = dot(s.Normal, lightDir);
 			// NdotL = 1 + clamp(floor(NdotL), -1, 0);
			half NdotL = 1.1;
			// NdotL = smoothstep(0, 0.025f, NdotL);


			half4 c;
			c.rgb =
				s.Albedo
				// *_LightColor0.rgb
				*NdotL *(atten+0.4) *2;

			c.a = s.Alpha;
			return c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
