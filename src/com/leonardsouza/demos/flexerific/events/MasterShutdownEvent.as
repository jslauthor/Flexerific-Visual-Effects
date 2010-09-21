package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class MasterShutdownEvent extends Event
	{
		
		public static const SHUTDOWN:String = "shutdown";
		
		public function MasterShutdownEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}