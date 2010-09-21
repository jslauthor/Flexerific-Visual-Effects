package com.leonardsouza.demos.flexerific.events
{
	import flash.events.Event;
	
	public class LoginFailedEvent extends Event
	{
		
		public static const LOGIN_FAILED:String = 'loginFailed';
		
		public function LoginFailedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}