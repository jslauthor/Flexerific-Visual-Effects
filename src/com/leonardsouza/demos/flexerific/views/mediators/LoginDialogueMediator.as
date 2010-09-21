package com.leonardsouza.demos.flexerific.views.mediators
{
	
	import com.leonardsouza.demos.flexerific.events.ChangeViewStateEvent;
	import com.leonardsouza.demos.flexerific.events.LoginFailedEvent;
	import com.leonardsouza.demos.flexerific.views.components.LoginDialogue;
	import com.leonardsouza.effects.DisplacementMapAnimate;
	import com.leonardsouza.filters.DisplacementMapFilter;
	import com.leonardsouza.util.math.MathUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.BitmapAsset;
	import mx.core.FlexGlobals;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.supportClasses.Range;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.RepeatBehavior;
	
	public class LoginDialogueMediator extends Mediator
	{
		
		[Inject]
		public var view:LoginDialogue;
		
		protected var _numberOfTries:int = 0;
		protected var _maxTries:int = 3;
		
		protected var _distressDisplace:DisplacementMapAnimate;
		
		[Embed('/assets/images/displace.jpg')]
		protected var _displaceImageMap:Class;
		
		public function LoginDialogueMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.submitButton, MouseEvent.CLICK, verifyLogin);
			eventMap.mapListener(view.verifySecurity, EffectEvent.EFFECT_END, afterVerifyAnimation);
			eventMap.mapListener(view, LoginFailedEvent.LOGIN_FAILED, function f():void {dispatch(new LoginFailedEvent(LoginFailedEvent.LOGIN_FAILED));});
			eventMap.mapListener(view, Event.ADDED_TO_STAGE, function f():void { _numberOfTries = 0;});
			eventMap.mapListener(view.distressAddAction, EffectEvent.EFFECT_END, playDisplace);
			eventMap.mapListener(view.failureFade, EffectEvent.EFFECT_START, function f():void 
			{
				_distressDisplace.xToScale = MathUtil.randomRange(600, 700);
				_distressDisplace.yToScale = MathUtil.randomRange(600, 700);
				_distressDisplace.repeatCount = 1;
				_distressDisplace.duration = 750;
				_distressDisplace.stop();
				_distressDisplace.play();
			});
			eventMap.mapListener(view.fromDistress, EffectEvent.EFFECT_END, function f():void { _distressDisplace.stop(); });
			eventMap.mapListener(IEventDispatcher(FlexGlobals.topLevelApplication), KeyboardEvent.KEY_DOWN, keyboardListener); 
			
			ChangeWatcher.watch(view, "visible", updateVisible);
		}
		
		protected function updateVisible(event:Event):void
		{
			if (view.visible)
			{
				view.motionBackground.prepareCurves();
			}
		}
		
		protected function keyboardListener(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER)
				verifyLogin();
		}
		
		protected function verifyLogin(event:MouseEvent = null):void
		{
			if (view.verifySecurity.isPlaying || view.distressSequence.isPlaying) return;
			view.verifySecurity.play();	
		}
		
		protected function playDisplace(event:EffectEvent):void
		{
			if (!_distressDisplace)
			{
				_distressDisplace = new DisplacementMapAnimate();
				_distressDisplace.image = _displaceImageMap;
				_distressDisplace.target = view.distress;
				_distressDisplace.repeatBehavior = RepeatBehavior.REVERSE;
			}

			switch (_numberOfTries)
			{
				case 0:
				case _maxTries-2:
					_distressDisplace.xFromScale = 0;
					_distressDisplace.yFromScale = 0;
					_distressDisplace.xToScale = MathUtil.randomRange(100, 200);
					_distressDisplace.yToScale = MathUtil.randomRange(100, 200);
					_distressDisplace.repeatCount = 0;
					_distressDisplace.duration = 850;
					view.distressAlpha.alphaFrom = 0;
					view.distressAlpha.alphaTo = .4;
					view.distressAlpha.play();
					_distressDisplace.play();
					break;
				case _maxTries-1: 
					_distressDisplace.xToScale = MathUtil.randomRange(350, 500);
					_distressDisplace.yToScale = MathUtil.randomRange(350, 500);
					_distressDisplace.repeatCount = 0;
					_distressDisplace.duration = 500;
					view.distressAlpha.alphaFrom = view.distress.alpha;
					view.distressAlpha.alphaTo = .6;
					view.distressAlpha.play();
					_distressDisplace.play();
					break;
				default:
					break;
			}
			
			
		}
		
		protected function afterVerifyAnimation(event:EffectEvent):void
		{
			// Normally we would create an event that would dispatch the login/password to a command to verify
			// but we will simply do it here 
			
			var username:String = view.loginInput.text;
			var password:String = view.passwordInput.text;
			
			if (username.toUpperCase() == 'aldious'.toUpperCase() 
				&& password.toUpperCase() == 'endoftheworld'.toUpperCase())
			{
				dispatch(new ChangeViewStateEvent(ChangeViewStateEvent.CHANGE_STATE, 'authenticated'));
			}
			else
			{
				if (_numberOfTries < _maxTries - 1)
				{
					if (view.currentState != 'distress')
					{
						view.currentState = 'distress';
					}
					else if (view.currentState == 'distress')
					{
						view.distressSequence.play();
					}
				}
				else
				{
					view.currentState = 'failure';
					view.loginInput.text = "";
					view.passwordInput.text = "";
					_numberOfTries = -1;
				}

				_numberOfTries++;
			}			
		}
	}
}