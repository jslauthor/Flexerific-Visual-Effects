package com.leonardsouza.demos.flexerific.contexts
{
	
	import com.leonardsouza.demos.flexerific.views.components.ControlBars;
	import com.leonardsouza.demos.flexerific.views.components.Domination;
	import com.leonardsouza.demos.flexerific.views.components.EffectsComputer;
	import com.leonardsouza.demos.flexerific.views.components.Heatmap;
	import com.leonardsouza.demos.flexerific.views.components.LoginDialogue;
	import com.leonardsouza.demos.flexerific.views.mediators.ControlBarsMediator;
	import com.leonardsouza.demos.flexerific.views.mediators.DominationMediator;
	import com.leonardsouza.demos.flexerific.views.mediators.EffectsComputerMediator;
	import com.leonardsouza.demos.flexerific.views.mediators.HeatmapMediator;
	import com.leonardsouza.demos.flexerific.views.mediators.LoginDialogueMediator;
	import com.leonardsouza.demos.flexerific.views.mediators.MainMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class FlexerificContext extends Context
	{
		public function FlexerificContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			// Map views
			mediatorMap.mapView(Main, MainMediator);
			mediatorMap.mapView(EffectsComputer, EffectsComputerMediator);
			mediatorMap.mapView(LoginDialogue, LoginDialogueMediator);
			mediatorMap.mapView(Domination, DominationMediator);
			mediatorMap.mapView(ControlBars, ControlBarsMediator);
			mediatorMap.mapView(Heatmap, HeatmapMediator);
		}
		
	}
}