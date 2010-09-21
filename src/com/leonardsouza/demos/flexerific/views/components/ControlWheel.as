package com.leonardsouza.demos.flexerific.views.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.supportClasses.TrackBase;
	import spark.events.TrackBaseEvent;
	import spark.primitives.Ellipse;
	import spark.skins.spark.VSliderSkin;
	
	public class ControlWheel extends TrackBase
	{
		
		protected var _previousPoint:Point;
		protected var _trackWasOrigin:Boolean; 
		
		public function ControlWheel()
		{
			super();
		}
		
		override public function set maximum(value:Number):void
		{
			super.maximum = value;
		}
		
		[Bindable]
		override public function get maximum():Number
		{
			return super.maximum;
		}
		
		/*
		** Method Overrides
		*/
		
		override protected function pointToValue(x:Number, y:Number):Number
		{
			if (!track) return 0;

			var p:Point = globalToLocal(new Point(x, y));
			var newPoint:Point = new Point(p.x - width/2, p.y - height/2);
			
			var atan:Number = Math.atan2(newPoint.y, newPoint.x) * 180/Math.PI;
			var degree:Number = atan > 0 ? atan : (180 + atan) + 180; 
			var percentage:Number = degree / 360;  
			
			return nearestValidValue(maximum * percentage, snapInterval); 
		}

		override protected function track_mouseDownHandler(event:MouseEvent):void
		{
			if (!enabled)
				return;

			var newValue:Number = pointToValue(event.stageX, event.stageY);
			
			if (newValue != value)
			{
				setValue(newValue);
				dispatchEvent(new Event(Event.CHANGE));
			}
			
			_trackWasOrigin = true;
			
			systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, 
				system_mouseMoveHandler, true);
			systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, 
				system_mouseUpHandler, true);
			systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, 
				system_mouseUpHandler);
			
			event.updateAfterEvent();
		}
		
		override protected function system_mouseMoveHandler(event:MouseEvent):void
		{
			var p:Point;
			var newValue:Number;
			
			if (!_trackWasOrigin)
			{
				p = new Point(event.stageX, event.stageY);
				if (_previousPoint == null) _previousPoint = p;
				
				var interval:Number = p.y > _previousPoint.y ? -snapInterval : snapInterval;
				newValue = nearestValidValue(value + interval, snapInterval);
				_previousPoint = p;
			}
			else
			{
				newValue = pointToValue(event.stageX, event.stageY);
			}
			
			if (newValue != value)
			{
				setValue(newValue); 
				dispatchEvent(new Event(Event.CHANGE));
			}
			
			event.updateAfterEvent();
		}

		override protected function system_mouseUpHandler(event:Event):void
		{
			_trackWasOrigin = false;
			
			systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, 
				system_mouseMoveHandler, true);
			systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, 
				system_mouseUpHandler, true);
			systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, 
				system_mouseUpHandler);
			
			dispatchEvent(new FlexEvent(FlexEvent.CHANGE_END));
		}
		
	}
}