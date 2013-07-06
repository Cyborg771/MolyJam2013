package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.MouseEvent;
	
	public class TestMinigame extends Minigame {
		
		public function TestMinigame(gameState:GameState) {
			super(gameState);
			
			_gameName = "Test Minigame";
			
			testButton.addEventListener(MouseEvent.CLICK, testClicked, false, 0, true);
		}
		
		private function testClicked(e:MouseEvent):void {
			minigameComplete();
		}
		
	}
}
