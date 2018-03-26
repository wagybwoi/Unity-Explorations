Shader "CookbookShaders/Fur" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ControlTex ("Control Tex", 2D) = "red" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0

		_FurLength ("Fur Length", Range(0.0002,1)) = 0.25
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		_CutoffEnd ("Alpha cutoff end", Range(0,1)) = 0.5
		_EdgeFade ("Edge Fage", Range(0,1)) = 0.4
		_Gravity ("Gravity direction", Vector) = (0,0,1,0)
		_GravityStrength ("G strength", Range(0,1)) = 0.25
		
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows alpha:blend vertex:vert
		#define FUR_MULTIPLIER 0.05
		#include "FurPass.cginc"
		ENDCG
	}
	FallBack "Diffuse"
}
