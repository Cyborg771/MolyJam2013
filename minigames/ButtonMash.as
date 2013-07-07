package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	
	public class ButtonMash extends Minigame {
		
		private var _timer:Timer;
		private var _taps:int = 0;
		
		public function ButtonMash(gameState:GameState) {
			super(gameState);
			_gameName = "Button Mash";
			_timer = new Timer(10000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (e.keyCode == 32 ) {
				//animation goes here
				_taps = _taps +1;
				trace("TAPS:"+_taps);
				// if taps reach x, game is beaten
				if (_taps == 50){
					_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
					minigameComplete();
				}
			}
		
		}
		
		private function timerComplete(e:TimerEvent):void {
			//Fail function content goes here.
			trace("TOO SLOW!");
		}
		
		
		
	}
}
