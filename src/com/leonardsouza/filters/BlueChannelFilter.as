package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	public class BlueChannelFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/shift_blue.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _bOffset:Point = new Point();
		
		public function BlueChannelFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}
		
		public function get bOffset():Point
		{
			return _bOffset;
		}
		
		public function set bOffset(value:Point):void
		{
			if (value == null) return;
			_bOffset = value;
			applyProperty('ob', [value.x, value.y]);
			notifyFilterChanged();
		}
	}
}