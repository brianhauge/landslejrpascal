/*

*/

package com.fdf.pascal {	

	import flash.display.MovieClip;
	import com.fdf.pascal.effects.Overlay;
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
	import Board;


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
		public var board : Board;

		public function Pascal(theStage, laboratoryObject : MovieClip) {

			trace("Constructor er loadet");

			this.currentLaboratoryObject = laboratoryObject;
			this.originalWidth = laboratoryObject.width;
			this.originalHeight = laboratoryObject.height;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;
			this.stage = theStage;
			

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
			trace(this.currentLaboratoryObject.name);
			
			/*
				opret overlay og tilføj denne til stage, samt clickevent på overlay
			*/
			
			this.overlay = new Overlay(this.stage);
			this.stage.addChild(this.overlay);
			this.overlay.addEventListener(MouseEvent.CLICK, scalingHandler);
			this.currentLaboratoryObject.visible = false;
			this.board = new Board();
			this.stage.addChild(this.board);

			
			/*
				skaler element op
			*/
					
			this.board.width = 850;
			this.board.scaleY = this.board.scaleX;
			
			/*
				bring element forrest
			*/

			this.board.parent.setChildIndex(this.board, this.board.parent.numChildren - 1);

			/*
				centrer element og lidt transitions
			*/
			this.board.x = (this.board.stage.stageWidth / 2) - (this.board.width / 2);
			this.board.y = (this.board.stage.stageHeight / 2) - (this.board.height / 2);
			var myTransitionManager:TransitionManager = new TransitionManager(this.board);
  			myTransitionManager.startTransition({type:Zoom, direction:Transition.IN, duration:1, easing:Bounce.easeOut});
			
		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			
			
			this.currentLaboratoryObject.visible = true;
			this.stage.removeChild(this.board);
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
					trace("Escape button pushed");
					break;
			}
		}

	}
}