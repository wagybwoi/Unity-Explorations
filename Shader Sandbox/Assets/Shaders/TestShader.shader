Shader "CookbookShaders/TestShader"
{
	Properties
	{
		_MainColor ("Main Color", Color) = (1, 1, 1, 1)
		_EndColor ("End Color", Color) = (1, 1, 1, 1)

		_NoiseTex1 ("Texture", 2D) = "white" {}
		_NoiseTex2 ("Texture", 2D) = "white" {}
		_EndColorTexture ("Texture", 2D) = "white" {}

		_Direction ("Direction", Vector) = (1, 0.5, 0)
	}
	SubShader
	{
		Tags { 
//			"RenderType"="Opaque"
			"Queue"="Transparent"
			"RenderType"="Transparent"
		}
		LOD 100

//        ZWrite Off
//        Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _NoiseTex1;
			float4 _NoiseTex1_ST;

			sampler2D _NoiseTex2;
			float4 _NoiseTex2_ST;

			sampler2D _EndColorTexture;
			float4 _EndColorTexture_ST;

			float4 _MainColor;
			float4 _EndColor;

			float3 _Direction;

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				float time = _Time[0];
				float3 noise1 = tex2Dlod(_NoiseTex1, float4(v.uv.x + time*5, v.uv.y + time*2, 0, 0));
				float3 noise2 = tex2Dlod(_NoiseTex2, float4(v.uv.x + time, v.uv.y - time, 0, 0));
//				float3 worldPos = mul (unity_ObjectToWorld, v.vertex).xyz;
				float threshold = 0.5;
				float extrudeModifier = 0.01;
				float willExtrude = noise1.r > threshold;
				v.vertex.xyz += ( willExtrude*(v.normal*(noise2*extrudeModifier)) + (1 - willExtrude)*(v.normal*(noise2*extrudeModifier)) );

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _NoiseTex1);
				o.uv = TRANSFORM_TEX(v.uv, _NoiseTex2);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
//				float time = _Time[0];
				fixed4 startColor = _MainColor;
				fixed4 endColor = tex2D(_EndColorTexture, float2(i.uv.x , i.uv.y));

				float time = _Time[0];
				float3 noise1 = tex2D(_NoiseTex1, float4(i.uv.x + time*5, i.uv.y + time*2, 0, 0));
				float3 noise2 = tex2D(_NoiseTex2, float4(i.uv.x + time, i.uv.y - time, 0, 0));

//				fixed4 finalColor = lerp(_MainColor, endColor, 1);
//				fixed4 finalColor = lerp(_MainColor, _EndColor, noise2.r);

				fixed4 finalColor;

//				if(noise2.r < 0.5) {
//					finalColor = _MainColor;
//				} else {
//					finalColor = _EndColor;
//				}

				finalColor = round(noise1.r)*_EndColor + (1-round(noise1.r))*_MainColor;

//				finalColor.a = 1-noise2.r;

//				float threshold = 0.5;
//				if(noise2.r > threshold) {
//					lerp(finalColor, float4(1,1,1,1), noise1*0.1);
//				}

				return finalColor;
			}
			ENDCG
		}
	}
}
