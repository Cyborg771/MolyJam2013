package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	
	public class MenuState extends State {
		
		private var _introVid:MovieClip;
		private var _background:MovieClip
		private var _loader:Loader = new Loader();
		
		public function MenuState(manager:StateManager) {
			super(manager);
			trace("MENU STATE INITIALIZED");
			
			playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
			creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			
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
			_introVid = e.target.content;
			addChild(_introVid);
			removeChild(loadScreen);
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded2, false, 0, true);
			_loader.load(new URLRequest("Background.swf"));
			
			
			_introVid.addEventListener(Event.ENTER_FRAME, introVidUpdate, false, 0, true);
			_introVid.addEventListener(MouseEvent.CLICK, skipQuote, false, 0, true);
			getStage().addEventListener(KeyboardEvent.KEY_DOWN, skipQuote, false, 0, true);
		}
		
		private function onLoaded2(e:Event) {
			_background = e.target.content;
			addChild(_background);
			setChildIndex(_background, 0);
		}
		 
		private function introVidUpdate(e:Event):void {
			if (e.target.currentFrame >= 423) {
				_introVid.alpha -= 0.05;
			}
			if (e.target.currentFrame == e.target.totalFrames) {
				_introVid.removeEventListener(Event.ENTER_FRAME, introVidUpdate);
				_introVid.removeEventListener(MouseEvent.CLICK, skipQuote);
				getStage().removeEventListener(KeyboardEvent.KEY_DOWN, skipQuote);
				removeChild(_introVid);
				_introVid.stop();
				_introVid = null;
			}
		}
		
		private function skipQuote(e:Event):void {
			_introVid.gotoAndStop(_introVid.totalFrames);
		}
		
	}
	
}
