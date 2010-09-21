package com.leonardsouza.util.math
{
	public class MathUtil
	{
		public static function randomRange(min:Number = 0, max:Number = 0) :Number
		{
			return Math.random() * (max - min) + min;
		}
	}
}