skills["Born1"] =
{
	name = "Born1",
	
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
			name = "born1",
			loop = false,
			stance = "born",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "idle",
			
			IsReady = function(this)
				return true;
			end,
			
			Events = 
			{
				["Effect"] =
				{
						
				},	
			},
		},
	},	
}