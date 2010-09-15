package com.fdf.pascal.data {

	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	
		public class VideoLoader extends MovieClip {

			private var httpUrl : String;
			private var loader : Loader;
			private var videoUrl : String;
			public var player : Object;
			
			function VideoLoader (videoUrl : String) : void {
				this.videoUrl = videoUrl;
				this.loader = new Loader();
				
				this.loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
				this.loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
				
				function onLoaderInit(event:Event):void {
					this.addChild(this.loader);
					this.loader.content.addEventListener("onReady", onPlayerReady);
					this.loader.content.addEventListener("onError", onPlayerError);
					this.loader.content.addEventListener("onStateChange", onPlayerStateChange);
					this.loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
				}
				
				function onPlayerReady(event:Event):void {
					// Event.data contains the event parameter, which is the Player API ID 
					trace("player ready:", Object(event).data);
				
					// Once this event has been dispatched by the player, we can use
					// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
					// to load a particular YouTube video.
					this.player = this.loader.content;
					// Set appropriate player dimensions for your application
					this.player.setSize(70, 52);
					this.player.x = 11;
					this.player.y = 63;
					this.player.rotation = 2;
				}
				
				function onPlayerError(event:Event):void {
					// Event.data contains the event parameter, which is the error code
					trace("player error:", Object(event).data);
				}
				
				function onPlayerStateChange(event:Event):void {
					// Event.data contains the event parameter, which is the new player state
					trace("player state:", Object(event).data);
				}
				
				function onVideoPlaybackQualityChange(event:Event):void {
					// Event.data contains the event parameter, which is the new video quality
					trace("video quality:", Object(event).data);
				}

			}
		}
}