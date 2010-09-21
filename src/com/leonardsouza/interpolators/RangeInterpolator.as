package com.leonardsouza.interpolators
{
	import spark.components.supportClasses.Range;
	import spark.effects.interpolation.IInterpolator;
	
	public class RangeInterpolator implements IInterpolator
	{
		
		public function interpolate(fraction:Number, startValue:Object, endValue:Object):Object
		{
			var range:Range = new Range();
			range.minimum = getCurrent(fraction, Range(startValue).minimum, Range(endValue).minimum);
			range.maximum = getCurrent(fraction, Range(startValue).maximum, Range(endValue).maximum);
			
			return range;
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