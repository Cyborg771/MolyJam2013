package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import states.StateManager;
	import sounds.SoundManager;
	
	public class MolyJam2013 extends MovieClip
	{
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT:int = 480;
		
		private var _stateManager:StateManager;
		
		public function MolyJam2013()
		{
			SoundManager.initialize();
			
			_stateManager = new StateManager(this);
			//_stateManager.setState("Menu");
			
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		private function update(e:Event):void
		{
			_stateManager.update();
		}
		
	}
	
}
