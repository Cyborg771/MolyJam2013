package Minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	
	public class Minigame extends MovieClip {
		
		private var _gameState:GameState;
		
		public function Minigame(gameState:GameState) {
			_gameState = gameState;
		}
		
		public virtual function update():void {
			
		}
		
	}
}
