package com.leonardsouza.filters
{
	import com.leonardsouza.filters.base.ShaderFilterBase;
	
	import flash.display.Shader;
	import flash.geom.Point;
	
	public class DampedSinFilter extends ShaderFilterBase
	{
		
		[Embed(source='assets/pixelbender/damped_sin_wave.pbj', mimeType='application/octet-stream')]
		protected var _pixelbender:Class;
		
		private var _position:Point;
		private var _amount:Number;
		private var _waveLength:Number;
		private var _time:Number;
		private var _overlay:Number;
		
		public function DampedSinFilter(shader:Object=null)
		{
			var s:Shader = new Shader(new _pixelbender());
			super(s); 
		}

		public function get overlay():Number
		{
			return _overlay;
		}

		public function set overlay(value:Number):void
		{
			_overlay = value;
			applyProperty('overlay', value);
			notifyFilterChanged();
		}

		public function get time():Number
		{
			return _time;
		}

		public function set time(value:Number):void
		{
			_time = value;
			applyProperty('t', value);
			notifyFilterChanged();
		}

		public function get waveLength():Number
		{
			return _waveLength;
		}

		public function set waveLength(value:Number):void
		{
			_waveLength = value;
			applyProperty('wavelength', value);
			notifyFilterChanged();
		}

		public function get amount():Number
		{
			return _amount;
		}

		public function set amount(value:Number):void
		{
			_amount = value;
			applyProperty('amount', value);
			notifyFilterChanged();
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
			applyProperty('pos', [value.x, value.y]);
			notifyFilterChanged();
		}

	}
}