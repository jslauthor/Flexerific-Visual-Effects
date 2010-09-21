package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class ChangeViewStateEvent extends Event
	{
		
		static public const CHANGE_STATE:String = "changeState";
		
		public var state:String;
		
		public function ChangeViewStateEvent(type:String, state:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.state = state;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ChangeViewStateEvent(type, state, bubbles, cancelable);
		}
	}
}