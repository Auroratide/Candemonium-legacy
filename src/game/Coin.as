package game {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Coin extends Sprite {
		private var swirls:Sprite;
		public function Coin() {
			var tmp:Bitmap = Assets.portal();
			tmp.x = -Assets.portalWidth() / 2;
			tmp.y = -Assets.portalHeight() / 2;
			this.addChild(tmp);
			
			swirls = new Sprite();
			swirls.addChild(Assets.portalSwirls());
			swirls.getChildAt(0).x = -Assets.portalSwirlsWidth() / 2;
			swirls.getChildAt(0).y = -Assets.portalSwirlsHeight() / 2;
			swirls.scaleX = 1.1;
			swirls.scaleY = 1.1;
			this.addChild(swirls);
			
			this.addEventListener(Event.ENTER_FRAME, idleAnimation);
			this.addEventListener(Event.ENTER_FRAME, detectCollision);
		}
		
		private function idleAnimation(e:Event):void {
			if(!Main.gameWindow.isPaused){
				swirls.rotation -= 2;
				if (scaleX < 1) {
					scaleX += .05;
					scaleY += .05;
				}
			}
		}
		
		private function detectCollision(e:Event):void {
			if (hitTestPoint(Main.gameWindow.getPlayerX(), Main.gameWindow.getPlayerY(), true))
				Main.gameWindow.progressLevel();
		}
	}
}