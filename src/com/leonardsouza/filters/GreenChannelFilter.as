package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	public class GreenChannelFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/shift_green.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _gOffset:Point = new Point();
		
		public function GreenChannelFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}
		
		public function get gOffset():Point
		{
			return _gOffset;
		}
		
		public function set gOffset(value:Point):void
		{
			if (value == null) return;
			_gOffset = value;
			applyProperty('og', [value.x, value.y]);
			notifyFilterChanged();
		}
		
	}
}