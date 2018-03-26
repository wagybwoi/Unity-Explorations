Shader "CookbookShaders/Dissolve"
{
	Properties
	{
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_DissolveSpeed ("Dissolve Speed", Range(0, 10)) = 3
		_ColorThreshold ("Color Threshold", Range(0, 10)) = 5
		_DissolveColor ("Dissolve Color", Color) = (1,1,1,1)
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

			fixed4 _MainColor;
			sampler2D _NoiseTex;
			float4 _NoiseTex_ST;
			float _DissolveSpeed;
			float _ColorThreshold;
			fixed4 _DissolveColor;

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _NoiseTex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = _MainColor;
				fixed4 noise = tex2D(_NoiseTex, i.uv);
				float noiseSample = noise.r;

				float color_threshold = ((sin(_Time*10)*0.15)+0.16) * _ColorThreshold;
				float useDissolve = noiseSample - color_threshold < 0;
				col = (1 - useDissolve)*col + useDissolve*_DissolveColor;

				float threshold = ((sin(_Time*10)*0.15)+0.16) * _DissolveSpeed;
				clip(noiseSample - threshold);

				return col;
			}
			ENDCG
		}
	}
}
