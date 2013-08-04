skills["Run"] =
{
	name = "Run",
	
	IsReady = function(this)
		return true;
	end, 
	
	Enter = function(this)
		Self:SetMoveSpeed(Config.moveSpeed);
	end,
	
	Leave = function(this)
		Self:SetMoveSpeed(0.0);
	end,
	
	Actions = 
	{
		["Run"] =
		{
			name = "run",
			loop = true,
			stance = "move",
			weapon = 0,
			switch = 1,
			priority = 0,
			
			IsReady = function(this)
				return Config.moveSpeed >= 5;
			end,
			
			Events = 
			{
				["LStep"] =
				{
					time = Config.Run.leftStepEventTime,
					Func = function(this)
						Self:PlaySound{path=Config.Run.leftStepSound, time = 1.0, volume = 1.0, distance = 10};
					end,	
				},	
				
				["RStep"] =
				{
					time = Config.Run.rightStepEventTime,
					Func = function(this)
						Self:PlaySound{path=Config.Run.rightStepSound, time = 1.0, volume = 1.0, distance = 10};
					end,	
				},	
			},
		},	
		
		["Walk"] =
		{
			name = "walk",
			loop = true,
			stance = "move",
			weapon = 0,
			switch = 1,
			priority = 0,
			
			IsReady = function(this)
				return Config.moveSpeed < 5;
			end,
			
			Events = 
			{
				["LStep"] =
				{
					time = Config.Walk.leftStepEventTime,
					Func = function(this)
						Self:PlaySound{path=Config.Walk.leftStepSound, time = 1.0, volume = 1.0, distance = 10};
					end,	
				},	
				
				["RStep"] =
				{
					time = Config.Walk.rightStepEventTime,
					Func = function(this)
						Self:PlaySound{path=Config.Walk.rightStepSound, time = 1.0, volume = 1.0, distance = 10};
					end,	
				},	
			},
		},	
	},	
}