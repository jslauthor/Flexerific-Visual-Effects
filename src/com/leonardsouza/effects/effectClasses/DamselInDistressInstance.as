package com.leonardsouza.effects.effectClasses
{
	import com.leonardsouza.effects.generators.NoiseGenerator;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.EffectInstance;
	
	public class DamselInDistressInstance extends EffectInstance
	{

		public var distressAmount:Number;
		public var scaleSize:uint;

		private var _startTime:Number;
		private var _timer:Timer;
		private var _bmpContainer:UIComponent;
		private var _bmpHolder:Bitmap;
		private var _bmp0:BitmapData;
		private var _bmp1:BitmapData;
		private var _bmp2:BitmapData;
		private var _bmp3:BitmapData;
		private var _bmp4:BitmapData;
		private var _p0:Point;
		private var _pl:Array;
		private var _c:Array;
		private var _d:Array;
		private var _wx:Number;
		private var _vert:Number;
		private var _m:Matrix = new Matrix();
		private var _containerMatrix:Matrix = new Matrix();		
		private var _targetScale:Number;
		private var _targetWidth:Number;
		private var _targetHeight:Number;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function DamselInDistressInstance(target:Object)
		{
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  @private
		 */
		override public function initEffect(event:Event):void
		{
			super.initEffect(event);
		}		

		/**
		 *  @private
		 */
        override public function startEffect():void
        {
            _startTime = getTimer();
            initVars();
            drawChildren(); 
            if (target != Application.application) target.visible = false;
            super.startEffect();
        }

		/**
		 *  @private
		 */
		override public function play():void
		{
			super.play();
			if (isNaN(distressAmount))
				distressAmount = 12;

			_timer.start();
		}

		override public function pause():void
		{
			super.pause();
			createNoise(false);
			_timer.stop();
		}

		override public function resume():void
		{
			super.resume();
			_timer.start();
		}

		override public function end():void
		{
			_timer.stop();
			createNoise(false);
			destroyChildren();
			super.end();
			target.visible = true;
		}	

		override public function stop():void
		{
			super.stop();
			createNoise(false);
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private function initVars():void
		{
 			_timer = new Timer(20, 0);
			_timer.addEventListener(TimerEvent.TIMER, createDDEffect);
			_timer.addEventListener(Event.DEACTIVATE, function hi():void { trace("DamselInDistress Timer Deactivate") });
			
			_p0 = new Point(0, 0);
			_pl = new Array(new Point(0, 0), new Point(0, 0), new Point(0, 0));
			_c = new Array(Math.random() + 1, Math.random() + 1, Math.random());
			_d = new Array(0, 0, 0);
			_wx = 0.25;
			_vert = 0;
			_targetScale = getQualityScale();
			_m.scale(_targetScale*target.scaleX, _targetScale*target.scaleY); // Need to take original scaling into account
			_targetWidth = target.width * _targetScale;
			_targetHeight = target.height * _targetScale;
		}

		/**
		 *  @private
		 */
		private function getQualityScale():Number
		{
			if (target.width >= scaleSize)
			{
				return scaleSize / UIComponent(target).width;
			}
			else
			{
				return 1;
			}
		}

		/**
		 *  @private
		 */
		private function getContainerScale():Number
		{
			var num:Number = UIComponent(target).width / _bmpHolder.width;
			return num;
		}

		/**
		 *  @private
		 */
		private function invalidateContainer():void
		{
			_bmpContainer.width = _bmpHolder.width;
			_bmpContainer.height = _bmpHolder.height;
			_bmpContainer.x = target.x;
			_bmpContainer.y = target.y;
			var scaleNum:Number = getContainerScale();
			if (_containerMatrix.a != scaleNum)
			{
				_containerMatrix.scale(scaleNum, scaleNum);
				_bmpContainer.transform.matrix = _containerMatrix;
			}	
		}

		/**
		 *  @private
		 */
		private function drawChildren():void
		{
			createChildren();
			target.parent.addChildAt(_bmpContainer, target.parent.getChildIndex(target)+1);
		}

		/**
		 *  @private
		 */		
		private function destroyChildren():void
		{	
			try
			{
				if (target.parent.contains(_bmpContainer) != null)
					target.parent.removeChild(_bmpContainer);
			}
			catch (e:Error) {throw new Error(e.message);}
			
			_bmpHolder.bitmapData.dispose();
			_bmp0.dispose();
			_bmp1.dispose();
			_bmp2.dispose();
			_bmp3.dispose();
			
			_bmpHolder = null;
			_bmp0 = null;
			_bmp1 = null;
			_bmp2 = null;
			_bmp3 = null;
			
			System.gc();
			
			createChildren();			
		}		
	
		private function createChildren():void
		{
			_bmp0 = new BitmapData(_targetWidth, _targetHeight, true, 0);
			_bmp0.draw(UIComponent(target), _m);

			_bmp1 = _bmp0.clone();
			_bmp2 = _bmp0.clone();
			_bmp3 = _bmp0.clone();
			
			_bmpHolder = new Bitmap(_bmp1);
			_bmpContainer = new UIComponent();
			_bmpContainer.addChild(_bmpHolder);

			invalidateContainer();
		}
	
		/**
		 *  @private
		 */
		private function createDDEffect(evt:TimerEvent):void
		{
			
			if ( (getTimer() - _startTime) >= duration) end(); 
			
			for (var i:Number=3; i--;) {
				if (_c[i] >= 1) {
					_c[i]--;
					_d[i] = Math.random() / 4;
				}
				_c[i] += _d[i];
				_pl[i].x = Math.ceil(Math.sin(_c[i] * Math.PI * 2) * _d[i] * 32);
			}
			
			_bmp0.draw(UIComponent(target), _m);
			_bmp2 = _bmp0.clone();
			
			invalidateContainer();			
		
			var _o:Number;
			var _p:Number = (Math.abs(_pl[0].x) + Math.abs(_pl[1].x) + Math.abs(_pl[2].x) + distressAmount) / 4;
			
			for (var j:Number = _targetWidth; j--; ) 
			{
				//_o = (Math.random() + 1) * _p;
				_o = Math.sin(j / _targetWidth * (Math.random() / 8 + 1) * _wx * Math.PI * 2) * _p * _p * _wx;
				_bmp2.copyPixels(_bmp0, new Rectangle(_o, j, _targetWidth - _o, 1), new Point(0, j));
			}
			
			if (_p >= 4) _wx = Math.random() * 2;
			
			// Generate noise
			if (_wx < 1) 
			{
				_bmp3.noise(int(Math.random() * 1000), 0, 255, 1|2|4, false);
				var n:Number = _p * _p * _p;
				_bmp2.merge(_bmp3, _bmp2.rect, _p0, n, n, n, 0);
				createNoise(true);
			}
			else
			{
				createNoise(false);
			}
			
			// Vertical hold
			if (Math.random() < 0.01) _vert = 20;
			if (_vert > 0) 
			{
				_vert += 20;
				_vert %= _targetHeight;
				var _bmp4:BitmapData = _bmp2.clone();
				_bmp2.copyPixels(_bmp4, new Rectangle(0, 0, _targetWidth, _vert), new Point(0, target.height - _vert));
				_bmp2.copyPixels(_bmp4, new Rectangle(0, _vert, _targetWidth, _targetHeight - _vert), new Point(0, 0));
			}
			
			_bmp1.copyChannel(_bmp2, _bmp1.rect, _pl[0], 1, 1);
			_bmp1.copyChannel(_bmp2, _bmp1.rect, _pl[1], 2, 2);
			_bmp1.copyChannel(_bmp2, _bmp1.rect, _pl[2], 4, 4);
			
			if (!_timer.running) NoiseGenerator.stop();
		}
		
		private function createNoise(method:Boolean):void
		{
			if (method && !NoiseGenerator.isPlaying) 
				NoiseGenerator.play();
			else if (!method && NoiseGenerator.isPlaying)
				NoiseGenerator.stop();			
		}
		
	}
}