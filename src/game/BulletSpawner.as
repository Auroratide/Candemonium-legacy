package game {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BulletSpawner extends Sprite {
		private var generationSequence:Function;
		private var _count:uint;
		public var vel:Velocity;
		
		/*  Constructor
		==============================================*/
		public function BulletSpawner(genSeq:Function) {
			_count = 0;
			generationSequence = genSeq;
			this.addEventListener(Event.ENTER_FRAME, generateBullet);
			vel = new Velocity();
		}
		
		/*  Access
		==============================================*/
		public function get count():uint {  return _count; }
		
		public function destroySpawner():void {
			this.removeEventListener(Event.ENTER_FRAME, generateBullet);
			parent.removeChild(this);
		}
		
		/*  Events
		==============================================*/
		private function generateBullet(e:Event):void {
			if(!Main.gameWindow.isPaused){
				++_count;
				generationSequence(this);
			}
		}
		
		/*  Generation Algorithms
		==============================================*/
		public static function firstSequence(spawner:BulletSpawner):void {
		//  Falling Candy
			spawner.x = Math.random() * 360;
			if(spawner.count % 10 == 0){
				var b:StraightBullet = new StraightBullet(StraightBullet.falling, new Velocity(Math.random()*2+1, Velocity.DOWN));
				b.x = spawner.x;
				spawner.parent.addChild(b);
			}
		}
		
		public static function secondSequence(spawner:BulletSpawner):void {
		//  Candy scrolls across the screen from the left and right
			spawner.y = Math.random() * 360;
			if (spawner.count % 18 == 0) {
				var b:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(Math.random() * 3 + 1, (spawner.x < 10 ? Velocity.RIGHT : Velocity.LEFT)));
				b.x = spawner.x;
				b.y = spawner.y;
				spawner.parent.addChild(b);
			}
		}
		
		public static function thirdSequence(spawner:BulletSpawner):void {
		//  Two spawners travel in a circle randomly spitting out candy
			if (spawner.x > 400) {
				spawner.vel.direction = Velocity.DOWN;
				spawner.x = 395;
			}
			else if (spawner.y > 400) {
				spawner.vel.direction = Velocity.LEFT;
				spawner.y = 395;
			}
			else if (spawner.x < 0) {
				spawner.vel.direction = Velocity.UP;
				spawner.x = 5;
			}
			else if (spawner.y < 0) {
				spawner.vel.direction = Velocity.RIGHT;
				spawner.y = 5;
			}
			spawner.x += spawner.vel.deltaX();
			spawner.y += spawner.vel.deltaY();
			if (spawner.count % 6 == 0) {
				var b:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(4, Math.random() * Math.PI * 2));
				b.x = spawner.x;
				b.y = spawner.y;
				spawner.parent.addChild(b);
			}
		}
		
		public static function fourthSequence(spawner:BulletSpawner):void {
			if (spawner.count % 80 == 0) {
				for (var i:int = 0; i < 12; ++i) {
					var b:CandyCornBullet = new CandyCornBullet(CandyCornBullet.accelerate, new Velocity(0, Velocity.DOWN));
					b.rotation = 180;
					b.x = 30 * (i+1);
					b.y = -100;
					spawner.parent.addChild(b);
				}
			}
			if ((spawner.count+40) % 80 == 0) {
				for (var ii:int = 0; ii < 12; ++ii) {
					var bb:CandyCornBullet = new CandyCornBullet(CandyCornBullet.accelerate, new Velocity(0, Velocity.DOWN));
					bb.rotation = 180;
					bb.x = 30 * (ii+1) + 15;
					bb.y = -100;
					spawner.parent.addChild(bb);
				}
			}
		}
		
		public static function fifthSequence(spawner:BulletSpawner):void {
			if (spawner.count % 2 == 0) {
				var b:CandyCornBullet = new CandyCornBullet(CandyCornBullet.turnLeft, new Velocity(0, Velocity.UP - Math.PI / 4));
				b.rotation = 45;
				b.y = 520;
				b.x = 30 * (spawner.count % 60) - 150;
				spawner.parent.addChild(b);
			}
			if ((spawner.count+1) % 2 == 0) {
				var bb:CandyCornBullet = new CandyCornBullet(CandyCornBullet.turnRight, new Velocity(0, Velocity.UP + Math.PI / 4));
				bb.rotation = 315;
				bb.y = 520;
				bb.x = 30 * (spawner.count % 60) - 150;
				spawner.parent.addChild(bb);
			}
			
			// To make sure the player doesn't cheat
			if (spawner.count % 30 == 0 && spawner.count >= 1200) {
				var f:HomingBullet = new HomingBullet(HomingBullet.homing, new Velocity(2, Velocity.DOWN));
				f.x = 200;
				f.y = -5;
				spawner.parent.addChild(f);
			}
		}
		
		public static function sixthSequence(spawner:BulletSpawner):void {
			if(spawner.count % 2 == 0 || spawner.count < 900){
				var b:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(2, Math.PI / 30 * (spawner.count % 120)));
				b.x = 200;
				spawner.parent.addChild(b);
			}
		}
		
		public static function seventhSequence(spawner:BulletSpawner):void {
			if (spawner.count % 10 == 0) {
				var b:GumballBullet = new GumballBullet(GumballBullet.gravity, new Velocity(Math.random() * 4 + 1, Math.random()*Math.PI/2 + (spawner.x > 200 ? Math.PI/2 : 0)));
				b.x = spawner.x;
				b.y = spawner.y;
				spawner.parent.addChild(b);
			}
		}
		
		public static function eighthSequence(spawner:BulletSpawner):void {
			if (spawner.count % 150 == 0) {
				for (var i:int = 0; i < 4; ++i) {
					var b:HomingBullet = new HomingBullet(HomingBullet.homing, new Velocity(2, Math.PI / 2 * i));
					b.x = [0, 200, 430, 200][i];
					b.y = [200, 430, 200, 0][i];
					spawner.parent.addChild(b);
				}
			}
		}
		
		public static function ninthSequence(spawner:BulletSpawner):void {
			if ((spawner.count-1) % 180 == 0) {
				spawner.y = Math.random() * 360 + 20;
				var b:CottonCandyBullet = new CottonCandyBullet(CottonCandyBullet.slowAndSplit, new Velocity(0,Math.atan(-(Main.gameWindow.getPlayerY() - spawner.y) / (Main.gameWindow.getPlayerX() - spawner.x)) + (Main.gameWindow.getPlayerX() < spawner.x ? Math.PI : 0)));
				b.y = spawner.y;
				b.x = spawner.x;
				spawner.parent.addChild(b);
			}
		}
		
		public static function finalSequence(spawner:BulletSpawner):void {
			if(spawner.count % 2 == 0){
				var b:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(4.5, Math.PI / 30 * (spawner.count % 60)));
				b.x = spawner.x;
				b.y = spawner.y;
				spawner.parent.addChild(b);
			}
			if (spawner.count % 30 == 0) {
				spawner.x = Math.random() * 360 + 20;
				spawner.y = Math.random() * 360 + 20;
			}
		}
		
		public static function laserSequence(spawner:BulletSpawner):void {
			var offset:int = 0;
			var dir:Number = Velocity.RIGHT;
			if (spawner.x > 400) {
				offset = 30;
				dir = Velocity.LEFT;
			}
			else if (spawner.y < 0) {
				offset = 60;
				dir = Velocity.DOWN;
			}
			else if (spawner.y > 400) {
				offset = 120;
				dir = Velocity.UP;
			}
			if ((spawner.count-1+offset) % 180 == 0) {
				var b:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(4, dir));
				b.x = spawner.x;
				b.y = spawner.y;
				spawner.parent.addChild(b);
			}
			
			if ((spawner.count + 90+offset) % 180 < 60) {
				var bb:StraightBullet = new StraightBullet(StraightBullet.straight, new Velocity(9, dir));
				bb.x = spawner.x;
				bb.y = spawner.y;
				spawner.parent.addChild(bb);
			}
			
			if ((spawner.count + 90 + offset) % 180 == 61) {
				if(spawner.x < 0 || spawner.x > 400)
					spawner.y = Math.random() * 360 + 20;
				if(spawner.y < 0 || spawner.y > 400)
					spawner.x = Math.random() * 360 + 20;
			}
		}
		
		public static function eleventhSequence(spawner:BulletSpawner):void {
			if (spawner.count % 10 == 0) {
				var b:CandyCornBullet = new CandyCornBullet(StraightBullet.falling, new Velocity(4, Math.atan( -(Main.gameWindow.getPlayerY() - spawner.y) / (Main.gameWindow.getPlayerX() - spawner.x)) + (Main.gameWindow.getPlayerX() < spawner.x ? Math.PI : 0)));
				b.x = spawner.x;
				b.y = spawner.y;
				b.rotation = 180/Math.PI *(Math.atan( -(Main.gameWindow.getPlayerY() - spawner.y) / (Main.gameWindow.getPlayerX() - spawner.x)) + (Main.gameWindow.getPlayerX() < spawner.x ? Math.PI : 0) - Math.PI);
				spawner.parent.addChild(b);
				spawner.x = Math.round(Math.random()) * 400;
				spawner.y = Math.round(Math.random()) * 400;
			}
			
			if (spawner.count % 121 == 0) {
				var bb:CandyCornBullet = new CandyCornBullet(StraightBullet.falling, new Velocity(12, Math.atan( -(Main.gameWindow.getPlayerY() - spawner.y) / (Main.gameWindow.getPlayerX() - spawner.x)) + (Main.gameWindow.getPlayerX() < spawner.x ? Math.PI : 0)));
				bb.x = spawner.x;
				bb.y = spawner.y;
				bb.rotation = 180/Math.PI *(Math.atan( -(Main.gameWindow.getPlayerY() - spawner.y) / (Main.gameWindow.getPlayerX() - spawner.x)) + (Main.gameWindow.getPlayerX() < spawner.x ? Math.PI : 0) - Math.PI);
				spawner.parent.addChild(bb);
				spawner.x = Math.round(Math.random()) * 400;
				spawner.y = Math.round(Math.random()) * 400;
			}
		}
	}
}