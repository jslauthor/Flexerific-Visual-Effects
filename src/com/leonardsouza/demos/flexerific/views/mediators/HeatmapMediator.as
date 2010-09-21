package com.leonardsouza.demos.flexerific.views.mediators
{
	import com.leonardsouza.demos.flexerific.events.AddHeatEvent;
	import com.leonardsouza.demos.flexerific.events.LaunchDominationEvent;
	import com.leonardsouza.demos.flexerific.views.components.Heatmap;
	import com.leonardsouza.demos.flexerific.views.components.HeatmapEllipse;
	import com.leonardsouza.sound.AudioChannel;
	
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.core.DisplayObjectSharingMode;
	import spark.effects.Resize;
	import spark.effects.Scale;

	public class HeatmapMediator extends Mediator
	{
		
		[Inject]
		public var view:Heatmap;
		
		[Embed('/assets/audio/explosion.mp3')]
		private var audioFile:Class;
		
		public function HeatmapMediator() { super(); }
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, AddHeatEvent.ADD_HEAT, addHeat);
			view.heatmapEllipses.removeAllElements();
		}

		override public function onRemove():void
		{
			view.heatmapEllipses.removeAllElements();
		}
		
		protected function addHeat(event:AddHeatEvent):void
		{
			var bomb:AudioChannel = new AudioChannel();
			bomb.source = audioFile;
			bomb.volume = .35;
			bomb.play();
			
			var heatmapEllipse:HeatmapEllipse = new HeatmapEllipse();
			heatmapEllipse.width = 10;
			heatmapEllipse.height = 10;
			heatmapEllipse.blendMode = BlendMode.ADD;
			heatmapEllipse.displayObjectSharingMode = DisplayObjectSharingMode.OWNS_UNSHARED_OBJECT;
			
			view.heatmapEllipses.addElement(heatmapEllipse);
			heatmapEllipse.x = event.position.x;
			heatmapEllipse.y = event.position.y;
			
			var scale:Scale = new Scale(heatmapEllipse);
			scale.autoCenterTransform = true;
			scale.duration = 1500;
			scale.scaleXBy = event.scaleXTo;
			scale.scaleYBy = event.scaleYTo;
			scale.play();
		}
	}
}