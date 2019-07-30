package com.ardeol.fue {
	public class FullWindow extends Window{
		public function FullWindow(t:String = "") {
			super(t, 0, 0, false);
		}
		
		// Cannot be relocated
		override public function set x(value:Number):void {}
		override public function set y(value:Number):void {}
	}
}