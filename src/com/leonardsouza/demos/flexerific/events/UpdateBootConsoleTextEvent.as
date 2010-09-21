package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class UpdateBootConsoleTextEvent extends Event
	{
		
		static public const UPDATE_CONSOLE:String = "updateConsole";
		
		public var lineFrom:int;
		public var numLines:int;
		
		public function UpdateBootConsoleTextEvent(type:String, from:int = 0, num:int = 5, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			lineFrom = from;
			numLines = num;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new UpdateBootConsoleTextEvent(type, lineFrom, numLines, bubbles, cancelable);
		}
	}
}