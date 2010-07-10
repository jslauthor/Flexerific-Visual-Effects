package com.leonardsouza.effects.generators
{
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class NoiseGenerator extends EventDispatcher
	{
		
		private static var _sound:Sound = new Sound();
		private static var _soundChannel:SoundChannel;
		
		public static var isPlaying:Boolean = false;
		public static var amp_multiplier:Number = 0.12;
		
		public function NoiseGenerator() { }
		
		public static function play():void
		{
			if (_soundChannel || isPlaying) return;
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, generateNoise);
			_soundChannel = _sound.play();
			isPlaying = true;
		}
		
		public static function stop():void
		{
			if (_soundChannel)
			{
				_soundChannel.stop();
				_soundChannel = null;
				_sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, generateNoise);
				isPlaying = false;			
			}
		}
		
		private static function generateNoise(evt:SampleDataEvent):void
		{
			var sample:Number;
		    for ( var i:int = 0; i < 8192; i++ ) 
		    {
		        sample = Math.random() -.5;
		        evt.data.writeFloat(sample * amp_multiplier);
		        evt.data.writeFloat(sample * amp_multiplier);
		    }
		}
		
	}
}