﻿package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	
	public class BeerGrab extends Minigame {
		
		private var _grabbing:Boolean = false;
		private var _pulling:Boolean = false;
		private var _gotBeer:Boolean = false;
		private var _moveSpeed:int = 25;
		
		public function BeerGrab(gameState:GameState) {
			super(gameState);
			_gameName = "Beer Grab";
			
			SoundManager.addSound("Beer", new Beer(), SoundManager.FX);
			
			hand.stop();
		}
		
		public override function startGame():void {
			_started = true;
			
			SoundManager.playSound("Beer");
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 87) {
					_grabbing = true;
				}
			}
		}
		
		public override function update():void {
			if (_grabbing) {
				hand.y -= 20;
				if (hand.y < 265) {
					_grabbing = false;
					_pulling = true;
					if (hand.x > 295 && hand.x < 360) {
						beer.visible = false;
						hand.gotoAndStop(2);
						_gotBeer = true;
					}
				}
			}
			else if (_pulling) {
				hand.y += 20;
				if (hand.y > 497) {
					hand.y = 497;
					if (!_gotBeer) {
						_pulling = false;
						_gameState.changeRelaxation(-10);
					}
					else {
						_gameState.changeRelaxation(10);
						SoundManager.removeSound("Beer");
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
