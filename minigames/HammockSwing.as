package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	import flash.display.MovieClip;
	
	public class HammockSwing extends Minigame {
		
		private var _matchIcons:Array;
		private var _lastIcon:MovieClip;
		private var _swings:int = 0;
		
		public function HammockSwing(gameState:GameState) {
			super(gameState);
			_gameName = "Hammock Swing";
			
			SoundManager.addSound("SoRelaxing", new SoRelaxing(), SoundManager.FX);
			SoundManager.addSound("Swing", new Jump(), SoundManager.FX);
			
			hammock.stop();
			
			_matchIcons = [matchIcon1, matchIcon2, matchIcon3, matchIcon4];
			_lastIcon = matchIcon4;
		}
		
		public override function startGame():void {
			_started = true;
			
			SoundManager.playSound("SoRelaxing");
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 65 || e.keyCode == 68) {
					var closestDist = int.MAX_VALUE;
					var closestIcon = 0;
					var correctButton:Boolean = false;
					for (var i = 0; i < _matchIcons.length; i++) {
						var dist:int = Math.abs(_matchIcons[i].y - targetIcon.y);
						if (dist < closestDist) {
							closestDist = dist;
							closestIcon = i;
						}
					}
					
					if (e.keyCode == 65) {
						hammock.gotoAndStop(2);
						if (closestIcon == 0 || closestIcon == 2) correctButton = true;
					}
					if (e.keyCode == 68) {
						hammock.gotoAndStop(3);
						if (closestIcon == 1 || closestIcon == 3) correctButton = true;
					}
					
					if (closestDist < 30) {
						_matchIcons[closestIcon].alpha = 0.5;
						if (correctButton) {
							_gameState.changeRelaxation(0.5);
							_swings++;
							SoundManager.playSound("Swing");
							if (_swings >= 20) {
								SoundManager.removeSound("Swing");
								SoundManager.removeSound("SoRelaxing");
								minigameComplete();
							}
						}
						else _gameState.changeRelaxation(-3);
					}
					else {
						_gameState.changeRelaxation(-3);
					}
					
				}
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
				if (e.keyCode == 65 || e.keyCode == 68) {
					hammock.gotoAndStop(1);
				}
			}
		}
		
		public override function update():void {
			for (var i = 0; i < _matchIcons.length; i++) {
				_matchIcons[i].y-=12;
				if (_matchIcons[i].y <= -129) {
					_matchIcons[i].y = _lastIcon.y + 300;
					_lastIcon = _matchIcons[i];
					_matchIcons[i].alpha = 1;
				}
			}
		}
		
	}
	
}