package com.leonardsouza.demos.flexerific.views.mediators
{
	import com.leonardsouza.demos.flexerific.events.AddHeatEvent;
	import com.leonardsouza.demos.flexerific.events.DominationEndEvent;
	import com.leonardsouza.demos.flexerific.events.LaunchDominationEvent;
	import com.leonardsouza.demos.flexerific.views.components.Domination;
	import com.leonardsouza.effects.DisplacementMapAnimate;
	
	import flash.display.BitmapDataChannel;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.BitmapAsset;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DominationMediator extends Mediator
	{
		
		[Inject]
		public var view:Domination;
		
		protected var _radarTimer:Timer;
		
		[Embed('/assets/images/heatmap_displacement.jpg')]
		protected var _displaceImageMap:Class;
		
		protected var _distressDisplace:DisplacementMapAnimate;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, LaunchDominationEvent.LAUNCH, function f():void 
			{ 
				view.currentState = 'enslavement';
			});
			eventMap.mapListener(view, AddHeatEvent.ADD_HEAT, function f(event:AddHeatEvent):void { dispatch(event); });
			eventMap.mapListener(view.enslavemenSequence, EffectEvent.EFFECT_END, function f(event:EffectEvent):void { dispatch(new DominationEndEvent(DominationEndEvent.DOMINATION_END)); });
			
			/* Timer for animating the Radar moving across the screen */
			
			_radarTimer = new Timer(30, 0);
			_radarTimer.addEventListener(TimerEvent.TIMER, moveCurve);
			
			ChangeWatcher.watch(view, "visible", updateVisible);
			view.currentState = 'freedom';
			
			/* This hurt performance too much than it already was
			_distressDisplace = new DisplacementMapAnimate();
			_distressDisplace.targets = [view.heatmap, view.targetLocatorContainer];
			_distressDisplace.image = _displaceImageMap;
			_distressDisplace.duration = 1;
			_distressDisplace.xComponent = BitmapDataChannel.RED;
			_distressDisplace.yComponent = BitmapDataChannel.GREEN;
			_distressDisplace.xFromScale = 70;
			_distressDisplace.yFromScale = 70;
			_distressDisplace.xToScale = 70;
			_distressDisplace.yToScale = 70;
			_distressDisplace.play();
			*/
		}
		
		protected function updateVisible(event:Event):void
		{
			if (view.visible)
			{
				_radarTimer.start();
				view.radar.prepareCurve();
			}
			else
			{
				_radarTimer.stop();
			}
		}
		
		protected function moveCurve(event:TimerEvent):void
		{
			view.radar.curveX += view.radar.curveX < view.width-75 ? 8 : -view.width+135; 
		}
	}
}