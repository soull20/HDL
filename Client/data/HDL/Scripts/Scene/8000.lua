dofile("../Data/HDL//Scripts/Scene/Common.lua");

--[[
--触发器1
triggers[1] =
{
	Enter = function(self)
		scene:CreateMonsterGroup(1);
	end,
}

--触发器2
triggers[2] =
{
	Enter = function(self)
		scene:CreateMonsterGroup(2);
	end,
}

--触发器3
triggers[3] =
{
	Enter = function(self)
		scene:CreateMonsterGroup(3);
	end,
}

--触发器4
triggers[4] =
{
	Enter = function(self)
		scene:CreateMonsterGroup(4);
	end,
}

--触发器5
triggers[5] =
{
	Enter = function(self)
		scene:CreateMonsterGroup(5);
	end,
}
]]