package com.leonardsouza.sound
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import mx.core.SoundAsset;
	
	public class AudioChannel
	{
		
		private var _soundChannel:SoundChannel;
		private var _source:Class;
		private var _volume:Number = 1;
		private var _repeatForever:Boolean = false;
		private var _isPlaying:Boolean = false;
		
		protected var _soundAsset:SoundAsset;
		
		public function AudioChannel() { }

		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function get repeatForever():Boolean
		{
			return _repeatForever;
		}

		public function set repeatForever(value:Boolean):void
		{
			_repeatForever = value;
		}

		public function get source():Class
		{
			return _source;
		}

		public function set source(value:Class):void
		{
			_source = value;
			destroyChannel();
			_soundAsset = new _source() as SoundAsset;
		}

		public function get soundChannel():SoundChannel
		{
			return _soundChannel;
		}

		public function set soundChannel(value:SoundChannel):void
		{
			_soundChannel = value;
		}

		public function get volume():Number
		{
			if (_soundChannel) 
				return _soundChannel.soundTransform.volume;
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			if (_soundChannel != null)
			{
				var st:SoundTransform = new SoundTransform(value);
				_soundChannel.soundTransform = st;
			}
		}
		
		public function play(startTime:Number=0, loops:int=0):void
		{
			if (_soundAsset)
			{
				destroyChannel();
				
				if (loops > 0) repeatForever = false;
				_soundChannel = _soundAsset.play(startTime, loops, new SoundTransform(volume));
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, doRepeat);
				
				_isPlaying = true;
			}
		}
		
		public function stop():void
		{
			if (_soundChannel)
				_soundChannel.stop();
			
			_isPlaying = false;
		}
		
		protected function doRepeat(event:Event):void
		{
			if (repeatForever)
				play();
		}
		
		protected function destroyChannel():void
		{
			if (_soundChannel != null)
			{
				stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, doRepeat);
				_soundChannel = null;
			}
		}
		
	}
}