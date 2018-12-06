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

		_Specular ("Specular", Range(0,1)) = 1
		_Gloss ("Gloss", Range(0,1)) = 1
		_Alpha ("Alpha", Range(0,1)) = 1
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert alpha

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

		fixed _Alpha;

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
					o.Albedo = o.Albedo.rbg; break;
				case 2:
					o.Albedo = o.Albedo.grb; break;
				case 3:
					o.Albedo = o.Albedo.gbr; break;
				case 4:
					o.Albedo = o.Albedo.brg; break;
				case 5:
					o.Albedo = o.Albedo.bgr; break;
			}
		}

		void swizzleEmission(inout SurfaceOutput o) {
			switch (_SwizzlingEmission) {
				case 1:
					o.Emission = o.Emission.rbg; break;
				case 2:
					o.Emission = o.Emission.grb; break;
				case 3:
					o.Emission = o.Emission.gbr; break;
				case 4:
					o.Emission = o.Emission.brg; break;
				case 5:
					o.Emission = o.Emission.bgr; break;
			}
		}

		void swizzleNormal(inout SurfaceOutput o) {
			switch (_SwizzlingNormal) {
				case 1:
					if (_SetNormal >= 1) o.Normal = o.Normal.rbg; break;
				case 2:
					if (_SetNormal >= 1) o.Normal = o.Normal.grb; break;
				case 3:
					if (_SetNormal >= 1) o.Normal = o.Normal.gbr; break;
				case 4:
					if (_SetNormal >= 1) o.Normal = o.Normal.brg; break;
				case 5:
					if (_SetNormal >= 1) o.Normal = o.Normal.bgr; break;
			}
		}

		void surf (Input IN, inout SurfaceOutput o) {
			setAlbedo(o);
			setEmission(o);
			setNormal(o);

			swizzleAlbedo(o);
			swizzleEmission(o);
			swizzleNormal(o);

			o.Alpha = _Alpha;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
