package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	public class HeatmapGreyscaleFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/heatmap_greyscale.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _radius:uint = 2;
		private var _position:Point = new Point();
		
		public function HeatmapGreyscaleFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			applyProperty('position', [value.x, value.y]);
		}

		public function get radius():uint
		{
			return _radius;
		}

		public function set radius(value:uint):void
		{
			_radius = value;
			applyProperty('radius', value);
		}

	}
}