skills = {}
stance = {}
SkillCtrl = {}

EventFunc = 
{
	Init = function(this, action)
		this.action = action;
	end,
	
	Update =  function(this)
		if this.time == nil then
			return;
		end
		
		if this.triggered == false and Self:Time() - this.beginTime >= this.time then
			this.triggered = true;
			
			if this.Func ~= nil then
				this:Func();
			end
		end
	end,
	
	SysEnter = function(this)
		this.beginTime = Self:Time();
		this.triggered = false;
	end,
	
	SysLeave = function(this)
	end,
}

ActionFunc =
{
	Init = function(this, skill)
		this.skill = skill;
		
		local skillAction = this.skill.Actions[this.nextAction];
		if skillAction ~= nil then
			this.time = Self:GetActionTime(this.name, skillAction.name);
		else
			this.time = Self:GetActionTime(this.name, this.nextAction);
		end
		
		--将动作时间设置为特定长度
		--if this.fixTime ~= nil then
		--	this.time = this.fixTime;
		--end
		
		if this.Events ~= nil then
			for k in pairs(this.Events) do
				SetTableFunc(this.Events[k], EventFunc);
				this.Events[k]:Init(this);
			end
		end
	end,
	
	SysEnter = function(this, isLoopEnter)
		Self:DebugPrint("[lua]Action Enter:" .. this.name .. " " .. this.time);
		--Self:ChangeAction(this.name);
		Self:SetUpbody(this.upbody);
		Self:SetStance(this.stance);
		this.beginTime = Self:Time();
		this.isActive = true;
		this.isPaused = false;
		this.pauseTime = 0;
		
		if isLoopEnter == nil then
			this.leftTime = this.fixTime;
		end
		
		if this.skill.isCollideDown then
			this:OnEvent("SysCollideDown");
		end
		
		if this.Events ~= nil then
			for k, v in pairs(this.Events) do
				v:SysEnter();
			end
			
			if this.Events.ActionBegin ~= nil then
				this.Events.ActionBegin:Func();
			end
		end
	end,
	
	SysLeave = function(this)
		if this.Events ~= nil then
			for k, v in pairs(this.Events) do
				v:SysLeave();
			end
			
			if this.Events.ActionEnd ~= nil then
				this.Events.ActionEnd:Func();
			end
		end
		
		Self:CancelEffect("ACTION");
	end,
	
	OnEvent = function(this, name, args)
		Self:DebugPrint("event:" .. name .. "------------------------");
		
		if this.Events ~= nil then
			local ent = this.Events[name];
			if ent ~= nil then
				ent.args = args;
				ent:Func();
			end
		end
		
		Self:DebugPrint("stance:" .. this.stance .. "------------------------");
		local curStance = stance[this.stance];
		if curStance ~= nil then
			local funcName = curStance[name];
			if funcName ~= nil then
				funcName(name, args);
			end
		end
	end,
	
	Update = function(this)
		if this.isActive == false then
			return;
		end
		
		if this.leftTime ~= nil then
			this.leftTime = this.leftTime - Self:TimeDelta();
			if this.leftTime <= 0 then
				this.isActive = false;
				
				return;
			end
		end
		
		if this.isPaused then
			local timeDelta = Self:TimeDelta();
			
			this.pauseTime = this.pauseTime - timeDelta;
			if this.pauseTime < 0 then
				this:Resume();
			else	
				this.beginTime = this.beginTime + timeDelta;
				
				if this.Events ~= nil then
					for k, v in pairs(this.Events) do
						v.beginTime = v.beginTime + timeDelta;
					end
				end
				
				return;
			end
		end
		
		if (Self:Time() - this.beginTime >= this.time) then
			if this.loop then
				this:SysEnter(true);
			else
				this.isActive = false;	
			end
		end
		
		if this.Events ~= nil then
			for k, v in pairs(this.Events) do
				v:Update();
			end
		end
		
		--上下半身分割的技能全身的动作早客户端来设置
		if this.upbody == nil then
			Self:ChangeAction(this.name);
		end
	end,
	
	IsEventTriggered = function(this, eventName)
		if this.Events ~= nil then
			for k, v in pairs(this.Events) do
				if k == eventName and v.triggered then
					return true;
				end
			end
		end
		
		return false;
	end,
	
	Pause = function(this, t)
		Self:PauseAction();
		this.isPaused = true;
		this.pauseTime = t;
	end,
	
	Resume = function(this)
		Self:ResumeAction();
		this.isPaused = false;
		this.pauseTime = 0;
	end,
}

