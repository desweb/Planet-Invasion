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
		private var _content:Sprite;
		
		private var _scroll:ScrollManager;
		
		private var _scrollFormat:TextFormat;
		
		public function AchievementScene()
		{
			if (Common.IS_DEBUG) trace('create AchievementScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			// Scroll
			_scrollFormat = Common.getPolicy('Arial', 0x00ffff, 15);
			
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
			lineSprite.y		= 25 * i;
			lineSprite.alpha	= 0.75;
			
			lineSprite.graphics.beginFill(0x000000);
			lineSprite.graphics.drawRect(0, 0, GameState.stageWidth * 0.9, GameState.stageHeight * 0.05);
			lineSprite.graphics.endFill();
			
			var lockSprite:Sprite = new Sprite();
			lockSprite.x = GameState.stageWidth * 0.05;
			lockSprite.y = GameState.stageHeight * 0.025;
			
			if (achievementUser['is_unlock'])	lockSprite.graphics.beginFill(0x00FF00);
			else											lockSprite.graphics.beginFill(0xFF0000);
			
			lockSprite.graphics.drawCircle(0, 0, GameState.stageHeight * 0.01);
			lockSprite.graphics.endFill();
			
			lineSprite.addChild(lockSprite);
			
			// Name
			var nameLabel:TextField = new TextField();
			nameLabel.x = GameState.stageWidth*0.2;
			nameLabel.defaultTextFormat = _scrollFormat;
			nameLabel.text = achievement.name;
			lineSprite.addChild(nameLabel);
			
			// Description
			var descriptionLabel:TextField = new TextField();
			descriptionLabel.x = GameState.stageWidth*0.5;
			descriptionLabel.defaultTextFormat = _scrollFormat;
			descriptionLabel.text = achievement.description;
			lineSprite.addChild(descriptionLabel);
			
			// Score
			var scoreLabel:TextField = new TextField();
			scoreLabel.x = GameState.stageWidth*0.7;
			scoreLabel.defaultTextFormat = _scrollFormat;
			scoreLabel.text = achievementUser['score'] + ' / ' + achievement.score;
			lineSprite.addChild(scoreLabel);
			
			if (!achievementUser['is_unlock'])
			{
				nameLabel		.alpha =
				descriptionLabel	.alpha =
				scoreLabel			.alpha = 0.75;
			}
			
			return lineSprite;
		}
	}
}