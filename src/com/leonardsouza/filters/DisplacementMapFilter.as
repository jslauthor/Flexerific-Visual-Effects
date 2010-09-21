package com.leonardsouza.filters
{
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	
	import spark.filters.DisplacementMapFilter;
	
	public class DisplacementMapFilter extends spark.filters.DisplacementMapFilter
	{
		public function DisplacementMapFilter(mapBitmap:BitmapData=null, mapPoint:Point=null, componentX:uint=0, componentY:uint=0, scaleX:Number=0.0, scaleY:Number=0.0, mode:String="wrap", color:uint=0, alpha:Number=0.0)
		{
			super(mapBitmap, mapPoint, componentX, componentY, scaleX, scaleY, mode, color, alpha);
		}
		
		override public function clone():BitmapFilter
		{
			return new flash.filters.DisplacementMapFilter(mapBitmap, mapPoint, componentX, componentY, scaleX, scaleY, mode, color, alpha);
		}
	}
}