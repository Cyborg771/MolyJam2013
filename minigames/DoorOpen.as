package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	
	public class DoorOpen extends Minigame {
		
		private var _highlightPositions:Array = [41, 166, 295, 408, 531, 657];
		private var _keyPositions:Array = [52, 176.2, 300.55, 421.3, 541.8, 666];
		private var _keys:Array;
		private var _currentPosition:int = 0;
		private var _correctKey:MovieClip = null;
		private var _flashCounter:int = 0;
		private var _gameOver:Boolean = false;
		private var _interactable:Boolean = true;
		
		
		public function DoorOpen(gameState:GameState) {
			super(gameState);
			_gameName = "Door Open";
			
			yesNoIcon.visible = false;
			
			SoundManager.addSound("WhichKey", new WhichKey(), SoundManager.FX);
			SoundManager.addSound("KeySelect", new KeySelect(), SoundManager.FX);
			
			_keys = [key1, key2, key3, key4, key5, key6];
		}
		
		public override function startGame():void {
			_started = true;
			
			SoundManager.playSound("WhichKey");
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started && !_gameOver && _interactable) {
				if (e.keyCode == 65) {
					_currentPosition--;
					if (_currentPosition == -1) _currentPosition = 5;
					TweenLite.to(highlight, 0.3, {x:_highlightPositions[_currentPosition]});
				}
				if (e.keyCode == 68) {
					_currentPosition++;
					_currentPosition%=6;
					TweenLite.to(highlight, 0.3, {x:_highlightPositions[_currentPosition]});
				}
				if (e.keyCode == 87) {
					if (_correctKey == null) {
						var randomInt:int = _currentPosition;
						while (randomInt == _currentPosition) randomInt = Math.floor( Math.random() * 6 );
						_correctKey = _keys[randomInt];
					}
					var selectedKey:MovieClip;
					for (var i = 0; i < _keys.length; i++) {
						if (Math.abs(_keyPositions[i] - _keyPositions[_currentPosition]) < 5) {
							selectedKey = _keys[i];
						}
					}
					if (selectedKey == _correctKey) {
						_interactable = false;
						TweenLite.to(selectedKey, 0.2, {y:350, onComplete:rightKey})
					}
					else {
						_interactable = false;
						TweenLite.to(selectedKey, 0.2, {y:350, onComplete:wrongKey, onCompleteParams:[selectedKey]})
					}
				}
			}
		}
		
		private function wrongKey(key:MovieClip) {
			yesNoIcon.gotoAndStop(1);
			TweenLite.to(key, 0.2, {y:400, onComplete:wrongKey2});
			flashIcon();
			_gameState.changeRelaxation(-1);
		}
		
		private function wrongKey2() {
			SoundManager.playSound("KeySelect");
			shuffleKeys();
			shuffleKeys();
		}
		
		private function rightKey() {
			_gameOver = true;
			yesNoIcon.gotoAndStop(2);
			flashIcon();
			_gameState.changeRelaxation(3);
		}
		
		private function shuffleKeys() {
			var randomInt1:int = Math.floor( Math.random() * 6 );
			var randomInt2:int = randomInt1;
			while (randomInt2 == randomInt1) randomInt2 = Math.floor( Math.random() * 6 );
			var tempKey = _keys[randomInt1];
			_keys[randomInt1] = _keys[randomInt2];
			_keys[randomInt2] = tempKey;
			
			for (var i = 0; i < _keys.length; i++) {
				TweenLite.to(_keys[i], 0.3, {x:_keyPositions[i], onComplete:shuffleComplete});
			}
		}
		
		private function shuffleComplete(){
			_interactable = true;
		}
		
		private function flashIcon() {
			_flashCounter = 15;
		}
		
		public override function update():void {
			if (_flashCounter > 0) {
				if (_flashCounter%2 == 0) yesNoIcon.visible = !yesNoIcon.visible;
				_flashCounter--;
			}
			else {
				if (_gameOver) {
					SoundManager.removeSound("WhichKey");
					SoundManager.removeSound("KeySelect");
					minigameComplete();
				}
				yesNoIcon.visible = false;
			}
		}
		
	}
	
}