package com.leonardsouza.demos.flexerific.views.animations
{
	import com.leonardsouza.demos.flexerific.events.AddHeatEvent;
	import com.leonardsouza.easing.spark.Back;
	import com.leonardsouza.easing.spark.base.EaseInOutBase;
	
	import flash.geom.Point;
	
	import mx.effects.IEffectInstance;
	import mx.effects.Sequence;
	import mx.events.EffectEvent;
	
	import spark.effects.Move3D;
	
	[Event(name="addHeat", type="com.leonardsouza.demos.flexerific.events.AddHeatEvent")]
	
	public class DropPayload extends Sequence
	{

		private var _xTo:Number;
		private var _yTo:Number;
		private var _scaleXTo:Number = 10;
		private var _scaleYTo:Number = 10;
		private var _dropXOffset:Number = 7.5;
		private var _dropYOffset:Number = 7.5;
		private var _moveDuration:Number = 100;
		private var _easer:EaseInOutBase = new Back();
		
		public function DropPayload(target:Object=null)
		{
			super(target);
			initializeEffects()
		}

		public function get moveDuration():Number
		{
			return _moveDuration;
		}

		public function set moveDuration(value:Number):void
		{
			_moveDuration = value;
			initializeEffects();
		}

		public function get scaleYTo():Number
		{
			return _scaleYTo;
		}

		public function set scaleYTo(value:Number):void
		{
			_scaleYTo = value;
		}

		public function get scaleXTo():Number
		{
			return _scaleXTo;
		}

		public function set scaleXTo(value:Number):void
		{
			_scaleXTo = value;
		}

		public function get dropYOffset():Number
		{
			return _dropYOffset;
		}

		public function set dropYOffset(value:Number):void
		{
			_dropYOffset = value;
		}

		public function get dropXOffset():Number
		{
			return _dropXOffset;
		}

		public function set dropXOffset(value:Number):void
		{
			_dropXOffset = value;
		}

		public function get easer():EaseInOutBase
		{
			return _easer;
		}

		public function set easer(value:EaseInOutBase):void
		{
			_easer = value;
			initializeEffects();
		}

		public function get yTo():Number
		{
			return _yTo;
		}

		public function set yTo(value:Number):void
		{
			_yTo = value;
			initializeEffects()
		}

		public function get xTo():Number
		{
			return _xTo;
		}

		public function set xTo(value:Number):void
		{
			_xTo = value;
			initializeEffects();
		}

		protected function initializeEffects():void
		{
			children = new Array();
			
			var move:Move3D = new Move3D(target);
			move.xTo = xTo;
			move.yTo = yTo;
			move.duration = moveDuration;
			easer.easeType = EaseInOutBase.EASE_OUT;
			move.easer = easer;
			
			var blink:Blink = new Blink(target);
			blink.addEventListener(EffectEvent.EFFECT_END, 
				function():void 
				{ 
					dispatchEvent(new AddHeatEvent(AddHeatEvent.ADD_HEAT, new Point(xTo + dropXOffset, yTo + dropYOffset), scaleXTo, scaleYTo));
				});
			
			children.push(move);
			children.push(blink);
		}
	}
}