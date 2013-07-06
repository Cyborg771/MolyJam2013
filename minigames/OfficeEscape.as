package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	public class OfficeEscape extends Minigame {
		
		private var _backgrounds:Array;
		private var _jumping:Boolean = false;
		private var _velocityY:Number = 0;
		private var _jumpStrength:Number = 30;
		private var _gravity:Number = 2.5;
		
		public function OfficeEscape(gameState:GameState) {
			super(gameState);
			_gameName = "Office Escape";
			
			_backgrounds = new Array(background1, background2);
			character.stop();
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (e.keyCode == 83) {
				character.gotoAndStop(2);
			}
			if (e.keyCode == 87 && !_jumping) {
				_jumping = true;
				_velocityY = _jumpStrength;
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			character.gotoAndStop(1);
		}
		
		public override function update():void {
			if (_jumping) {
				character.y -= _velocityY;
				_velocityY -= _gravity;
				if (character.y > 600) {
					character.y = 600;
					_jumping = false;
				}
			}
			
			for (var i = 0; i < _backgrounds.length; i++) {
				_backgrounds[i].x-=20;
				if (_backgrounds[i].x <= 0-_backgrounds[i].width) {
					_backgrounds[i].x += 3200;
				}
			}
		}
		
	}
}