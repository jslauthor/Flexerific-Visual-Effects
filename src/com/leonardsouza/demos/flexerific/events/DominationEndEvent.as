package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class DominationEndEvent extends Event
	{
		
		public static const DOMINATION_END:String = 'dominationEnd'; 
		
		public function DominationEndEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}