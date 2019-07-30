package game {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class Player extends Sprite {
		public static const MAX_VELOCITY:Number = 8;
		public static const ACCELERATION:Number = 2;
		private static const TOLERANCE:Number = 3;
		
		public var vel:Velocity;
		public var score:Number;
		private var boundBox:Sprite; // What you look like
		private var eyes:Bitmap;
		private var point:Sprite;    // Your actual hitbox
		
		/*  Constructor
		==============================================*/
		public function Player() {
			vel = new Velocity();
			score = 0;
			boundBox = new Sprite();
			boundBox.addChild(Assets.star());
			boundBox.getChildAt(0).x = -Assets.starWidth() / 2;
			boundBox.getChildAt(0).y = -Assets.starHeight() / 2;
			this.addChild(boundBox);
			
			eyes = Assets.starEyes();
			eyes.x = -Assets.starEyesWidth()/2;
			eyes.y = -Assets.starEyesHeight() / 2;
			this.addChild(eyes);
			
			point = new Sprite();
			point.graphics.beginFill(0xFF0000);
			point.graphics.drawRect(0, 0, 2, 2);
			point.graphics.endFill();
			this.addChild(point);
			
			this.addEventListener(Event.ENTER_FRAME, move);
			this.addEventListener(Event.ENTER_FRAME, adjustVelocity);
			this.addEventListener(Event.ENTER_FRAME, updateScore);
		}
		
		/*  Events
		==============================================*/
		private function move(e:Event):void {
			if(!Main.gameWindow.isPaused){
				x += vel.deltaX();
				y += vel.deltaY();
				if (x < 20) x = 20;
				else if (x > 380) x = 380;
				if (y < 20) y = 20;
				else if (y > 380) y = 380;
				boundBox.rotation += 2.5;
			}
		}
		private function adjustVelocity(e:Event):void {
			if(!Main.gameWindow.isPaused){
				if (x > stage.mouseX - TOLERANCE && x < stage.mouseX + TOLERANCE && y > stage.mouseY - TOLERANCE && y < stage.mouseY + TOLERANCE) {
					vel.magnitude = 0;
				}
				else {
					vel.magnitude += vel.magnitude < MAX_VELOCITY ? ACCELERATION : 0;
					vel.direction = Math.atan(-(stage.mouseY - y) / (stage.mouseX - x)) + (stage.mouseX < x ? Math.PI : 0);
				}
			}
		}
		
		private function updateScore(e:Event):void {
			if(!Main.gameWindow.isPaused) score += .1 * Main.gameWindow.level;
		}
	}
}