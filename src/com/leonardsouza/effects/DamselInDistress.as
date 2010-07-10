package com.leonardsouza.effects
{
	import com.leonardsouza.effects.effectClasses.DamselInDistressInstance;
	
	import mx.effects.Effect;
	import mx.effects.IEffectInstance;

	public class DamselInDistress extends Effect
	{
		
	    //--------------------------------------------------------------------------
	    //
	    //  Class constants
	    //
	    //--------------------------------------------------------------------------
	
		public static const LOW:uint = 450;
		public static const MEDIUM:uint = 640;
		public static const HIGH:uint = 1024; 

	    private static var AFFECTED_PROPERTIES:Array = [ "visible" ];
		
		public function DamselInDistress(target:Object=null)
		{
			super(target);
			instanceClass = DamselInDistressInstance;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
	
		[Inspectable(category="General", defaultValue="NaN")]
		
		/** 
		 *  Amount of distress in which to place target object
		 *  Valid values are from 0.0 to 100.0. 
		 */
		public var distressAmount:Number;

		[Inspectable(category="General", defaultValue="low", enumeration="low,medium,high")]		 
		public var quality:String;

	    //--------------------------------------------------------------------------
	    //
	    //  Overridden methods
	    //
	    //--------------------------------------------------------------------------
	
	    /**
	     *  @private 
	     */
	    override public function getAffectedProperties():Array /* of String */
	    {
	        return AFFECTED_PROPERTIES;
	    }
			
		/**
		 *  @private
		 */
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var damselInstance:DamselInDistressInstance = DamselInDistressInstance(instance);
			
			damselInstance.distressAmount = distressAmount;
			damselInstance.scaleSize	  = setQuality(quality);

		}
		
		private function setQuality(val:String):uint
		{
			var qualityNum:uint;
			switch (val)
			{ 
				case "low": 
					qualityNum = LOW;
					break;
				case "medium": 
					qualityNum = MEDIUM;
					break;
				case "high": 
					qualityNum = HIGH;
					break;
				default: throw new Error("Invalid quality setting. Accepted settings are low, medium or high."); 
			}			
			return qualityNum;
		}
		
	}
}