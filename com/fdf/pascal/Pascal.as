/*

*/

package com.fdf.pascal {	

	import flash.display.MovieClip;
	import com.fdf.pascal.effects.Overlay;
	//import com.fdf.pascal.data.XmlLoader;
	import flash.display.Stage;
	import flash.display.DisplayObjectContainer;
	import flash.display.Scene;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import fl.transitions.*;
	import fl.transitions.easing.*;


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
		public var overlay : Overlay;
		public var tempLaboratoryObject : MovieClip;
		public var scaleWidth : Number;
		public var scaleX : Number;
		public var scaleY : Number;

		public function Pascal(theStage, laboratoryObject : MovieClip, scaleWidth, scaleX = 0, scaleY = 0) {

			trace("Constructor er loadet for: " + laboratoryObject.name);

			this.currentLaboratoryObject = laboratoryObject;
			this.tempLaboratoryObject = laboratoryObject;
			this.originalWidth = laboratoryObject.width;
			this.originalHeight = laboratoryObject.height;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;
			this.stage = theStage;
			this.scaleWidth = scaleWidth;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
			

			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);


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
				//new XmlLoader(this.currentLaboratoryObject);
				this.isScaledUp = true;
			}
		}

		/**
		 * Zoom in
		 */
		function zoomIn(event:MouseEvent):void {
			
			/*
				fjern click event fra elementet
			*/
			
			this.currentLaboratoryObject.removeEventListener(MouseEvent.CLICK, scalingHandler);
						
			/*
				opret overlay og tilfoej denne til stage, samt clickevent på overlay
			*/
			
			this.overlay = new Overlay(this.stage);
			this.stage.addChild(this.overlay);
			
			
			/*
				tilfoej tempLavatoryObject til stage
			*/
			
			this.stage.addChild(this.tempLaboratoryObject);

			
			/*
				skaler element op
			*/
					
			this.tempLaboratoryObject.width = this.scaleWidth;
			this.tempLaboratoryObject.scaleY = this.tempLaboratoryObject.scaleX;
			
			/*
				bring element forrest
			*/

			this.tempLaboratoryObject.parent.setChildIndex(this.tempLaboratoryObject, this.tempLaboratoryObject.parent.numChildren - 1);

			/*
				centrer element og lidt transitions
			*/
			this.tempLaboratoryObject.x = (this.tempLaboratoryObject.stage.stageWidth / 2) - (this.tempLaboratoryObject.width / 2) + this.scaleX;
			this.tempLaboratoryObject.y = (this.tempLaboratoryObject.stage.stageHeight / 2) - (this.tempLaboratoryObject.height / 2)  + this.scaleY;
			var myTransitionManager:TransitionManager = new TransitionManager(this.tempLaboratoryObject);
  			myTransitionManager.startTransition({type:Zoom, direction:Transition.IN, duration:1, easing:Bounce.easeOut});
			myTransitionManager.addEventListener("allTransitionsInDone", addOverlayClick);


			this.currentLaboratoryObject.removeEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.useHandCursor = false;
			this.tempLaboratoryObject.gotoAndStop(2);

		}
		
		
		// imageLoaded2 kaldes, når billedet er indlæst.
		function addOverlayClick(e:Event):void {
			//trace("The animation has finished!");
			this.overlay.addEventListener(MouseEvent.CLICK, scalingHandler);
		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			while (this.currentLaboratoryObject.numChildren) this.currentLaboratoryObject.removeChildAt(0);
			this.tempLaboratoryObject.gotoAndStop(1);
			
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			/*
				fjern clickevent fra overlay og overlay fra stage
			*/
			
			this.overlay.removeEventListener(MouseEvent.CLICK, scalingHandler);
			this.stage.removeChild(overlay);
			
			/*
				Placer element på oprindelig plads
			*/

			this.currentLaboratoryObject.width = this.originalWidth;
			this.currentLaboratoryObject.height = this.originalHeight;
			this.currentLaboratoryObject.x = this.originalX;
			this.currentLaboratoryObject.y = this.originalY;
			
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
		 * Enlarges the current laboratoryObject
		 */
		public function enlargeLaboratoryObject() : void {}

		/**
		 * Reduces the current laboratoryObject
		 */
		public function reduceLaboratoryObject() : void {}

        /**
		 * Tilpas galleriet i forhold til st¿rrelsen p Flash (http://felix-sanchez.dk/3d-galleri-i-flash-og-actionscript-med-five3d/)
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
					//trace("Escape button pushed");
					break;
			}
		}

	}
}