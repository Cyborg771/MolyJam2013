package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Minigame extends Sprite {
		
		public static const MINIGAME_COMPLETE:String = "MINIGAME_COMPLETE";
		
		public var _gameName:String;
		
		protected var _gameState:GameState;
		
		public function Minigame(gameState:GameState) {
			_gameState = gameState;
			
			_gameState.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction, false, 0, true);
			_gameState.getStage().addEventListener(KeyboardEvent.KEY_UP, keyUpFunction, false, 0, true);
			_gameState.getStage().focus = this;
		}
		
		public virtual function update():void {
			
		}
		
		protected virtual function keyDownFunction(e:KeyboardEvent):void {
			
		}
		
		protected virtual function keyUpFunction(e:KeyboardEvent):void {
			
		}
		
		protected function minigameComplete(){
			_gameState.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			_gameState.getStage().removeEventListener(KeyboardEvent.KEY_UP, keyUpFunction);
			dispatchEvent(new Event(MINIGAME_COMPLETE));
		}
		
	}
}
