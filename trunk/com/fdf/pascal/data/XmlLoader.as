package com.fdf.pascal.data {

//	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.ProgressEvent;
	import flash.xml.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
		public class XmlLoader extends MovieClip {

			public var httpUrl : String;
			public var xmlData : XML;
			public var urlLoader : URLLoader;
			public var loader : Loader;
			public var textField : TextField;
			public var canvas_mc : MovieClip;
			public var contentTypes : Array;
			private var tt_content_id : String;
			public var fontFormat : TextFormat;
			public var textX : Number;
			public var textY : Number;
			public var textWidth : Number;
			public var textHeight : Number;
			
			function XmlLoader (tt_content_id : String, x : Number, y : Number, width : Number, height : Number) : void {
				
				this.setContentTypes();
				
/*				this.loader = new Loader();
				
				this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
*/				
				//this.canvas_mc = new MovieClip();
				this.textX = x;
				this.textY = y;
				this.tt_content_id = tt_content_id;
				var myFont = new ZoomedInFont();
				this.fontFormat = new TextFormat();
				this.fontFormat.font = myFont.fontName;
				this.fontFormat.size = 8;
				this.textWidth = width;
				this.textHeight = height;
				
				this.getDataFromUrlAndRenderContent();
				
				//this.currentContentType = this.xmlData.child("CType");
					
			}
				
			function setContentTypes():void {
				//This is ugly, I know - but it was the only way for me to do it /soren.malling
				this.contentTypes = new Array("text", "textpic");				
				this.contentTypes["text"] = new Array("fields");// = new Array("bodytext");
				this.contentTypes["text"]["fields"] = new Array("bodytext");
				this.contentTypes["textpic"] = new Array("fields")
				this.contentTypes["textpic"]["fields"] = new Array("bodytext","image");
				this.contentTypes["goToFrame"] = new Array("fields");
				this.contentTypes["goToFrame"]["fields"] = new Array("movieClip", "frameNumber");
			}
			
			function goToLinkFromContent(e:TextEvent):void {
					navigateToURL(new URLRequest(e.text), '_new');	 
			}
			
			function renderBodytext():void {
				this.textField = new TextField();
				this.textField.addEventListener(TextEvent.LINK, goToLinkFromContent,false,0,true);
				this.textField.defaultTextFormat = this.fontFormat;
				//this.textField.autoSize = TextFieldAutoSize.LEFT;
				this.textField.htmlText = xmlData.data.row.bodytext;
				this.textField.x = this.textX;
				this.textField.y = this.textY;
				this.textField.width = this.textWidth;
				this.textField.height = this.textHeight;
				this.textField.textColor = 0xFFFFFFFF;			
				this.textField.wordWrap = true;
				this.textField.selectable = false;
				this.addChild(this.textField);
			}
			
			function renderImage():void {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event) {
	   				loader.width = 200;
					loader.scaleY = loader.scaleX;
					loader.x = 100;
					loader.y = 100;
					this.addChild(loader);
				});
				var fileRequest:URLRequest = new URLRequest("http://www.crystalxp.net/galerie/img/img-images-beauty--usmanahmedansari-5873.jpg");
				loader.load(fileRequest);
			}
			
			function getDataFromUrlAndRenderContent() : void {
				this.httpUrl = 'http://fdf.dk/index.php?id=2539&tx_t3flex_pi1[action]=SELECT&tx_t3flex_pi1[table]=tt_content&no_cache=1&tx_t3flex_pi1[uid]=' + this.tt_content_id;
				this.urlLoader = new URLLoader();
				this.urlLoader.load(new URLRequest(this.httpUrl));
				this.urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
					this.xmlData = new XML(e.target.data);

					xmlData = this.xmlData;
					
					for each(var field in contentTypes[this.xmlData.data.row.CType].fields) {
						if(field == 'bodytext') {
							renderBodytext();
						}
						if(field == 'image') {
							renderImage();
						}
					}
				});
			}

			function onLoadProgress(e:ProgressEvent) {}
			
			function onLoadComplete(e:Event) {}
			

		}
}