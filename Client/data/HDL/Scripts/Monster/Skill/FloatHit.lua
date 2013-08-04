skills["FloatHit"] =
{
	name = "FloatHit",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(Config.moveSpeed);
		Self:SetJumpSpeed(Config.jumpSpeed);
		Self:SetJumpAccel(0.0);
	end,
	
	Actions = 
	{
		["Up"] =
		{
			name = "air_float_hit",
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
				["Top"] =
				{
					time = 0.2,
					Func = function(this)
						Self:SetJumpSpeed(0.0);
					end,	
				},
			}
				
		},	
		
		["Down"] = 
		{
			name = "air_float_down",
			loop = false,
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
						Self:SetMoveSpeed(0.0);
					end,	
				},
				
				["ActionBegin"] =
				{
					Func = function(this)
						Self:SetJumpAccel(-20.0);
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