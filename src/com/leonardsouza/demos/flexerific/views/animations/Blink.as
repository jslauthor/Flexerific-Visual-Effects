package com.leonardsouza.demos.flexerific.views.animations
{
	import spark.effects.Animate;
	import spark.effects.animation.Keyframe;
	import spark.effects.animation.MotionPath;
	
	public class Blink extends Animate
	{
		public function Blink(target:Object=null)
		{
			super(target);
			initializeEffect();
		}
		
		protected function initializeEffect():void
		{
			var mp:MotionPath = new MotionPath("alpha");
			mp.keyframes = new Vector.<Keyframe>();
			
			var kf:Keyframe = new Keyframe(0);
			mp.keyframes.push(new Keyframe(0));
			mp.keyframes.push(new Keyframe(50, 1));
			mp.keyframes.push(new Keyframe(100, .8));
			
			motionPaths = new Vector.<MotionPath>();
			motionPaths.push(mp);
		}
	}
}