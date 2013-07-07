package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import sounds.SoundManager;
	
	public class DriveHome extends Minigame {
		
		private var _backgrounds:Array;
		private var _driveSpeed:int = 30;
		private var _timer:Timer;
		
		private var _downCars:Array;
		private var _upCars:Array;
		private var _carPositions:Array = new Array([185, 285, 385], [410, 510, 610]);
		private var _moveLeft:Boolean = false;
		private var _moveRight:Boolean = false;
		private var _moveUp:Boolean = false;
		private var _moveDown:Boolean = false;
		
		public function DriveHome(gameState:GameState) {
			super(gameState);
			_gameName = "Drive Home";
			
			_timer = new Timer(25000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			
			_downCars = new Array(enemyCar7, enemyCar8, enemyCar9, enemyCar10, enemyCar11, enemyCar12);
			for (var i = 0; i < _downCars.length; i++) {
				randomizeCar(0, _downCars[i]);
			}
			_upCars = new Array(enemyCar1, enemyCar2, enemyCar3, enemyCar4, enemyCar5, enemyCar6);
			for (i = 0; i < _upCars.length; i++) {
				randomizeCar(1, _upCars[i]);
			}
			
			SoundManager.addSound("Hit", new Hit(), SoundManager.FX);
			SoundManager.addSound("Engine", new Engine(), SoundManager.FX);
			SoundManager.playSound("Engine", true);
			
			_backgrounds = new Array(background1, background2);
		}
		
		public override function update():void {
			for (var i = 0; i < _backgrounds.length; i++) {
				_backgrounds[i].y+=_driveSpeed;
				if (_backgrounds[i].y >= 600+_backgrounds[i].height) {
					_backgrounds[i].y -= 2352;
				}
			}
			
			var playerRect:Rectangle = new Rectangle(playerCar.x, playerCar.y, 60, 120);
			var enemyRect:Rectangle;
			
			for (i = 0; i < _upCars.length; i++) {
				_upCars[i].y+=_driveSpeed - 15;
				if (_upCars[i].y > 600) {
					_upCars[i].y -= 2100;
				}
				enemyRect = new Rectangle(_upCars[i].x, _upCars[i].y, 60, 120);
				if (playerRect.intersects(enemyRect)) {
					hit();
				}
			}
			
			for (i = 0; i < _downCars.length; i++) {
				_downCars[i].y+=_driveSpeed + 15;
				if (_downCars[i].y > 720) {
					_downCars[i].y -= 2100;
				}
				enemyRect = new Rectangle(_downCars[i].x-60, _downCars[i].y-120, 60, 120);
				if (playerRect.intersects(enemyRect)) {
					hit();
				}
			}
			
			if (_moveLeft && !_moveRight) {
				if (playerCar.x > 110) playerCar.x -= 5;
			}
			else if (_moveRight && !_moveLeft) {
				if (playerCar.x < 685) playerCar.x += 5;
			}
			if (_moveUp && !_moveDown) {
				if (playerCar.y > 120) playerCar.y -= 5;
			}
			if (_moveDown && !_moveUp) {
				if (playerCar.y < 200) playerCar.y += 5;
			}
		}
		
		private function hit() {
			_gameState.changeRelaxation(-1);
			if (!SoundManager.checkIfPlaying("Hit")) {
				SoundManager.playSound("Hit");
				_gameState.shakeMinigame(15);
			}
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (e.keyCode == 68 || e.keyCode == 39) {
				_moveRight = true;
			}
			else if (e.keyCode == 65 || e.keyCode == 37) {
				_moveLeft = true;
			}
			if (e.keyCode == 87 || e.keyCode == 38) {
				_moveUp = true;
			}
			else if (e.keyCode == 83 || e.keyCode == 40) {
				_moveDown = true;
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (e.keyCode == 68 || e.keyCode == 39) {
				_moveRight = false;
			}
			else if (e.keyCode == 65 || e.keyCode == 37) {
				_moveLeft = false;
			}
			if (e.keyCode == 87 || e.keyCode == 38) {
				_moveUp = false;
			}
			else if (e.keyCode == 83 || e.keyCode == 40) {
				_moveDown = false;
			}
		}
		
		private function timerComplete(e:TimerEvent):void {
			SoundManager.removeSound("Hit");
			SoundManager.stopSound("Engine");
			SoundManager.removeSound("Engine");
			_gameState.changeRelaxation(10);
			minigameComplete();
		}
		
		private function randomizeCar(dir:int, car:MovieClip) {
			var randomInt:int = Math.floor( Math.random() * 3 );
			car.x = _carPositions[dir][randomInt];
			car.gotoAndStop(randomInt+1);
		}
		
	}
	
}
