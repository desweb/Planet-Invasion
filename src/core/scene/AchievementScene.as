package core.scene 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.Achievement;
	import core.Common;
	import core.GameState;
	
	/**
	 * Achievements list of the user
	 * @author desweb
	 */
	public class AchievementScene extends Scene
	{
		private var _title_label:TextField;
		
		private var _scroll:ScrollManager;
		private var _content:Sprite;
		
		private var _title_success_format		:TextFormat;
		private var _title_lock_format				:TextFormat;
		private var _content_success_format	:TextFormat;
		private var _content_lock_format		:TextFormat;
		private var _score_success_format		:TextFormat;
		private var _score_lock_format			:TextFormat;
		
		public function AchievementScene()
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			// Title
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 20);
			format_title.bold = true;
			
			_title_label = new TextField();
			_title_label.x							= GameState.stageWidth	* .25;
			_title_label.y							= GameState.stageHeight	* .1;
			_title_label.width					= GameState.stageWidth	* .5;
			_title_label.height					= GameState.stageHeight	* .5;
			_title_label.defaultTextFormat	= format_title;
			_title_label.text						= 'Achievements';
			_title_label.selectable				= false;
			addChild(_title_label);
			
			// Format
			_title_success_format			= Common.getPolicy('Arial', 0x00FFFF, 15);
			_title_lock_format				= Common.getPolicy('Arial', 0xFF0000, 15);
			_content_success_format	= Common.getPolicy('Arial', 0x00FFFF, 12);
			_content_lock_format			= Common.getPolicy('Arial', 0xFF0000, 12);
			_score_success_format		= Common.getPolicy('Arial', 0x00FFFF, 14);
			_score_lock_format			= Common.getPolicy('Arial', 0xFF0000, 14);
			
			_title_success_format	.bold = true;
			_title_lock_format		.bold = true;
			
			// Scroll
			_content = new Sprite();
			
			var achievementUser:Array = GameState.user.achievements;
			
			var i:int = 0;
			for (var key:String in achievementUser)
			{
				_content.addChild(generateLine(key, achievementUser[key], i));
				
				i++;
			}
			
			_scroll = new ScrollManager(_content);
			addChild(_scroll);
		}
		
		/**
		 * Interface
		 */
		
		private function generateLine(key:String, achievementUser:Array, i:int):Sprite
		{
			var achievement:Achievement = new Achievement(key);
			
			// Achievement line
			var lineSprite:Sprite = new Sprite();
			lineSprite.y = GameState.stageHeight * .076 * i;
			lineSprite.graphics.drawRect(0, 0, GameState.stageWidth * .9, GameState.stageHeight * .075);
			lineSprite.graphics.endFill();
			
			// Separator
			var separatorSprite:Sprite = new Sprite();
			separatorSprite.y = (GameState.stageHeight * .075) - 1;
			separatorSprite.graphics.beginFill(0xffffff);
			separatorSprite.graphics.drawRect(0, 0, GameState.stageWidth * .9, 1);
			separatorSprite.graphics.endFill();
			lineSprite.addChild(separatorSprite);
			
			// Name
			var nameLabel:TextField = new TextField();
			nameLabel.x			= GameState.stageWidth 	* .05;
			nameLabel.y			= GameState.stageHeight	* .01;
			nameLabel.width	= GameState.stageWidth	* .2;
			nameLabel.defaultTextFormat = achievementUser['is_unlock'] == 1? _title_success_format: _title_lock_format;
			nameLabel.text = achievement.name;
			nameLabel.selectable = false;
			lineSprite.addChild(nameLabel);
			
			// Description
			var descriptionLabel:TextField = new TextField();
			descriptionLabel.x			= GameState.stageWidth 	* .2;
			descriptionLabel.y			= GameState.stageHeight	* .01;
			descriptionLabel.width	= GameState.stageWidth 	* .5;
			descriptionLabel.defaultTextFormat = achievementUser['is_unlock'] == 1? _content_success_format: _content_lock_format;
			descriptionLabel.text = achievement.description;
			descriptionLabel.selectable = false;
			lineSprite.addChild(descriptionLabel);
			
			// Score
			var scoreLabel:TextField = new TextField();
			scoreLabel.x = GameState.stageWidth		* .7;
			scoreLabel.y = GameState.stageHeight	* .01;
			scoreLabel.defaultTextFormat = achievementUser['is_unlock'] == 1? _score_success_format: _score_lock_format;
			scoreLabel.text = achievementUser['score'] + ' / ' + achievement.score;
			scoreLabel.selectable = false;
			lineSprite.addChild(scoreLabel);
			
			return lineSprite;
		}
	}
}