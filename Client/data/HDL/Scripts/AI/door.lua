dofile("../Data/HDL//Scripts/AI/util.lua");

--[[

--�õ���ɫλ��
actor:GetPos();

--�ı��ɫ�ĳ���
actor:TurnTo(vector);

--�ı��ɫ����
actor:PlayBase("Idle");
]]

METER = 100;

--[[
config = 
{
	--���ܺ�
	skill = 1000,
	
	--���ܵ���Ч������Χ
	skillRange = 5 * METER,
	
	--����ʩ�ŵ�ʱ����
	skillDelta = 2.0,
	
		--������ҵķ�Χ
	alarmRange = 30 * METER,
}]]

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


--�õ������Χ�������
function GetPlayerAroundPos(r)
	local playerPos = vector:New(player:GetPos());
	local randX = r * (math.random() - 0.5);
	local randY = r * (math.random() - 0.5);
	playerPos.x = playerPos.x + randX;
	playerPos.y = playerPos.y + randY;
	
	return playerPos;
end

--����ͽ�ɫ�ľ���
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
	self.opened = false;
	monster:PlayBase("Idle");
end

function idle:Leave()
end

function idle:Update()
	local monsterNum = ai:GetGroupNum(-1);
	if monsterNum == 0 and (not self.opened) then
		monster:PlayBase("Open");
		self.opened = true;
	end
end

function idle:OnEvent(event)
end

function idle:IsInRange()
	return SelfToPlayer() < config.ViewRange;
end
