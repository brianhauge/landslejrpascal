/*

*/

package com.fdf.pascal {	

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.DisplayObjectContainer;
	import flash.display.Scene;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;


	public class Pascal {

		public var currentLaboratoryObject : MovieClip;
		public var stage : Stage;
		public var _scene : Scene;
		public var numChildren : DisplayObjectContainer;
		public var originalWidth : Number;
		public var originalHeight : Number;
		public var originalX : Number;
		public var originalY : Number;
		public var isScaledUp : Boolean;

		public function Pascal(theStage, laboratoryObject : MovieClip) {

			trace("Constructor er loadet");

			this.currentLaboratoryObject = laboratoryObject;
			this.originalWidth = laboratoryObject.width;
			this.originalHeight = laboratoryObject.height;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;

			laboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			laboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			laboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);


			//theStage.addEventListener(Event.RESIZE, onResize);
			//theStage.onResize = function() {this.onResize()};

			theStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
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
				this.isScaledUp = true;
			}
		}

		/**
		 * Zoom in
		 */
		function zoomIn(event:MouseEvent):void {
			/*
				skaler element op
			*/
			this.currentLaboratoryObject.width = 500;
			this.currentLaboratoryObject.scaleY = this.currentLaboratoryObject.scaleX;
			/*
				bring element forrest
			*/

			this.currentLaboratoryObject.parent.setChildIndex(this.currentLaboratoryObject, this.currentLaboratoryObject.parent.numChildren - 1);

			/*
				centrer element
			*/
			this.currentLaboratoryObject.x = (this.currentLaboratoryObject.stage.stageWidth / 2) - (this.currentLaboratoryObject.width / 2);
			this.currentLaboratoryObject.y = (this.currentLaboratoryObject.stage.stageHeight / 2) - (this.currentLaboratoryObject.height / 2);
		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			this.currentLaboratoryObject.width = this.originalWidth;
			this.currentLaboratoryObject.height = this.originalHeight;
			this.currentLaboratoryObject.x = this.originalX;
			this.currentLaboratoryObject.y = this.originalY;
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
		 * Enlarges the current laboratoryObject
		 */
		public function enlargeLaboratoryObject() : void {}

		/**
		 * Reduces the current laboratoryObject
		 */
		public function reduceLaboratoryObject() : void {}

        /**
		 * Tilpas galleriet i forhold til størrelsen på Flash (http://felix-sanchez.dk/3d-galleri-i-flash-og-actionscript-med-five3d/)
         */
        
		public function onResize(event:Event) : void {
            /*this._scene.x = Math.round(stage.stageWidth/2);
            this._scene.y = Math.round(stage.stageHeight/2);*/
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
					trace("Escape button pushed");
					break;
			}
		}

	}
}