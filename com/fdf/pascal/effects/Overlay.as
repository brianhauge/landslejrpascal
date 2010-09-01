package com.fdf.pascal.effects {
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	
	public class Overlay extends MovieClip {
		
		private var overlay_mc:MovieClip;
		private var quit_mc:MovieClip;


		public function Overlay(theStage) {
						
		
			trace("Overlay constructor er loadet");
			
			overlay_mc = new MovieClip();
			quit_mc = new Quit();
			overlay_mc.graphics.beginFill(0x000000, 0.8);
			overlay_mc.graphics.drawRect( 0, 0, theStage.stageWidth, theStage.stageHeight );
			overlay_mc.graphics.endFill();
			quit_mc.x = theStage.stageWidth - 30;
			quit_mc.y = 30;
			quit_mc.addEventListener(MouseEvent.MOUSE_OVER, addGlow);
			quit_mc.addEventListener(MouseEvent.MOUSE_OUT, removeGlow);
			
			addChild( overlay_mc );
			addChild( quit_mc );
		}
		
				/**
		 * Add glow - for hover
		 */
		function addGlow(event:MouseEvent):void {
			var filt:GlowFilter = new GlowFilter;
			filt.color = 0xCCCC00;
			filt.blurX = 9;
			filt.blurY = 9;
			quit_mc.filters = [filt];
			quit_mc.buttonMode = true;
			quit_mc.useHandCursor = true;
		}

		/**
		 * Remove glow - for mouseout
		 */
		public function removeGlow(event:MouseEvent):void {
			quit_mc.filters = [];
		}

	}
	
}
