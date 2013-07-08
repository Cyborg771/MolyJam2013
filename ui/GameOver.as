package ui {
	
	import flash.display.MovieClip;
	import sounds.SoundManager;
	import flash.events.MouseEvent;
	import states.GameState;
	
	public class GameOver extends MovieClip {
		
		private var _gameState:GameState;
		
		public function GameOver(score:int, gameState:GameState) {
			_gameState = gameState;
			scoreText.text = "RELAXATION: "+score;
			SoundManager.addSound("HighScore", new HighScore(), SoundManager.FX);
			SoundManager.addSound("AverageScore", new AverageScore(), SoundManager.FX);
			SoundManager.addSound("LowScore", new LowScore(), SoundManager.FX);
			if (score >= 30) {
				SoundManager.playSound("HighScore");
				avatar.gotoAndStop(1);
			}
			else if (score  > -30){
				SoundManager.playSound("AverageScore");
				avatar.gotoAndStop(3);
			}
			else{
				SoundManager.playSound("LowScore");
				avatar.gotoAndStop(2);
			}
			
			backButton.addEventListener(MouseEvent.CLICK, backClicked, false, 0, true);
		}
		
		private function backClicked(e:MouseEvent):void {
			_gameState.endGame();
		}
	}
	
}
