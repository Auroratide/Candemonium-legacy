package com.ardeol.fue {
	public class StreamError extends Error {
		public static const END_OF_STREAM:String = "End of stream";
		public function StreamError(msg:String = "Stream ERROR") {
			message = msg;
		}
	}
}