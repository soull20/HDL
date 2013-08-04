dofile("../Data/HDL//Scripts/AI/util.lua");

METER = 100;

config = monster:GetConfig();

function Init()
	mgr:Init();
end

function Update()
	mgr:Update();
end

function OnEvent(event)
	mgr:OnEvent(event);
end

--得到玩家周围的随机点
function GetPlayerAroundPos(r)
	local playerPos = vector:New(player:GetPos());
	local randX = r * (math.random() - 0.5);
	local randY = r * (math.random() - 0.5);
	playerPos.x = playerPos.x + randX;
	playerPos.y = playerPos.y + randY;
	
	return playerPos;
end

--怪物和角色的距离
function SelfToPlayer()
	local playerPos = vector:New(player:GetPos());
	local selfPos = vector:New(monster:GetPos());
	local dis = playerPos:Sub(selfPos);
	
	return dis:Length();
end

--Mgr
mgr = {}

function mgr:Init()
	self:ChangeTo(idle);
end

function mgr:ChangeTo(s)
	if s == self.curState then
		return;
	end
	
	if self.curState then
		self.curState:Leave();
	end
	
	self.curState = s;
	
	if self.curState then
		self.curState:Enter();
	end
end

function mgr:Update()
	if self.curState then
		self.curState:Update();
	end
end

function mgr:OnEvent(event)
	if event == "Death" then
		self:ChangeTo(death);
		return;
	end
	
	if self.curState and self.curState.OnEvent then
		self.curState:OnEvent(event);
	end
end

--Idle

idle = {}

function idle:Enter()
	self.time = math.random();
	monster:PlayBase("Idle");
	ai:DebugPrint("[2]--------------------------------------------------------------------------------------------");
end

function idle:Leave()
end

function idle:Update()
	self.time = self.time - ai:TimeDelta();
	if self.time < 0.0 then
		if runaway:IsInRange() then
			ai:DebugPrint("--------------------------------------------------------------------------------------------");
			mgr:ChangeTo(runaway);
			return;
		elseif skilling:IsInRange() then
			mgr:ChangeTo(skilling);
			return;
		elseif trace:IsInRange() then
			mgr:ChangeTo(trace);
			return;
		end
	end
end

function idle:OnEvent(event)
end

--RandMove
patrol = {}

function patrol:Enter()
	local dir = vector:New();
	dir:Rand();
	monster:TurnToDir(dir);
	monster:Move("Run", config.PatrolSpeed);
	
	self.time = math.random(2);
end

function patrol:Leave()
	monster:PlayBase("Idle");
end

function patrol:Update()
	self.time = self.time - ai:TimeDelta();
	if self.time < 0.0 then
		mgr:ChangeTo(idle);
		return;
	end
end

function patrol:OnEvent(event)
	--怪物碰到场景后直接进入Idle
	if event.name == "PhyCollided" then
		mgr:ChangeTo(idle);
		return;
	end
end

--Trace
trace = {}

function trace:Enter()
	self:TurnToPlayer();
	monster:Move("Run", config.TraceSpeed);
	
	self.time = math.random(2);
end

function trace:Leave()
	monster:PlayBase("Idle");
end

function trace:Update()
	self.time = self.time - ai:TimeDelta();
	if self.time < 0.0 then
		mgr:ChangeTo(idle);
		return;
	end
end

function trace:OnEvent(event)
	--怪物碰到场景后直接进入Idle
	if event.name == "PhyCollided" then
		mgr:ChangeTo(idle);
		return;
	end
end

function trace:IsInRange()
	return SelfToPlayer() < config.ViewRange;
end

function trace:TurnToPlayer()
	local tgtPos = GetPlayerAroundPos(10 * METER);
	local selfPos = vector:New(monster:GetPos());
	local dir = tgtPos:Sub(selfPos);
	dir:Normalize();
	
	monster:TurnToDir(dir);
end

--Eascape
runaway = {}

function runaway:Enter()
	local tgtPos = vector:New(player:GetPos());
	local selfPos = vector:New(monster:GetPos());
	local dir = selfPos:Sub(tgtPos);
	dir:Normalize();
	
	monster:TurnToDir(dir);
	monster:Move("Run", config.TraceSpeed);
	
	self.time = math.random(2);
end

function runaway:Leave()
end

function runaway:Update()
	ai:DebugPrint("[0]---------------------------------------------------------------");
	self.time = self.time - ai:TimeDelta();
	if self.time < 0.0 then
		ai:DebugPrint("[1]---------------------------------------------------------------");
		mgr:ChangeTo(idle);
		return;
	end
end

function runaway:IsInRange()
	return SelfToPlayer() < 5 * METER;
end

--Use skill
skilling = {}

function skilling:Enter()
	self:TurnToPlayer();
	monster:PlaySkill(config.Skill1);
	self.time = math.random(2);
end

function skilling:Leave()
end

function skilling:Update()
	self.time = self.time - ai:TimeDelta();
	if self.time < 0.0 then
		mgr:ChangeTo(idle);
		return;
	end
end

function skilling:TurnToPlayer()
	local tgtPos = GetPlayerAroundPos(5 * METER);
	local selfPos = vector:New(monster:GetPos());
	local dir = tgtPos:Sub(selfPos);
	dir:Normalize();
	
	monster:TurnToDir(dir);
end

function skilling:IsInRange()
	return SelfToPlayer() < config.AtkRange;
end

--Death
death = {}

function death:Enter()
	--monster:PlayBase("Death");
end

function death:Leave()
end

function death:Update()
end

function death:OnEvent(event)
end