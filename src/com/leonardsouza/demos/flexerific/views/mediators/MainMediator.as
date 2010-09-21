package com.leonardsouza.demos.flexerific.views.mediators
{
	
	import com.leonardsouza.demos.flexerific.events.MasterShutdownEvent;
	import com.leonardsouza.filters.HeatmapColorizeFilter;
	import com.leonardsouza.filters.RGBSplitterFilter;
	import com.leonardsouza.sound.AudioChannel;
	
	import flash.geom.Point;
	import flash.media.SoundTransform;
	
	import mx.core.SoundAsset;
	import mx.core.Window;
	import mx.effects.SoundEffect;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator
	{
		
		[Inject]
		public var view:Main;
		
		override public function preRegister():void
		{
			eventMap.mapListener(view, FlexEvent.APPLICATION_COMPLETE, function f():void 
			{ 
				view.currentState = 'credits';
			});
			
			eventMap.mapListener(view.loadingToCreditsTransition, EffectEvent.EFFECT_END, function f():void 
			{ 
				view.currentState = 'lit'; 
			});
			
			eventMap.mapListener(eventDispatcher, MasterShutdownEvent.SHUTDOWN, function f():void 
			{
				view.currentState = 'shutdown';
			}); 
		}
		
		
	}
}