package game {
	public class CandyCornBullet extends Bullet {
		public function CandyCornBullet(moveSeq:Function, v:Velocity) {
			super(Main.gameWindow.incrementBullets(), moveSeq, v);
			Main.gameWindow.bullets[id] = this;
			haltRotation();
			//rotation = Math.random() * 360;
			
			img = Assets.candyCorn();
			img.x = -Assets.candyCornWidth() / 4;
			img.y = -Assets.candyCornHeight() / 4;
			
			img.scaleX = .5;
			img.scaleY = .5;
			this.addChild(img);
		}
		
		/*  Move Sequences
		==============================================*/
		public static function accelerate(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			if (b.count == 1) b.vel.magnitude = 6;
			if (b.count > 20 && b.count <= 32)
				b.vel.magnitude -= .5;
			if (b.count > 80)
				b.vel.magnitude += .15;
		}
		
		public static function turnRight(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			if (b.count == 1) b.vel.magnitude = 3;
			if (b.count > 60 && b.count <= 90)
				b.vel.magnitude -= .1;
			if (b.count > 150)
				b.vel.magnitude += .05;
			
			if (b.count == 95)
				b.vel.direction += Math.PI/2;
			if (b.count > 90 && b.count <= 150)
				b.rotation += 1.5;
		}
		
		public static function turnLeft(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			if (b.count == 1) b.vel.magnitude = 3;
			if (b.count > 60 && b.count <= 90)
				b.vel.magnitude -= .1;
			if (b.count > 150)
				b.vel.magnitude += .05;
			
			if (b.count == 95)
				b.vel.direction -= Math.PI/2;
			if (b.count > 90 && b.count <= 150)
				b.rotation -= 1.5;
		}
	}
}