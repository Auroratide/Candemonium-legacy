package game {
	import com.ardeol.fue.FullWindow;
	import flash.display.Bitmap;
	import flash.errors.InvalidSWFError;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//  a poorly written class b/c time.
	public class MenuWindow extends FullWindow {
		public var titleMenu:Bitmap;
		public var subMenu:Bitmap;
		public var beginText:TextField;
		public var beginButton:InvisibleButton;
		public var instructionText:TextField;
		public var instructionPortal:Bitmap;
		public var instructionCandy:Bitmap;
		
		public var replayText:TextField;
		public var scoreText:TextField;
		
		public var creditsScreen:Bitmap;
		public var backText:TextField;
		public var backButton:InvisibleButton;
		
		public var controlsScreen:Bitmap;
		
		public var startButton:InvisibleButton;
		public var creditsButton:InvisibleButton;
		public var controlsButton:InvisibleButton;
		
		public function MenuWindow() {
			super("Menu");
			
			subMenu = Assets.subMenu();
			subMenu.x = 100;
			subMenu.y = 125;
			this.addChild(subMenu);
			
			var tf:TextFormat = Main.defaultTextFormat();
			beginText = Main.defaultTextField();
			tf.size = 28;
			beginText.defaultTextFormat = tf;
			beginText.text = "Begin";
			beginText.x = 160;
			beginText.y = 225;
			this.addChild(beginText);
			
			var tf2:TextFormat = Main.defaultTextFormat();
			tf2.size = 20;
			instructionText = Main.defaultTextField();
			instructionText.defaultTextFormat = tf2;
			instructionText.x = 118;
			instructionText.y = 140;
			instructionText.text = "Collect:\n\nAvoid:";
			this.addChild(instructionText);
			
			instructionPortal = Assets.portal();
			instructionPortal.x = 200;
			instructionPortal.y = 138;
			this.addChild(instructionPortal);
			instructionCandy = Assets.lolliPop();
			instructionCandy.x = 220;
			instructionCandy.y = 180;
			instructionCandy.rotation = 45;
			this.addChild(instructionCandy);
			
			replayText = Main.defaultTextField();
			replayText.defaultTextFormat = tf;
			replayText.text = "Replay";
			replayText.x = 154;
			replayText.y = 225;
			this.addChild(replayText);
			replayText.visible = false;
			
			var tf3:TextFormat = Main.defaultTextFormat(true);
			tf3.size = 20;
			scoreText = Main.defaultTextField();
			scoreText.defaultTextFormat = tf3;
			scoreText.width = 200;
			scoreText.text = "Score: ";
			scoreText.x = 100;
			scoreText.y = 160;
			this.addChild(scoreText);
			scoreText.visible = false;
			
			beginButton = new InvisibleButton(beginGame, 74, 32);
			beginButton.x = 162;
			beginButton.y = 225;
			beginButton.visible = false;
			this.addChild(beginButton);
			
			titleMenu = Assets.titleMenu();
			this.addChild(titleMenu);
			
			creditsScreen = Assets.credits();
			this.addChild(creditsScreen);
			creditsScreen.visible = false;
			
			controlsScreen = Assets.controls();
			this.addChild(controlsScreen);
			controlsScreen.visible = false;
			
			backText = Main.defaultTextField();
			backText.defaultTextFormat = tf3;
			backText.width = 400;
			backText.y = 350;
			backText.text = "Back";
			this.addChild(backText);
			backText.visible = false;
			
			startButton = new InvisibleButton(activateGame, 132, 43);
			startButton.x = 135;
			startButton.y = 164;
			this.addChild(startButton);
			
			creditsButton = new InvisibleButton(showCredits, 185, 44);
			creditsButton.x = 109;
			creditsButton.y = 274;
			this.addChild(creditsButton);
			
			controlsButton = new InvisibleButton(showControls, 224, 43);
			controlsButton.x = 89;
			controlsButton.y = 219;
			this.addChild(controlsButton);
			
			backButton = new InvisibleButton(showMenu, 52, 30);
			backButton.x = 174;
			backButton.y = 343;
			this.addChild(backButton);
			backButton.visible = false;
		}
		
		public function showReplayScreen():void {
			visible = true;
			scoreText.text = "Score\n" + Main.gameWindow.score;
		}
		
		public static function activateGame():void {
			Main.menuWindow.titleMenu.visible = false;
			Main.menuWindow.startButton.visible = false;
			Main.menuWindow.creditsButton.visible = false;
			Main.menuWindow.controlsButton.visible = false;
			Main.menuWindow.beginButton.visible = true;
		}
		
		public static function beginGame():void {
			Main.menuWindow.visible = false;
			//Main.menuWindow.beginButton.visible = false;
			Main.menuWindow.beginText.visible = false;
			Main.menuWindow.instructionCandy.visible = false;
			Main.menuWindow.instructionPortal.visible = false;
			Main.menuWindow.instructionText.visible = false;
			Main.menuWindow.replayText.visible = true;
			Main.menuWindow.scoreText.visible = true;
			Main.gameWindow.startGame();
		}
		
		public static function showCredits():void {
			Main.menuWindow.startButton.visible = false;
			Main.menuWindow.creditsButton.visible = false;
			Main.menuWindow.controlsButton.visible = false;
			Main.menuWindow.backButton.visible = true;
			Main.menuWindow.backText.visible = true;
			Main.menuWindow.creditsScreen.visible = true;
		}
		
		public static function showControls():void {
			Main.menuWindow.controlsScreen.visible = true;
			Main.menuWindow.startButton.visible = false;
			Main.menuWindow.creditsButton.visible = false;
			Main.menuWindow.controlsButton.visible = false;
			Main.menuWindow.backButton.visible = true;
			Main.menuWindow.backText.visible = true;
		}
		
		public static function showMenu():void {
			Main.menuWindow.creditsScreen.visible = false;
			Main.menuWindow.backButton.visible = false;
			Main.menuWindow.backText.visible = false;
			Main.menuWindow.startButton.visible = true;
			Main.menuWindow.creditsButton.visible = true;
			Main.menuWindow.controlsScreen.visible = false;
			Main.menuWindow.controlsButton.visible = true;
		}
	}
}