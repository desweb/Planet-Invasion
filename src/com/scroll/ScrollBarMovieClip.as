package com.scroll {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;	
	
	public class ScrollBarMovieClip extends MovieClip	{
		
		// Propriétés
		public var scrollerHeight:Number = 38.5;
		private var arrowTimer:Timer;
		private var scrollTimer;
		private var dir:Number;
		private var target:*;
		private var targetMinY:Number;
		private var sensitivityDefault:Number = 4.0
		public var sensitivity:Number = sensitivityDefault;
		private var active:Boolean = false;
		
		private var bg:Bg;
		private var up:Sprite;
		private var down:Sprite;
		private var cursor:Sprite;
		
		// Constructeur
		public function ScrollBarMovieClip() {
			
			super();
			
			/*
			 * Add test
			 */
			bg = new Bg();
			addChild(bg);
			
			// Create up button
			var upPoints:Vector.<Number> = new Vector.<Number>(6, true);
			upPoints[0] = 5;
			upPoints[1] = 0;
			upPoints[2] = 10;
			upPoints[3] = 10;
			upPoints[4] = 0;
			upPoints[5] = 10;
			
			up = new Sprite();
			up.graphics.beginFill(0xffff00);
			up.graphics.drawTriangles(upPoints);
			up.graphics.endFill();
			addChild(up);
			
			// Create scroll bar
			cursor = new Sprite();
			cursor.graphics.beginFill(0xffff00);
			cursor.graphics.drawRect(0, 0, 10, 20);
			cursor.graphics.endFill();
			addChild(cursor);
			
			// Create down button
			var downPoints:Vector.<Number> = new Vector.<Number>(6, true);
			downPoints[0] = 0;
			downPoints[1] = 0;
			downPoints[2] = 10;
			downPoints[3] = 0;
			downPoints[4] = 5;
			downPoints[5] = 10;
			
			down = new Sprite();
			down.graphics.beginFill(0xffff00);
			down.graphics.drawTriangles(downPoints);
			down.graphics.endFill();
			addChild(down);
			
			var mvClip:MovieClip = new MovieClip();
			
			// Màjs
			arrowTimer = new Timer (25);
			arrowTimer.addEventListener (TimerEvent.TIMER, updateArrow);
			
			scrollTimer = new Timer (25);
			scrollTimer.addEventListener (TimerEvent.TIMER, updateScroll);
			
			// Handlers
			up.addEventListener (MouseEvent.MOUSE_DOWN, startUp);
			down.addEventListener (MouseEvent.MOUSE_DOWN, startDown);
			
			up.addEventListener (MouseEvent.MOUSE_UP, stopUpdateByMouse);
			down.addEventListener (MouseEvent.MOUSE_UP, stopUpdateByMouse);
			
			cursor.addEventListener (MouseEvent.MOUSE_DOWN, startScroll);
			cursor.addEventListener (MouseEvent.MOUSE_UP, stopUpdateByMouse);
			
			addEventListener (Event.ENTER_FRAME, updateComponent);
			
			addEventListener (Event.ADDED_TO_STAGE, addedToStage);
			
			// Etats
			/*up.over.visible = false;
			down.over.visible = false;
			cursor.over.visible = false;*/
			
			cursor.useHandCursor =
			up.useHandCursor =
			down.useHandCursor = true;
			cursor.mouseChildren =
			up.mouseChildren =
			down.mouseChildren = false;
			cursor.buttonMode =
			down.buttonMode =
			up.buttonMode = true;
			
			// Par défaut
			visible = false;
			active = false;
			
		}
		
		// Règle la taille
		public function setHeight (newHeight:Number, cursorHeight:Number = 25) {
			
			scrollerHeight = newHeight;
			
			cursor.height = cursorHeight;
			
			bg.y = up.height;
			bg.height = newHeight - up.height - down.height;
			
			cursor.y = up.height;
			
			down.y = bg.y + bg.height + up.height/2;
			
		}
		
		// Fixe la cible
		public function setTarget (targetRef:*, targetMinYSet:Number = 0) {
			
			target = targetRef;
			
			targetMinY = targetMinYSet;
					
		}
		
		// Fixe la sensibilité
		public function setSensitivity (sensitivitySet:Number) {
			
			sensitivityDefault = sensitivitySet;
			sensitivity = sensitivityDefault;
			
		}
		
		// Màj
		private function updateComponent (e:Event) {
			
			if (target) {
				if (target.height > height) {
					visible = true;
					active = true;
				} else {
					visible = false;
					active = false;
					target.y = targetMinY;
				}
			}
			
		}
		
		private function startUp (e:MouseEvent) {
			
			dir = +1;
			arrowTimer.start();
			
			//up.over.visible = true;
						
		}
		
		private function startDown (e:MouseEvent) {
			
			dir = -1;
			arrowTimer.start();
			
			//down.over.visible = true;
						
		}
		
		private function stopUpdateByMouse(e:MouseEvent) {
			
			stopUpdate();
			
		}
		
		public function stopUpdate() {
			
			arrowTimer.stop();
			scrollTimer.stop();
			
			//up.over.visible = false;
			//down.over.visible = false;
			//cursor.over.visible = false;
			
		}
		
		// Maj par les flèches
		private function updateArrow (e:TimerEvent) {
			
			updateArrowAction();
			
		}
		
		private function updateArrowAction() {
			
			target.y += (dir * sensitivity);
			
			bounds();
			
			var path:Number = bg.height - cursor.height;
			
			cursor.y = up.y + (up.height / 2) + 
			
								(path / ( (target.height + targetMinY - height) ) ) * ( (target.y - targetMinY) * -1);
			
			cursor.y = Math.max (cursor.y, up.y + up.height / 2);
			cursor.y = Math.min (cursor.y, down.y - down.height/2 - cursor.height);
				
		}
		
		// Maj par le scroll
		private function startScroll (e:MouseEvent) {
			
			scrollTimer.start();
			
			//cursor.over.visible = true;
			
		}
		
		private function updateScroll (e:TimerEvent) {
			
			cursor.y = mouseY - cursor.height / 2;
			
			cursor.y = Math.max (cursor.y, up.y + up.height / 2);
			cursor.y = Math.min (cursor.y, down.y - down.height/2 - cursor.height);
			
			var path:Number = Math.ceil (height) - up.height - cursor.height - down.height;
			
			target.y = targetMinY - ( ( ( (target.height + targetMinY) - height) / path) * (cursor.y - up.height) );
			
			bounds();
			
		}
		
		private function bounds() {
			
			target.y = Math.min (targetMinY, target.y);
			target.y = Math.max (target.y, (target.height * -1) + height);
			
		}	
		
		private function addedToStage(e:Event) {
			
			stage.addEventListener (MouseEvent.MOUSE_UP, stopUpdateByMouse);
			
		}
		
		public function setToTop() {
						
			cursor.y = up.y + up.height / 2 + 2;
			
		}
		
		// PUBLIC
		
		// Scroll UP
		public function scrollUp() {
			
			if (active) {
				sensitivity = 2.0;
				dir = +1;
				updateArrowAction();
				sensitivity = sensitivityDefault;
			}
			
		}
		
		// Scroll DOWN
		public function scrollDown() {
			
			if (active) {
				sensitivity = 2.0;
				dir = -1;
				updateArrowAction();
				sensitivity = sensitivityDefault;
			}
			
		}
		
				
	}
	
}