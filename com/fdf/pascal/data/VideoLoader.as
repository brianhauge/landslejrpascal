package com.fdf.pascal.data {

	import flash.display.Shape;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	
		public class VideoLoader extends MovieClip {

			private var httpUrl : String;
			private var urlLoader : URLLoader;
			private var loader : Loader;
			private var videoUrl : String;
			private var rect : Shape;
			private var ldr : Loader;
			private var urlReq : URLRequest;
			
			function VideoLoader (videoUrl : String) : void {
				this.videoUrl = videoUrl;
				
				this.rect = new Shape();
				this.rect.graphics.beginFill(0xFFFFFF);
				this.rect.graphics.drawRect(0, 0, 100, 100);
				this.rect.graphics.endFill();
				this.addChild(this.rect);
				
				this.ldr = new Loader();
				this.ldr.mask = this.rect;
				this.urlReq = new URLRequest(this.videoUrl);
				this.ldr.load(this.urlReq);
				this.addChild(this.ldr);
			}
		}
}