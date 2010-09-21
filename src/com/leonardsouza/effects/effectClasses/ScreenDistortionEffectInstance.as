package com.leonardsouza.effects.effectClasses
{
	import com.leonardsouza.effects.enum.EffectQuality;
	import com.leonardsouza.filters.DisplacementMapFilter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.UIComponent;
	import mx.graphics.GradientEntry;
	import mx.graphics.LinearGradient;
	
	import spark.components.Group;
	import spark.effects.supportClasses.AnimateFilterInstance;
	import spark.primitives.Rect;
	
	public class ScreenDistortionEffectInstance extends AnimateFilterInstance
	{
		private var _verticalCrawlX:Number;
		private var _verticalCrawlHeight:Number;
		private var _showVerticalCrawl:Boolean = true;
		private var _scaleToTarget:Boolean = true;
		private var _quality:String;

		protected var _bmd:BitmapData; 
		protected var _neutral:Number = 0x007F7F7F;
		protected var _verticalCrawl:Group;
		
		public function ScreenDistortionEffectInstance(target:Object)
		{
			super(target);
		}
		
		public function get quality():String
		{
			return _quality;
		}

		public function set quality(value:String):void
		{
			_quality = value;
			
			if (_bmd) _bmd.dispose();
			switch (value)
			{
				default:
				case EffectQuality.LOW:
					_bmd = new BitmapData(120, 120, true, _neutral);
					break;
				case EffectQuality.MEDIUM:
					_bmd = new BitmapData(300, 300, true, _neutral);
					break;
				case EffectQuality.HIGH:
					_bmd = new BitmapData(500, 500, true, _neutral);
					break;
			}
		}

		public function get scaleToTarget():Boolean
		{
			return _scaleToTarget;
		}

		public function set scaleToTarget(value:Boolean):void
		{
			_scaleToTarget = value;
			if (!target || !bitmapFilter) return; 
			
			if (_scaleToTarget)
			{
				DisplacementMapFilter(bitmapFilter).scaleX = UIComponent(target).width / _bmd.width;
				DisplacementMapFilter(bitmapFilter).scaleY = UIComponent(target).height / _bmd.height;
			}
			else
			{
				DisplacementMapFilter(bitmapFilter).scaleX = DisplacementMapFilter(bitmapFilter).scaleY = 1;
			}
			render();
		}

		public function get showVerticalCrawl():Boolean
		{
			return _showVerticalCrawl;
		}

		public function set showVerticalCrawl(value:Boolean):void
		{
			_showVerticalCrawl = value;
			render();
		}

		public function get verticalCrawlHeight():Number
		{
			return _verticalCrawlHeight;
		}

		public function set verticalCrawlHeight(value:Number):void
		{
			_verticalCrawlHeight = value;
			render();
		}

		public function get verticalCrawlX():Number
		{
			return _verticalCrawlX;
		}

		public function set verticalCrawlX(value:Number):void
		{
			_verticalCrawlX = value;
			render();
		}

		/*
		** Protected methods
		*/
		
		protected function render():void
		{
			
			if (!target || !bitmapFilter) return; 

			if (showVerticalCrawl)
			{
				if (!_verticalCrawl) generateCrawl();
				_bmd.draw(_verticalCrawl);
			}
			
			DisplacementMapFilter(bitmapFilter).mapBitmap = _bmd;
			trace(getQualifiedClassName(DisplacementMapFilter(bitmapFilter)));
		}
		
		protected function generateCrawl():void
		{
			var rect:Rect = new Rect();
			rect.width = _bmd.width;
			rect.height = verticalCrawlHeight;
			var grad:LinearGradient = new LinearGradient();
			grad.entries = 
			[
				new GradientEntry(0, 0, 1),
				new GradientEntry(_neutral, 0, 1),
				new GradientEntry(0, 0, 1)
			];
			rect.fill = grad;
			
			_verticalCrawl = new Group();
			_verticalCrawl.width = _bmd.width;
			_verticalCrawl.height = _bmd.height;
			_verticalCrawl.addElement(rect);
		}
		
	}
}