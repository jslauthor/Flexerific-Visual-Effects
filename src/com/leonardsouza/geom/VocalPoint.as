package com.leonardsouza.geom
{

	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import mx.events.PropertyChangeEvent;
	
	public class VocalPoint extends EventDispatcher
	{
		
		protected var _x:Number;
		protected var _y:Number;
		
		public function VocalPoint(x:Number=0, y:Number=0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			var oldValue:Number = value;
			_x = value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, false, false, null, "x", oldValue, value)); 
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			var oldValue:Number = value;
			_y = value;
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, false, false, null, "y", oldValue, value)); 
		}
		
		override public function toString():String
		{
			return "X: " + _x + " Y: " + _y;
		}
		
	}
}