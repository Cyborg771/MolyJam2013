package states {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class State extends Sprite {

		protected var _manager:StateManager;
		
		public function State(manager:StateManager) {
			_manager = manager;
		}
		
		public virtual function update():void {
		}
		
		public function getStage():Stage{
			return _manager._mainClass.stage;
		}

	}
	
}
