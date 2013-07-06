package states {
	
	import flash.display.Stage;
	
	public class StateManager
	{
		public var _mainClass:MolyJam2013;
		
		private var _currentState:State;
		
		public function StateManager(mainClass:MolyJam2013) {
			_mainClass = mainClass;
		}
		
		public function setState(stateToSet:String) {
			if (_currentState != null) clearCurrentState();
			
			switch (stateToSet) {
				case "Game":
					_currentState = new GameState(this);
					break;
				case "Menu":
					_currentState = new MenuState(this);
					break;
				case "Credits":
					_currentState = new CreditsState(this);
					break;
				default:
					trace("Unknown state: " + stateToSet);
					break;
			}
			
			_mainClass.stage.addChild(_currentState);
		}
		
		private function clearCurrentState():void {
			_mainClass.stage.removeChild(_currentState);
			_currentState = null;
		}
		
		public function update():void {
			if (_currentState) _currentState.update();
			else trace("ERROR: State Unset");
		}
		
	}
	
}
