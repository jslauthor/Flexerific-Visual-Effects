package com.leonardsouza.effects.supportClasses
{
	import com.leonardsouza.util.math.MathUtil;
	
	import mx.core.IVisualElement;
	
	import spark.components.supportClasses.Range;
	import spark.effects.animation.Animation;
	import spark.effects.supportClasses.AnimateInstance;
	
	public class ShakeInstance3D extends AnimateInstance
	{
		
		private var _xRange:Range;
		private var _yRange:Range;
		private var _zRange:Range;
		
		public function ShakeInstance3D(target:Object)
		{
			super(target);
		}

		public function get zRange():Range
		{
			return _zRange;
		}

		public function set zRange(value:Range):void
		{
			_zRange = value;
		}

		public function get yRange():Range
		{
			return _yRange;
		}

		public function set yRange(value:Range):void
		{
			_yRange = value;
		}

		public function get xRange():Range
		{
			return _xRange;
		}

		public function set xRange(value:Range):void
		{
			_xRange = value;
		}
		
		/*
		** Overrides
		*/
		
		override public function animationUpdate(animation:Animation):void
		{
			if (animation.currentValue.hasOwnProperty('xRange'))
				target.x = MathUtil.randomRange(animation.currentValue.xRange.minimum, animation.currentValue.xRange.maximum);
			if (animation.currentValue.hasOwnProperty('yRange'))
				target.y = MathUtil.randomRange(animation.currentValue.yRange.minimum, animation.currentValue.yRange.maximum);
			if (animation.currentValue.hasOwnProperty('zRange'))
				target.z = MathUtil.randomRange(animation.currentValue.zRange.minimum, animation.currentValue.zRange.maximum);
		}
		
	}
}