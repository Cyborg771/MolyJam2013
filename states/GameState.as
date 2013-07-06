package states {
	
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import ui.RelaxationMeter;
	import minigames.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	
	public class GameState extends State {
		
		private var _background:MovieClip;
		private var _relaxationMeter:RelaxationMeter;
		
		private var _minigames:Array;
		private var _currentIndex = 0;
		private var _currentMinigame:Minigame;
		
		private var _shakeTime:int = 0;
		
		public function GameState(manager:StateManager) {
			super(manager);
			trace("GAME STATE INITIALIZED");
			
			_relaxationMeter = new RelaxationMeter();
			_relaxationMeter.x = 10;
			_relaxationMeter.y = 10;
			addChild(_relaxationMeter);
			
			_minigames = new Array(TestMinigame, OfficeEscape, DriveHome);
			
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			_loader.load(new URLRequest("Background.swf"));
			
			nextMinigame();
			_currentMinigame.addEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete, false, 0, true);
			
			setChildIndex(loadScreen, this.numChildren-1);
		}
		
		public override function update():void {
			_relaxationMeter.update();
			if (_currentMinigame != null) {
				_currentMinigame.update();
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
			}
		}
		
		private function onLoaded(e:Event) {
			_background = e.target.content;
			addChild(_background);
			setChildIndex(_background, 0);
			removeChild(loadScreen);
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
			}
			else {
				trace("GAME OVER");
			}
		}
		
		private function minigameComplete(e:Event):void {
			_currentIndex++;
			nextMinigame();
		}
		
		public function shakeMinigame(time:int):void {
			_shakeTime = time;
		}
		
	}
	
}
