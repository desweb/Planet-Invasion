package core.scene 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.Common;
	import core.GameState;
	
	/**
	 * Credits list
	 * @author desweb
	 */
	public class CreditScene extends Scene
	{
		private var _scroll:ScrollManager;
		private var _scroll_content:Sprite;
		
		public function CreditScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			var credits_title_format		:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 20);
			var credits_content_format	:TextFormat = Common.getPolicy('Arial', 0xFFFFFF, 15);
			
			credits_title_format.bold = true;
			
			// Title format
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
			format_title.bold = true;
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x							= GameState.stageWidth	* .25;
			title_label.y							= GameState.stageHeight	* .1;
			title_label.width						= GameState.stageWidth	* .5;
			title_label.height					= GameState.stageHeight	* .5;
			title_label.defaultTextFormat	= format_title;
			title_label.text						= 'Credits';
			title_label.selectable				= false;
			addChild(title_label);
			
			/**
			 * Content scroll
			 */
			
			_scroll_content = new Sprite();
			
			// Idea
			var idea_title_label:TextField = new TextField();
			idea_title_label.y		= 10;
			idea_title_label.width	= 560;
			idea_title_label.height	= 30;
			idea_title_label.defaultTextFormat = credits_title_format;
			idea_title_label.text = 'Concept by';
			idea_title_label.selectable = false;
			_scroll_content.addChild(idea_title_label);
			
			var idea_content_label:TextField = new TextField();
			idea_content_label.y			= 50;
			idea_content_label.width		= 560;
			idea_content_label.height	= 60;
			idea_content_label.defaultTextFormat = credits_content_format;
			idea_content_label.text = 'Victor Delforge\nAudric Fourez';
			idea_title_label.selectable = false;
			_scroll_content.addChild(idea_content_label);
			
			// Developpers
			var developpers_title_label:TextField = new TextField();
			developpers_title_label.y		= 100;
			developpers_title_label.width	= 560;
			developpers_title_label.height	= 30;
			developpers_title_label.defaultTextFormat = credits_title_format;
			developpers_title_label.text = 'Developped by';
			developpers_title_label.selectable = false;
			_scroll_content.addChild(developpers_title_label);
			
			var developpers_content_label:TextField = new TextField();
			developpers_content_label.y			= 140;
			developpers_content_label.width		= 560;
			developpers_content_label.height	= 60;
			developpers_content_label.defaultTextFormat = credits_content_format;
			developpers_content_label.text = 'Victor Delforge\nAudric Fourez';
			developpers_content_label.selectable = false;
			_scroll_content.addChild(developpers_content_label);
			
			// Designers
			var designers_title_label:TextField = new TextField();
			designers_title_label.y		= 200;
			designers_title_label.width	= 560;
			designers_title_label.height	= 30;
			designers_title_label.defaultTextFormat = credits_title_format;
			designers_title_label.text = 'Designed by';
			designers_title_label.selectable = false;
			_scroll_content.addChild(designers_title_label);
			
			var designers_content_label:TextField = new TextField();
			designers_content_label.y			= 240;
			designers_content_label.width		= 560;
			designers_content_label.height	= 60;
			designers_content_label.defaultTextFormat = credits_content_format;
			designers_content_label.text = 'Estelle Poitevin';
			designers_content_label.selectable = false;
			_scroll_content.addChild(designers_content_label);
			
			// Sound designer
			var sound_design_title_label:TextField = new TextField();
			sound_design_title_label.y			= 300;
			sound_design_title_label.width	= 560;
			sound_design_title_label.height	= 30;
			sound_design_title_label.defaultTextFormat = credits_title_format;
			sound_design_title_label.text = 'Sound design by';
			sound_design_title_label.selectable = false;
			_scroll_content.addChild(sound_design_title_label);
			
			var sound_design_content_label:TextField = new TextField();
			sound_design_content_label.y			= 340;
			sound_design_content_label.width	= 560;
			sound_design_content_label.height	= 60;
			sound_design_content_label.defaultTextFormat = credits_content_format;
			sound_design_content_label.text = 'Victor Delforge';
			sound_design_content_label.selectable = false;
			_scroll_content.addChild(sound_design_content_label);
			
			// Thanks
			var thanks_title_label:TextField = new TextField();
			thanks_title_label.y		= 400;
			thanks_title_label.width	= 560;
			thanks_title_label.height	= 30;
			thanks_title_label.defaultTextFormat = credits_title_format;
			thanks_title_label.text = 'Thanks';
			thanks_title_label.selectable = false;
			_scroll_content.addChild(thanks_title_label);
			
			var greensock_logo:GreensockLogoFlash = new GreensockLogoFlash();
			greensock_logo.x = GameState.stageWidth * .45;
			greensock_logo.y = 460;
			_scroll_content.addChild(greensock_logo);
			
			// Marge
			var marge_label:TextField = new TextField();
			marge_label.y			= 500;
			marge_label.width		= 560;
			marge_label.height	= 10;
			marge_label.text = '';
			marge_label.selectable = false;
			_scroll_content.addChild(marge_label);
			
			// Scroll
			_scroll = new ScrollManager(_scroll_content);
			addChild(_scroll);
			
			// Achievement
			checkAchievement(Common.ACHIEVEMENT_CURIOSITY, 1);
		}
	}
}