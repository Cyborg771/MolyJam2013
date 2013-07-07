package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.KeyboardEvent;
	
	public class BeerGrab extends Minigame {
		
		private var _grabbing:Boolean = false;
		private var _pulling:Boolean = false;
		private var _gotBeer:Boolean = false;
		private var _moveSpeed:int = 15;
		
		public function BeerGrab(gameState:GameState) {
			super(gameState);
			_gameName = "Beer Grab";
			
			hand.stop();
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				_grabbing = true;
			}
		}
		
		public override function update():void {
			if (_grabbing) {
				hand.y -= 20;
				if (hand.y < 150) {
					_grabbing = false;
					_pulling = true;
					if (hand.x > 245 && hand.x < 340) {
						beer.visible = false;
						hand.gotoAndStop(2);
						_gotBeer = true;
					}
				}
			}
			else if (_pulling) {
				hand.y += 20;
				if (hand.y > 380) {
					if (!_gotBeer) {
						_pulling = false;
					}
					else {
						minigameComplete();
					}
				}
			}
			else {
				hand.x += _moveSpeed;
				if (hand.x > 800-hand.width || hand.x < 0) _moveSpeed *= -1;
			}
		}
		
	}
	
}
