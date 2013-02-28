package core.scene 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import flash.display.Sprite;
	
	/*import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;*/
	
	import core.Common;
	
	/**
	 * First menu
	 * @author desweb
	 */
	public class MenuScene extends Scene
	{
		//private var _engine:CitrusEngine;
		
		private var _bgSprite:Bg;
		private var _btnSprite:Btn;
		
		public function MenuScene()
		{
			if (Common.IS_DEBUG) trace('create MenuScene');
			
			//super();
			
			//_engine = CitrusEngine.getInstance();
			
			//initialize();
			
			/*var label:TextField = new TextField();
			label.text = "Hello world";
			label.x = 10;
			label.y = 10;
			label.textColor = 0xFFFFFF;
			addChild(label);
			
			label.addEventListener(MouseEvent.CLICK, clickLabel);*/
			
			_bgSprite = new Bg();
			_bgSprite.gotoAndStop(3);
			_bgSprite.scaleX = 0.35;
			_bgSprite.scaleY = 0.35;
			addChild(_bgSprite);
			
			_btnSprite = new Btn();
			_btnSprite.btn_txt.textColor = 0xFFF000;
			_btnSprite.btn_txt.text = 'JOUER';
			_btnSprite.x = 0;
			_btnSprite.y = 0;
			_btnSprite.btn_txt.selectable = false;
			addChild(_btnSprite);
		}
		
		public function clickLabel(e:Event):void
		{
			SceneManager.getInstance().setCurrentScene(Common.SCENE_GAME_MODE);
		}
	}

}