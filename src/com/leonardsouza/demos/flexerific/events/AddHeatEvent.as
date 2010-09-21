package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class AddHeatEvent extends Event
	{
		
		public static const ADD_HEAT:String = "addHeat";
		
		public var position:Point;
		public var scaleXTo:Number
		public var scaleYTo:Number
		
		public function AddHeatEvent(type:String, position:Point, scaleXTo:Number, scaleYTo:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.position = position;
			this.scaleXTo = scaleXTo;
			this.scaleYTo = scaleYTo;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AddHeatEvent(type, position, scaleXTo, scaleYTo, bubbles, cancelable);
		}
		
	}
}