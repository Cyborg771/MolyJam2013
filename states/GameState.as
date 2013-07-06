package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import ui.RelaxationMeter;
	import minigames.*;
	
	public class GameState extends State {
		
		private var _relaxationMeter:RelaxationMeter;
		
		private var _minigames:Array;
		private var _currentMinigame:Minigame;
		
		public function GameState(manager:StateManager) {
			super(manager);
			
			_relaxationMeter = new RelaxationMeter();
			addChild(_relaxationMeter);
			
			setMinigame();
			_currentMinigame.addEventListener(Minigame.MINIGAME_COMPLETE, minigameComplete, false, 0, true);
			
			trace("GAME STATE INITIALIZED");
		}
		
		public override function update():void {
			_relaxationMeter.update();
			_currentMinigame.update();
		}
		
		private function setMinigame(){
			if (_currentMinigame != null) {
				removeChild(_currentMinigame);
				_currentMinigame = null;
			}
			_currentMinigame = new TestMinigame(this);
			addChild(_currentMinigame);
		}
		
		private function minigameComplete(e:Event):void {
			trace("COMPLETE");
		}
		
	}
	
}
