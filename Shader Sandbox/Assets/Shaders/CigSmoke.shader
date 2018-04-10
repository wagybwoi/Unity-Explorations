Shader "CookbookShaders/CigSmoke"
{
	Properties
	{
		_NoiseTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (0.615, 0, 1.0, 1.0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _NoiseTex;
			float4 _NoiseTex_ST;
			float4 _Color;

			v2f vert (appdata v)
			{
				v2f o;
				float time = _Time[0];
				fixed4 noise = tex2Dlod (_NoiseTex, float4(TRANSFORM_TEX(v.uv, _NoiseTex).x, TRANSFORM_TEX(v.uv, _NoiseTex).y + time, 0, 0));
				v.vertex.x =
					// Original value
					(v.vertex.x)

					// Multiply by z for bottom to top growth
					* (v.vertex.z+0.5)

					// Add sine offset for some behaviour
//					+ (sin(_Time[1]*1000*v.vertex.z/2)+1)/10;
//					- sin( ((_Time[1]*100)*((v.vertex.z+0.5)/2)) )/5
					+ (sin( (v.vertex.z*2)*5 - (_Time[1]*3) )/5) * (v.vertex.z+0.5)

					// Noise for randomness
//					* (noise.r/2)
					;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _NoiseTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = _Color;
				return col;
			}
			ENDCG
		}
	}
}
