package states {
	
	import flash.display.Sprite;
	
	public class State extends Sprite {

		protected var _manager:StateManager;
		
		public function State(manager:StateManager) {
			_manager = manager;
		}
		
		public virtual function update():void {
		}

	}
	
}
