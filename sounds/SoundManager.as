package sounds {
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import flash.events.Event;
	
	/*
	The SoundManager is a class which handles any and all sound related functions in the game. All of it's functions are static which means it doesn't require
	instantiation. It contains two SoundTransform objects used to control the seperate audio levels of sound effects and music, as well as a dictionary of all the sounds
	currently in use. Each sound is stored as a ManageableSound object, which is simply a wrapper which gives us the ability to store additional data about the sound.
	*/
	
	public class SoundManager {
		
		//FX and MUSIC are constants used to denote which kind of sound a particular file is, this is important for volume control.
		public static const FX:int = 0;
		public static const MUSIC:int = 1;
		
		//The sounds dictionary holds a list of all currently loaded sound files, referenced by names.
		private static var _$sounds:Dictionary;
		
		//fxTransform and musicTransform are SoundTransform objects use to control things like pan and volume, the transforms array simply holds the two SoundTransform
		//objects for easy retrieval.
		private static var _$fxTransform:SoundTransform;
		private static var _$musicTransform:SoundTransform;
		public static var $transforms:Array;
		
		//SoundManager is an entirely static class. It is never instantiated and so the constructor is never called.
		public function SoundManager()
		{
		}
		
		//SoundManager is never instantiated but certain variables need to be instantiated at runtime. The Initialize function takes care of these and is called from the
		//main class at the start of the program. The sounds dictionary, fxTransform, and musicTransform are all instantiated and the two SoundTransforms are put into the
		//transforms array;
		public static function initialize():void
		{
			_$sounds = new Dictionary();
			
			_$fxTransform = new SoundTransform();
			_$musicTransform = new SoundTransform();
			
			$transforms = [_$fxTransform, _$musicTransform];
		}
		
		//addSound checks if the sounds dictionary contains a ManageableSound object with the same name as the one being added. If not it creates this new object and adds
		//it to the dictionary.
		public static function addSound(soundName:String, sound:Sound, soundType:int):void
		{
			if (_$sounds[soundName] == null)
			{
				_$sounds[soundName] = new ManageableSound(sound, soundType);
				trace("ADDED SOUND: "+soundName);
			}
			else trace(soundName+" ALREADY EXISTS");
		}
		
		//removeSound checks if the sounds dictionary contains a ManageableSound object with the same name as the one being removed. If so it nullifies that object, thus
		//removing it from the dictionary.
		public static function removeSound(soundName:String):void
		{
			if (_$sounds[soundName] != null)
			{
				if (_$sounds[soundName].soundChannel != null) {
					_$sounds[soundName].soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
				}
				_$sounds[soundName] = null;
				trace("REMOVED SOUND: "+soundName);
			}
			else trace(soundName+" DOES NOT EXIST");
		}
		
		//playSound checks if the sounds dictionary contains a ManageableSound object with the same name as the one being played. If so it calls the ManageableSound's
		//play function, sets it's loop value, and adds an event listener for when the sound stops playing.
		public static function playSound(soundName:String, loop:Boolean = false):void
		{
			if (_$sounds[soundName] != null)
			{
				_$sounds[soundName].play();
				_$sounds[soundName].loop = loop;
				_$sounds[soundName].soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete, false, 0, true);
				trace("PLAYING SOUND: "+soundName);
			}
			else trace(soundName+" DOES NOT EXIST");
		}
		
		//pauseSound checks if the sounds dictionary contains a ManageableSound object with the same name as the one being paused. If so it calls the ManageableSound's
		//pause function.
		public static function pauseSound(soundName:String):void
		{
			if (_$sounds[soundName] != null)
			{
				_$sounds[soundName].pause();
				trace("PAUSING SOUND: "+soundName);
			}
			else trace(soundName+" DOES NOT EXIST");
		}
		
		//resumeSound checks if the sounds dictionary contains a ManageableSound object with the same name as the one being resumed. If so it calls the ManageableSound's
		//resume function.
		public static function resumeSound(soundName:String):void
		{
			if (_$sounds[soundName] != null)
			{
				_$sounds[soundName].resume();
				trace("RESUMING SOUND: "+soundName);
			}
			else trace(soundName+" DOES NOT EXIST");
		}
		
		public static function stopSound(soundName:String):void
		{
			if (_$sounds[soundName] != null)
			{
				_$sounds[soundName].stop();
				trace("STOPPING SOUND: "+soundName);
			}
			else trace(soundName+" DOES NOT EXIST");
		}
		
		//pauseAllSounds iterates through each ManageableSound object in the sounds dictionary and calls the pauseSound function on it.
		public static function pauseAllSounds():void
		{
			for (var key:String in _$sounds)
			{
				pauseSound(key);
			}
		}
		
		//resumeAllSounds iterates through each ManageableSound object in the sounds dictionary and calls the resumeSound function on it.
		public static function resumeAllSounds():void
		{
			for (var key:String in _$sounds)
			{
				resumeSound(key);
			}
		}
		
		//updateVolume iterates through each ManageableSound object in the sounds dictionary and resets it's SoundChannel's SoundTransform object, thus making sure it is
		//playing at the correct volume level.
		public static function updateVolume():void
		{
			for (var key:String in _$sounds)
			{
				if (_$sounds[key].soundChannel != null)
				{
					_$sounds[key].soundChannel.soundTransform = $transforms[_$sounds[key].soundType];
				}
			}
		}
		
		//onSoundChannelSoundComplete is an event listener function which is called when a sound ends. It iterates through the sounds dictionary looking for the sound
		//which matches the one that just ended. It then checks if the sound is set to loop, if so it plays it again, if not then it nullifies the ManageableSound's
		//SoundChannel.
		public static function onSoundChannelSoundComplete(e:Event):void {
			e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelSoundComplete);
			for (var key:String in _$sounds) {
				if (_$sounds[key].soundChannel == e.currentTarget) {
					if (_$sounds[key].loop) playSound(key, true);
					else _$sounds[key].soundChannel = null;
					break;
				}
			}
		}
		
		//checkIfPlaying checks if the sounds dictionary contains a ManageableSound object with the same name as the one being checked. If so it checks to see if that
		//ManageableSound's SoundChannel is nullified. This indicates whether or not the sound is currently active or not.
		public static function checkIfPlaying(soundName:String):Boolean
		{
			if (_$sounds[soundName] != null)
			{
				if (_$sounds[soundName].soundChannel != null) return true;
				else return false;
			}
			else return false;
		}

	}
	
}
