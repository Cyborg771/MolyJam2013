package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class CreditsState extends State {
		
		public function CreditsState(manager:StateManager) {
			super(manager);
			
			backButton.addEventListener(MouseEvent.CLICK, backClicked, false, 0, true);
			
			trace("CREDITS STATE INITIALIZED");
		}
		
		private function backClicked(e:MouseEvent):void {
			_manager.setState("Menu");
		}
	}
	
}
