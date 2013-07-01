package core 
{
	/**
	 * ...
	 * @author desweb
	 */
	public class Improvement 
	{
		public var name			:String;
		public var type			:String;
		public var description	:String;
		
		public var price	:Array;
		public var value	:Array;
		
		public function Improvement(key:String) 
		{
			price		= new Array();
			value	= new Array();
			
			for (var i:int = 1; i <= 5; i++)
			{
				price[i] = new Array();
				price[i]['metal']		= 0;
				price[i]['crystal']	= 0;
				price[i]['money']	= 0;
				
				value[i] = 0;
			}
			
			switch (key)
			{
				case Common.IMPROVEMENT_ARMOR_RESIST:
					name	= 'Armor resistance';
					type		= 'armor';
					
					value[1] = 10;
					value[2] = 15;
					value[3] = 20;
					value[4] = 30;
					value[5] = 50;
					
					price[2]['metal']		= 20;
					price[2]['crystal']	= 0;
					price[2]['money']	= 30;
					
					price[3]['metal']		= 60;
					price[3]['crystal']	= 0;
					price[3]['money']	= 80;
					
					price[4]['metal']		= 120;
					price[4]['crystal']	= 0;
					price[4]['money']	= 160;
					
					price[5]['metal']		= 200;
					price[5]['crystal']	= 0;
					price[5]['money']	= 260;
					break;
				
				case Common.IMPROVEMENT_SHIELD_RESIST:
					name	= 'Shield resistance';
					type		= 'armor';
					
					value[0] = 0;
					value[1] = 5;
					value[2] = 10;
					value[3] = 15;
					value[4] = 20;
					value[5] = 30;
					
					price[1]['metal']		= 0;
					price[1]['crystal']	= 100;
					price[1]['money']	= 140;
					
					price[2]['metal']		= 0;
					price[2]['crystal']	= 60;
					price[2]['money']	= 90;
					
					price[3]['metal']		= 0;
					price[3]['crystal']	= 100;
					price[3]['money']	= 140;
					
					price[4]['metal']		= 0;
					price[4]['crystal']	= 160;
					price[4]['money']	= 220;
					
					price[5]['metal']		= 0;
					price[5]['crystal']	= 240;
					price[5]['money']	= 320;
					break;
				
				case Common.IMPROVEMENT_SHIELD_REGEN:
					name	= 'Shield regeneration';
					type		= 'armor / s';
					
					value[1] = .25;
					value[2] = .5;
					value[3] = .75;
					value[4] = 1;
					value[5] = 2;
					
					price[2]['metal']		= 0;
					price[2]['crystal']	= 30;
					price[2]['money']	= 40;
					
					price[3]['metal']		= 0;
					price[3]['crystal']	= 50;
					price[3]['money']	= 70;
					
					price[4]['metal']		= 0;
					price[4]['crystal']	= 80;
					price[4]['money']	= 100;
					
					price[5]['metal']		= 0;
					price[5]['crystal']	= 120;
					price[5]['money']	= 150;
					break;
				
				case Common.IMPROVEMENT_SHIELD_REPOP:
					name	= 'Shield recurrence';
					type		= 's';
					
					value[1] = 30;
					value[2] = 25;
					value[3] = 20;
					value[4] = 15;
					value[5] = 10;
					
					price[2]['metal']		= 0;
					price[2]['crystal']	= 50;
					price[2]['money']	= 60;
					
					price[3]['metal']		= 0;
					price[3]['crystal']	= 80;
					price[3]['money']	= 100;
					
					price[4]['metal']		= 0;
					price[4]['crystal']	= 120;
					price[4]['money']	= 140;
					
					price[5]['metal']		= 0;
					price[5]['crystal']	= 180;
					price[5]['money']	= 220;
					break;
				
				case Common.IMPROVEMENT_GUN_DAMAGE:
					name	= 'Gun damage';
					type		= 'damage';
					
					value[1] = 1;
					value[2] = 3;
					value[3] = 6;
					value[4] = 10;
					value[5] = 15;
					
					price[2]['metal']		= 20;
					price[2]['crystal']	= 0;
					price[2]['money']	= 30;
					
					price[3]['metal']		= 30;
					price[3]['crystal']	= 0;
					price[3]['money']	= 50;
					
					price[4]['metal']		= 60;
					price[4]['crystal']	= 0;
					price[4]['money']	= 80;
					
					price[5]['metal']		= 100;
					price[5]['crystal']	= 0;
					price[5]['money']	= 140;
					break;
				
				case Common.IMPROVEMENT_GUN_CADENCE:
					name	= 'Gun cadence';
					type		= 's charging';
					
					value[1] = .5;
					value[2] = .45;
					value[3] = .4;
					value[4] = .3;
					value[5] = .2;
					
					price[2]['metal']		= 40;
					price[2]['crystal']	= 0;
					price[2]['money']	= 60;
					
					price[3]['metal']		= 60;
					price[3]['crystal']	= 0;
					price[3]['money']	= 90;
					
					price[4]['metal']		= 90;
					price[4]['crystal']	= 0;
					price[4]['money']	= 120;
					
					price[5]['metal']		= 120;
					price[5]['crystal']	= 0;
					price[5]['money']	= 160;
					break;
				
				case Common.IMPROVEMENT_GUN_DOUBLE:
					name			= 'Gun double';
					description	= 'Fire 2 guns.';
					
					price[1]['metal']		= 300;
					price[1]['crystal']	= 0;
					price[1]['money']	= 400;
					break;
				
				case Common.IMPROVEMENT_LASER_DAMAGE:
					name	= 'Laser damage';
					type		= 'damage';
					
					value[1] = 1;
					value[2] = 2;
					value[3] = 3;
					value[4] = 4;
					value[5] = 10;
					
					price[1]['metal']		= 0;
					price[1]['crystal']	= 40;
					price[1]['money']	= 50;
					
					price[2]['metal']		= 0;
					price[2]['crystal']	= 60;
					price[2]['money']	= 80;
					
					price[3]['metal']		= 0;
					price[3]['crystal']	= 120;
					price[3]['money']	= 150;
					
					price[4]['metal']		= 0;
					price[4]['crystal']	= 200;
					price[4]['money']	= 240;
					
					price[5]['metal']		= 0;
					price[5]['crystal']	= 300;
					price[5]['money']	= 360;
					break;
				
				case Common.IMPROVEMENT_MISSILE_DAMAGE:
					name	= 'Missile damage';
					type		= 'damage';
					
					value[1] = 2;
					value[2] = 6;
					value[3] = 12;
					value[4] = 20;
					value[5] = 30;
					
					price[1]['metal']		= 80;
					price[1]['crystal']	= 0;
					price[1]['money']	= 100;
					
					price[2]['metal']		= 60;
					price[2]['crystal']	= 0;
					price[2]['money']	= 80;
					
					price[3]['metal']		= 100;
					price[3]['crystal']	= 0;
					price[3]['money']	= 130;
					
					price[4]['metal']		= 160;
					price[4]['crystal']	= 0;
					price[4]['money']	= 200;
					
					price[5]['metal']		= 240;
					price[5]['crystal']	= 0;
					price[5]['money']	= 300;
					break;
				
				case Common.IMPROVEMENT_MISSILE_CADENCE:
					name	= 'Missile cadence';
					type		= 's charging';
					
					value[1] = 1.5;
					value[2] = 1.25;
					value[3] = 1;
					value[4] = .75;
					value[5] = .5;
					
					price[2]['metal']		= 50;
					price[2]['crystal']	= 0;
					price[2]['money']	= 60;
					
					price[3]['metal']		= 120;
					price[3]['crystal']	= 0;
					price[3]['money']	= 140;
					
					price[4]['metal']		= 200;
					price[4]['crystal']	= 0;
					price[4]['money']	= 240;
					
					price[5]['metal']		= 300;
					price[5]['crystal']	= 0;
					price[5]['money']	= 360;
					break;
				
				case Common.IMPROVEMENT_MISSILE_DOUBLE:
					name			= 'Missile double';
					description	= 'Fire 2 missiles.';
					
					price[1]['metal']		= 400;
					price[1]['crystal']	= 0;
					price[1]['money']	= 500;
					break;
				
				case Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE:
					name	= 'Missile search damage';
					type		= 'damage';
					
					value[1] = 5;
					value[2] = 10;
					value[3] = 20;
					value[4] = 35;
					value[5] = 50;
					
					price[1]['metal']		= 160;
					price[1]['crystal']	= 0;
					price[1]['money']	= 200;
					
					price[2]['metal']		= 120;
					price[2]['crystal']	= 0;
					price[2]['money']	= 160;
					
					price[3]['metal']		= 200;
					price[3]['crystal']	= 0;
					price[3]['money']	= 260;
					
					price[4]['metal']		= 320;
					price[4]['crystal']	= 0;
					price[4]['money']	= 400;
					
					price[5]['metal']		= 480;
					price[5]['crystal']	= 0;
					price[5]['money']	= 600;
					break;
				
				case Common.IMPROVEMENT_MISSILE_SEARCH_NUMBER:
					name	= 'Missile search number';
					type		= 'missiles';
					
					value[1] = 1;
					value[2] = 2;
					value[3] = 4;
					value[4] = 6;
					value[5] = 8;
					
					price[2]['metal']		= 100;
					price[2]['crystal']	= 0;
					price[2]['money']	= 120;
					
					price[3]['metal']		= 240;
					price[3]['crystal']	= 0;
					price[3]['money']	= 280;
					
					price[4]['metal']		= 400;
					price[4]['crystal']	= 0;
					price[4]['money']	= 480;
					
					price[5]['metal']		= 600;
					price[5]['crystal']	= 0;
					price[5]['money']	= 720;
					break;
				
				case Common.IMPROVEMENT_TRI_FORCE:
					name			= 'Tri force';
					description	= 'All weapons fire in 3 directions.';
					
					price[1]['metal']		= 1500;
					price[1]['crystal']	= 1500;
					price[1]['money']	= 2000;
					break;
				
				case Common.IMPROVEMENT_IEM:
					name			= 'IEM';
					description	= 'Launch an IEM.';
					
					price[1]['metal']		= 0;
					price[1]['crystal']	= 300
					price[1]['money']	= 400;
					break;
				
				case Common.IMPROVEMENT_BOMB:
					name			= 'Bomb';
					description	= 'Launch a bombardment.';
					
					price[1]['metal']		= 400;
					price[1]['crystal']	= 0;
					price[1]['money']	= 500;
					break;
				
				case Common.IMPROVEMENT_REINFORCE:
					name			= 'Reinforce';
					description	= 'Call reinforcements.';
					
					price[1]['metal']		= 500;
					price[1]['crystal']	= 500;
					price[1]['money']	= 1000;
					break;
			}
		}
	}
}