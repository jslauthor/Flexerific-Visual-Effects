package com.leonardsouza.filters
{
	import com.leonardsouza.display.RGBA;
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.filters.BitmapFilter;
	
	public class HeatmapColorizeFilter extends ShaderFilterBase
	{		
		
		[Embed(source='assets/pixelbender/heatmap_colorizer_adjustable.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _high:RGBA;
		private var _mediumHigh:RGBA;
		private var _medium:RGBA;
		private var _lowMedium:RGBA;
		private var _low:RGBA;
		private var _lowest:RGBA;
		
		public function HeatmapColorizeFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s);
		}

		public function get high():RGBA
		{
			return _high;
		}

		public function set high(value:RGBA):void
		{
			_high = value;
			applyProperty('high', [value.red, value.green, value.blue]);
		}

		public function get mediumHigh():RGBA
		{
			return _mediumHigh;
		}

		public function set mediumHigh(value:RGBA):void
		{
			_mediumHigh = value;
			applyProperty('mediumHigh', [value.red, value.green, value.blue]);
		}

		public function get medium():RGBA
		{
			return _medium;
		}

		public function set medium(value:RGBA):void
		{
			_medium = value;
			applyProperty('medium', [value.red, value.green, value.blue]);
		}

		public function get lowMedium():RGBA
		{
			return _lowMedium;
		}

		public function set lowMedium(value:RGBA):void
		{
			_lowMedium = value;
			applyProperty('lowMedium', [value.red, value.green, value.blue]);
		}

		public function get low():RGBA
		{
			return _low;
		}

		public function set low(value:RGBA):void
		{
			_low = value;
			applyProperty('low', [value.red, value.green, value.blue]);
		}

		public function get lowest():RGBA
		{
			return _lowest;
		}

		public function set lowest(value:RGBA):void
		{
			_lowest = value;
			applyProperty('lowest', [value.red, value.green, value.blue]);
		}

	}
}