package com.leonardsouza.effects
{
	import com.leonardsouza.components.Range;
	import com.leonardsouza.effects.supportClasses.ShakeInstance3D;
	
	import mx.effects.IEffectInstance;
	
	import spark.effects.Animate;
	
	public class Shake3D extends Animate
	{
		
		private var _xRange:Range;
		private var _yRange:Range;
		private var _zRange:Range;
		
		protected var _instance:ShakeInstance3D;
		
		public function Shake3D(target:Object=null)
		{
			super(target);
			instanceClass = ShakeInstance3D;
		}

		public function get zRange():Range
		{
			return _zRange;
		}

		public function set zRange(value:Range):void
		{
			_zRange = value;
			updateProperties();
		}

		public function get yRange():Range
		{
			return _yRange;
		}

		public function set yRange(value:Range):void
		{
			_yRange = value;
			updateProperties();
		}

		public function get xRange():Range
		{
			return _xRange;
		}

		public function set xRange(value:Range):void
		{
			_xRange = value;
			updateProperties();
		}
		
		protected function updateProperties():void
		{
			if (_instance == null) return;
			if (xRange != null) 
				_instance.xRange = xRange;
			else
				_instance.xRange = new Range(0,0);
			if (yRange != null) 
				_instance.yRange = yRange;
			else
				_instance.yRange = new Range(0,0);
			if (zRange != null) 
				_instance.zRange = zRange;
			else
				_instance.yRange = new Range(0,0);
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			_instance = ShakeInstance3D(instance);
			
			updateProperties();	
		}
		
		override public function getAffectedProperties():Array
		{
			return ['x', 'y', 'z'];
		}
		
	}
}