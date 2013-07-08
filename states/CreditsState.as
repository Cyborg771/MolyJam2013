package states {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public class CreditsState extends State {
		
		private var _loader:Loader;
		private var _background:MovieClip;
		
		public function CreditsState(manager:StateManager) {
			super(manager);
			trace("CREDITS STATE INITIALIZED");
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded, false, 0, true);
			_loader.load(new URLRequest("Background.swf"));
			
			backButton.addEventListener(MouseEvent.CLICK, backClicked, false, 0, true);
		}
		
		private function backClicked(e:MouseEvent):void {
			_manager.setState("Menu");
		}
		
		private function onLoaded(e:Event) {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			_background = e.target.content;
			addChild(_background);
			setChildIndex(_background, 0);
		}
		
	}
	
}
