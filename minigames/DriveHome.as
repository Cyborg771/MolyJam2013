package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class DriveHome extends Minigame {
		
		private var _timer:Timer;
		
		public function DriveHome(gameState:GameState) {
			super(gameState);
			_gameName = "Drive Home";
			
			_timer = new Timer(25000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
		}
		
		private function timerComplete(e:TimerEvent):void {
			minigameComplete();
		}
		
	}
	
}
