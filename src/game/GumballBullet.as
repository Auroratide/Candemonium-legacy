package game {
	public class GumballBullet extends Bullet {
		private var initialVel:Velocity;
		public function GumballBullet(moveSeq:Function, v:Velocity) {
			super(Main.gameWindow.incrementBullets(), moveSeq, v);
			Main.gameWindow.bullets[id] = this;
			
			rotation = Math.random() * 360;
			initialVel = v.clone();
			
			img = Assets.gumball();
			img.x = -Assets.gumballWidth() / 2;
			img.y = -Assets.gumballHeight() / 2;
			
			img.scaleX = Math.random()*.5 + .5;
			img.scaleY = img.scaleX;
			this.addChild(img);
		}
		
		public function get initialVelMag():Number {  return initialVel.magnitude; }
		public function get initialVelDir():Number {  return initialVel.direction; }
		
		/*  Move Sequences
		==============================================*/
		public static function gravity(b:GumballBullet):void {
			var accel:Number = .1;
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			b.rotation += b.rotationSpeed;
			b.vel.magnitude = Math.sqrt(Math.pow(b.initialVelMag * Math.cos(b.initialVelDir), 2) + Math.pow(b.initialVelMag * Math.sin(b.initialVelDir) - .1 * b.count, 2));
			b.vel.direction += -accel * b.initialVelMag * Math.cos(b.initialVelDir) / (Math.pow(accel * b.count, 2) - 2*accel * b.initialVelMag * b.count * Math.sin(b.initialVelDir) + Math.pow(b.initialVelMag, 2));
			//trace("New: " + b.vel.direction*180/Math.PI);
		}
	}
}