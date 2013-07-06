package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.Event;
	
	public class Minigame extends Sprite {
		
		public static const MINIGAME_COMPLETE:String = "MINIGAME_COMPLETE";
		
		private var _gameState:GameState;
		
		public function Minigame(gameState:GameState) {
			_gameState = gameState;
		}
		
		public virtual function update():void {
			
		}
		
		protected function minigameComplete(){
			dispatchEvent(new Event(MINIGAME_COMPLETE));
		}
		
	}
}
