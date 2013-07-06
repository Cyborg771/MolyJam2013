package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class MenuState extends State {
		
		public function MenuState(manager:StateManager) {
			super(manager);
			trace("MENU STATE INITIALIZED");
			
			playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
			creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			
			introQuote.addEventListener(Event.ENTER_FRAME, introQuoteUpdate, false, 0, true);
		}
		
		private function playClicked(e:MouseEvent):void {
			_manager.setState("Game");
		}
		
		private function creditsClicked(e:MouseEvent):void {
			_manager.setState("Credits");
		}
		
		private function introQuoteUpdate(e:Event):void {
			if (e.target.currentFrame == e.target.totalFrames) {
				introQuote.removeEventListener(Event.ENTER_FRAME, introQuoteUpdate);
				removeChild(introQuote);
				introQuote.stop();
				introQuote = null;
			}
		}
	}
	
}
