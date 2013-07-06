package minigames.officeescape {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import minigames.*;
	
	public class OfficeEscape extends Minigame {
		
		public function OfficeEscape(gameState:GameState) {
			super(gameState);
			
			_gameName = "Office Escape";
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			trace(e.keyCode);
		}
		
		public override function update():void {
			background.x-=10;
		}
		
	}
}