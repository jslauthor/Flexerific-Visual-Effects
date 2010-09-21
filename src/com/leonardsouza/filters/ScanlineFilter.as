package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	
	import spark.filters.ShaderFilter;
	
	public class ScanlineFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/scanline.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _spacing:Number;
		private var _brightness:Number;
		
		public function ScanlineFilter() 
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}
		
		public function get brightness():Number
		{
			return _brightness;
		}

		public function set brightness(value:Number):void
		{
			_brightness = value;
			applyProperty('brightness', value);
		}

		public function get spacing():Number
		{
			return _spacing;
		}

		public function set spacing(value:Number):void
		{
			_spacing = value;
			applyProperty('spacing', value);
		}
		
	}
}