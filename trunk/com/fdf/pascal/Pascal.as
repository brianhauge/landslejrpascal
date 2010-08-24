/*

*/

package com.fdf.pascal {	

	import flash.display.MovieClip;
	import flash.display.Stage;
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

		public function Pascal(theStage, laboratoryObject : MovieClip) {

			trace("Constructor er loadet");

			trace(laboratoryObject);

			this.currentLaboratoryObject = laboratoryObject;

			laboratoryObject.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			laboratoryObject.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			//stage.addEventListener(Event.RESIZE, onResize);
			theStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
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
        
		public function onResize(e:Event) : void {
            /*_scene.x = Math.round(stage.stageWidth/2);
            _scene.y = Math.round(stage.stageHeight/2);*/
        }


		/**
		 * Handler af onKeyDown
		 */
		public function onKeyDown(event:KeyboardEvent) : void {
			trace("some key was pushed");
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