package minigames {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import sounds.SoundManager;
	import states.GameState;
	
	public class HammockSwing extends Minigame {
		
		public function HammockSwing(gameState:GameState) {
			super(gameState);
			_gameName = "Hammock Swing";
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