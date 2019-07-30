package game {
	import flash.display.Bitmap;
	import com.ardeol.fue.FullWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.text.TextField;
	
	public class GameWindow extends FullWindow {
		public static var back:Bitmap;
		public static var border:Bitmap;
		
		private var player:Player;
		private var scoreText:TextField;
		private var levelText:TextField;
		public var isPaused:Boolean;
		public var bulletWindow:BulletWindow;
		public var bullets:Object;
		private var _numOfBullets:uint;
		private var coin:Coin;
		
		private var _level:uint;
		private var _count:uint;
		private var _lives:Vector.<Bitmap>;
		private var screen:Sprite;
		
		/*  Constructor
		==============================================*/
		public function GameWindow() {
			super("Game");
			//  Initialize variables
			back = Assets.backgroundFill();
			border = Assets.backgroundBorder();
			player = new Player();
			scoreText = Main.defaultTextField();
			levelText = Main.defaultTextField(true);
			isPaused = false;
			bulletWindow = new BulletWindow();
			bullets = new Object();
			_numOfBullets = 0;
			coin = new Coin();
			_level = 0;
			_count = 0;
			_lives = new Vector.<Bitmap>();
			screen = new Sprite();
			
			// Display Back
			this.addChild(back);
			
			// Display Player
			player.x = 200;
			player.y = 340;
			this.addChild(player);
			
			// Display Coin
			
			// Display Bullet Window
			this.addChild(bulletWindow);
			
			// Display Border
			this.addChild(border);
			
			// Display Score
			scoreText.text = "Score";
			scoreText.x = 10;
			scoreText.y = 0;
			scoreText.width = 400;
			this.addChild(scoreText);
			
			// Display Level Text
			levelText.text = "";
			levelText.y = 380;
			levelText.width = 400;
			this.addChild(levelText);
			
			// Display Screen
			screen.visible = false;
			this.addChild(screen);
			
			//  Initialize Event Listener
			if (this.stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.ENTER_FRAME, updateScore);
		}
		
		private function init(e:Event = null):void {
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, togglePause);
			//startGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/*  Access Methods
		==============================================*/
		public function getPlayerX():Number {  return player.x; }
		public function getPlayerY():Number {  return player.y; }
		public function get numOfBullets():uint {  return _numOfBullets; }
		public function get level():uint { return _level; }
		public function setLevelText(name:String):void {
			levelText.text = name;
		}
		public function get lives():int {  return _lives.length; }
		public function get score():uint {  return player.score; }
		
		/*  Public Methods
		==============================================*/
		public function incrementBullets():uint {
			return ++_numOfBullets;
		}
		
		public function destroyAllBullets():void {
			for (var index:Object in bullets) 
				bullets[index].destroyBullet();
		}
		
		public function progressLevel():void {
			player.score += 100*_level;
			++_level;
			_count = 0;
			this.removeChild(coin);
			destroyAllBullets();
			bulletWindow.destroyAllSpawners();
			bulletWindow.commenceLevel(_level);
			flashScreen();
		}
		
		public function startGame():void {
			Mouse.hide();
			_level = 1;
			while (_lives.length != 0)
				decrementLives();
			for (var i:int = 0; i < 3; ++i)
				incrementLives();
			player.score = 0;
			_count = 0;
			bulletWindow.commenceLevel(_level);
		}
		
		public function endGame():void {
			Mouse.show();
			destroyAllBullets();
			bulletWindow.destroyAllSpawners();
			if (this.contains(coin))
				this.removeChild(coin);
			_level = 0;
			Main.menuWindow.showReplayScreen();
		}
		
		public function incrementLives():int {
			var life:Bitmap = Assets.starLife();
			life.y = 1;
			life.x = 380 - lives * 20;
			this.addChild(life);
			_lives.push(life);
			return _lives.length;
		}
		
		public function decrementLives():int {
		//  Returns the new number of lives
			if (lives == 0) {
				endGame();
				return 0;
			}
			this.removeChild(_lives.pop());
			return _lives.length;
		}
		
		public function flashScreen(color:uint = 0xFFFFFF):void {
			screen.graphics.clear();
			screen.graphics.beginFill(color);
			screen.graphics.drawRect(0, 0, 400, 400);
			screen.graphics.endFill();
			screen.alpha = 1;
			screen.visible = true;
		}
		
		/*  Events
		==============================================*/
		private function togglePause(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.P || e.keyCode == Keyboard.SHIFT)
				isPaused = !isPaused;
			if (isPaused)
				Mouse.show();
			else
				Mouse.hide();
		}
		
		private function updateScore(e:Event):void {
			if(!isPaused && _level > 0){
				++_count;
				scoreText.text = "Score: " + Math.round(player.score);
				if (_count == 900) {
					coin.x = Math.random() * 300 + 50;
					coin.y = Math.random() * 300 + 50;
					coin.scaleX = 0;
					coin.scaleY = 0;
					this.addChild(coin);
				}
			}
			if (screen.visible) {
				screen.alpha -= .25;
				if (screen.alpha <= 0)
					screen.visible = false;
			}
		}
	}
}