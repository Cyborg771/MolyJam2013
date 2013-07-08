package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	
	public class Recliner extends Minigame {
		
		private var _taps:int = 0;
		private var _gruntTimer:int = 5;
		private var _prevGrunt:int = 0;
		private var _gameOver:Boolean = false;
		private var _gameOverTimer:int = 60;
		
		public function Recliner(gameState:GameState) {
			super(gameState);
			_gameName = "Recliner";
			
			chair.gotoAndStop(1);
			
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
			if (_started && !_gameOver) {
				if (e.keyCode == 87) {
					chair.gotoAndStop(2);
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
					if (_taps == 30){
						_gameState.changeRelaxation(10);
						_gameOver = true;
						chair.gotoAndStop(3);
					}
				}
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started && !_gameOver) {
				if (e.keyCode == 87) {
					chair.gotoAndStop(1);
				}
			}
		}
		
		public override function update():void {
			if (!_gameOver) {
				_gameState.changeRelaxation(-.15);
			}
			else {
				_gameOverTimer--;
				SoundManager.removeSound("Grunt1");
				SoundManager.removeSound("Grunt2");
				SoundManager.removeSound("Grunt3");
				if (_gameOverTimer == 0) minigameComplete()
			}
		}
		
	}
	
}