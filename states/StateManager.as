package states {
	
	import flash.display.Stage;
	
	public class StateManager
	{

		public var _mainClass:MolyJam2013;
		
		private var _currentState:State;
		
		public function StateManager(mainClass:MolyJam2013)
		{
			_mainClass = mainClass;
		}
		
		public function setState(stateToSet:String)
		{
			if (_currentState != null) clearCurrentState();
			
			switch (stateToSet)
			{
				case "Game":
					//_currentState = new GameState(this);
					break;
				case "Menu":
					//_currentState = new MenuState(this);
					break;
				case "Settings":
					//_currentState = new SettingsState(this);
					break;
				case "Tutorial":
					//_currentState = new TutorialState(this);
					break;
				default:
					break;
			}
			
			_mainClass.stage.addChild(_currentState);
		}
		
		private function clearCurrentState():void
		{
			_mainClass.stage.removeChild(_currentState);
			_currentState = null;
			trace("STATE REMOVED");
		}
		
		public function update():void
		{
			if (_currentState) _currentState.update();
			else trace("ERROR: State Unset");
		}
		
	}
	
}
