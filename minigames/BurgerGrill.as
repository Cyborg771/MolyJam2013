package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	import com.greensock.TweenLite;
	
	public class BurgerGrill extends Minigame {
		
		private var _burgers:Array;
		private var _fires:Array;
		private var _burgerPositions:Array;
		private var _currentPosition:int = 0;
		private var _grillTimes:Array = new Array(4);
		private var _successfulFlips:int = 0;
		
		public function BurgerGrill(gameState:GameState) {
			super(gameState);
			_gameName = "Burger Grill";
			
			_burgers = [burger1, burger2, burger3, burger4];
			_fires = [fire1, fire2, fire3, fire4];
			for (var i = 0; i < _burgers.length; i++){
				_burgers[i].stop();
				_fires[i].visible = false;
				setGrillTime(i);
			}
			_burgerPositions = [100, 260, 420, 580];
		}
		
		public override function startGame():void {
			_started = true;
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 65) {
					_currentPosition--;
					if (_currentPosition == -1) _currentPosition = 3;
					TweenLite.to(spatula, 0.5, {x:_burgerPositions[_currentPosition]});
				}
				if (e.keyCode == 68) {
					_currentPosition++;
					_currentPosition%=4;
					TweenLite.to(spatula, 0.5, {x:_burgerPositions[_currentPosition]});
				}
				if (e.keyCode == 87 && _burgers[_currentPosition].currentFrame == 1) {
					_burgers[_currentPosition].play();
					_fires[_currentPosition].visible = false;
					if (_grillTimes[_currentPosition] < 0) {
						_gameState.changeRelaxation(3);
						_successfulFlips++;
						if (_successfulFlips == 12) minigameComplete();
					}
					setGrillTime(_currentPosition);
				}
			}
		}
		
		public override function update():void {
			for (var i = 0; i < _burgers.length; i++) {
				if (_burgers[i].currentFrame == 1) _burgers[i].stop();
				_grillTimes[i]--;
				if (_grillTimes[i] < 0) {
					_fires[i].visible = true;
					_gameState.changeRelaxation(-0.075);
				}
			}
		}
		
		private function setGrillTime(i:int):void {
			var randomInt:int = Math.floor( Math.random() * 270 ) + 31;
			_grillTimes[i] = randomInt;
		}
		
	}
	
}