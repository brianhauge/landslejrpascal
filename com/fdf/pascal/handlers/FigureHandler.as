/*

*/

package com.fdf.pascal.handlers {	

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
		public var originalX : Number;
		public var originalY : Number;
		public var isScaledUp : Boolean;
		public var moveX : Number;
		public var moveY : Number;
		public var labParent : MovieClip;
		public var pos : String;
		public var t3MovieClip : XmlLoader;
		public var tt_content_id : String;

		public function FigureHandler(labParent, laboratoryObject : MovieClip, pos, tt_content_id : String) {

			//trace("FigureHandler Constructor er loadet");

			this.currentLaboratoryObject = laboratoryObject;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;
			this.labParent = labParent;
			this.pos = pos;
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);
			this.labParent.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.tt_content_id = tt_content_id;
			this.t3MovieClip = new XmlLoader(this.tt_content_id, 16, 16, 60, 100);
			this.t3MovieClip.fontFormat.size = 3;
			
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
			
			this.labParent.addChild(this.currentLaboratoryObject);
			
			/*
				bring element forrest
			*/

			this.currentLaboratoryObject.parent.setChildIndex(this.currentLaboratoryObject, this.currentLaboratoryObject.parent.numChildren - 1);

			/*
				flyt figuren til højre eller venstre element og lidt transitions
			*/
			this.currentLaboratoryObject.x = (this.currentLaboratoryObject.stage.stageWidth / 2) - (this.currentLaboratoryObject.width / 2) + this.moveX;
			this.currentLaboratoryObject.y = (this.currentLaboratoryObject.stage.stageHeight / 2) - (this.currentLaboratoryObject.height / 2)  + this.moveY;
			if(this.pos == "tv") var moveX1:Tween = new Tween(this.currentLaboratoryObject, "x", Strong.easeOut, this.originalX, 0, 1, true);
			if(this.pos == "th") var moveX2:Tween = new Tween(this.currentLaboratoryObject, "x", Strong.easeOut, this.originalX, 70, 1, true);
			var moveY:Tween = new Tween(this.currentLaboratoryObject, "y", Bounce.easeOut, this.currentLaboratoryObject.y, 20, 1, true);
			
			/*
				Gør de to andre figurer usynlige
			*/
			
			this.labParent.getChildAt(1).visible = false;
			this.labParent.getChildAt(2).visible = false;
			
			/*
				Tilføj indhold fra Typo3
			*/
			this.labParent.addChild(this.t3MovieClip);
		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			
			/*
				Fjern indholdet fra Typo3
			*/
			
			this.labParent.removeChild(this.t3MovieClip);
			
			/*
				Gør de to andre figurer synlige igen
			*/
			
			this.labParent.getChildAt(1).visible = true;
			this.labParent.getChildAt(2).visible = true;
			
			/*
				Placer element på oprindelig plads
			*/

			if(this.pos == "tv")  var moveX1:Tween = new Tween(this.currentLaboratoryObject, "x", Strong.easeOut, 0, this.originalX, 1, true);
			if(this.pos == "th")  var moveX2:Tween = new Tween(this.currentLaboratoryObject, "x", Strong.easeOut, 70, this.originalX, 1, true);
			var moveY:Tween = new Tween(this.currentLaboratoryObject, "y", Bounce.easeOut, 20, this.originalY, 1, true);			
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