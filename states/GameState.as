package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ui.RelaxationMeter;
	
	public class GameState extends State {
		
		private var _relaxationMeter:RelaxationMeter;
		
		public function GameState(manager:StateManager) {
			super(manager);
			
			backButton.addEventListener(MouseEvent.CLICK, backClicked, false, 0, true);
			
			_relaxationMeter = new RelaxationMeter();
			addChild(_relaxationMeter);
			
			trace("GAME STATE INITIALIZED");
		}
		
		private function backClicked(e:MouseEvent):void {
			_manager.setState("Menu");
		}
		
	}
	
}
