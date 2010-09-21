package com.leonardsouza.effects
{
	
	// A lot of this was taken from the Flex 4 Cookbook, which something you should buy, it's great!
	
	import com.leonardsouza.effects.supportClasses.DisplacementMapAnimateInstance;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.EventDispatcher;
	
	import mx.core.BitmapAsset;
	import mx.effects.IEffectInstance;
	import mx.events.EffectEvent;
	
	import spark.effects.Animate;
	
	public class DisplacementMapAnimate extends Animate
	{
		
		private var _image:Class;
		private var _xFromScale:Number = 0;
		private var _yFromScale:Number = 0;
		private var _xToScale:Number = 100;
		private var _yToScale:Number = 100;
		private var _xComponent:uint = BitmapDataChannel.BLUE;
		private var _yComponent:uint = BitmapDataChannel.RED;
		
		protected var _instance:DisplacementMapAnimateInstance;
		
		public function DisplacementMapAnimate(target:Object=null)
		{
			super(target);
			this.instanceClass = DisplacementMapAnimateInstance;
		}

		public function get yComponent():uint
		{
			return _yComponent;
		}

		public function set yComponent(value:uint):void
		{
			_yComponent = value;
			updateProperties();
		}

		public function get xComponent():uint
		{
			return _xComponent;
		}

		public function set xComponent(value:uint):void
		{
			_xComponent = value;
			updateProperties();
		}

		public function get yFromScale():Number
		{
			return _yFromScale;
		}

		public function set yFromScale(value:Number):void
		{
			_yFromScale = value;
			updateProperties();
		}

		public function get xFromScale():Number
		{
			return _xFromScale;
		}

		public function set xFromScale(value:Number):void
		{
			_xFromScale = value;
			updateProperties();
		}

		public function get yToScale():Number
		{
			return _yToScale;
		}
		
		public function set yToScale(value:Number):void
		{
			_yToScale = value;
			updateProperties();
		}
		
		public function get xToScale():Number
		{
			return _xToScale;
		}
		
		public function set xToScale(value:Number):void
		{
			_xToScale = value;
			updateProperties();
		}
		
		
		public function get image():Class
		{
			return _image;
		}

		public function set image(value:Class):void
		{
			_image = value;
			updateProperties();
		}
		
		protected function updateProperties():void
		{
			if (_instance == null) return;
			DisplacementMapAnimateInstance(_instance).bitmapData = (new image() as BitmapAsset).bitmapData;
			DisplacementMapAnimateInstance(_instance).xFromScale = xFromScale;
			DisplacementMapAnimateInstance(_instance).yFromScale = yFromScale;
			DisplacementMapAnimateInstance(_instance).xToScale = xToScale;
			DisplacementMapAnimateInstance(_instance).yToScale = yToScale;
			DisplacementMapAnimateInstance(_instance).xComponent = xComponent;
			DisplacementMapAnimateInstance(_instance).yComponent = yComponent;	
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			_instance = DisplacementMapAnimateInstance(instance);
			updateProperties();
		}
		
		override public function getAffectedProperties():Array
		{
			return [];
		}
		
		override public function play(targets:Array=null, playReversedFromEnd:Boolean=false):Array
		{
			if (DisplacementMapAnimateInstance(_instance))
			{
				xFromScale = DisplacementMapAnimateInstance(_instance).currentXScale;
				yFromScale = DisplacementMapAnimateInstance(_instance).currentYScale;
			}
			return super.play(targets, playReversedFromEnd);
		}

		/*

		override public function createInstance(target:Object=null):IEffectInstance
		{
			var newInstance:IEffectInstance = super.createInstance(target);
			
			if (newInstance)
			EventDispatcher(newInstance).addEventListener(EffectEvent.EFFECT_UPDATE, effectUpdateHandler);
			
			return newInstance;
		}
		
		
		override public function deleteInstance(instance:IEffectInstance):void
		{
			EventDispatcher(instance).removeEventListener(
			EffectEvent.EFFECT_UPDATE, effectUpdateHandler);
			
			super.deleteInstance(instance);
		}
		
		protected function effectUpdateHandler(event:EffectEvent):void
		{
		
		}
		
		*/
		
	}
}