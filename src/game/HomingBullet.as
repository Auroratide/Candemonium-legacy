package game {
	public class HomingBullet extends Bullet {
		public function HomingBullet(moveSeq:Function, v:Velocity) {
			super(Main.gameWindow.incrementBullets(), moveSeq, v);
			Main.gameWindow.bullets[id] = this;
			
			rotation = Math.random() * 360;
			
			if (Math.round(Math.random()) == 0) {
				img = Assets.hardCandy();
				img.x = -Assets.hardCandyWidth() / 2;
				img.y = -Assets.hardCandyHeight() / 2;
			}
			else {
				img = Assets.jollyRancher();
				img.x = -Assets.jollyRancherWidth() / 2;
				img.y = -Assets.jollyRancherHeight() / 2;
			}
			
			img.scaleX = .5;
			img.scaleY = .5;
			this.addChild(img);
		}
		
		/*  Exit Condition
		==============================================*/
		protected override function exitCondition():Boolean {
			return count > 320;
		}
		
		/*  Move Sequences
		==============================================*/
		public static function homing(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			b.rotation += b.rotationSpeed;
			if (b.count > 300) {
				b.vel.magnitude -= .1;
				b.alpha -= .05;
			}
			b.vel.direction = Math.atan(-(Main.gameWindow.getPlayerY() - b.y) / (Main.gameWindow.getPlayerX() - b.x)) + (Main.gameWindow.getPlayerX() < b.x ? Math.PI : 0);
		}
	}
}