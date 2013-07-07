package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	
	public class DoorOpen extends Minigame {
		
		public function DoorOpen(gameState:GameState) {
			super(gameState);
			_gameName = "Door Open";
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