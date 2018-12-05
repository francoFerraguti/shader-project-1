Shader "Custom/FirstSurfaceShader" {
	Properties {
		_ColorAlbedo ("Albedo Color", Color) = (1,1,1,1)
		_SetAlbedo ("Set Albedo?", Int) = 1
		_SwizzlingAlbedo ("Swizzle Position for Albedo", Range(0, 5)) = 0
		_ColorEmission ("Emission Color", Color) = (1,1,1,1)
		_SetEmission ("Set Emission?", Int) = 1
		_SwizzlingEmission ("Swizzle Position for Emission", Range(0, 5)) = 0
		_ColorNormal ("Normal Color", Color) = (1,1,1,1)
		_SetNormal ("Set Normal?", Int) = 1
		_SwizzlingNormal ("Swizzle Position for Normal", Range(0, 5)) = 0
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uvMainTex;
		};

		fixed4 _ColorAlbedo;
		int _SetAlbedo;
		int _SwizzlingAlbedo;
		fixed4 _ColorEmission;
		int _SetEmission;
		int _SwizzlingEmission;
		fixed4 _ColorNormal;
		int _SetNormal;
		int _SwizzlingNormal;

		void setAlbedo(inout SurfaceOutput o) {
			if (_SetAlbedo >= 1) {
				o.Albedo = _ColorAlbedo.rgb;
			}
		}

		void setEmission(inout SurfaceOutput o) {
			if (_SetEmission >= 1) {
				o.Emission = _ColorEmission.rgb;
			}
		}

		void setNormal(inout SurfaceOutput o) {
			if (_SetNormal >= 1) {
				o.Normal = _ColorNormal.rgb;
			}
		}

		void swizzleAlbedo(inout SurfaceOutput o) {
			switch (_SwizzlingAlbedo) {
				case 1:
					o.Albedo = _ColorAlbedo.rbg; break;
				case 2:
					o.Albedo = _ColorAlbedo.grb; break;
				case 3:
					o.Albedo = _ColorAlbedo.gbr; break;
				case 4:
					o.Albedo = _ColorAlbedo.brg; break;
				case 5:
					o.Albedo = _ColorAlbedo.bgr; break;
			}
		}

		void swizzleEmission(inout SurfaceOutput o) {
			switch (_SwizzlingEmission) {
				case 1:
					o.Emission = _ColorEmission.rbg; break;
				case 2:
					o.Emission = _ColorEmission.grb; break;
				case 3:
					o.Emission = _ColorEmission.gbr; break;
				case 4:
					o.Emission = _ColorEmission.brg; break;
				case 5:
					o.Emission = _ColorEmission.bgr; break;
			}
		}

		void swizzleNormal(inout SurfaceOutput o) {
			switch (_SwizzlingNormal) {
				case 1:
					o.Normal = _ColorNormal.rbg; break;
				case 2:
					o.Normal = _ColorNormal.grb; break;
				case 3:
					o.Normal = _ColorNormal.gbr; break;
				case 4:
					o.Normal = _ColorNormal.brg; break;
				case 5:
					o.Normal = _ColorNormal.bgr; break;
			}
		}

		void surf (Input IN, inout SurfaceOutput o) {
			setAlbedo(o);
			setEmission(o);
			setNormal(o);

			swizzleAlbedo(o);
			swizzleEmission(o);
			swizzleNormal(o);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
