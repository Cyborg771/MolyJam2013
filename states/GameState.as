package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import ui.RelaxationMeter;
	import minigames.*;
	
	public class GameState extends State {
		
		private var _relaxationMeter:RelaxationMeter;
		
		private var _minigames:Array;
		private var _currentIndex = 0;
		private var _currentMinigame:Minigame;
		
		public function GameState(manager:StateManager) {
			super(manager);
			trace("GAME STATE INITIALIZED");
			
			_relaxationMeter = new RelaxationMeter();
			addChild(_relaxationMeter);
			
			_minigames = new Array(TestMinigame, TestMinigame, TestMinigame);
			
			nextMinigame();
			_currentMinigame.addEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete, false, 0, true);
		}
		
		public override function update():void {
			_relaxationMeter.update();
			if (_currentMinigame != null) _currentMinigame.update();
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
			}
			else {
				trace("GAME OVER");
			}
		}
		
		private function minigameComplete(e:Event):void {
			_currentIndex++;
			nextMinigame();
		}
		
	}
	
}
