package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.API;
	import core.Common;
	import core.GameState;
	
	/**
	 * General ranking & ranking of adventure, survival & duo mode
	 * @author desweb
	 */
	public class RankScene extends Scene
	{
		private var _loader:URLLoader;
		
		private var _contentRank			:Sprite;
		private var _contentRankAdventure	:Sprite;
		private var _contentRankSurvival	:Sprite;
		private var _contentRankDuo			:Sprite;
		
		private var _scrollRank				:ScrollManager;
		private var _scrollRankAdventure	:ScrollManager;
		private var _scrollRankSurvival		:ScrollManager;
		private var _scrollRankDuo			:ScrollManager;
		
		private var _scrollFormat:TextFormat;
		
		public function RankScene() 
		{
			if (Common.IS_DEBUG) trace('create RankScene');
			
			/**
			 * Initialization
			 */
			generateBg();
			generateBtnReturn();
			
			_scrollFormat = Common.getPolicy('Arial', 0x00ffff, 15);
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, completeResponseRank);
			_loader.load(API.get_rank(1, 25));
		}
		
		private function completeResponseRank(e:Event):void
		{
			trace('complete');
			
			_loader.removeEventListener(Event.COMPLETE, completeResponseRank);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var users_rank:XML = new XML(loader.data);
			
			_contentRank = new Sprite();
			
			var i:int = 0;
			for each (var user:XML in users_rank.users.user)
			{
				_contentRank.addChild(generateLine(user, i));
				
				i++;
			}
			
			_scrollRank = new ScrollManager(_contentRank);
			addChild(_scrollRank);
		}
		
		private function generateLine(user:XML, i:int):Sprite
		{
			trace(user);
			
			// Rank line
			var lineSprite:Sprite = new Sprite();
			lineSprite.y		= 25 * i;
			lineSprite.alpha	= 0.75;
			
			lineSprite.graphics.beginFill(0x000000);
			lineSprite.graphics.drawRect(0, 0, GameState.stageWidth * 0.9, GameState.stageHeight * 0.05);
			lineSprite.graphics.endFill();
			
			// Medal
			if (i < 3)
			{
				var medalSprite:Sprite = new Sprite();
				medalSprite.x = GameState.stageWidth * 0.05;
				medalSprite.y = GameState.stageHeight * 0.025;
				
				if		(i == 0) medalSprite.graphics.beginFill(0xFFD700); // Gold
				else if	(i == 1) medalSprite.graphics.beginFill(0xCECECE); // Argent
				else if	(i == 2) medalSprite.graphics.beginFill(0x614E1A); // Bronze
				
				medalSprite.graphics.drawCircle(0, 0, GameState.stageHeight * 0.01);
				medalSprite.graphics.endFill();
				
				lineSprite.addChild(medalSprite);
			}
			
			// Rank number
			var rankLabel:TextField = new TextField();
			rankLabel.x = GameState.stageWidth*0.1;
			rankLabel.defaultTextFormat = _scrollFormat;
			rankLabel.text = user.rank;
			lineSprite.addChild(rankLabel);
			
			// Username
			var usernameLabel:TextField = new TextField();
			usernameLabel.x = GameState.stageWidth*0.3;
			usernameLabel.defaultTextFormat = _scrollFormat;
			usernameLabel.text = user.username;
			lineSprite.addChild(usernameLabel);
			
			// Points
			var pointsLabel:TextField = new TextField();
			pointsLabel.x = GameState.stageWidth*0.7;
			pointsLabel.defaultTextFormat = _scrollFormat;
			pointsLabel.text = user.score + ' pts';
			lineSprite.addChild(pointsLabel);
			
			return lineSprite;
		}
	}
}