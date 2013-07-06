package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class MenuState extends State {
		
		public function MenuState(manager:StateManager) {
			super(manager);
			trace("MENU STATE INITIALIZED");
			
			playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
			creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			
			introQuote.addEventListener(Event.ENTER_FRAME, introQuoteUpdate, false, 0, true);
			introQuote.addEventListener(MouseEvent.CLICK, skipQuote, false, 0, true);
			getStage().addEventListener(KeyboardEvent.KEY_DOWN, skipQuote, false, 0, true);
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
				introQuote.removeEventListener(MouseEvent.CLICK, skipQuote);
				getStage().removeEventListener(KeyboardEvent.KEY_DOWN, skipQuote);
				removeChild(introQuote);
				introQuote.stop();
				introQuote = null;
			}
		}
		
		private function skipQuote(e:Event):void {
			introQuote.gotoAndStop(introQuote.totalFrames);
		}
		
	}
	
}
