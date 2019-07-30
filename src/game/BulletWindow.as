package game {
	import com.ardeol.fue.Window;
	import com.ardeol.fue.VCam;
	import flash.events.Event;
	
	public class BulletWindow extends Window {
		private var vcam:VCam;
		
		private var spawners:Vector.<BulletSpawner>;
		
		/*  Constructor
		==============================================*/
		public function BulletWindow() {
			super("Bullets");
			vcam = new VCam();
			this.addChild(vcam);
			
			/* Reference
			graphics.lineStyle(1);
			graphics.lineTo(0, 400);
			graphics.lineTo(400, 400);
			graphics.lineTo(400, 0);
			graphics.lineTo(0, 0);
			/*  */
			spawners = new Vector.<BulletSpawner>();
		}
		
		public function createSpawner(seq:Function, xx:Number = 0, yy:Number = 0):BulletSpawner {
			var sp:BulletSpawner = new BulletSpawner(seq);
			sp.x = xx;
			sp.y = yy;
			spawners.push(sp);
			return sp;
		}
		
		public function commenceLevel(lv:uint):void {
			switch(lv) {
				case 1:
					createSpawner(BulletSpawner.firstSequence);
					Main.gameWindow.setLevelText("Make it Rain");
					break;
				case 2:
					var b21:BulletSpawner = createSpawner(BulletSpawner.secondSequence);
					var b22:BulletSpawner = createSpawner(BulletSpawner.secondSequence);
					b21.x = -40;
					b22.x = 440;
					Main.gameWindow.setLevelText("Crossing the Street");
					break;
				case 3:
					var b31:BulletSpawner = createSpawner(BulletSpawner.thirdSequence);
					var b32:BulletSpawner = createSpawner(BulletSpawner.thirdSequence);
					b31.x = 5;
					b31.y = 5;
					b31.vel.magnitude = 4;
					b32.x = 395;
					b32.y = 395;
					b32.vel.magnitude = 4;
					b32.vel.direction = Velocity.LEFT;
					Main.gameWindow.setLevelText("Circling");
					break;
				case 4:
					createSpawner(BulletSpawner.fourthSequence);
					Main.gameWindow.setLevelText("Shooting Gallery");
					break;
				case 5:
					createSpawner(BulletSpawner.fifthSequence);
					Main.gameWindow.setLevelText("Trick or Treat");
					Main.gameWindow.incrementLives();
					break;
				case 6:
					createSpawner(BulletSpawner.sixthSequence);
					Main.gameWindow.setLevelText("Between the Gaps");
					break;
				case 7:
					var b71:BulletSpawner = createSpawner(BulletSpawner.seventhSequence);
					var b72:BulletSpawner = createSpawner(BulletSpawner.seventhSequence);
					b71.x = 10;
					b71.y = 30;
					b72.x = 390;
					b72.y = 30;
					Main.gameWindow.setLevelText("Gumball Machine");
					break;
				case 8:
					createSpawner(BulletSpawner.eighthSequence);
					createSpawner(BulletSpawner.firstSequence);
					Main.gameWindow.setLevelText("The Hunt is On");
					break;
				case 9:
					createSpawner(BulletSpawner.ninthSequence);
					var b92:BulletSpawner = createSpawner(BulletSpawner.ninthSequence);
					b92.x = 400;
					Main.gameWindow.setLevelText("Sharing");
					break;
				case 10:
					var b101:BulletSpawner = createSpawner(BulletSpawner.laserSequence);
					b101.x = -1;
					b101.y = 200;
					var b102:BulletSpawner = createSpawner(BulletSpawner.laserSequence);
					b102.x = 200;
					b102.y = -1;
					var b103:BulletSpawner = createSpawner(BulletSpawner.laserSequence);
					b103.x = 401;
					b103.y = 200;
					var b104:BulletSpawner = createSpawner(BulletSpawner.laserSequence);
					b104.x = 200;
					b104.y = 401;
					Main.gameWindow.setLevelText("Lasers.");
					Main.gameWindow.incrementLives();
					break;
				case 11:
					createSpawner(BulletSpawner.eleventhSequence);
					Main.gameWindow.setLevelText("Don't get Sniped");
					break;
				default:
					var d1:BulletSpawner = createSpawner(BulletSpawner.finalSequence);
					d1.x = 200;
					d1.y = 200;
					if (lv % 5 == 0)
						Main.gameWindow.incrementLives();
					Main.gameWindow.setLevelText("Candemonium!");
			}
			for each(var spawner:BulletSpawner in spawners)
				this.addChild(spawner);
		}
		
		public function destroyAllSpawners():void {
			while (spawners.length > 0)
				spawners.pop().destroySpawner();
		}
	}
	
}