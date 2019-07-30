package game {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class InvisibleButton extends Sprite {
		private var action:Function;
		private var cane:Bitmap;
		private var cane2:Bitmap;
		
		public function InvisibleButton(fun:Function, w:Number, h:Number) {
			graphics.beginFill(0xFFFFFF, 0.01);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
			
			action = fun;
			
			cane = Assets.candyCane();
			cane.scaleY = -1;
			cane.x = -43;
			cane.rotation = 113;
			cane.visible = false;
			this.addChild(cane);
			
			cane2 = Assets.candyCane();
			cane2.x = w + 43;
			cane2.rotation = 67;
			cane2.visible = false;
			this.addChild(cane2);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		
		private function onHover(e:MouseEvent):void {
			cane.visible = true;
			cane2.visible = true;
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onOut(e:MouseEvent):void {
			cane.visible = false;
			cane2.visible = false;
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onUp(e:MouseEvent):void {
			action();
		}
	}
}