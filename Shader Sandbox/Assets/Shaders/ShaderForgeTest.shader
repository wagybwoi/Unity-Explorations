// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33796,y:32355,varname:node_3138,prsc:2|emission-5265-RGB;n:type:ShaderForge.SFN_Color,id:5265,x:32829,y:32384,ptovrint:False,ptlb:node_5265,ptin:_node_5265,varname:node_5265,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07058824,c2:0.1058824,c3:0.2431373,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2376,x:32189,y:32464,ptovrint:False,ptlb:node_2376,ptin:_node_2376,varname:node_2376,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9daf4d14c8ee9408c8350a5409a05490,ntxv:3,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4913,x:32587,y:32701,varname:node_4913,prsc:2|A-2376-G,B-1804-OUT;n:type:ShaderForge.SFN_Time,id:3996,x:32189,y:32890,varname:node_3996,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3579,x:32189,y:33134,prsc:2,pt:False;n:type:ShaderForge.SFN_Sin,id:1804,x:32416,y:32890,varname:node_1804,prsc:2|IN-3996-T;n:type:ShaderForge.SFN_Multiply,id:7217,x:32432,y:33144,varname:node_7217,prsc:2|A-2376-RGB,B-3579-OUT,C-1804-OUT;proporder:5265-2376;pass:END;sub:END;*/

Shader "Shader Forge/ShaderForgeTest" {
    Properties {
        _node_5265 ("node_5265", Color) = (0.07058824,0.1058824,0.2431373,1)
        _node_2376 ("node_2376", 2D) = "bump" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _node_5265;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float3 emissive = _node_5265.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
