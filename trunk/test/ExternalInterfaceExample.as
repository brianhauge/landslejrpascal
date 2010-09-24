﻿package {
    import flash.display.Sprite;
    import flash.events.*;
    import flash.external.ExternalInterface;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;

    public class ExternalInterfaceExample extends Sprite {
        /*private var input:TextField;
        private var output:TextField;
        private var sendBtn:Sprite;*/
		private var w:Number;
		private var h:Number;
		private var vimeoID:Number;

        public function ExternalInterfaceExample(vimeoID,w,h,btn) {
			this.w = w;
			this.h = h;
			this.vimeoID = vidmeoID;
			btn.addEventListener(MouseEvent.CLICK, openVimeo);
			
            /*input = new TextField();
            input.type = TextFieldType.INPUT;
            input.background = true;
            input.border = true;
            input.width = 350;
            input.height = 18;
            addChild(input);

            sendBtn = new Sprite();
            sendBtn.mouseEnabled = true;
            sendBtn.x = input.width + 10;
            sendBtn.graphics.beginFill(0xCCCCCC);
            sendBtn.graphics.drawRoundRect(0, 0, 80, 18, 10, 10);
            sendBtn.graphics.endFill();
            sendBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            addChild(sendBtn);

            output = new TextField();
            output.y = 25;
            output.width = 450;
            output.height = 325;
            output.multiline = true;
            output.wordWrap = true;
            output.border = true;
            output.text = "Initializing...\n";
            addChild(output);*/

            if (ExternalInterface.available) {
                try {
                    output.appendText("Adding callback...\n");
                    ExternalInterface.addCallback("sendToActionScript", receivedFromJavaScript);
                    if (checkJavaScriptReady()) {
                        //output.appendText("JavaScript is ready.\n");
						trace("JavaScript is ready.\n");
                    } else {
                        //output.appendText("JavaScript is not ready, creating timer.\n");
						trace("JavaScript is not ready, creating timer.\n");
                        var readyTimer:Timer = new Timer(100, 0);
                        readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                        readyTimer.start();
                    }
                } catch (error:SecurityError) {
                    //output.appendText("A SecurityError occurred: " + error.message + "\n");
					trace("A SecurityError occurred: " + error.message + "\n");
                } catch (error:Error) {
                    //output.appendText("An Error occurred: " + error.message + "\n");
					trace("An Error occurred: " + error.message + "\n");
                }
            } else {
                //output.appendText("External interface is not available for this container.");
				trace("External interface is not available for this container.");
            }
        }
        private function receivedFromJavaScript(value:String):void {
            //output.appendText("JavaScript says: " + value + "\n");
			trace("JavaScript says: " + value + "\n");
        }
        private function checkJavaScriptReady():Boolean {
            var isReady:Boolean = ExternalInterface.call("isReady");
            return isReady;
        }
        private function timerHandler(event:TimerEvent):void {
            //output.appendText("Checking JavaScript status...\n");
			trace("Checking JavaScript status...\n");
            var isReady:Boolean = checkJavaScriptReady();
            if (isReady) {
                //output.appendText("JavaScript is ready.\n");
				trace("JavaScript is ready.\n");
                Timer(event.target).stop();
            }
        }
        public function openVimeo():void {
            if (ExternalInterface.available) {
                ExternalInterface.call("openVimeo", this.vimeoID, this.w, this.h);
            }
        }
    }
}
