package com.leonardsouza.interpolators
{
	import spark.effects.interpolation.HSBInterpolator;
	import spark.effects.interpolation.IInterpolator;
	
	public class StringNumberInterpolator implements IInterpolator
	{
		
		public function interpolate(fraction:Number, startValue:Object, endValue:Object):Object
		{
			if (fraction == 0) return startValue;
			if (fraction == 1) return endValue;
			return Math.round(fraction * (Number(endValue) - Number(startValue)));
		}
		
		public function increment(baseValue:Object, incrementValue:Object):Object
		{
			return Number(baseValue) + Number(incrementValue);
		}
		
		public function decrement(baseValue:Object, decrementValue:Object):Object
		{
			return Number(baseValue) - Number(decrementValue);
		}
	}
}