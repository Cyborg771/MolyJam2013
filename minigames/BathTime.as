package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	
	public class BathTime extends Minigame {
		
		public function BathTime(gameState:GameState) {
			super(gameState);
			_gameName = "Bath Time";
		}
		
		public override function startGame():void {
			_started = true;
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (_started) {
			}
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (_started) {
			}
		}
		
		public override function update():void {
		}
		
	}
	
}