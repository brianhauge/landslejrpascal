/*

*/

package com.fdf.pascal.effects {	

	import flash.display.MovieClip;
	import com.fdf.pascal.data.XmlLoader;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import fl.transitions.Tween;



	public class FigureHandler {

		public var currentLaboratoryObject : MovieClip;
		public var originalWidth : Number;
		public var originalHeight : Number;
		public var originalX : Number;
		public var originalY : Number;
		public var isScaledUp : Boolean;
		public var tempLaboratoryObject : MovieClip;
		public var scaleWidth : Number;
		public var scaleX : Number;
		public var scaleY : Number;
		public var portrait4 : MovieClip;
		public var pos : String;
		public var t3 : XmlLoader;

		public function FigureHandler(portrait4, laboratoryObject : MovieClip, pos) {

			trace("FigureHandler Constructor er loadet");

			this.currentLaboratoryObject = laboratoryObject;
			this.tempLaboratoryObject = laboratoryObject;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;
			this.portrait4 = portrait4;
			this.pos = pos;
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);
			this.portrait4.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.t3 = new XmlLoader();
			this.t3.x = 1;
			
		}	

		/**
		 * Scaling handler
		 */
		function scalingHandler(event:MouseEvent):void {
			if(this.isScaledUp == true) {
				this.zoomOut(event);
				this.isScaledUp = false;
			} else {
				this.zoomIn(event);
				//new XmlLoader(this.currentLaboratoryObject);
				this.isScaledUp = true;
			}
		}

		/**
		 * Zoom in
		 */
		function zoomIn(event:MouseEvent):void {
			
			
			/*
				tilfoej tempLavatoryObject til stage
			*/
			
			this.portrait4.addChild(this.tempLaboratoryObject);
			
			/*
				bring element forrest
			*/

			this.tempLaboratoryObject.parent.setChildIndex(this.tempLaboratoryObject, this.tempLaboratoryObject.parent.numChildren - 1);

			/*
				centrer element og lidt transitions
			*/
			this.tempLaboratoryObject.x = (this.tempLaboratoryObject.stage.stageWidth / 2) - (this.tempLaboratoryObject.width / 2) + this.scaleX;
			this.tempLaboratoryObject.y = (this.tempLaboratoryObject.stage.stageHeight / 2) - (this.tempLaboratoryObject.height / 2)  + this.scaleY;
			if(this.pos == "tv") var moveX1:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, this.originalX, 0, 1, true);
			if(this.pos == "th") var moveX2:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, this.originalX, 70, 1, true);
			var moveY:Tween = new Tween(this.tempLaboratoryObject, "y", Bounce.easeOut, this.tempLaboratoryObject.y, 20, 1, true);
			this.portrait4.getChildAt(1).visible = false;
			this.portrait4.getChildAt(2).visible = false;
			
			this.portrait4.addChild(this.t3);
			this.currentLaboratoryObject.useHandCursor = false;
			this.tempLaboratoryObject.gotoAndStop(2);

		}
		
		function animationFinished(e:Event):void {
			trace("The animation has finished!");
			
		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			this.portrait4.removeChild(this.t3);
			this.portrait4.getChildAt(1).visible = true;
			this.portrait4.getChildAt(2).visible = true;
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
						
			/*
				Placer element på oprindelig plads
			*/

			this.currentLaboratoryObject.width = this.originalWidth;
			this.currentLaboratoryObject.height = this.originalHeight;
			if(this.pos == "tv")  var moveX1:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, 0, this.originalX, 1, true);
			if(this.pos == "th")  var moveX2:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, 70, this.originalX, 1, true);
			var moveY:Tween = new Tween(this.tempLaboratoryObject, "y", Bounce.easeOut, 20, this.originalY, 1, true);
			/*
				Tilføj click event til object igen
			*/
			
			this.currentLaboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);
			
		}

		/**
		 * Add glow - for hover
		 */
		function addGlow(event:MouseEvent):void {
			var filt:GlowFilter = new GlowFilter;
			filt.color = 0xCCCC00;
			filt.blurX = 9;
			filt.blurY = 9;
			this.currentLaboratoryObject.filters = [filt];
			this.currentLaboratoryObject.buttonMode = true;
			this.currentLaboratoryObject.useHandCursor = true;
		}

		/**
		 * Remove glow - for mouseout
		 */
		public function removeGlow(event:MouseEvent):void {
			this.currentLaboratoryObject.filters = [];
		}

		/**
		 * Handler af onKeyDown
		 */
		public function onKeyDown(event:KeyboardEvent) : void {
			var key : uint = event.keyCode;
			trace(key);
			switch(key) {
				//case Keyboard.ESCAPE :
				case 27 :
					//trace("Escape button pushed");
					break;
			}
		}
	}
}