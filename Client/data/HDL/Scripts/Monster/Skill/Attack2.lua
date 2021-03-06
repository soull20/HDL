skills[Config.Attack2.skillID] = 
{
	name = "��ͨ����1",
	Actions = 
	{
		[1] = 
		{
			name = "attack2",
			loop = false,
			stance = "ground_action",
			weapon = true,
			switch = true,
			priority = 0,
			nextAction = "idle",
			
			IsReady = function()
				return true;
			end,
			
			Events = 
			{
				["Attack1"] = 
				{
					time = Config.Attack2.Attack1.time,
					Func = function(this)
						Self:PlayGlobalEffect{id = Config.Attack2.Attack1.effectID,};
					end,
				},	
				
				["StartSwordLight1"] =
				{
					time = Config.Attack2.SwordLight1.startTime,
					Func = function(this)
						Self:StartSwordLight
						{
							tex = Config.Attack2.SwordLight1.tex,
							noise = "",
							time = 0.3,
							dispTime = 0.1,
							bone1 = "FX_Weapon_01",
							bone2 = "FX_Weapon_02",
							hand = "body",
							color = {1.0, 1.0, 1.0,},
						};
					end,	
				},
				
				["Attack2"] = 
				{
					time = Config.Attack2.Attack2.time,
					Func = function(this)
						Self:PlayGlobalEffect{id = Config.Attack2.Attack2.effectID,};
					end,
				},	
				
				["StartSwordLight2"] =
				{
					time = Config.Attack2.SwordLight2.startTime,
					Func = function(this)
						Self:StartSwordLight
						{
							tex = Config.Attack2.SwordLight2.tex,
							noise = "",
							time = 0.3,
							dispTime = 0.1,
							bone1 = "FX_Weapon_01",
							bone2 = "FX_Weapon_02",
							hand = "body",
							color = {1.0, 1.0, 1.0,},
						};
					end,	
				},
				
				["Sound"] = 
				{
					time = 0.17,
					Func = function(this)
						Self:PlaySound{path=Config.Attack2.Sound.sound, time = 1.0, volume = 1.0, distance = 10};
					end,
				},	
			},
		},	
	},
	
	IsReady = function()
		return true;
	end,
}