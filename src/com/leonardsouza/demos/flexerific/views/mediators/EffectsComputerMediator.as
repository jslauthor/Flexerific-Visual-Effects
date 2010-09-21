package com.leonardsouza.demos.flexerific.views.mediators
{
	import com.leonardsouza.demos.flexerific.events.ChangeViewStateEvent;
	import com.leonardsouza.demos.flexerific.events.DominationEndEvent;
	import com.leonardsouza.demos.flexerific.events.LoginFailedEvent;
	import com.leonardsouza.demos.flexerific.events.MasterShutdownEvent;
	import com.leonardsouza.demos.flexerific.events.UpdateBootConsoleTextEvent;
	import com.leonardsouza.demos.flexerific.views.components.EffectsComputer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	import mx.utils.ColorUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.Group;
	import spark.primitives.Rect;
	
	public class EffectsComputerMediator extends Mediator
	{
		
		[Inject]
		public var view:EffectsComputer;
		
		[Embed(source='/assets/docs/boot_console.txt', mimeType='application/octet-stream')]
		protected var bootConsoleText:Class;
		protected var bootConsoleArray:Array;
		
		
		protected var _bmd:BitmapData;
		protected var _verticalY:Number = 0;
		
		public function EffectsComputerMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			eventMap.mapListener(view.powerSymbol, MouseEvent.CLICK, toggleOnOff);
			eventMap.mapListener(view, ChangeViewStateEvent.CHANGE_STATE, changeState);
			eventMap.mapListener(eventDispatcher, ChangeViewStateEvent.CHANGE_STATE, changeState);
			eventMap.mapListener(view, UpdateBootConsoleTextEvent.UPDATE_CONSOLE, updateSystemBootConsole);
			eventMap.mapListener(eventDispatcher, DominationEndEvent.DOMINATION_END, function f():void {view.currentState = 'meltdown'; });
			eventMap.mapListener(eventDispatcher, LoginFailedEvent.LOGIN_FAILED, function f():void {view.currentState = 'denied'});
			eventMap.mapListener(view.meltdownSequence, EffectEvent.EFFECT_END, function f():void {dispatch(new MasterShutdownEvent(MasterShutdownEvent.SHUTDOWN)) });
			initialize();
		}
		
		protected function initialize():void
		{
			var bootConsoleString:String = ByteArray(new bootConsoleText()).toString();
			bootConsoleArray = bootConsoleString.split('\n');
		}
		
		protected function toggleOnOff(event:MouseEvent = null):void
		{
			/* 
			** So here is a nasty little side effect of calling state change events from transitions.
			** It calls end() instead of stop() in the middle of the transition, which fires off the change event
			** when it shouldn't. Basically it completes the effect, when the desired outcome is to stop it in the middle.
			*/
			view.preBootSequence.stop();
			view.bootingSequence.stop();
			view.currentState = view.currentState == 'off' ? 'preBoot' : 'off';
		}
		
		protected function changeState(event:ChangeViewStateEvent):void
		{
			view.currentState = event.state;
		}
		
		protected function updateSystemBootConsole(event:UpdateBootConsoleTextEvent):void
		{
			view.consoleText.text = "";

			for (var x:int = event.lineFrom; x < event.lineFrom + event.numLines; x++)
			{
				view.consoleText.text += bootConsoleArray[x] + '\n';
			}
		}
		
		protected function generateCrawl():void
		{
			//_bmd = new BitmapData(view.screenContent.width, view.screenContent.height, false, 0x7F7F7F);
			_bmd.fillRect(new Rectangle(0, 0, _bmd.width, _bmd.height), 0x7F7F7F);
			
			_bmd.fillRect(new Rectangle(0, _verticalY, _bmd.width, 2), ColorUtil.adjustBrightness(0, -50));
			_bmd.fillRect(new Rectangle(0, _verticalY+2, _bmd.width, 2), ColorUtil.adjustBrightness(0, -30));
			_bmd.fillRect(new Rectangle(0, _verticalY+4, _bmd.width, 2), 0);
			_bmd.fillRect(new Rectangle(0, _verticalY+6, _bmd.width, 2), ColorUtil.adjustBrightness(0, -30));
			_bmd.fillRect(new Rectangle(0, _verticalY+8, _bmd.width, 2), ColorUtil.adjustBrightness(0, -50));
			if (_verticalY <= view.screenContent.height)
				_verticalY += 5;
			else
				_verticalY = 0;
			
			/*	
				.setPixels( 
				.copyPixels(_verticalCrawl, new Rectangle(0, 0, 30, 50), new Point());
				*/
			//_bmd.draw(_verticalCrawl, _verticalCrawl.transform.matrix, null, null, new Rectangle(0, 0, 30, 50));

			/*
			view.screenContent.filters = new Array(
				new DisplacementMapFilter(_bmd, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED, 10, 0)
				);
			*/	
		}
		
	}
}