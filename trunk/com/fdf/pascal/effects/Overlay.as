package com.fdf.pascal.effects {
	import flash.display.MovieClip;
	
	public class Overlay extends MovieClip {
		
		private var overlay_mc:MovieClip;


		public function Overlay(theStage) {
			
		
			trace("Overlay constructor er loadet");
			
			overlay_mc = new MovieClip();
			overlay_mc.mouseChildren = false;
			overlay_mc.name = "overlay_mc";
			overlay_mc.graphics.beginFill(0x000000, 0.7);
			overlay_mc.graphics.drawRect( 0, 0, theStage.stageWidth, theStage.stageHeight );
			overlay_mc.graphics.endFill();
			addChild( overlay_mc ); 
		}

	}
	
}
