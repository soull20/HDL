skills[1111011] = 
{
	name = "ÆÕÍ¨¹¥»÷µÚÒ»»÷",
	Actions = 
	{
		[1] = 
		{
			name = "attack1",
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
				["ActionBegin"] =
				{
					Func = function(this)
						
					end,	
				},
				
				["ActionEnd"] =
				{
					Func = function(this)
						
					end,	
				},
				
				["NextBegin"] = 
				{
					time = 0.5,	
					Func = function(this)
						Self:DebugPrint("nextbegin");
					end,
				},
				
				["NextEnd"] =
				{	
					Func = function(this)
						Self:DebugPrint("nextend");
					end,
				},
				
				["Attack"] = 
				{
					time = 0.37,
					Func = function(this)
						Self:PlayGlobalEffect{id = 11110112};
					end,
				},	
				
				["StartSwordLight"] =
				{
					time = 0.31,
					Func = function(this)
						Self:StartSwordLight
						{
							viewTime = 0.3,
							tex = "TrailLight/Textures/MUX_Trail08.dds",
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
				
				["End"] =
				{
					time = 0.24,
					Func = function(this)
					end,	
				},
				
				["Sound"] = 
				{
					time = 0.17,
					Func = function(this)
						Self:PlaySound{path="atk-hammer-01.wav", time = 1.0, volume = 1.0, distance = 10};
					end,
				},	
			},
		},	
	},
	
	IsReady = function()
		return true;
	end,
}