package core.game 
{
	// Test
	import flash.display.Loader;
	import flash.net.URLRequest;
	import core.Common;
	
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameBg extends Sprite
	{
		public function GameBg() 
		{
			x = 0;
			y = 0;
			
			/*var conteneurImage:Loader = new Loader();
			// url de l'image ou du swf à charger
			var image:URLRequest = new URLRequest(Common.PATH_ASSETS + 'images/game-bg.jpg');
			// chargement de l'image ou du swf dans le conteneur
			conteneurImage.load(image);
			// affichage du conteneur
			addChild(conteneurImage);
			
			conteneurImage.scaleX =
			conteneurImage.scaleY = .5;*/
			
			/*graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, GameState.stageWidth, GameState.stageHeight);
			graphics.endFill();*/
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update (e:Event):void
		{
			if (Tools.random(1, 3) == 1)
			{
				var star:Sprite = new Sprite();
				star.x = GameState.stageWidth+1;
				star.y = Tools.random(0, GameState.stageHeight);
				star.graphics.beginFill(0xffffff);
				
				star.graphics.drawCircle(0, 0, Tools.random(1, 2));
				star.graphics.endFill();
				addChild(star);
				
				TweenLite.to(star, Tools.random(1, 3), { x: -100, onComplete:removeStar, ease:Linear.easeNone, onCompleteParams:[star] } );
			}
		}
		
		private function removeStar(star:Sprite):void
		{
			removeChild(star);
		}
	}
}