package com.leonardsouza.filters
{
	import com.leonardsouza.display.RGBA;
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	
	public class RGBSineDistortion extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/sin_wave_distortion.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _intensityRGB:RGBA;
		private var _directionRGB:RGBA;
		private var _frequencyRGB:RGBA;
		
		public function RGBSineDistortion(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}
		
		public function get frequencyRGB():RGBA
		{
			return _frequencyRGB;
		}

		public function set frequencyRGB(value:RGBA):void
		{
			if (value == null) return;
			_frequencyRGB = value;
			applyProperty('frequencyRGB', [value.red, value.green, value.blue]);
			notifyFilterChanged();
		}

		public function get directionRGB():RGBA
		{
			return _directionRGB;
		}

		public function set directionRGB(value:RGBA):void
		{
			if (value == null) return;
			_directionRGB = value;
			applyProperty('directionRGB', [value.red, value.green, value.blue]);
			notifyFilterChanged();
		}

		public function get intensityRGB():RGBA
		{
			return _intensityRGB;
		}

		public function set intensityRGB(value:RGBA):void
		{
			if (value == null) return;
			_intensityRGB = value;
			applyProperty('intensityRGB', [value.red, value.green, value.blue]);
			notifyFilterChanged();
		}

	}
}