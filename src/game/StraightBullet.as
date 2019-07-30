package game {
	public class StraightBullet extends Bullet {
		public function StraightBullet(moveSeq:Function, v:Velocity) {
			super(Main.gameWindow.incrementBullets(), moveSeq, v);
			Main.gameWindow.bullets[id] = this;
			
			rotation = Math.random() * 360;
			
			switch(id % 9) {
				case 0:
					img = Assets.gumball();
					img.x = -Assets.gumballWidth() / 2;
					img.y = -Assets.gumballHeight() / 2;
					break;
				case 1:
					img = Assets.candyCane();
					img.x = -Assets.candyCaneWidth() / 2;
					img.y = -Assets.candyCaneHeight() / 2;
					break;
				case 2:
					img = Assets.cottonCandy();
					img.x = -Assets.cottonCandyWidth() / 2;
					img.y = -Assets.cottonCandyHeight() / 2;
					break;
				case 3:
					img = Assets.hardCandy();
					img.x = -Assets.hardCandyWidth() / 2;
					img.y = -Assets.hardCandyHeight() / 2;
					break;
				case 4:
					img = Assets.jellyBelly();
					img.x = -Assets.jellyBellyWidth() / 2;
					img.y = -Assets.jellyBellyHeight() / 2;
					break;
				case 5:
					img = Assets.jollyRancher();
					img.x = -Assets.jollyRancherWidth() / 2;
					img.y = -Assets.jollyRancherHeight() / 2;
					break;
				case 6:
					img = Assets.lolliPop();
					img.x = -Assets.lolliPopWidth() / 2;
					img.y = -Assets.lolliPopHeight() / 2;
					break;
				case 7:
					img = Assets.lolliPop2();
					img.x = -Assets.lolliPop2Width() / 2;
					img.y = -Assets.lolliPop2Height() / 2;
					break;
				default:
					img = Assets.candyCorn();
					img.x = -Assets.candyCornWidth() / 2;
					img.y = -Assets.candyCornHeight() / 2;
					break;
			}
			
			img.scaleX = .75;
			img.scaleY = .75;
			this.addChild(img);
		}
		
		/*  Move Sequences
		==============================================*/
		public static function falling(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			b.rotation += b.rotationSpeed;
			b.vel.magnitude += .05;
		}
		
		public static function straight(b:Bullet):void {
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			b.rotation += b.rotationSpeed;
		}
	}
}