package com.leonardsouza.demos.flexerific.views.components
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	import spark.primitives.Ellipse;
	
	public class SystemIndicator extends Ellipse
	{
		
		private var _shouldFlicker:Boolean;
		protected var _flickerTimer:Timer = new Timer(0, 0);
		
		public var range:Object = {max:500, min:10};
		
		public function SystemIndicator() 
		{ 
			super();
			_flickerTimer.addEventListener(TimerEvent.TIMER, toggleFlicker);
		}
		
		public function get shouldFlicker():Boolean
		{
			return _shouldFlicker;
		}

		public function set shouldFlicker(value:Boolean):void
		{
			_shouldFlicker = value;
			if (_shouldFlicker)
			{
				if (!_flickerTimer.running) { _flickerTimer.start(); }
			}
			else
			{
				if (_flickerTimer.running) { _flickerTimer.stop(); }
				alpha = 1;
			}
		}

		protected function toggleFlicker(event:TimerEvent):void
		{
			alpha = alpha > .4 ? .4 : 1;
			_flickerTimer.delay = randomRange(500, 10);
		}
		
		protected function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (range.max - range.min) + range.min;
		}
		
	}
}