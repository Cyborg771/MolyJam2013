package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	
	public class OfficeEscape extends Minigame {
		
		private var _backgrounds:Array;
		private var _obstacles:Array;
		private var _obstaclePositions:Array = new Array(455, 310);
		private var _jumping:Boolean = false;
		private var _velocityY:Number = 0;
		private var _jumpStrength:Number = 30;
		private var _gravity:Number = 2.5;
		private var _timer:Timer;
		private var _runSpeed:int = 20;
		
		public function OfficeEscape(gameState:GameState) {
			super(gameState);
			_gameName = "Office Escape";
			
			_timer = new Timer(30000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			_backgrounds = new Array(background1, background2);
			_obstacles = new Array(obstacle1, obstacle2);
			for (var i = 0; i < _obstacles.length; i++) {
				setObstacle(_obstacles[i]);
			}
			character.stop();
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (e.keyCode == 83 && !_jumping) {
				character.gotoAndStop(2);
			}
			if (e.keyCode == 87 && !_jumping) {
				_jumping = true;
				character.gotoAndStop(3);
				_velocityY = _jumpStrength;
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (!_jumping) character.gotoAndStop(1);
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
			
			for (i = 0; i < _obstacles.length; i++) {
				_obstacles[i].x-=_runSpeed;
				if (_obstacles[i].x <= 0-_obstacles[i].width) {
					_obstacles[i].x += 3200;
					setObstacle(_obstacles[i]);
				}
				if (new Rectangle(character.x, character.y-character.height, character.width, character.height).intersects(new Rectangle(_obstacles[i].x, _obstacles[i].y, _obstacles[i].width, _obstacles[i].height))) {
					trace("HIT");
				}
			}
		}
		
		private function timerComplete(e:TimerEvent):void {
			minigameComplete();
		}
		
		private function setObstacle(o:MovieClip) {
			var randomInt:int = Math.floor( Math.random() * 2 );
			o.gotoAndStop(randomInt+1);
			o.y = _obstaclePositions[randomInt];
		}
		
	}
}