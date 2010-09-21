package com.leonardsouza.interpolators
{
	import com.leonardsouza.display.RGBA;
	
	import spark.effects.interpolation.IInterpolator;
	
	public class RGBAInterpolator implements IInterpolator
	{

		public function interpolate(fraction:Number, startValue:Object, endValue:Object):Object
		{
			var rgb:RGBA = new RGBA();
			rgb.red = getCurrent(fraction, RGBA(startValue).red, RGBA(endValue).red);
			rgb.green = getCurrent(fraction, RGBA(startValue).green, RGBA(endValue).green);
			rgb.blue = getCurrent(fraction, RGBA(startValue).blue, RGBA(endValue).blue);

			return rgb;
		}
		
		public function increment(baseValue:Object, incrementValue:Object):Object
		{
			return null;
		}
		
		public function decrement(baseValue:Object, decrementValue:Object):Object
		{
			return null;
		}
		
		protected function getCurrent(fraction:Number, startValue:Number, endValue:Number):Number
		{
			return startValue - ((startValue - endValue) * fraction);
		}
	}
}