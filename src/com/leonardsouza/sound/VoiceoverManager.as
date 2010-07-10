package com.leonardsouza.sound
{
	import com.whiterabbit.util.MathUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	[Bindable]
	public class VoiceoverManager extends EventDispatcher
	{
		
		public static const COMPLETE:String = "Queue has completed playing";
		public static const START:String = "Queue has started playing";
		
		private static const QUEUE_DELAY:String = "delay";
		private static const QUEUE_FILE:String = "file";
		private static const NS:Namespace = new Namespace("http://www.whiterabbitindustries.com/2008/xml");
		default xml namespace = NS;
		
		private static var instance:VoiceoverManager;
		
		private var _configFile:XML;
		private var _sound:Sound = new Sound();
		private var _soundChannel:SoundChannel = new SoundChannel();
		private var _queue:Array = new Array();
		private var _queuePosition:Number = 0;
		private var _delayTimer:Timer = new Timer(0);
		private var _isPlaying:Boolean;
		private var _caption:String;

		/* Constructor */
		
		public function VoiceoverManager(enforcer:SingletonEnforcer)
		{ 
			if (enforcer == null) 
				{ throw new Error( "Can only instantiate VoiceoverManager (Resource ID: " + this + ") once" ); }
			else
			{
				instance = this;
			}
		}

		/* Getters and Setters */
		
		public function get isPlaying():Boolean { return _isPlaying; }
		public function get caption():String { return _caption; }

		/* Functions */ 

		public static function getInstance():VoiceoverManager
		{
			if (instance == null) { instance = new VoiceoverManager( new SingletonEnforcer() ); }
			return instance;
		} 
		
		public function loadConfigFile(val:String):void
		{
			var cFile:File = File.getRootDirectories()[0].resolvePath(val);
			
			if (cFile.exists)
			{ 
				var configStream:FileStream = new FileStream;
				configStream.open(cFile, FileMode.READ);
				
				_configFile = new XML(configStream.readUTFBytes(configStream.bytesAvailable));								
			}
			else
			{
				throw new Error( "Could not find config file: " + val); 
			}		
		}
		
		public function play(sequenceName:String = "", semantics:String = null):void
		{
			if (sequenceName == "") 
				{ throw new Error('VoiceoverManager requires a sequence name to play.'); return; }
			else if (!findSequence(sequenceName)) 
				{ throw new Error('VoiceoverManager cannot find sequence name to play.'); return; }
			
			_queue = new Array();
			
			if (isPlaying && sequenceName != "interrupt") { addSequenceToQueue("interrupt"); }
			addSequenceToQueue(sequenceName);
			
			stop();
			_queuePosition = 0;
			nextInQueue();
			dispatchEvent(new Event(START));
		}
		
		public function stop():void
		{
			_isPlaying = false;
			if (_soundChannel) _soundChannel.stop();
			if (_delayTimer) _delayTimer.stop();		
		}
		
		public function resume():void
		{
			if (_sound.length > 0) _soundChannel = _sound.play();
			if (_delayTimer) _delayTimer.start();
		}
		
		/* Private functions */
		
		private function nextInQueue(evt:Event = null):void
		{
			_isPlaying = true;
			if (_queuePosition > _queue.length-1) 
			{ 
				_isPlaying = false;
				dispatchEvent(new Event(COMPLETE));
				return; 
			}
			
			if (_queue[_queuePosition]["type"] == QUEUE_DELAY)
			{
				_delayTimer = new Timer(_queue[_queuePosition]["delay"]*1000, 1); // Multiply for milliseconds
				_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, nextInQueue);
				_delayTimer.start();
			}
			else if (_queue[_queuePosition]["type"] == QUEUE_FILE)
			{
				_caption = _queue[_queuePosition]["caption"];
				var request:URLRequest = new URLRequest(_queue[_queuePosition]["file"]);
				_sound = new Sound(request, new SoundLoaderContext(50));
				_sound.addEventListener(IOErrorEvent.IO_ERROR, nextInQueue);
				_soundChannel = _sound.play();
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, nextInQueue);				
			}
			
			_queuePosition++;
		}
		
		private function addSequenceToQueue(sequenceName:String):void
		{
			if (!_configFile) { throw Error("No config file loaded"); return; }
			var uri:String = _configFile.Config.(@name=="fileURI");
			
			for each (var node:XML in _configFile.Sequence.(@name==sequenceName).Cue)
			{
				var elementToAdd:Number = Math.round(MathUtil.randomBetween(0, node.CueAsset.length()-1)); // Choose one of the random assets
				var asset:XML = node.CueAsset[elementToAdd];
				_queue.push( { type : QUEUE_DELAY, delay : asset.@beforeDelay != "" ? asset.@beforeDelay : 0 } );
				_queue.push( { type : QUEUE_FILE, file : uri+asset.@name+"."+asset.@type, caption : asset.@caption } );
				_queue.push( { type : QUEUE_DELAY, delay : asset.@afterDelay != "" ? asset.@afterDelay : 0 } );
			}			
		}

		private function findSequence(sequenceName:String):Boolean
		{
			if (_configFile.Sequence.(@name==sequenceName).length() > 0) 
				return true;
			else
				return false;
		}
		
	}
	
}

class SingletonEnforcer { }