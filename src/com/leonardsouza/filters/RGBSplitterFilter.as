package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	import spark.filters.ShaderFilter;
	
	public class RGBSplitterFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/rgb_splitter.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _rOffset:Point = new Point();
		private var _gOffset:Point = new Point();
		private var _bOffset:Point = new Point();
		
		public function RGBSplitterFilter()
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