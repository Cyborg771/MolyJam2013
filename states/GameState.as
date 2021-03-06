﻿package states {
	
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import ui.*;
	import minigames.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import sounds.SoundManager;
	import flash.utils.Dictionary;
	
	public class GameState extends State {
		
		private var _loader:Loader;
		private var _background:MovieClip;
		private var _backgroundTrippy:MovieClip;
		private var _relaxationMeter:RelaxationMeter;
		private var _instructions:Instructions;
		private var _instructionSets:Array;
		private var _firstFrame:int = 0;
		private var _instructionCounter:int = 0;
		
		private var _minigames:Array;
		private var _currentIndex = 0;
		private var _currentMinigame:Minigame;
		
		private var _shakeTime:int = 0;
		
		public function GameState(manager:StateManager) {
			super(manager);
			trace("GAME STATE INITIALIZED");
			
			SoundManager.addSound("GameMusic", new GameMusic(), SoundManager.MUSIC);
			SoundManager.playSound("GameMusic", true);
			
			_relaxationMeter = new RelaxationMeter();
			_relaxationMeter.x = 10;
			_relaxationMeter.y = 10;
			addChild(_relaxationMeter);
			
			_instructions = new Instructions();
			addChild(_instructions);
			_instructions.visible = false;
			_instructions.mouseEnabled = false;
			
			_minigames = new Array(OfficeEscape, DriveHome, DoorOpen, BathTime, BeerGrab, BeerOpen, ChannelSurfing, CatPat, Recliner, BurgerGrill, HammockSwing);
			_instructionSets = [3, 1, 5, 4, 2, 2, 2, 2, 2, 5, 4];
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			_loader.load(new URLRequest("Background.swf"));
			
			setChildIndex(loadScreen, this.numChildren-1);
		}
		
		public override function update():void {
			_relaxationMeter.update();
			
			if (_instructions.currentFrame > _firstFrame+3) {
				_instructions.gotoAndPlay(_firstFrame);
				_instructionCounter++;
				if (_instructionCounter == 12) {
					_instructions.stop();
					_instructions.visible = false;
					_currentMinigame.startGame();
				}
			}
			
			if (_currentMinigame != null && _currentMinigame._started) {
				if (_shakeTime > 0) {
					var randomInt:int = Math.floor( Math.random() * 3 ) -1;
					_currentMinigame.x = randomInt * _shakeTime;
					_currentMinigame.y = randomInt * _shakeTime;
					_shakeTime--;
				}
				else {
					_currentMinigame.x = 0;
					_currentMinigame.y = 0;
				}
				_currentMinigame.update();
			}
		}
		
		private function onLoaded(e:Event) {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			_background = e.target.content;
			addChild(_background);
			setChildIndex(_background, 0);
			removeChild(loadScreen);
			
			_loader.load(new URLRequest("BackgroundTrippy.swf"));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded2, false, 0, true);
			
			nextMinigame();
			_currentMinigame.addEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete, false, 0, true);
		}
		
		private function onLoaded2(e:Event) {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded2);
			_backgroundTrippy = e.target.content;
			addChild(_backgroundTrippy);
			setChildIndex(_backgroundTrippy, 0);
			_backgroundTrippy.visible = false;
		}
		
		public function changeRelaxation(delta:Number) {
			_relaxationMeter.relaxationValue += delta;
			
			if (_relaxationMeter.relaxationValue >= 30) {
				_backgroundTrippy.visible = true;
				_background.visible = false;
			}
			else if (_relaxationMeter.relaxationValue > -30) {
				_backgroundTrippy.visible = false;
				_background.visible = true;
			}
			else {
				_backgroundTrippy.visible = false;
				_background.visible = false;
			}
		}
		
		private function nextMinigame(){
			if (_currentMinigame != null) {
				trace("REMOVING MINIGAME \""+_currentMinigame._gameName+"\"");
				removeChild(_currentMinigame);
				_currentMinigame.removeEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete);
				_currentMinigame = null;
			}
			if (_currentIndex < _minigames.length) {
				_currentMinigame = new _minigames[_currentIndex](this);
				trace("NEW MINIGAME \""+_currentMinigame._gameName+"\"");
				_currentMinigame.addEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete, false, 0, true);
				addChild(_currentMinigame);
				setChildIndex(_relaxationMeter, this.numChildren-1);
				setInstructions(_instructionSets[_currentIndex]);
			}
			else {
				removeChild(_relaxationMeter);
				addChild(new GameOver(_relaxationMeter.relaxationValue, this));
			}
		}
		
		private function setInstructions(i:int) {
			_instructions.visible = true;
			setChildIndex(_instructions, this.numChildren-1);
			_firstFrame = (i-1)*4+1;
			_instructions.gotoAndPlay(_firstFrame);
			_instructionCounter = 0;
		}
		
		private function minigameComplete(e:Event):void {
			_currentIndex++;
			nextMinigame();
		}
		
		public function shakeMinigame(time:int):void {
			_shakeTime = time;
		}
		
		public function endGame(){
			SoundManager.stopSound("GameMusic");
			SoundManager.removeSound("GameMusic");
			_manager.setState("Menu");
		}
		
	}
	
}
