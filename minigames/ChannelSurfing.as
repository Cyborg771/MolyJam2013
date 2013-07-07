package minigames {
	
	import flash.display.Sprite;
	import states.GameState;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import sounds.SoundManager;
	import flash.events.Event;
	
	public class ChannelSurfing extends Minigame {
		
		private var _timer:Timer;
		private var _channelTimer:Timer;
		private var _prevChannel:int;
		
		public function ChannelSurfing(gameState:GameState) {
			super(gameState);
			_gameName = "ChannelSurfing";
			
			_timer = new Timer(20000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete, false, 0, true);
			_timer.start();
			
			changeChannel();
			icon.gotoAndStop(1);
			
			_channelTimer = new Timer(2000, 0);
			_channelTimer.addEventListener(TimerEvent.TIMER, changeChannel, false, 0, true);
			_channelTimer.start();
			
			tvContent.stop();
		}
		
		private function timerComplete(e:TimerEvent):void {
			minigameComplete();
		}
		
		protected override function keyDownFunction(e:KeyboardEvent):void {
			if (e.keyCode == 87 || e.keyCode == 38) tvContent.gotoAndStop(10);
		}
		
		protected override function keyUpFunction(e:KeyboardEvent):void {
			if (e.keyCode == 87 || e.keyCode == 38) changeChannel(e);
		}
		
		private function changeChannel(e:Event = null):void {
			var randomInt = _prevChannel
			while (randomInt == _prevChannel) randomInt= Math.floor( Math.random() * 9 ) + 1;
			tvContent.gotoAndStop(randomInt);
			_prevChannel = randomInt;
		}
		
		public override function update():void {
			if (tvContent.currentFrame <= 5) {
				_gameState.changeRelaxation(-0.25);
				icon.gotoAndStop(1);
			}
			else if (tvContent.currentFrame != 10) {
				_gameState.changeRelaxation(0.15);
				icon.gotoAndStop(2);
			}
		}
		
	}
	
}
