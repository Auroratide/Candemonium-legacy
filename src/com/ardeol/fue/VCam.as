package com.ardeol.fue{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class VCam extends Sprite{
		private var oldX:Number;
		private var oldY:Number;
		
		public var xVel:Number;
		public var yVel:Number;
		public var accel:Number;
		public var maxSpeed:Number;
		
		public function VCam(xx:Number = 0, yy:Number = 0){
			visible = false;
			x = xx;
			y = yy;
			oldX = x;
			oldY = y;
			xVel = 0;
			yVel = 0;
			accel = 3;
			maxSpeed = 24;
			addEventListener(Event.ENTER_FRAME, updateCamera);
			addEventListener(Event.ENTER_FRAME, moveCamera);
		}
		
		/*  This works by applying the Vcam's transform matrix
			to its parent.  The matrix is translated depending on its
			previous location.
			*/
		private function updateCamera(e:Event):void{
			var mat:Matrix = this.transform.matrix.clone();
			mat.invert();
			mat.translate(x-oldX, y-oldY);
			parent.transform.matrix = mat;
			oldX = x;
			oldY = y;
		}
		
		private function moveCamera(e:Event):void{
			this.x += xVel;
			this.y += yVel;
		}
	}
}