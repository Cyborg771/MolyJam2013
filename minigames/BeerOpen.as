package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	
	public class BeerOpen extends Minigame {
		
		private var _taps:int = 0;
		private var _gruntTimer:int = 5;
		private var _prevGrunt:int = 0;
		private var _raiseHand:Boolean = false;
		
		public function BeerOpen(gameState:GameState) {
			super(gameState);
			_gameName = "Beer Open";
			
			SoundManager.addSound("Grunt1", new Grunt1(), SoundManager.FX);
			SoundManager.addSound("Grunt2", new Grunt2(), SoundManager.FX);
			SoundManager.addSound("Grunt3", new Grunt3(), SoundManager.FX);
			
			flashingW.visible = false;
		}
		
		public override function startGame():void {
			_started = true;
			
			flashingW.visible = true;
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 87 && !_raiseHand) {
					hand.x = 190;
					_taps ++;
					_gameState.changeRelaxation(0.5);
					_gruntTimer--;
					if (_gruntTimer == 0) {
						_gruntTimer = 5;
						var randomInt:int = _prevGrunt;
						while (randomInt == _prevGrunt) randomInt = Math.floor( Math.random() * 3 ) + 1;
						_prevGrunt = randomInt;
						SoundManager.playSound("Grunt"+randomInt);
					}
					if (_taps == 50){
						_raiseHand = true;
						_gameState.changeRelaxation(10);
					}
				}
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 87 && !_raiseHand) {
					hand.x = 170;
				}
			}
		}
		
		public override function update():void {
			if (_raiseHand) {
				hand.y -= 20;
				if (hand.y <= -hand.height) minigameComplete();
			}
			else {
				_gameState.changeRelaxation(-.15);
			}
		}
		
	}
	
}
