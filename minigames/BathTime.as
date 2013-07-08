package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import sounds.SoundManager;
	import flash.events.Event;
	
	public class BathTime extends Minigame {
		
		private var _timer:Timer;
		private var _targetTimer:Timer;
		private var _temp:int = 50;
		private var _targetTemp:int = 50;
		private var _tempDown:Boolean = false;
		private var _tempUp:Boolean = false;
		
		public function BathTime(gameState:GameState) {
			super(gameState);
			_gameName = "Bath Time";
			
			warning.gotoAndStop(3);
			
			SoundManager.addSound("Shower", new Shower(), SoundManager.FX);
		}
		
		public override function startGame():void {
			_started = true;
			SoundManager.playSound("Shower", true);
			changeTarget();
			
			_timer = new Timer(20000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			
			_targetTimer = new Timer(2000, 0);
			_targetTimer.addEventListener(TimerEvent.TIMER, changeTarget, false, 0, true);
			_targetTimer.start();
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 65) {
					knob.rotation = -30;
					_tempDown = true;
				}
				if (e.keyCode == 68) {
					knob.rotation = 30;
					_tempUp = true;
				}
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 65 || e.keyCode == 68) {
					knob.rotation = 0;
					_tempDown = false;
					_tempUp = false;
				}
			}
		}
		
		public override function update():void {
			if (_tempUp) {
				_temp+=2;
				if (_temp > 100) _temp = 100;
			}
			if (_tempDown) {
				_temp-=2;
				if (_temp < 1) _temp = 1;
			}
			if (Math.abs(_temp - _targetTemp) < 10) {
				_gameState.changeRelaxation(0.2);
				warning.gotoAndStop(3);
			}
			else {
				_gameState.changeRelaxation(-0.2);
				if (_temp > _targetTemp) warning.gotoAndStop(2);
				else warning.gotoAndStop(1);
			}
		}
		
		private function changeTarget(e:Event = null) {
			var randomInt:int = Math.floor( Math.random() * 50 ) + 1;
			_targetTemp = randomInt;
		}
		
		private function timerComplete(e:TimerEvent):void {
			SoundManager.removeSound("Shower");
			minigameComplete();
		}
		
	}
	
}