SkillFunc = 
{
	Init = function(this)
		if this.Actions ~= nil then
			for k in pairs(this.Actions) do
				SetTableFunc(this.Actions[k], ActionFunc);
				this.Actions[k]:Init(this);
			end
		end
	end,
	
	SysEnter = function(this)
		Self:OnSkillEnter(this.name);
		
		Self:EndSwordLight{};
		Self:EndGhost{hand = "body",};
		Self:EndGhost{hand = "both",};
		Self:ResumeAction();
		Self:SetJumpAccel(-10);
		this.isCollideDown = false;
		
		if this.Actions ~= nil then
			if this.randAction then
				this.curAction = this:SelectRandAction();--this.Actions[math.random(table.getn(this.Actions))];
			else
				this.curAction = this:SelectAction();
			end
		end
		
		if this.curAction ~= nil then
			if this.Enter ~= nil then
				this:Enter();
			end
			
			this.curAction:SysEnter();
		end
		
		this:OnCtrlEvent("SkillEnter");
	end,
	
	SysLeave = function(this)
		if this.curAction ~= nil then
			this.curAction:SysLeave();
		end
		
		Self:DebugPrint("Skill Leave:" .. this.name);
		if this.Leave ~= nil then
			this:Leave();
		end
		
		Self:OnSkillLeave();
		this:OnCtrlEvent("SkillLeave");
		Self:CancelEffect("SKILL");
	end,
	
	OnEvent = function(this, name, args)
		if name == "SysCollideDown" then
			this.isCollideDown = true;
		end
		
		if this.curAction ~= nil then
			this.curAction:OnEvent(name, args);
		end
	end,
	
	Update = function(this)
		if this.curAction ~= nil then
			this.curAction:Update();
			
			if this.curAction.isActive == false then
				this:NextAction();
			end
		end
		
		if this.UpdateCtrl ~= nil and Config.isMain then
			local curActionName = "";
			if this.curAction ~= nil then
				curActionName = this.curAction.name;
			end
			
			this:UpdateCtrl(curActionName);
		end
	end,	
	
	NextAction = function(this)
		if this.curAction ~= nil and this.curAction.nextAction ~= nil then
			this.curAction:SysLeave();
			this.curAction = this:FindActionByKey(this.curAction.nextAction);
			 
			if this.curAction ~= nil then
				this.curAction:SysEnter();
			end
		end
	end,
	
	FindActionByKey = function(this, key)
		if this.Actions ~= nil then
			--[[
			for k in pairs(this.Actions) do
				if this.Actions[k].name == actionName then
					return this.Actions[k];
				end
			end]]
			
			for k, v in pairs(this.Actions) do
				if k == key then
					return v;
				end
			end
		end
		
		return nil;
	end,
	
	SelectAction = function(this)
		if this.Actions == nil then
			return;
		end
		
		local selAction = nil;
		
		for k in pairs(this.Actions) do
			local curAction = this.Actions[k];
			if curAction.priority ~= nil and curAction.IsReady ~= nil and curAction.IsReady() then
				if selAction == nil then
					selAction = curAction;
				elseif selAction.priority < curAction.priority then
					selAction = curAction;
				end
			end
		end
		
		return selAction;
	end,
	
	SelectRandAction = function(this)
		local normalAction = this:SelectAction();
		if this:IsRandAction(normalAction) then
			local key = this.randAction[math.random(table.getn(this.randAction))];
			Self:DebugPrint("[lua]rand action:" .. key);
			return this.Actions[key];
		else
			return normalAction;
		end
	end,
	
	IsRandAction = function(this, act)
		for k, v in pairs(this.randAction) do
			if this.Actions[v] == act then
				return true;
			end
		end
		
		return false;
	end,
	
	IsEventTriggered = function(this, eventName)
		if this.Actions ~= nil then
			for k, v in pairs(this.Actions) do
				if v:IsEventTriggered(eventName) then
					return true;
				end
			end
		end
		
		return false;
	end,
	
	OnCtrlEvent = function(this, eventName)
		if this.CtrlEvent ~= nil and Config.isMain then
			this:CtrlEvent(eventName);
		end 
	end,
}

