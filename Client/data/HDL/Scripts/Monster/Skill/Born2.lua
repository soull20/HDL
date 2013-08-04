skills["Born2"] =
{
	name = "Born2",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(0);
	end,
	
	Actions = 
	{
		["Born"] = 
		{
			name = "born2",
			loop = false,
			stance = "born",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "idle",
			
			IsReady = function(this)
				return true;
			end,
			
			
		},
	},	
}