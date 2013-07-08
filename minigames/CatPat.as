package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	import flash.display.MovieClip;
	
	public class CatPat extends Minigame {
		
		private var _matchIcons:Array;
		private var _lastIcon:MovieClip;
		private var _patCounter:int = 0;
		
		public function CatPat(gameState:GameState) {
			super(gameState);
			_gameName = "Cat Pat";
			
			_matchIcons = [matchIcon1, matchIcon2, matchIcon3];
			_lastIcon = matchIcon3;
			
			SoundManager.addSound("CatHappy1", new CatHappy(), SoundManager.FX);
			SoundManager.addSound("CatHappy2", new CatHappy2(), SoundManager.FX);
			SoundManager.addSound("CatAngry", new CatAngry(), SoundManager.FX);
			SoundManager.addSound("GoodCat", new GoodCat(), SoundManager.FX);
			
			
			cat.stop();
		}
		
		public override function startGame():void {
			_started = true;
			
			SoundManager.playSound("GoodCat");
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 87) {
					hand.y = 175;
					var closestDist = int.MAX_VALUE;
					var closestIcon = 0;
					for (var i = 0; i < _matchIcons.length; i++) {
						var dist:int = Math.abs(_matchIcons[i].y - targetIcon.y);
						if (dist < closestDist) {
							closestDist = dist;
							closestIcon = i;
						}
					}
					if (closestDist < 30) {
						cat.gotoAndStop(3);
						_matchIcons[closestIcon].alpha = 0.5;
						_gameState.changeRelaxation(0.5);
						_patCounter++;
						if (_patCounter >= 15) {
							SoundManager.removeSound("CatHappy1");
							SoundManager.removeSound("CatHappy2");
							SoundManager.removeSound("CatAngry");
							SoundManager.removeSound("GoodCat");
							minigameComplete();
						}
						SoundManager.playSound("CatHappy"+(_patCounter%2+1));
					}
					else {
						cat.gotoAndStop(2);
						_gameState.changeRelaxation(-3);
						SoundManager.playSound("CatAngry");
					}
				}
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 87) {
					hand.y = 115;
				}
			}
		}
		
		public override function update():void {
			for (var i = 0; i < _matchIcons.length; i++) {
				_matchIcons[i].y-=10;
				if (_matchIcons[i].y <= -129) {
					_matchIcons[i].y = _lastIcon.y + 300;
					_lastIcon = _matchIcons[i];
					_matchIcons[i].alpha = 1;
				}
			}
		}
		
	}
	
}