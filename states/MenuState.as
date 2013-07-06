package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	
	public class MenuState extends State {
		
		private var introVid:MovieClip;
		
		public function MenuState(manager:StateManager) {
			super(manager);
			trace("MENU STATE INITIALIZED");
			
			playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
			creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			_loader.load(new URLRequest("IntroQuote.swf"));
		}
		
		private function playClicked(e:MouseEvent):void {
			_manager.setState("Game");
		}
		
		private function creditsClicked(e:MouseEvent):void {
			_manager.setState("Credits");
		}
		
		private function onLoaded(e:Event){
			introVid = e.target.content;
			addChild(introVid);
			removeChild(loadScreen);
			
			introVid.addEventListener(Event.ENTER_FRAME, introVidUpdate, false, 0, true);
			introVid.addEventListener(MouseEvent.CLICK, skipQuote, false, 0, true);
			getStage().addEventListener(KeyboardEvent.KEY_DOWN, skipQuote, false, 0, true);
		}
		 
		private function introVidUpdate(e:Event):void {
			if (e.target.currentFrame >= 423) {
				introVid.alpha -= 0.05;
			}
			if (e.target.currentFrame == e.target.totalFrames) {
				introVid.removeEventListener(Event.ENTER_FRAME, introVidUpdate);
				introVid.removeEventListener(MouseEvent.CLICK, skipQuote);
				getStage().removeEventListener(KeyboardEvent.KEY_DOWN, skipQuote);
				removeChild(introVid);
				introVid.stop();
				introVid = null;
			}
		}
		
		private function skipQuote(e:Event):void {
			introVid.gotoAndStop(introVid.totalFrames);
		}
		
	}
	
}
