package game {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class Bullet extends Sprite {
		public var vel:Velocity;
		protected var moveSequence:Function;
		protected var img:Bitmap;
		
		private var _id:uint;
		private var _count:uint;
		private var _rotationSpeed:Number;
		
		/*  Constructor
		==============================================*/
		public function Bullet(ID:uint, moveSeq:Function, v:Velocity) {
			_id = ID;
			vel = v.clone();
			_count = 0;
			_rotationSpeed = Math.random() * 8 - 4;
			moveSequence = moveSeq;
			this.addEventListener(Event.ENTER_FRAME, move);
			this.addEventListener(Event.ENTER_FRAME, detectCollision);
		}
		
		/*  Access Methods
		==============================================*/
		public function get id():uint {  return _id; }
		public function get count():uint {  return _count; }
		public function get rotationSpeed():Number {  return _rotationSpeed; }
		public function haltRotation():void {  _rotationSpeed = 0; }
		
		/*  Events
		==============================================*/
		private function move(e:Event):void {
			if(!Main.gameWindow.isPaused){
				++_count;
				moveSequence(this);
				if (exitCondition())
					destroyBullet();
			}
		}
		private function detectCollision(e:Event):void {
			if (hitTestPoint(Main.gameWindow.getPlayerX(), Main.gameWindow.getPlayerY(), true)){
				Main.gameWindow.destroyAllBullets();
				Main.gameWindow.flashScreen(0xFF0000);
				Main.gameWindow.decrementLives();
			}
		}
		
		/*  Public Methods
		==============================================*/
		public static function createBullet():Bullet {
		//  Designed to be overridden
			var bul:Bullet = new Bullet(Main.gameWindow.incrementBullets(), defaultSequence, new Velocity(Math.random() * 2 + 1, 3 * Math.PI / 2));
			Main.gameWindow.bullets[bul.id] = bul;
			return bul;
		}
		
		public function destroyBullet():void {
			this.removeEventListener(Event.ENTER_FRAME, move);
			this.removeEventListener(Event.ENTER_FRAME, detectCollision);
			parent.removeChild(this);
			if (_id in Main.gameWindow.bullets)
				delete Main.gameWindow.bullets[_id];
		}
		
		/*  Protected Methods
		==============================================*/
		protected function exitCondition():Boolean {
		//  Used to detect when a bullet ought to be destroyed
			return x > 600 || y > 600 || x < -200 || y < -200;
		}
		
		/*  Move Sequences
		==============================================*/
		protected static function defaultSequence(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
		}
	}
}