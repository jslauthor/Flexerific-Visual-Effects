package com.leonardsouza.effects.supportClasses
{
	import com.leonardsouza.filters.DisplacementMapFilter;
	
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	
	import mx.events.EffectEvent;
	
	import spark.effects.animation.Animation;
	import spark.effects.animation.Keyframe;
	import spark.effects.animation.MotionPath;
	import spark.effects.supportClasses.AnimateInstance;
	
	public class DisplacementMapAnimateInstance extends AnimateInstance
	{
		
		public var currentXScale:Number;
		public var currentYScale:Number;
		
		private var _bitmapData:BitmapData;
		private var _xFromScale:Number;
		private var _yFromScale:Number;
		private var _xToScale:Number;
		private var _yToScale:Number;
		private var _xComponent:uint;
		private var _yComponent:uint;
		
		protected var _filter:DisplacementMapFilter;
		
		public function DisplacementMapAnimateInstance(target:Object)
		{
			super(target);
		}
		
		public function get yComponent():uint
		{
			return _yComponent;
		}
		
		public function set yComponent(value:uint):void
		{
			_yComponent = value;
		}
		
		public function get xComponent():uint
		{
			return _xComponent;
		}
		
		public function set xComponent(value:uint):void
		{
			_xComponent = value;
		}
		
		public function get yFromScale():Number
		{
			return _yFromScale;
		}
		
		public function set yFromScale(value:Number):void
		{
			_yFromScale = value;
		}
		
		public function get xFromScale():Number
		{
			return _xFromScale;
		}
		
		public function set xFromScale(value:Number):void
		{
			_xFromScale = value;
		}
		
		public function get yToScale():Number
		{
			return _yToScale;
		}
		
		public function set yToScale(value:Number):void
		{
			_yToScale = value;
		}
		
		public function get xToScale():Number
		{
			return _xToScale;
		}
		
		public function set xToScale(value:Number):void
		{
			_xToScale = value;
		}
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}
		
		/*
		** Overrides
		*/
		
		override public function play():void
		{
			var xScaleMotionPath:MotionPath = new MotionPath('xScale');
			var xScaleKeyframe1:Keyframe = new Keyframe(0, xFromScale);
			var xScaleKeyframe2:Keyframe = new Keyframe(duration, xToScale);
			xScaleMotionPath.keyframes = new Vector.<Keyframe>();
			xScaleMotionPath.keyframes.push(xScaleKeyframe1);
			xScaleMotionPath.keyframes.push(xScaleKeyframe2);
			
			var yScaleMotionPath:MotionPath = new MotionPath('yScale');
			var yScaleKeyframe1:Keyframe = new Keyframe(0, yFromScale);
			var yScaleKeyframe2:Keyframe = new Keyframe(duration, yToScale);
			yScaleMotionPath.keyframes = new Vector.<Keyframe>();
			yScaleMotionPath.keyframes.push(yScaleKeyframe1);
			yScaleMotionPath.keyframes.push(yScaleKeyframe2);
			
			motionPaths = new Vector.<MotionPath>();
			motionPaths.push(xScaleMotionPath);
			motionPaths.push(yScaleMotionPath);
			
			super.play();
		}
		
		protected function setDisplacementFilter(displacement:Object):void
		{
			var filters:Array = target.filters;
			var n:int = filters.length;
			for (var i:int = 0; i < n; i++)
			{
				if (filters[i] is DisplacementMapFilter)
					filters.splice (i, 1);
			}
			
			_filter = new DisplacementMapFilter(bitmapData, new Point(0, 0),
				xComponent, yComponent,
				displacement.xScale as Number, displacement.yScale as Number,
				DisplacementMapFilterMode.WRAP, 0.0, 0);
			filters.push(_filter);
			target.filters = filters;
			
			currentXScale = displacement.xScale;
			currentYScale = displacement.yScale;
		}
		
		override public function animationUpdate(animation:Animation):void
		{
			setDisplacementFilter(animation.currentValue);
		}
		
		override public function animationStop(animation:Animation):void
		{
			setDisplacementFilter(animation.currentValue);
			super.animationStop(animation);
		}

	}
}