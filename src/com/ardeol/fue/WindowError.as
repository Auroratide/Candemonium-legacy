package com.ardeol.fue {
	public class WindowError extends Error {
		public static const INVALID_DIMENSION:String = "Invalid dimension";
		public static const NOT_RESIZEABLE:String = "Window cannot be resized";
		public static const ELEMENT_EXISTENT:String = "Element already exists";
		public static const ELEMENT_NONEXISTENT:String = "Element does not exist";
		public function WindowError(msg:String = "Window ERROR") {
			message = msg;
		}
	}
}