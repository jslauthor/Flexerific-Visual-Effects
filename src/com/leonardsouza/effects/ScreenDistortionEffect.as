package com.leonardsouza.effects
{
	import com.leonardsouza.effects.effectClasses.ScreenDistortionEffectInstance;
	import com.leonardsouza.effects.enum.EffectQuality;
	import com.leonardsouza.filters.DisplacementMapFilter;
	
	import mx.effects.IEffectInstance;
	import mx.filters.IBitmapFilter;
	
	import spark.effects.AnimateFilter;
	
	public class ScreenDistortionEffect extends AnimateFilter
	{
		
		private var _distressAmount:Number;
		
		public function ScreenDistortionEffect(target:Object=null)
		{
			super(target);
			instanceClass = ScreenDistortionEffectInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var sdInstance:ScreenDistortionEffectInstance = instance as ScreenDistortionEffectInstance;
			sdInstance.bitmapFilter = new DisplacementMapFilter();
			sdInstance.quality = EffectQuality.MEDIUM;
			sdInstance.scaleToTarget = true;
		}
	}
}