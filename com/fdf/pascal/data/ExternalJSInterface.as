﻿package com.fdf.pascal.data {
    import flash.events.*;
    import flash.external.ExternalInterface;
    import flash.utils.Timer;
	import flash.filters.GlowFilter;
	import flash.display.MovieClip;

    public class ExternalJSInterface {
		private var videoid:String;
		private var sourceType:String;
		private var btn : MovieClip;

        public function ExternalJSInterface(videoid,sourceType,btn) {
			this.videoid = videoid;
			this.sourceType = sourceType;
			this.btn = btn;
			this.btn.addEventListener(MouseEvent.CLICK, openVideo);
			this.btn.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.btn.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);

            if (ExternalInterface.available) {
                try {
					trace("Adding callback...\n");
                    ExternalInterface.addCallback("sendToActionScript", receivedFromJavaScript);
                    if (checkJavaScriptReady()) {
						trace("JavaScript is ready.\n");
                    } else {
						trace("JavaScript is not ready, creating timer.\n");
                        var readyTimer:Timer = new Timer(100, 0);
                        readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                        readyTimer.start();
                    }
                } catch (error:SecurityError) {
					trace("A SecurityError occurred: " + error.message + "\n");
                } catch (error:Error) {
					trace("An Error occurred: " + error.message + "\n");
                }
            } else {
				trace("External interface is not available for this container.");
            }
        }
		function addGlow(event:MouseEvent):void {
			var filt:GlowFilter = new GlowFilter;
			filt.color = 0xCCCC00;
			filt.blurX = 30;
			filt.blurY = 30;
			this.btn.filters = [filt];
			this.btn.buttonMode = true;
			this.btn.useHandCursor = true;
		}
		public function removeGlow(event:MouseEvent):void {
			this.btn.filters = [];
		}

        private function receivedFromJavaScript(value:String):void {
			trace("JavaScript says: " + value + "\n");
        }
        private function checkJavaScriptReady():Boolean {
            var isReady:Boolean = ExternalInterface.call("isReady");
            return isReady;
        }
        private function timerHandler(event:TimerEvent):void {
			trace("Checking JavaScript status...\n");
            var isReady:Boolean = checkJavaScriptReady();
            if (isReady) {
				trace("JavaScript is ready.\n");
                Timer(event.target).stop();
            }
        }
        public function openVideo(event:MouseEvent):void {
            if (ExternalInterface.available) {
                ExternalInterface.call("openVideo", this.sourceType, this.videoid);
            }
        }
    }
}
