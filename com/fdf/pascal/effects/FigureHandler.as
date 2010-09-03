/*

*/

package com.fdf.pascal.effects {	

	import flash.display.MovieClip;
	import com.fdf.pascal.data.XmlLoader;
	import flash.display.DisplayObjectContainer;
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
		public var numChildren : DisplayObjectContainer;
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

		public function FigureHandler(portrait4, laboratoryObject : MovieClip) {

			trace("FigureHandler Constructor er loadet");

			this.currentLaboratoryObject = laboratoryObject;
			this.tempLaboratoryObject = laboratoryObject;
			this.originalX = this.currentLaboratoryObject.x;
			this.originalY = this.currentLaboratoryObject.y;
			this.isScaledUp = false;
			this.portrait4 = portrait4;
					

			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			this.currentLaboratoryObject.addEventListener(MouseEvent.CLICK, scalingHandler);


			//theStage.addEventListener(Event.RESIZE, onResize);
			//theStage.onResize = function() {this.onResize()};

			portrait4.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
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
				new XmlLoader(this.currentLaboratoryObject);
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
			
			//this.currentLaboratoryObject.removeEventListener(MouseEvent.CLICK, scalingHandler);
						

			
			/*
				tilfoej tempLavatoryObject til stage
			*/
			
			this.portrait4.addChild(this.tempLaboratoryObject);

			
			/*
				skaler element op
			*/
					
			
			
			/*
				bring element forrest
			*/

			this.tempLaboratoryObject.parent.setChildIndex(this.tempLaboratoryObject, this.tempLaboratoryObject.parent.numChildren - 1);

			/*
				centrer element og lidt transitions
			*/
			this.tempLaboratoryObject.x = (this.tempLaboratoryObject.stage.stageWidth / 2) - (this.tempLaboratoryObject.width / 2) + this.scaleX;
			this.tempLaboratoryObject.y = (this.tempLaboratoryObject.stage.stageHeight / 2) - (this.tempLaboratoryObject.height / 2)  + this.scaleY;
			
			//var myTransitionManager:TransitionManager = new TransitionManager(this.portrait4.getChildAt(1));
  			//myTransitionManager.startTransition({type:Fade, direction:Transition.OUT, duration:3, easing:Strong.easeOut});
			//myTransitionManager.addEventListener("allTransitionsInDone", animationFinished);
			
			var moveX:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, this.tempLaboratoryObject.x, 70, 1, true);
			var moveY:Tween = new Tween(this.tempLaboratoryObject, "y", Bounce.easeOut, this.tempLaboratoryObject.y, 20, 1, true);
			this.portrait4.getChildAt(1).visible = false;
			this.portrait4.getChildAt(2).visible = false;
			//TransitionManager.start(this.portrait4.getChildAt(1), {type:Fade, direction:Transition.OUT, duration:9, easing:Strong.easeOut});
			//TransitionManager.start(img1_mc, {type:Fade, direction:Transition.IN, duration:9, easing:Strong.easeOut});




			//this.currentLaboratoryObject.removeEventListener(MouseEvent.MOUSE_OVER, addGlow);
			this.currentLaboratoryObject.useHandCursor = false;
			this.tempLaboratoryObject.gotoAndStop(2);

		}
		
		
		// imageLoaded2 kaldes, når billedet er indlæst.
		function animationFinished(e:Event):void {
			trace("The animation has finished!");

		}

		/**
		 * Zoom out
		 */
		function zoomOut(event:MouseEvent):void {
			this.portrait4.getChildAt(1).visible = true;
			this.portrait4.getChildAt(2).visible = true;
			this.currentLaboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
						
			/*
				Placer element på oprindelig plads
			*/

			this.currentLaboratoryObject.width = this.originalWidth;
			this.currentLaboratoryObject.height = this.originalHeight;
			var moveX:Tween = new Tween(this.tempLaboratoryObject, "x", Strong.easeOut, 70, this.originalX, 1, true);
			var moveY:Tween = new Tween(this.tempLaboratoryObject, "y", Bounce.easeOut, 20, this.originalY, 1, true);
			
			//this.currentLaboratoryObject.x = this.originalX;
			//this.currentLaboratoryObject.y = this.originalY;
			
			
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