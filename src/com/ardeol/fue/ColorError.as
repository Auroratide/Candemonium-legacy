package com.ardeol.fue{
	public class ColorError extends Error {
		public static const INVALID_ARGUMENT:String = "Argument is an invalid color";
		public function ColorError(msg:String = "Color ERROR") {
			message = msg;
		}
	}
}