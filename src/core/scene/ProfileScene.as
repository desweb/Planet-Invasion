package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.utils.Tools;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class ProfileScene extends Scene
	{
		
		private var _loader:LoaderFlash;
		
		public function ProfileScene() 
		{
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			sceneReturn = Common.SCENE_MENU;
			
			// Title format
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 25);
			format_title.bold = true;
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x							= GameState.stageWidth	* .25;
			title_label.y							= GameState.stageHeight	* .05;
			title_label.width						= GameState.stageWidth	* .5;
			title_label.height					= GameState.stageHeight	* .5;
			title_label.defaultTextFormat	= format_title;
			title_label.text						= GameState.user.username;
			title_label.selectable				= false;
			addChild(title_label);
			
			// Loader
			_loader = new LoaderFlash();
			_loader.x = GameState.stageWidth / 2;
			_loader.y = GameState.stageHeight / 2;
			addChild(_loader);
			
			addEventListener(Event.ENTER_FRAME, updateLoader);
			
			API.get_user(function(response_user:XML):void
			{
				API.get_game(function(response_game:XML):void
				{
					API.get_userRank(function(response_rank:XML):void
					{
						generateInterface(response_rank);
					});
				});
			});
		}
		
		/**
		 * Events
		 */
		
		private function updateLoader(e:Event):void
		{
			_loader.rotation += 10;
		}
		
		/**
		 * Functions
		 */
		
		private function generateInterface(response_rank:XML):void
		{
			// Remove loader
			removeEventListener(Event.ENTER_FRAME, updateLoader);
			
			removeChild(_loader);
			_loader = null;
			
			// Title format
			var title_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 20);
			title_format.bold = true;
			
			// Sub title format
			var sub_title_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 15);
			sub_title_format.bold = true;
			
			// Content format
			var content_format:TextFormat = Common.getPolicy('Arial', 0x00FFFF, 12);
			
			// Background
			var bg_sprite:Sprite = new Sprite();
			bg_sprite.graphics.beginFill(0x000000, .75);
			bg_sprite.graphics.drawRect(GameState.stageWidth * .04, GameState.stageHeight * .125, GameState.stageWidth * 9.2, GameState.stageHeight * .85);
			bg_sprite.graphics.endFill();
			addChild(bg_sprite);
			
			/*
			 * General
			 */
			
			// Title general
			var general_title_label:TextField = new TextField();
			general_title_label.x							= GameState.stageWidth	* .25;
			general_title_label.y							= GameState.stageHeight	* .15;
			general_title_label.width						= GameState.stageWidth	* .5;
			general_title_label.height					= GameState.stageHeight	* .5;
			general_title_label.defaultTextFormat	= title_format;
			general_title_label.text						= 'General';
			general_title_label.selectable				= false;
			addChild(general_title_label);
			
			var general_content_str:String = new String();
			general_content_str += 'Score : ' + GameState.user.score + ' pts  -  ';
			general_content_str += 'Metal : ' + GameState.user.metal + '  -  ';
			general_content_str += 'Crystal : ' + GameState.user.crystal + '  -  ';
			general_content_str += 'Money : ' + GameState.user.money;
			
			var general_content_label:TextField = new TextField();
			general_content_label.x							= general_title_label.x;
			general_content_label.y							= GameState.stageHeight * .225;
			general_content_label.width					= general_title_label.width;
			general_content_label.defaultTextFormat	= content_format;
			general_content_label.text						= general_content_str;
			general_content_label.selectable				= false;
			addChild(general_content_label);
			
			/*
			 * Games
			 */
			
			// Title games
			var game_title_label:TextField = new TextField();
			game_title_label.x							= GameState.stageWidth	* .25;
			game_title_label.y							= GameState.stageHeight	* .3;
			game_title_label.width					= GameState.stageWidth	* .5;
			game_title_label.height					= GameState.stageHeight	* .5;
			game_title_label.defaultTextFormat	= title_format;
			game_title_label.text						= 'Games';
			game_title_label.selectable				= false;
			addChild(game_title_label);
			
			// Adventure mode
			var adventure_sub_title_label:TextField = new TextField();
			adventure_sub_title_label.x							= GameState.stageWidth	* .05;
			adventure_sub_title_label.y							= GameState.stageHeight	* .375;
			adventure_sub_title_label.width						= GameState.stageWidth	* .3;
			adventure_sub_title_label.height						= GameState.stageHeight	* .1;
			adventure_sub_title_label.defaultTextFormat	= sub_title_format;
			adventure_sub_title_label.text							= 'Adventure';
			adventure_sub_title_label.selectable				= false;
			addChild(adventure_sub_title_label);
			
			var adventure:Array = GameState.user.games[Common.GAME_ADVENTURE_KEY];
			
			var adventure_str:String = new String();
			adventure_str += 'Score : '			+ adventure['score']				+ ' pts\n\n';
			adventure_str += 'Total metal : '		+ adventure['total_metal']		+ '\n';
			adventure_str += 'Total crystal : '	+ adventure['total_crystal']		+ '\n';
			adventure_str += 'Total money : '	+ adventure['total_money']	+ '\n\n';
			adventure_str += 'Total time : '		+ Tools.convertTimeToLabel(adventure['total_time'])	+ '\n';
			adventure_str += 'Best time : '		+ Tools.convertTimeToLabel(adventure['best_time'])	+ '\n';
			
			var adventure_content_label:TextField = new TextField();
			adventure_content_label.x							= adventure_sub_title_label.x;
			adventure_content_label.y							= GameState.stageHeight * .425;
			adventure_content_label.width					= adventure_sub_title_label.width;
			adventure_content_label.height					= GameState.stageHeight * .3;
			adventure_content_label.defaultTextFormat	= content_format;
			adventure_content_label.text						= adventure_str;
			adventure_content_label.selectable				= false;
			addChild(adventure_content_label);
			
			// Survival mode
			var survival_sub_title_label:TextField = new TextField();
			survival_sub_title_label.x							= GameState.stageWidth	* .35;
			survival_sub_title_label.y							= adventure_sub_title_label.y;
			survival_sub_title_label.width						= adventure_sub_title_label.width;
			survival_sub_title_label.height						= adventure_sub_title_label.height;
			survival_sub_title_label.defaultTextFormat	= sub_title_format;
			survival_sub_title_label.text						= 'Survival';
			survival_sub_title_label.selectable				= false;
			addChild(survival_sub_title_label);
			
			var survival:Array = GameState.user.games[Common.GAME_SURVIVAL_KEY];
			
			var survival_str:String = new String();
			survival_str += 'Score : '			+ survival['score']				+ ' pts\n\n';
			survival_str += 'Total metal : '	+ survival['total_metal']		+ '\n';
			survival_str += 'Total crystal : '	+ survival['total_crystal']	+ '\n';
			survival_str += 'Total money : '	+ survival['total_money']	+ '\n\n';
			survival_str += 'Total time : '		+ Tools.convertTimeToLabel(survival['total_time'])	+ '\n';
			survival_str += 'Best time : '		+ Tools.convertTimeToLabel(survival['best_time'])	+ '\n';
			
			var survival_content_label:TextField = new TextField();
			survival_content_label.x							= survival_sub_title_label.x;
			survival_content_label.y							= adventure_content_label.y;
			survival_content_label.width					= survival_sub_title_label.width;
			survival_content_label.height					= adventure_content_label.height;
			survival_content_label.defaultTextFormat	= content_format;
			survival_content_label.text						= survival_str;
			survival_content_label.selectable				= false;
			addChild(survival_content_label);
			
			// Duo mode
			var duo_sub_title_label:TextField = new TextField();
			duo_sub_title_label.x							= GameState.stageWidth * .65;
			duo_sub_title_label.y							= adventure_sub_title_label.y;
			duo_sub_title_label.width					= adventure_sub_title_label.width;
			duo_sub_title_label.height					= adventure_sub_title_label.height;
			duo_sub_title_label.defaultTextFormat	= sub_title_format;
			duo_sub_title_label.text						= 'Duo';
			duo_sub_title_label.selectable				= false;
			addChild(duo_sub_title_label);
			
			var duo:Array = GameState.user.games[Common.GAME_DUO_KEY];
			
			var duo_str:String = new String();
			duo_str += 'Score : '				+ duo['score']			+ ' pts\n\n';
			duo_str += 'Total metal : '		+ duo['total_metal']	+ '\n';
			duo_str += 'Total crystal : '	+ duo['total_crystal']	+ '\n';
			duo_str += 'Total money : '	+ duo['total_money']	+ '\n\n';
			duo_str += 'Total time : '		+ Tools.convertTimeToLabel(duo['total_time'])	+ '\n';
			duo_str += 'Best time : '		+ Tools.convertTimeToLabel(duo['best_time'])	+ '\n';
			
			var duo_content_label:TextField = new TextField();
			duo_content_label.x							= duo_sub_title_label.x;
			duo_content_label.y							= adventure_content_label.y;
			duo_content_label.width						= duo_sub_title_label.width;
			duo_content_label.height					= adventure_content_label.height;
			duo_content_label.defaultTextFormat	= content_format;
			duo_content_label.text						= duo_str;
			duo_content_label.selectable				= false;
			addChild(duo_content_label);
			
			/*
			 * Ranking
			 */
			
			// Title rankin
			var rank_title_label:TextField = new TextField();
			rank_title_label.x							= GameState.stageWidth	* .25;
			rank_title_label.y							= GameState.stageHeight	* .725;
			rank_title_label.width						= GameState.stageWidth	* .5;
			rank_title_label.height					= GameState.stageHeight	* .5;
			rank_title_label.defaultTextFormat	= title_format;
			rank_title_label.text						= 'Ranking';
			rank_title_label.selectable				= false;
			addChild(rank_title_label);
			
			for (var i:uint = 0; i < 4; i++)
			{
				var rank:XMLList = i == 0? response_rank.general: (i == 1? response_rank.adventure: (i == 2? response_rank.survival: response_rank.duo));
				
				var rank_sub_title_label:TextField = new TextField();
				rank_sub_title_label.x							= GameState.stageWidth	* .1 + GameState.stageWidth	* .2 * i;
				rank_sub_title_label.y							= GameState.stageHeight	* .8;
				rank_sub_title_label.width						= GameState.stageWidth	* .2;
				rank_sub_title_label.height						= GameState.stageHeight	* .1;
				rank_sub_title_label.defaultTextFormat	= sub_title_format;
				rank_sub_title_label.text							= i == 0? 'General': (i == 1? 'Adventure': (i == 2? 'Survival': 'Duo'));
				rank_sub_title_label.selectable				= false;
				addChild(rank_sub_title_label);
				
				rank.rank++;
				
				var rank_content_label:TextField = new TextField();
				rank_content_label.x							= GameState.stageWidth	* .1 + GameState.stageWidth	* .2 * i;
				rank_content_label.y							= GameState.stageHeight	* .85;
				rank_content_label.width					= GameState.stageWidth	* .2;
				rank_content_label.height					= GameState.stageHeight	* .1;
				rank_content_label.defaultTextFormat	= content_format;
				rank_content_label.text						= (rank.rank == 1? rank.rank + 'er': rank.rank + 'ème') + '  -  ' + rank.score + ' pts';
				rank_content_label.selectable				= false;
				addChild(rank_content_label);
			}
		}
	}
}