SkillMgr = 
{
	curSkill = nil,
	selectedSkill = nil,
	
	OnEvent = function(this, name, args)
		if this.curSkill ~= nil then
			this.curSkill:OnEvent(name, args);
		end
	end,
	
	ReEnter = function(this)
		if this.curSkill ~= nil then
			Self:DebugPrint("[lua]ReEnter");
			this.curSkill:SysEnter();
		end
	end,
	
	--播放技能
	PlaySkill = function(this, key)
		this:ChangeTo(skills[key]);
	end,
	
	CancelSkill = function(this, key)
		if this.curSkill ~= nil then
			this.curSkill:NextAction();
		end
	end,
	
	--播放被击
	PlayHit = function(this, hitName)
		this:ChangeTo(hit[hitName]);
	end,
	
	--内部转换函数
	ChangeTo = function(this, skill)
		if skill ~= nil then
			Self:DebugPrint("[lua]ChangeTo:" .. skill.name);
			
			if this.curSkill ~= nil then
				this.curSkill:SysLeave();
			end
			
			this.curSkill = skill;
			this.curSkill:SysEnter();
		end
	end,
	
	--技能当前是否可用
	IsSkillReady = function(this, skillID)
		local skill = skills[skillID];
		if skill ~= nil then
			return skill:IsReady();
		end
		
		return false;
	end,
	
	Update = function(this, delta)
		if this.curSkill ~= nil then
			this.curSkill:Update();
			if this.curSkill.curAction == nil then
				if this.curSkill.nextSkill ~= nil then
					this:PlaySkill(this.curSkill.nextSkill);
				else
					this.curSkill:SysLeave();
					this.curSkill = nil;
				end
			end
		end
		
		if this.curSkill == nil then
			this:PlaySkill("Idle");
		end
	end,	
}

function SetTableFunc(t0, t1)
	if t0 == nil or t1 == nil then
		return;
	end
	
	for k in pairs(t1) do
		t0[k] = t1[k];
	end
end

---------------------------------------------------------------------------------------------------------
--角色脚本初始化时调用一次
function Init()
	for k in pairs(skills) do
		SetTableFunc(skills[k], SkillFunc);
		SetTableFunc(skills[k], SkillCtrl[k]);
		skills[k]:Init();
	end
	
	Self:DebugPrint("[lua]Script inited");
	
	if Config.InitEffect ~= nil then
		Self:DebugPrint("[lua]InitEffect");
		for k, v in pairs(Config.InitEffect) do
			Self:DebugPrint("[lua]InitEffect" .. v);
			Self:PlayLocalEffect{id = v};
		end
	end
end

--每帧调用
function Update(delta)
	SkillMgr:Update(delta);
end

function PlaySkill(skillID)
	SkillMgr:PlaySkill(skillID);
end

function CancelSkill(skillID)
	SkillMgr:CancelSkill(skillID);
end

--播放基础动作
function PlayBase(actionName)
	SkillMgr:PlaySkill(actionName);
end

--重新播放当前动作
function ReEnter()
	SkillMgr:ReEnter();
end

function OnEvent(name, args)
	SkillMgr:OnEvent(name, args);
end

function SetConfig(key, value)
	Config[key] = value;
end

--设置技能动作的时间
function SetBaseTime(skillName, time)
	skill = skills[skillName];
	if skill ~= nil and skill.Actions ~= nil then
		for k, v in pairs(skill.Actions) do
			v.time = time;
			v.loop = false;
		end
	end
end

