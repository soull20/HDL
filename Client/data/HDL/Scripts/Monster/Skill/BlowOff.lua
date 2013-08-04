skills["BlowOff"] =
{
	name = "BlowOff",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetJumpAccel(-20);
	end,
	
	Leave = function(this)
		Self:SetJumpAccel(-9.8);
	end,
	
	Actions = 
	{
		["Up"] =
		{
			name = "blow_off_1",
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
						Self:SetMoveSpeed(Config.moveSpeed);
					end,	
				},
			}
				
		},	
		
		["Down"] = 
		{
			name = "blow_off_2",
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
						if Config.BlowOff.downEffect ~= 0 then
							Self:PlayLocalEffect(Config.BlowOff.downEffect);
						end
						
						this.action.skill:NextAction();
					end,	
				},
			}
		},
		
		["Land"] = 
		{
			name = "blow_off_3",
			loop = false,
			stance = "float",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "raise",
			
			Events =
			{
				["ActionBegin"] =
				{
					Func = function(this)
						Self:SetJumpSpeed(0);
						Self:SetMoveSpeed(0);
					end,	
				},
			}
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