﻿package com.fdf.pascal.data {

//	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
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
			private var t3Url : String;
			public var fontFormat : TextFormat;
			public var textX : Number;
			public var textY : Number;
			
			function XmlLoader (t3Url : String, x : Number, y : Number, width : Number, height : Number) : void {
				
				this.setContentTypes();
				
/*				this.loader = new Loader();
				
				this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
*/				
				//this.canvas_mc = new MovieClip();
				this.textX = x;
				this.textY = y;
				this.graphics.drawRect( x, y, width, height );
				this.graphics.endFill();
				this.t3Url = t3Url;
				var myFont = new ZoomedInFont();
				this.fontFormat = new TextFormat();
				this.fontFormat.font = myFont.fontName;
				this.fontFormat.size = 8;
			
				
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
			
			function renderBodytext():void {
				this.textField = new TextField();
				this.textField.defaultTextFormat = this.fontFormat;
				this.textField.autoSize = TextFieldAutoSize.LEFT;
				this.textField.htmlText = xmlData.data.row.bodytext;
				this.textField.x = this.textX;
				this.textField.y = this.textY;
				this.textField.textColor = 0xFFFFFFFF;			
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
				//this.httpUrl = 'http://brianhauge.dk/index.php?id=1629&tx_t3flex_pi1[action]=SELECT&tx_t3flex_pi1[table]=tt_content&tx_t3flex_pi1[uid]=1974&no_cache=1';
				this.httpUrl = this.t3Url;
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