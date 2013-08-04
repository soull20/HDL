skills["Death"] =
{
	name = "Death",
	nextSkill = "Die",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(0);
	end,
	
	Actions = 
	{
		["Death"] =
		{
			name = "death",
			loop = false,
			stance = "death",
			weapon = 0,
			switch = 0,
			priority = 0,
			nextAction = "lie",
			
			IsReady = function(this)
				return true;
			end,
		},	
	},	
}