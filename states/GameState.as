package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class GameState extends State {
		
		public function GameState(manager:StateManager) {
			super(manager);
			
			backButton.addEventListener(MouseEvent.CLICK, backClicked, false, 0, true);
			
			trace("GAME STATE INITIALIZED");
		}
		
		private function backClicked(e:MouseEvent):void {
			_manager.setState("Menu");
		}
		
	}
	
}
