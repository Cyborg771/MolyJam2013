package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import sounds.SoundManager;
	
	public class OfficeEscape extends Minigame {
		
		private var _backgrounds:Array;
		private var _obstacles:Array;
		private var _obstaclePositions:Array = new Array(410, 110);
		private var _jumping:Boolean = false;
		private var _velocityY:Number = 0;
		private var _jumpStrength:Number = 35;
		private var _gravity:Number = 2.5;
		private var _timer:Timer;
		private var _runSpeed:int = 20;
		private var _flashTime:int = 0;
		
		public function OfficeEscape(gameState:GameState) {
			super(gameState);
			_gameName = "Office Escape";
			
			_timer = new Timer(25000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			_backgrounds = new Array(background1, background2);
			for (var i = 0; i < _backgrounds.length; i++) {
				_backgrounds[i].gotoAndStop(i+1);
			}
			_obstacles = new Array(obstacle1, obstacle2);
			for (i = 0; i < _obstacles.length; i++) {
				setObstacle(_obstacles[i]);
			}
			character.stop();
			
			SoundManager.addSound("Ow1", new Ow1(), SoundManager.FX);
			SoundManager.addSound("Ow2", new Ow2(), SoundManager.FX);
			SoundManager.addSound("Ow3", new Ow3(), SoundManager.FX);
			SoundManager.addSound("Jump", new Jump(), SoundManager.FX);
			SoundManager.addSound("Slide", new Slide(), SoundManager.FX);
			SoundManager.addSound("Hit", new Hit(), SoundManager.FX);
			SoundManager.addSound("GottaLeave", new LeaveWork(), SoundManager.FX);
			SoundManager.playSound("GottaLeave");
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (e.keyCode == 83 && !_jumping) {
				character.gotoAndStop(2);
				if (!SoundManager.checkIfPlaying("Slide")) SoundManager.playSound("Slide");
			}
			if (e.keyCode == 87 && !_jumping) {
				_jumping = true;
				character.gotoAndStop(3);
				_velocityY = _jumpStrength;
				SoundManager.playSound("Jump");
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (!_jumping && e.keyCode == 83) {
				character.gotoAndStop(1);
				SoundManager.stopSound("Slide");
			}
		}
		
		public override function update():void {
			if (_jumping) {
				character.y -= _velocityY;
				_velocityY -= _gravity;
				if (character.y > 550) {
					character.y = 550;
					_jumping = false;
					character.gotoAndStop(1);
				}
			}
			
			for (var i = 0; i < _backgrounds.length; i++) {
				_backgrounds[i].x-=_runSpeed;
				if (_backgrounds[i].x <= 0-_backgrounds[i].width) {
					_backgrounds[i].x += 3200;
				}
			}
			
			var charBox:Rectangle = new Rectangle(character.x, character.y-character.hitBox.height, character.hitBox.width, character.hitBox.height);
			for (i = 0; i < _obstacles.length; i++) {
				_obstacles[i].x-=_runSpeed;
				if (_obstacles[i].x <= 0-_obstacles[i].width) {
					_obstacles[i].x += 3200;
					setObstacle(_obstacles[i]);
				}
				var obstBox:Rectangle = new Rectangle(_obstacles[i].x + _obstacles[i].hitBox.x, _obstacles[i].y + _obstacles[i].hitBox.y, _obstacles[i].hitBox.width, _obstacles[i].hitBox.height);
				if (charBox.intersects(obstBox)) {
					if (!SoundManager.checkIfPlaying("Ow1") && !SoundManager.checkIfPlaying("Ow2") && !SoundManager.checkIfPlaying("Ow3")) {
						var randomInt:int = Math.floor( Math.random() * 3 ) + 1;
						SoundManager.playSound("Ow" + randomInt);
						SoundManager.playSound("Hit");
						_gameState.shakeMinigame(20);
						character.gotoAndStop(4);
						_flashTime = 32;
					}
				}
			}
			if (character.currentFrame == 4 && _flashTime == 0) {
				character.gotoAndStop(1);
			}
			else if (character.currentFrame == 4) {
				_flashTime--;
			}
		}
		
		private function timerComplete(e:TimerEvent):void {
			SoundManager.removeSound("Ow1");
			SoundManager.removeSound("Ow2");
			SoundManager.removeSound("Ow3");
			SoundManager.removeSound("Jump");
			SoundManager.removeSound("Slide");
			SoundManager.removeSound("Hit");
			SoundManager.removeSound("GottaLeave");
			minigameComplete();
		}
		
		private function setObstacle(o:MovieClip) {
			var randomInt:int = Math.floor( Math.random() * 2 );
			o.gotoAndStop(randomInt+1);
			o.y = _obstaclePositions[randomInt];
		}
		
	}
}