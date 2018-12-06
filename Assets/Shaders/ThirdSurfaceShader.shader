Shader "Custom/ThirdSurfaceShader" {
	Properties {
		_Texture ("Texture", 2D) = "white" {}
		_Range ("Range", Range(0,5)) = 1
		_Cube ("Cube", CUBE) = "" {}
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _Texture;
		half _Range;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_Texture;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed3 textureColor = (tex2D(_Texture, IN.uv_Texture) * _Range).rgb;
			fixed3 cubemapColor = texCUBE(_Cube, IN.worldRefl).rgb;

			o.Albedo = textureColor * fixed3(1.8,1.3,0.8);
			o.Emission = (cubemapColor.brg / 2);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
