Shader "CookbookShaders/StylizedWater"
{
	Properties
	{
		// color of the water
		_Color("Color", Color) = (1, 1, 1, 1)
		// color of the edge effect
		_EdgeColor("Edge Color", Color) = (1, 1, 1, 1)
		// width of the edge effect
		_DepthFactor("Depth Factor", float) = 1.0

		_WaveSpeed("Wave Speed", float) = 1.0
		_WaveAmp("Wave Amp", float) = 0.2
		_NoiseTex("Noise Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags {
			"RenderType"="Opaque"
			"LightMode"="ForwardBase"
		}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            #include "UnityLightingCommon.cginc" // for _LightColor0
			#include "UnityCG.cginc"

			// Unity built-in - NOT required in Properties
			sampler2D _CameraDepthTexture;
//			sampler2D _MainTex;
//			float4 _MainTex_ST;
			float4 _Color;
			float4 _EdgeColor;
			float  _DepthFactor;
			float _WaveSpeed;
			float _WaveAmp;
			sampler2D _NoiseTex;



			struct vertexInput
			{
				float4 vertex : POSITION;
                float3 texCoord : TEXCOORD1;
                float3 normal : NORMAL;
                fixed4 diff : COLOR0; // diffuse lighting color
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
                float3 texCoord : TEXCOORD0;
				float4 screenPos : TEXCOORD1;
                float3 normal : NORMAL;
                fixed4 diff : COLOR0; // diffuse lighting color
			};



			vertexOutput vert(vertexInput input) {
				vertexOutput output;

				// convert to camera clip space
				output.pos = UnityObjectToClipPos(input.vertex);

				// apply wave animation
				float noiseSample = tex2Dlod(_NoiseTex, float4(input.texCoord.xy, 0, 0));
				output.pos.y += sin(_Time*_WaveSpeed*noiseSample)*_WaveAmp;
				output.pos.x += cos(_Time*_WaveSpeed*noiseSample)*_WaveAmp;

				// compute depth
				output.screenPos = ComputeScreenPos(output.pos);

				// texture coordinates 
				output.texCoord = input.texCoord;

				// normals
				output.normal = input.normal;

				// get vertex normal in world space
                half3 worldNormal = UnityObjectToWorldNormal(input.normal);
                // dot product between normal and light direction for
                // standard diffuse (Lambert) lighting
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                // factor in the light color
                output.diff = nl * _LightColor0;

				return output;
			}

			float4 frag(vertexOutput input) : COLOR {
				// sample camera depth texture
				float4 depthSample = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, input.screenPos);
				float depth = LinearEyeDepth(depthSample).r;
//				float depth = depthSample.r;

				// apply the DepthFactor to be able to tune at what depth values
				// the foam line actually starts
				float foamLine = 1 - saturate(_DepthFactor * (depth - input.screenPos.w));
//				float4 worldPos = mul(unity_ObjectToWorld, input.pos);
//				float whiteness = worldPos.y;

				// multiply the edge color by the foam factor to get the edge,
				// then add that to the color of the water
//				float4 col = _Color + foamLine * _EdgeColor;
				float4 col;
				if(foamLine > 0.8) {
					col = _EdgeColor;
				} else {
					col = _Color;
				}

				return col;
			}
			ENDCG
		}
	}
}
