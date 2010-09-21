package com.leonardsouza.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	
	public class BitmapProxy extends UIComponent implements IVisualElement
	{
		
		private var _source:DisplayObject;
		protected var _bitmap:Bitmap;
		protected var _bitmapData:BitmapData;
		
		protected var _renderTimer:Timer;
		
		public function BitmapProxy()
		{
			super();
			addEventListener(Event.ENTER_FRAME, render);
		}

		public function get source():DisplayObject
		{
			return _source;
		}

		public function set source(value:DisplayObject):void
		{
			_source = value;
		}
		

		
		override protected function createChildren():void
		{
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}
		
		override protected function measure():void
		{
			measuredMinWidth = _source.width ? _source.width : 0;
			measuredMinHeight = _source.height ? _source.height : 0;
			measuredWidth = _source.width ? _source.width : 0;
			measuredHeight = _source.height ? _source.height : 0;
			trace(width);
		} 
		
		/* Methods */
		
		protected function render(event:Event):void
		{
			if (_source == null || _source.width < 1 || _source.height < 1) return;
			if (_bitmapData != null) _bitmapData.dispose();
			_bitmapData = null;
			_bitmapData = new BitmapData(_source.width, source.height, true, 0x00FFFFFF);
			_bitmapData.draw(_source, _source.transform.matrix);	
			_bitmap.bitmapData = _bitmapData;
		}
		
	}
}