package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.Improvement;
	
	/**
	 * Manage user improvements
	 * @author desweb
	 */
	public class ImprovementScene extends Scene
	{
		private var _is_loading:Boolean = false;
		
		private var _loader:LoaderFlash;
		
		private var _title_format						:TextFormat;
		private var _improvement_format		:TextFormat;
		private var _value_format					:TextFormat;
		private var _resource_valid_format		:TextFormat;
		private var _resource_invalid_format	:TextFormat;
		
		private var _reinitalize_btn:BtnFlash;
		
		private var _scroll			:ScrollManager;
		private var _content		:Sprite;
		private var _content_y	:int = 0;
		
		private var _buy_btns:Array = new Array();
		
		public function ImprovementScene() 
		{
			if (Common.IS_DEBUG) trace('create ImprovementScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			sceneReturn = Common.SCENE_GAME_MODE;
			
			// Title format
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
			format_title.bold = true;
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x							= GameState.stageWidth	* .25;
			title_label.y							= GameState.stageHeight	* .025;
			title_label.width						= GameState.stageWidth	* .5;
			title_label.height					= GameState.stageHeight	* .5;
			title_label.defaultTextFormat	= format_title;
			title_label.text						= 'Improvements';
			title_label.selectable				= false;
			addChild(title_label);
			
			// Description label
			var description_label:TextField = new TextField();
			description_label.x							= GameState.stageWidth	* .05;
			description_label.y							= GameState.stageHeight	* .1;
			description_label.width					= GameState.stageWidth	* .9;
			description_label.height					= GameState.stageHeight	* .5;
			description_label.defaultTextFormat	= Common.getPolicy('Arial', 0x00FFFF, 12);
			description_label.text						= 'Buy new defenses, weapons, special weapons and improve them to win.';
			description_label.selectable				= false;
			addChild(description_label);
			
			// Resource label
			var resource_label:TextField = new TextField();
			resource_label.x							= GameState.stageWidth	* .05;
			resource_label.y							= GameState.stageHeight	* .16;
			resource_label.width						= GameState.stageWidth	* .5;
			resource_label.height						= GameState.stageHeight	* .5;
			resource_label.defaultTextFormat	= Common.getPolicy('Arial', 0x00FFFF, 12);
			resource_label.text						= 'My resources : ' + GameState.user.metal + ' metal, ' + GameState.user.crystal + ' crystal, ' + GameState.user.money + ' money';
			resource_label.selectable				= false;
			addChild(resource_label);
			
			// Reinitialize button
			_reinitalize_btn = generateBtn('Reinitialize');
			_reinitalize_btn.x = GameState.stageWidth	* .775;
			_reinitalize_btn.y = GameState.stageHeight	* .025;
			_reinitalize_btn.scaleX =
			_reinitalize_btn.scaleY = .8;
			addChild(_reinitalize_btn);
			
			_reinitalize_btn.addEventListener(MouseEvent.CLICK, clickReinitializeBtn);
			
			// Format
			_title_format						= Common.getPolicy('Arial', 0x00FFFF, 15);
			_improvement_format		= Common.getPolicy('Arial', 0x00FFFF, 13);
			_value_format					= Common.getPolicy('Arial', 0x00FFFF, 11);
			_resource_valid_format		= Common.getPolicy('Arial', 0x00FF00, 11);
			_resource_invalid_format	= Common.getPolicy('Arial', 0xFF0000, 11);
			
			_title_format.align						= 'left';
			_improvement_format.align		= 'left';
			_value_format.align					= 'left';
			_resource_valid_format.align		= 'left';
			_resource_invalid_format.align	= 'left';
			_title_format.bold						= true;
			_improvement_format.bold			= true;
			
			// Improvement list
			_content = new Sprite();
			
			// Defenses
			generateTitleRow('Defenses');
			generateImprovementRow(Common.IMPROVEMENT_ARMOR_RESIST);
			
			if (GameState.user.improvements[Common.IMPROVEMENT_SHIELD_RESIST] == 0) generateNewImprovementRow('New defense : Shield', Common.IMPROVEMENT_SHIELD_RESIST);
			else
			{
				generateImprovementRow(Common.IMPROVEMENT_SHIELD_RESIST);
				generateImprovementRow(Common.IMPROVEMENT_SHIELD_REGEN);
				generateImprovementRow(Common.IMPROVEMENT_SHIELD_REPOP);
			}
			
			// Weapons
			generateTitleRow('Weapons');
			generateImprovementRow				(Common.IMPROVEMENT_GUN_DAMAGE);
			generateImprovementRow				(Common.IMPROVEMENT_GUN_CADENCE);
			generateSpecialImprovementRow	(Common.IMPROVEMENT_GUN_DOUBLE);
			
			if (GameState.user.improvements[Common.IMPROVEMENT_LASER_DAMAGE] == 0)	generateNewImprovementRow	('New weapon : Laser', Common.IMPROVEMENT_LASER_DAMAGE);
			else																														generateImprovementRow			(Common.IMPROVEMENT_LASER_DAMAGE);
			
			if (GameState.user.improvements[Common.IMPROVEMENT_MISSILE_DAMAGE] == 0) generateNewImprovementRow('New weapon : Missile', Common.IMPROVEMENT_MISSILE_DAMAGE);
			else
			{
				generateImprovementRow				(Common.IMPROVEMENT_MISSILE_DAMAGE);
				generateImprovementRow				(Common.IMPROVEMENT_MISSILE_CADENCE);
				generateSpecialImprovementRow	(Common.IMPROVEMENT_MISSILE_DOUBLE);
			}
			
			if (GameState.user.improvements[Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE] == 0) generateNewImprovementRow('New weapon : Missile search', Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE);
			else
			{
				generateImprovementRow(Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE);
				generateImprovementRow(Common.IMPROVEMENT_MISSILE_SEARCH_NUMBER);
			}
			
			generateSpecialImprovementRow	(Common.IMPROVEMENT_TRI_FORCE);
			
			// Special weapons
			generateTitleRow('Special weapons');
			generateSpecialImprovementRow(Common.IMPROVEMENT_IEM);
			generateSpecialImprovementRow(Common.IMPROVEMENT_BOMB);
			generateSpecialImprovementRow(Common.IMPROVEMENT_REINFORCE);
			
			_scroll = new ScrollManager(_content);
			addChild(_scroll);
		}
		
		private function generateTitleRow(title:String):void
		{
			var row_height:Number = GameState.stageHeight * .07;
			
			// Title row
			var row:Sprite = new Sprite();
			row.y = _content_y;
			
			_content_y += row_height;
			
			row.graphics.drawRect(0, 0, GameState.stageWidth * .9, row_height);
			row.graphics.endFill();
			
			// Title label
			var title_label:TextField = new TextField();
			title_label.x		= GameState.stageWidth	* .02;
			title_label.y		= GameState.stageHeight	* .01;
			title_label.width	= GameState.stageWidth	* .3;
			title_label.defaultTextFormat = _title_format;
			title_label.text = title;
			title_label.selectable = false;
			row.addChild(title_label);
			
			// Separator
			var separator_sprite:Sprite = new Sprite();
			separator_sprite.y = row_height - 1;
			separator_sprite.graphics.beginFill(0x00FFFF);
			separator_sprite.graphics.drawRect(0, 0, GameState.stageWidth * .9, 1);
			separator_sprite.graphics.endFill();
			row.addChild(separator_sprite);
			
			_content.addChild(row);
		}
		
		private function generateNewImprovementRow(title:String, key:String):void
		{
			var row_height:Number = GameState.stageHeight * .1;
			
			var improvement:Improvement = new Improvement(key);
			var user_improvement:int = GameState.user.improvements[key];
			
			// Improvement row
			var row:Sprite = new Sprite();
			row.y = _content_y + 1;
			
			_content_y += row_height;
			
			row.graphics.drawRect(0, 0, GameState.stageWidth * .9, row_height);
			row.graphics.endFill();
			
			// Improvement label
			var improvement_label:TextField = new TextField();
			improvement_label.x			= GameState.stageWidth	* .01;
			improvement_label.y			= GameState.stageHeight	* .025;
			improvement_label.width	= GameState.stageWidth	* .4;
			improvement_label.height	= GameState.stageHeight	* .05;
			improvement_label.defaultTextFormat = _improvement_format;
			improvement_label.text = title;
			improvement_label.selectable = false;
			row.addChild(improvement_label);
			
			// Buy btn
			var buy_btn:BtnFlash = generateBtn('Buy',
				GameState.user.metal	< improvement.price[user_improvement + 1]['metal'] || 
				GameState.user.crystal	< improvement.price[user_improvement + 1]['crystal'] ||
				GameState.user.money	< improvement.price[user_improvement + 1]['money']? 3: 1);
			buy_btn.name = key;
			buy_btn.x = GameState.stageWidth * .725;
			buy_btn.y = improvement_label.y;
			buy_btn.scaleX =
			buy_btn.scaleY = .6;
			row.addChild(buy_btn);
			
			buy_btn.addEventListener(MouseEvent.CLICK, clickBuyBtn);
			
			_buy_btns[_buy_btns.length] = buy_btn;
			
			// Metal label
			var metal_label:TextField = new TextField();
			metal_label.x			= GameState.stageWidth 	* .41;
			metal_label.y			= improvement_label.y;
			metal_label.width	= GameState.stageWidth * .1;
			metal_label.defaultTextFormat = GameState.user.metal < improvement.price[user_improvement+1]['metal']? _resource_invalid_format: _resource_valid_format;
			metal_label.text = 'Metal : ' + improvement.price[user_improvement+1]['metal'];
			metal_label.selectable = false;
			row.addChild(metal_label);
			
			// Crystal label
			var crystal_label:TextField = new TextField();
			crystal_label.x		= GameState.stageWidth * .51;
			crystal_label.y		= improvement_label.y;
			crystal_label.width	= metal_label.width;
			crystal_label.defaultTextFormat = GameState.user.crystal < improvement.price[user_improvement+1]['crystal']? _resource_invalid_format: _resource_valid_format;
			crystal_label.text = 'Crystal : ' + improvement.price[user_improvement+1]['crystal'];
			crystal_label.selectable = false;
			row.addChild(crystal_label);
			
			// Money label
			var money_label:TextField = new TextField();
			money_label.x		= GameState.stageWidth * .61;
			money_label.y		= improvement_label.y;
			money_label.width	= metal_label.width;
			money_label.defaultTextFormat = GameState.user.money < improvement.price[user_improvement+1]['money']? _resource_invalid_format: _resource_valid_format;
			money_label.text = 'Money : ' + improvement.price[user_improvement+1]['money'];
			money_label.selectable = false;
			row.addChild(money_label);
			
			_content.addChild(row);
		}
		
		private function generateImprovementRow(key:String):void
		{
			var row_height:Number = GameState.stageHeight * .15;
			
			var improvement:Improvement = new Improvement(key);
			var user_improvement:int = GameState.user.improvements[key];
			
			// Improvement row
			var row:Sprite = new Sprite();
			row.y = _content_y + 1;
			
			_content_y += row_height;
			
			row.graphics.drawRect(0, 0, GameState.stageWidth * .9, row_height);
			row.graphics.endFill();
			
			// Improvement label
			var improvement_label:TextField = new TextField();
			improvement_label.x			= GameState.stageWidth	* .01;
			improvement_label.y			= GameState.stageHeight	* 0;
			improvement_label.width	= GameState.stageWidth	* .2;
			improvement_label.height	= GameState.stageHeight	* .05;
			improvement_label.defaultTextFormat = _improvement_format;
			improvement_label.text = improvement.name;
			improvement_label.selectable = false;
			row.addChild(improvement_label);
			
			// Level bar
			var level_bar:ImprovementLevelFlash = new ImprovementLevelFlash();
			level_bar.x = GameState.stageWidth	* .01;
			level_bar.y = GameState.stageHeight	* .05;
			
			level_bar.gotoAndStop(user_improvement+1);
			
			row.addChild(level_bar);
			
			// Actually label
			var actually_label:TextField = new TextField();
			actually_label.x			= GameState.stageWidth	* .01;
			actually_label.y			= GameState.stageHeight	* .09;
			actually_label.width	= GameState.stageWidth	* .2;
			actually_label.defaultTextFormat = _value_format;
			actually_label.text = 'Actually : ' + improvement.value[user_improvement] + ' ' + improvement.type;
			actually_label.selectable = false;
			row.addChild(actually_label);
			
			if (user_improvement >= 5)
			{
				_content.addChild(row);
				return;
			}
			
			// Buy btn
			var buy_btn:BtnFlash = generateBtn('Buy',
				GameState.user.metal	< improvement.price[user_improvement + 1]['metal'] || 
				GameState.user.crystal	< improvement.price[user_improvement + 1]['crystal'] ||
				GameState.user.money	< improvement.price[user_improvement + 1]['money']? 3: 1);
			buy_btn.name = key;
			buy_btn.x = GameState.stageWidth * .725;
			buy_btn.y = level_bar.y;
			buy_btn.scaleX =
			buy_btn.scaleY = .6;
			row.addChild(buy_btn);
			
			buy_btn.addEventListener(MouseEvent.CLICK, clickBuyBtn);
			
			_buy_btns[_buy_btns.length] = buy_btn;
			
			// New label
			var new_label:TextField = new TextField();
			new_label.x		= GameState.stageWidth * .21;
			new_label.y		= actually_label.y;
			new_label.width	= actually_label.width;
			new_label.defaultTextFormat = _value_format;
			new_label.text = 'New : ' + improvement.value[user_improvement+1] + ' ' + improvement.type;
			new_label.selectable = false;
			row.addChild(new_label);
			
			// Metal label
			var metal_label:TextField = new TextField();
			metal_label.x			= GameState.stageWidth * .41;
			metal_label.y			= actually_label.y;
			metal_label.width	= GameState.stageWidth * .1;
			metal_label.defaultTextFormat = GameState.user.metal < improvement.price[user_improvement+1]['metal']? _resource_invalid_format: _resource_valid_format;
			metal_label.text = 'Metal : ' + improvement.price[user_improvement+1]['metal'];
			metal_label.selectable = false;
			row.addChild(metal_label);
			
			// Crystal label
			var crystal_label:TextField = new TextField();
			crystal_label.x		= GameState.stageWidth * .51;
			crystal_label.y		= actually_label.y;
			crystal_label.width	= metal_label.width;
			crystal_label.defaultTextFormat = GameState.user.crystal < improvement.price[user_improvement+1]['crystal']? _resource_invalid_format: _resource_valid_format;
			crystal_label.text = 'Crystal : ' + improvement.price[user_improvement+1]['crystal'];
			crystal_label.selectable = false;
			row.addChild(crystal_label);
			
			// Money label
			var money_label:TextField = new TextField();
			money_label.x		= GameState.stageWidth * .61;
			money_label.y		= actually_label.y;
			money_label.width	= metal_label.width;
			money_label.defaultTextFormat = GameState.user.money < improvement.price[user_improvement+1]['money']? _resource_invalid_format: _resource_valid_format;
			money_label.text = 'Money : ' + improvement.price[user_improvement+1]['money'];
			money_label.selectable = false;
			row.addChild(money_label);
			
			_content.addChild(row);
		}
		
		private function generateSpecialImprovementRow(key:String):void
		{
			var improvement:Improvement = new Improvement(key);
			var user_improvement:int = GameState.user.improvements[key];
			
			// Improvement row
			var row:Sprite = new Sprite();
			row.y = _content_y + 1;
			
			_content_y += GameState.stageHeight * .15;
			
			row.graphics.drawRect(0, 0, GameState.stageWidth * .9, GameState.stageHeight * .15);
			row.graphics.endFill();
			
			// Improvement label
			var improvement_label:TextField = new TextField();
			improvement_label.x			= GameState.stageWidth	* .01;
			improvement_label.y			= GameState.stageHeight	* 0;
			improvement_label.width	= GameState.stageWidth	* .2;
			improvement_label.height	= GameState.stageHeight	* .05;
			improvement_label.defaultTextFormat = _improvement_format;
			improvement_label.text = improvement.name;
			improvement_label.selectable = false;
			row.addChild(improvement_label);
			
			// Level bar
			var level_bar:SpecialImprovementLevelFlash = new SpecialImprovementLevelFlash();
			level_bar.x = GameState.stageWidth	* .01;
			level_bar.y = GameState.stageHeight	* .05;
			
			level_bar.gotoAndStop(user_improvement+1);
			
			row.addChild(level_bar);
			
			// Description label
			var description_label:TextField = new TextField();
			description_label.x			= GameState.stageWidth	* .01;
			description_label.y			= GameState.stageHeight	* .09;
			description_label.width	= GameState.stageWidth	* .3;
			description_label.defaultTextFormat = _value_format;
			description_label.text = improvement.description;
			description_label.selectable = false;
			row.addChild(description_label);
			
			if (user_improvement >= 1)
			{
				_content.addChild(row);
				return;
			}
			
			// Buy btn
			var buy_btn:BtnFlash = generateBtn('Buy',
				GameState.user.metal	< improvement.price[user_improvement + 1]['metal'] || 
				GameState.user.crystal	< improvement.price[user_improvement + 1]['crystal'] ||
				GameState.user.money	< improvement.price[user_improvement + 1]['money']? 3: 1);
			buy_btn.name = key;
			buy_btn.x = GameState.stageWidth * .725;
			buy_btn.y = level_bar.y;
			buy_btn.scaleX =
			buy_btn.scaleY = .6;
			row.addChild(buy_btn);
			
			buy_btn.addEventListener(MouseEvent.CLICK, clickBuyBtn);
			
			_buy_btns[_buy_btns.length] = buy_btn;
			
			// Metal label
			var metal_label:TextField = new TextField();
			metal_label.x			= GameState.stageWidth * .31;
			metal_label.y			= description_label.y;
			metal_label.width	= GameState.stageWidth * .15;
			metal_label.defaultTextFormat = GameState.user.metal < improvement.price[user_improvement+1]['metal']? _resource_invalid_format: _resource_valid_format;
			metal_label.text = 'Metal : ' + improvement.price[user_improvement+1]['metal'];
			metal_label.selectable = false;
			row.addChild(metal_label);
			
			// Crystal label
			var crystal_label:TextField = new TextField();
			crystal_label.x		= GameState.stageWidth * .46;
			crystal_label.y		= description_label.y;
			crystal_label.width	= metal_label.width;
			crystal_label.defaultTextFormat = GameState.user.crystal < improvement.price[user_improvement+1]['crystal']? _resource_invalid_format: _resource_valid_format;
			crystal_label.text = 'Crystal : ' + improvement.price[user_improvement+1]['crystal'];
			crystal_label.selectable = false;
			row.addChild(crystal_label);
			
			// Money label
			var money_label:TextField = new TextField();
			money_label.x		= GameState.stageWidth * .61;
			money_label.y		= description_label.y;
			money_label.width	= metal_label.width;
			money_label.defaultTextFormat = GameState.user.money < improvement.price[user_improvement+1]['money']? _resource_invalid_format: _resource_valid_format;
			money_label.text = 'Money : ' + improvement.price[user_improvement+1]['money'];
			money_label.selectable = false;
			row.addChild(money_label);
			
			_content.addChild(row);
		}
		
		/**
		 * Override
		 */
		
		override public function destroy():void
		{
			if (Common.IS_DEBUG) trace('destroy ImprovementScene');
			
			for each (var buy_btn:BtnFlash in _buy_btns)
				buy_btn.removeEventListener(MouseEvent.CLICK, clickBuyBtn);
			
			_reinitalize_btn.removeEventListener(MouseEvent.CLICK, clickReinitializeBtn);
			
			super.destroy();
		}
		
		/**
		 * Events
		 */
		
		private function clickBuyBtn(e:MouseEvent):void
		{
			if (_is_loading) return;
			
			var improvement:Improvement = new Improvement(e.target.name);
			var user_improvement:int = GameState.user.improvements[e.target.name];
			
			if (GameState.user.metal	< improvement.price[user_improvement + 1]['metal'] || 
				GameState.user.crystal	< improvement.price[user_improvement + 1]['crystal'] ||
				GameState.user.money	< improvement.price[user_improvement + 1]['money'])
			{
				displayErrorPopup('You need more resources.');
				return;
			}
			
			e.target.visible = false;
			
			GameState.user.metal	-= improvement.price[user_improvement + 1]['metal'];
			GameState.user.crystal	-= improvement.price[user_improvement + 1]['crystal'];
			GameState.user.money	-= improvement.price[user_improvement + 1]['money'];
			GameState.user.improvements[e.target.name]++;
			
			if (e.target.name == Common.IMPROVEMENT_SHIELD_RESIST && 
				GameState.user.improvements[Common.IMPROVEMENT_SHIELD_RESIST]	== 1 && 
				GameState.user.improvements[Common.IMPROVEMENT_SHIELD_REGEN]	== 0 && 
				GameState.user.improvements[Common.IMPROVEMENT_SHIELD_REPOP]	== 0)
			{
				GameState.user.improvements[Common.IMPROVEMENT_SHIELD_REGEN]	++;
				GameState.user.improvements[Common.IMPROVEMENT_SHIELD_REPOP]	++;
			}
			else if (e.target.name == Common.IMPROVEMENT_MISSILE_DAMAGE && 
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_DAMAGE]		== 1 && 
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_CADENCE]	== 0)
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_CADENCE]++;
			else if (e.target.name == Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE && 
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE]	== 1 && 
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_SEARCH_NUMBER]	== 0)
				GameState.user.improvements[Common.IMPROVEMENT_MISSILE_SEARCH_NUMBER]++;
			
			if (GameState.user.isLog)
			{
				var loader:LoaderFlash = new LoaderFlash();
				loader.x = e.target.x + (e.target.width		/ 2);
				loader.y = e.target.y + (e.target.height	/ 2);
				loader.scaleX = 
				loader.scaleY = .4;
				e.target.parent.addChild(loader);
				
				loader.addEventListener(Event.ENTER_FRAME, updateLoader);
				
				API.post_improvementKey(e.target.name, GameState.user.improvements[e.target.name],
				function(response:XML):void
				{
					API.post_userStat(function(response:XML):void
					{
						e.target.parent.removeChild(loader);
						
						loader.removeEventListener(Event.ENTER_FRAME, updateLoader);
						loader = null;
						
						SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT, 1);
					});
				});
			}
			else SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT, 1);
		}
		
		private function clickReinitializeBtn(e:MouseEvent):void
		{
			if (_is_loading) return;
			
			e.target.visible = false;
			
			var metal		:int = 0;
			var crystal		:int = 0;
			var money	:int = 0;
			
			for (var key:String in GameState.user.improvements)
			{
				if (GameState.user.improvements[key] == 0) continue;
				
				var limit:int = 0;
				
				if (key == Common.IMPROVEMENT_ARMOR_RESIST	|| 
					key == Common.IMPROVEMENT_GUN_DAMAGE		|| 
					key == Common.IMPROVEMENT_GUN_CADENCE)
					limit = 1;
				
				while (GameState.user.improvements[key] > limit)
				{
					var improvement:Improvement = new Improvement(key);
					
					if (improvement.price[GameState.user.improvements[key]])
					{
						metal	+= improvement.price[GameState.user.improvements[key]]['metal'];
						crystal	+= improvement.price[GameState.user.improvements[key]]['crystal'];
						money	+= improvement.price[GameState.user.improvements[key]]['money'];
					}
					
					GameState.user.improvements[key]--;
				}
			}
			
			GameState.user.improvements[Common.IMPROVEMENT_ARMOR_RESIST]	=
			GameState.user.improvements[Common.IMPROVEMENT_GUN_DAMAGE]	=
			GameState.user.improvements[Common.IMPROVEMENT_GUN_CADENCE]	= 1;
			
			GameState.user.metal	+= metal;
			GameState.user.crystal	+= crystal;
			GameState.user.money	+= money;
			
			if (GameState.user.isLog)
			{
				var loader:LoaderFlash = new LoaderFlash();
				loader.x = e.target.x + (e.target.width		/ 2);
				loader.y = e.target.y + (e.target.height	/ 2);
				loader.scaleX = 
				loader.scaleY = .4;
				e.target.parent.addChild(loader);
				
				loader.addEventListener(Event.ENTER_FRAME, updateLoader);
				
				API.post_improvementInititalize(function(response:XML):void
				{
					API.post_userStat(function(response:XML):void
					{
						e.target.parent.removeChild(loader);
						
						loader.removeEventListener(Event.ENTER_FRAME, updateLoader);
						loader = null;
						
						SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT, 1);
					});
				});
			}
			else SceneManager.getInstance().setCurrentScene(Common.SCENE_IMPROVEMENT, 1);
		}
		
		private function updateLoader(e:Event):void
		{
			e.target.rotation += 10;
		}
	}
}