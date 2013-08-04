skills["Float"] =
{
	name = "Float",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(0.0);
		Self:SetJumpAccel(0.0);
	end,
	
	Actions = 
	{
		["Up"] =
		{
			name = "air_float_up",
			loop = false,
			stance = "float",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "Down",
			
			IsReady = function(this)
				return true;
			end,
			
			Events =
			{
				["ActionBegin"] =
				{
					Func = function(this)
						Self:SetJumpSpeed(Config.jumpSpeed);
					end,	
				},
			}
				
		},	
		
		["Down"] = 
		{
			name = "air_float_down",
			loop = true,
			stance = "float",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "Land",
			
			Events =
			{
				["SysCollideDown"] =
				{
					Func = function(this)
						this.action.skill:NextAction();
					end,	
				},
				
				["ActionBegin"] =
				{
					Func = function(this)
						Self:SetJumpAccel(-20);
					end,	
				},
			}
		},
		
		["Land"] = 
		{
			name = "air_float_land",
			loop = false,
			stance = "float",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "raise",
		},
		
		["raise"] = 
		{
			name = "raise",
			loop = false,
			stance = "float",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "idle",
		},
	},	
}