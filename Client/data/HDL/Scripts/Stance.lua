stance["stand_free"] =
{
	["Rigide"] = function(name, args)
		Config.rigidTime = args["Time"];
		SkillMgr:PlaySkill("Rigide");
	end,
	
	["Float"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = 0;
		SkillMgr:PlaySkill("Float");
	end,
	
	["BlowOff"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = args["MoveSpeed"];
		SkillMgr:PlaySkill("BlowOff");
	end,
	
	["Dismembered"] = function(name, args)
		SkillMgr:PlaySkill("Dismembered");
	end,
}

stance["ground_action"] =
{
	["Rigide"] = function(name, args)
		Config.rigidTime = args["Time"];
		SkillMgr:PlaySkill("Rigide");
	end,
	
	["Float"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = 0;
		SkillMgr:PlaySkill("Float");
	end,
	
	["BlowOff"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = args["MoveSpeed"];
		SkillMgr:PlaySkill("BlowOff");
	end,
	
	["Dismembered"] = function(name, args)
		SkillMgr:PlaySkill("Dismembered");
	end,
}

stance["rigide"] =
{
	["Rigide"] = function(name, args)
		Config.rigidTime = args["Time"];
		SkillMgr:PlaySkill("RigideSecond");
	end,
	
	["Float"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = 0;
		SkillMgr:PlaySkill("Float");
	end,
	
	["BlowOff"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = args["MoveSpeed"];
		SkillMgr:PlaySkill("BlowOff");
	end,
	
	["Dismembered"] = function(name, args)
		SkillMgr:PlaySkill("Dismembered");
	end,
}

stance["rigidsecond"] =
{
	["Rigide"] = function(name, args)
		Config.rigidTime = args["Time"];
		SkillMgr:PlaySkill("Rigide");
	end,
	
	["Float"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = 0;
		SkillMgr:PlaySkill("Float");
	end,
	
	["BlowOff"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = args["MoveSpeed"];
		SkillMgr:PlaySkill("BlowOff");
	end,
	
	["Dismembered"] = function(name, args)
		SkillMgr:PlaySkill("Dismembered");
	end,
}

stance["down"] =
{

	

}

stance["float"] =
{
	
	["Float"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = 0;
		SkillMgr:PlaySkill("FloatHit");
	end,
	
	["BlowOff"] = function(name, args)
		Config.jumpSpeed = args["JumpSpeed"];
		Config.moveSpeed = args["MoveSpeed"];
		SkillMgr:PlaySkill("BlowOff");
	end,
}