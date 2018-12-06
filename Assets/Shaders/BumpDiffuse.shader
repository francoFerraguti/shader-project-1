Shader "Custom/BumpDiffuseShader" {
	Properties {
		_DiffuseTexture ("Diffuse Texture", 2D) = "white" {}
		_BumpTexture ("Bump Texture", 2D) = "bump" {}
        _MultiplyBump ("Bump Multiplier", Range(0, 10)) = 1
        _Brightness ("Brightness", Range(0,20)) = 1
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _DiffuseTexture;
		sampler2D _BumpTexture;
        half _MultiplyBump;
        fixed _Brightness;

		struct Input {
			float2 uv_DiffuseTexture;
			float2 uv_BumpTexture;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_DiffuseTexture, IN.uv_DiffuseTexture).rgb * _Brightness;
			o.Normal = UnpackNormal(tex2D(_BumpTexture, IN.uv_BumpTexture));
            o.Normal *= float3(_MultiplyBump, _MultiplyBump, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
