package com.leonardsouza.demos.flexerific.views.mediators
{
	import com.leonardsouza.demos.flexerific.events.LaunchDominationEvent;
	import com.leonardsouza.demos.flexerific.views.components.ControlBars;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ControlBarsMediator extends Mediator
	{
		
		[Inject]
		public var view:ControlBars;
		
		public function ControlBarsMediator() { super(); }
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, view.START_LAUNCH, function f():void 
			{
				dispatch(new LaunchDominationEvent(LaunchDominationEvent.LAUNCH));
			});
			
			eventMap.mapListener(view.launchButton, MouseEvent.CLICK, function f():void 
			{
				view.currentState = 'launch';
			});
		}
	}
}