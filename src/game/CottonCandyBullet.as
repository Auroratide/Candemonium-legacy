package game {
	public class CottonCandyBullet extends Bullet {
		private var _generation:int;
		private var _initialDir:Number;
		public var destroyMe:Boolean;
		
		public function CottonCandyBullet(moveSeq:Function, v:Velocity, g:int = 0) {
			super(Main.gameWindow.incrementBullets(), moveSeq, v);
			Main.gameWindow.bullets[id] = this;
			
			_initialDir = v.direction;
			_generation = g;
			destroyMe = false;
			
			rotation = Math.random() * 360;
			
			img = Assets.cottonCandy();
			img.x = -Assets.cottonCandyWidth() / 2;
			img.y = -Assets.cottonCandyHeight() / 2;
			
			img.scaleX = 1 - .15*_generation;
			img.scaleY = 1 - .15*_generation;
			this.addChild(img);
		}
		
		public function get initialDir():Number {  return _initialDir; }
		public function get generation():int {  return _generation; }
		
		/*  Exit Condition
		==============================================*/
		protected override function exitCondition():Boolean {
			return initialDir != vel.direction || destroyMe;
		}
		
		/*  Move Sequences
		==============================================*/
		public static function slowAndSplit(b:CottonCandyBullet):void {
			if (b.count == 1) b.vel.magnitude = 2;
			b.x += b.vel.deltaX();
			b.y += b.vel.deltaY();
			b.rotation += b.rotationSpeed;
			b.vel.magnitude -= .025;
			if (b.vel.magnitude <= .025 && b.vel.magnitude != 0 && b.generation < 3) {
				for (var i:int = 0; i < 4; ++i) {
					var bb:CottonCandyBullet = new CottonCandyBullet(CottonCandyBullet.slowAndSplit, new Velocity(0, b.initialDir + Math.PI / 4 * i - Math.PI/2), b.generation + 1);
					bb.x = b.x;
					bb.y = b.y;
					b.parent.addChild(bb);
					b.destroyMe = true;
				}
			}
		}
	}
}