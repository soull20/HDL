skills["Rigide"] =
{
	name = "Rigide",
	randAction = {1, 2, 3,},
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		
	end,
	
	Actions = 
	{
		[1] = 
		{
			name = "hit1",
			loop = false,
			stance = "rigide",	
			weapon = 1,
			switch = 0,
			priority = 0,
			nextAction = "idle",
			
			IsReady = function(this)
				return true;
			end,
			
			Events =
			{
				["Rigide"] =
				{
					time = 0.1,
					
					Func = function(this)
						this.action:Pause(Config.rigidTime);
					end,	
				},
			},
		},
		
		[2] = 
		{
			name = "hit2",
			loop = false,
			stance = "rigide",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "idle",
			
			IsReady = function(this)
				return true;
			end,
			
			Events =
			{
				["Rigide"] =
				{
					time = 0.1,
					
					Func = function(this)
						this.action:Pause(Config.rigidTime);
					end,	
				},
			},
		},
		
		[3] = 
		{
			name = "hit3",
			loop = false,
			stance = "rigide",	
			weapon = 1,
			switch = 0,
			priority = 1,
			nextAction = "idle",
			
			IsReady = function(this)
				return true;
			end,
			
			Events =
			{
				["Rigide"] =
				{
					time = 0.1,
					
					Func = function(this)
						this.action:Pause(Config.rigidTime);
					end,	
				},
			},
		},
	},	
}