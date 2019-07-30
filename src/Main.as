package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import game.GameWindow;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import game.MenuWindow;

	/**
	 * ...
	 * @author Ardeol
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite {
		
		[Embed(source = "../lib/BAUHS93.ttf", fontName = "ArcenaEmbed", mimetype = "application/x-font", embedAsCFF = "false")]
		public var ArcenaEmbed:Class;
		
		[Embed(source = "../lib/EntertainerMod.mp3")]
		public var Entertainer:Class;
		public static var entertainerSong:Sound;
		
		public static var bgm:SoundChannel;
		
		public static var gameWindow:GameWindow;
		public static var menuWindow:MenuWindow;

		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/*  Entry point
			==========================================*/
			gameWindow = new GameWindow();
			stage.addChild(gameWindow);
			
			menuWindow = new MenuWindow();
			stage.addChild(menuWindow);
			
			entertainerSong = new Entertainer();
			bgm = new SoundChannel();
			bgm = entertainerSong.play();
			bgm.addEventListener(Event.SOUND_COMPLETE, repeatSong);
			//Mouse.hide();
		}
		
		public static function defaultTextFormat(isCentered:Boolean = false):TextFormat {
			var tf:TextFormat = new TextFormat();
			tf.font = "ArcenaEmbed";
			tf.size = 16;
			if(isCentered)
				tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			return tf;
		}
		
		public static function defaultTextField(isCentered:Boolean = false):TextField {
			var t:TextField = new TextField();
			t.selectable = false;
			t.embedFonts = true;
			t.defaultTextFormat = defaultTextFormat(isCentered);
			return t;
		}
		
		private function repeatSong(e:Event):void {
			bgm.removeEventListener(Event.SOUND_COMPLETE, repeatSong);
			bgm = entertainerSong.play();
			bgm.addEventListener(Event.SOUND_COMPLETE, repeatSong);
		}
	}

}