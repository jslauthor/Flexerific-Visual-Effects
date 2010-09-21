package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	public class RedChannelFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/shift_red.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _rOffset:Point = new Point();
		
		public function RedChannelFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}
		
		public function get rOffset():Point
		{
			return _rOffset;
		}
		
		public function set rOffset(value:Point):void
		{
			if (value == null) return;
			_rOffset = value;
			applyProperty('or', [value.x, value.y]);
			notifyFilterChanged();
		}
		
	}
}