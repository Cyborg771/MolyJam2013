package gameobjects {
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import states.GameState;
	
	public class GameObject extends Sprite {
		
		protected var _gameState:GameState;
		protected var _velocity:Point;
		
		public function GameObject(gameState:GameState) {
			_gameState = gameState;
		}
		
		public virtual function update():void
		{
		}
		
		public function get bounds():Rectangle
		{
			return new Rectangle(x, y, width, height);
		}
		
		public function get velocity():Point
		{
			return _velocity;
		}
		
	}
	
}
