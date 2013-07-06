package sounds {
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/*
	The ManageableSound class is a wrapper that holds different information useful to the SoundManager class.
	*/
	
	public class ManageableSound {
		
		//The following variables hold important information about the sound object such as the audio data, whether it is an effect of music, it's related SoundChannel
		//object, whether or not it should loop, and whether or not it is currently paused.
		public var sound:Sound;
		public var soundType:int;
		public var soundChannel:SoundChannel;
		public var loop:Boolean;
		public var paused:Boolean;
		
		//pausePosition holds the current location of the sound when it is paused. This information is vital for resumin it at it's original position when it is resumed.
		private var _pausePosition:Number = 0;
		
		//The ManageableSound constructor takes arguments for the audio data and sound type, the rest of the variables are given default values until they are needed.
		public function ManageableSound(sound:Sound, soundType:int) {
			this.sound = sound;
			this.soundType = soundType;
			this.soundChannel = null;
			this.loop = false;
			this.paused = false;
		}
		
		//play sets the soundChannel object to be an instance of the sound and sets the correct SoundTransform
		public function play(loop:Boolean = false):void
		{
			soundChannel = sound.play(0, 1, SoundManager.$transforms[soundType])
			this.loop = loop;
		}
		
		//stop ends the SoundChannel's playback and then nullifies it
		public function stop():void
		{
			soundChannel.stop();
			soundChannel = null;
		}
		
		//pause checks if the sound is currently playing, if so it saves the current playback position to the pausePosition variable, stops, the playback, and sets the
		//pause boolean to true;
		public function pause():void
		{
			if (soundChannel != null)
			{
				_pausePosition = soundChannel.position;
				soundChannel.stop();
				paused = true;
			}
		}
		
		//resume checks if the sound is currently paused, if so it plays the sound again from the saved pausePosition and resets pause to false.
		public function resume():void
		{
			if (paused)
			{
				soundChannel = sound.play(_pausePosition, 1, SoundManager.$transforms[soundType]);
				paused = false;
			}
		}
	}
}
