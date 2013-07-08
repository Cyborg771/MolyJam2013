package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import sounds.SoundManager;
	
	public class MenuState extends State {
		
		private var _introVid:MovieClip;
		private var _background:MovieClip
		private var _loader:Loader = new Loader();
		private static var _introShown:Boolean = false;
		
		public function MenuState(manager:StateManager) {
			super(manager);
			trace("MENU STATE INITIALIZED");
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			_loader.load(new URLRequest("IntroQuote.swf"));
			
			if (!SoundManager.checkIfPlaying("MenuMusic")) {
				SoundManager.addSound("MenuMusic", new MenuMusic(), SoundManager.MUSIC);
				SoundManager.playSound("MenuMusic", true);
			}
		}
		
		private function playClicked(e:MouseEvent):void {
			SoundManager.stopSound("MenuMusic");
			SoundManager.removeSound("MenuMusic");
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
			getStage().addEventListener(MouseEvent.CLICK, skipQuote, false, 0, true);
			getStage().addEventListener(KeyboardEvent.KEY_DOWN, skipQuote, false, 0, true);
		}
		
		private function onLoaded2(e:Event) {
			if (_introShown) {
				skipQuote(e);
			}
			_introShown = true;
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
				getStage().removeEventListener(MouseEvent.CLICK, skipQuote);
				getStage().removeEventListener(KeyboardEvent.KEY_DOWN, skipQuote);
				removeChild(_introVid);
				_introVid.stop();
				_introVid = null;
				playButton.addEventListener(MouseEvent.CLICK, playClicked, false, 0, true);
				creditsButton.addEventListener(MouseEvent.CLICK, creditsClicked, false, 0, true);
			}
		}
		
		private function skipQuote(e:Event):void {
			_introVid.gotoAndStop(_introVid.totalFrames);
		}
		
	}
	
}
