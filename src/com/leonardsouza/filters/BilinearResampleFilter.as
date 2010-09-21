package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	
	public class BilinearResampleFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/bilinearresample.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _scale:Number;
		
		public function BilinearResampleFilter(scale:Number = 2)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
			
			this.scale = scale;
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
			applyProperty('scale', value);
		}

	}
}