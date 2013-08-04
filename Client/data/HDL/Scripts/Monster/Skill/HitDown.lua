skills["HitDown"] =
{
	name = "HitDown",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(0);
	end,
	
	Actions = 
	{
		["down"] = 
		{
			name = "down",
			loop = false,
			stance = "down",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "lie",
			
			IsReady = function(this)
				return true;
			end,
		},
		
		["lie"] = 
		{
			name = "lie",
			loop = false,
			stance = "down",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "raise",
		},
		
		["raise"] = 
		{
			name = "raise",
			loop = false,
			stance = "down",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "idle",
		},
	},	
}