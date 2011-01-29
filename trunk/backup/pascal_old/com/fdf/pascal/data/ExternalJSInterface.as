package com.fdf.pascal.data {
    import flash.events.*;
    import flash.external.ExternalInterface;
    import flash.utils.Timer;

    public class ExternalJSInterface {
		private var videoid:String;
		private var sourceType:String;

        public function ExternalJSInterface(videoid,sourceType,btn) {
			this.videoid = videoid;
			this.sourceType = sourceType;
			btn.addEventListener(MouseEvent.CLICK, openVideo);

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

