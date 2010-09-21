package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class LaunchDominationEvent extends Event
	{
		
		public static const LAUNCH:String = "launch";
		
		public function LaunchDominationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new LaunchDominationEvent(type, bubbles, cancelable);
		}
		
	}
}