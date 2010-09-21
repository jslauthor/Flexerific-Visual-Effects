package com.leonardsouza.interpolators
{
	import flash.geom.Point;
	
	import spark.effects.interpolation.IInterpolator;
	
	public class PointInterpolator implements IInterpolator
	{

		public function interpolate(fraction:Number, startValue:Object, endValue:Object):Object
		{
			var x:Number = getCurrent(fraction, Point(startValue).x, Point(endValue).x);
			var y:Number = getCurrent(fraction, Point(startValue).y, Point(endValue).y);
			return new Point(x, y);
		}
		
		public function increment(baseValue:Object, incrementValue:Object):Object
		{
			return baseValue.add(incrementValue);
		}
		
		public function decrement(baseValue:Object, decrementValue:Object):Object
		{
			return baseValue.subtract(decrementValue);
		}
		
		protected function getCurrent(fraction:Number, startValue:Number, endValue:Number):Number
		{
			return startValue - ((startValue - endValue) * fraction);
		}
		
	}
}