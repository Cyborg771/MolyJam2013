package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuState extends State {
		
		public function MenuState(manager:StateManager) {
			super(manager);
			
			playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
			creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			
			trace("MENU STATE INITIALIZED");
		}
		
		private function playClicked(e:MouseEvent):void {
			_manager.setState("Game");
		}
		
		private function creditsClicked(e:MouseEvent):void {
			_manager.setState("Credits");
		}
	}
	
}
