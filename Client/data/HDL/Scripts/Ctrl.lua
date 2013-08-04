
Ctrl = 
{
	MOVE = 0,
	ATK = 1,
	
	TurnToKeyboardDir = function(this, rotate)
		local kd = nil;
		if this:IsRunUp() and this:IsRunLeft() then
			kd = "WA";
		elseif this:IsRunUp() and this:IsRunRight() then
			kd = "WD";
		elseif this:IsRunLeft() and this:IsRunDown() then
			kd = "AS";
		elseif this:IsRunDown() and this:IsRunRight() then
			kd = "SD";
		elseif this:IsRunUp() then
			kd = "W";
		elseif this:IsRunLeft() then
			kd = "A";
		elseif this:IsRunDown() then
			kd = "S";
		elseif this:IsRunRight() then
			kd = "D";
		end
		
		if rotate == nil then
			rotate = true;
		end
		
		if kd ~= nil then
			Self:TurnToDir(kd);
		end
		
		return kd;
	end,
	
	TurnToRandDir = function(this)
		local dirset = {"WA", "WD", "AS", "SD", "W", "A", "S", "D",};
		local kd = dirset[math.random(table.getn(dirset))];
		Self:TurnToDir(kd);
	end,
	
	TurnToMouse = function(this)
		Self:TurnToMouse();
	end,
	
	HaveAttackTarget = function(this)
		return Self:HaveAttackTarget();
	end,
	
	TurnToAttackTarget = function(this)
		Self:TurnToAttackTarget();
	end,
	
	IsKeyboardRun = function(this)
		return this:IsRunLeft() or this:IsRunRight() or this:IsRunUp() or this:IsRunDown();
	end,
	
	IsRunLeft = function(this)
		return Self:IsKeyDown(CtrlMap["RunLeft"].Key);
	end,	
	
	IsRunRight = function(this)
		return Self:IsKeyDown(CtrlMap["RunRight"].Key);
	end,
	
	IsRunUp = function(this)
		return Self:IsKeyDown(CtrlMap["RunUp"].Key);
	end,
	
	IsRunDown = function(this)
		return Self:IsKeyDown(CtrlMap["RunDown"].Key);
	end,
	
	IsJump = function(this)
		return Self:IsKeyClicked(CtrlMap["Jump"].Key);
	end,
	
	IsDefense = function(this)
		return Self:IsKeyClicked(CtrlMap["Defense"].Key);
	end,
	
	IsDash = function(this)
		--1.˫��WSAD
		--[[
		if Self:IsKeyDoubleClicked(CtrlMap["RunLeft"].Key) or 
		   Self:IsKeyDoubleClicked(CtrlMap["RunRight"].Key) or 
		   Self:IsKeyDoubleClicked(CtrlMap["RunUp"].Key) or 
		   Self:IsKeyDoubleClicked(CtrlMap["RunDown"].Key) then
			return true;
		end]]
		
		--2.Shift + WSAD
		if this:IsKeyboardRun() and Self:IsKeyClicked("LSHIFT") then
			return true;
		end
		
		return false;
	end,
	
	--ʹ�ü��ܵ�����
	IsUseSkill = function(this)
		--ʹ����ͨ����
		if this:IsUseAtk() then
			return GetSkillID(Ctrl.ATK);
		end
		
		--������̶�Ӧ��ݼ�������ͼ1��2��3��4��5��6��Q��E����ֱ��ʩ�ţ�
		if SkillTable ~= nil then
			for k, v in pairs(SkillTable) do
				if Self:IsKeyClicked(k) then
					return v;
				end
			end
		end
		
		--������ICON��������Ҽ����������ʱ����������Ҽ���
		if Config.mouseRight ~= Ctrl.MOVE and Config.mouseRight ~= Ctrl.ATK and Self:IsMouseRClicked() then
			return Config.mouseRight;
		end
		
		return 0;
	end,
	
	--ʹ�õļ����Ƿ�Ϊ����״̬
	IsUseSkillPressed = function(this, skillID)
		Self:DebugPrint("[skillpressed]right:" .. Config.mouseRight .. " left:" .. Config.mouseLeft);
		
		if GetSkillID(Ctrl.ATK) == skillID then
			skillID = Ctrl.ATK;
		end
		
		if Config.mouseRight == skillID and Self:IsMouseRDown() then
			Self:DebugPrint("[skillpressed]is mouse r down");
			
			return true;
		end
		
		if Config.mouseLeft == skillID and Self:IsMouseLDown() then
			Self:DebugPrint("[skillpressed]is mouse l down");
			
			return true;
		end
		
		Self:DebugPrint("[skillpressed]nothing is mouse r down");
		
		return false;
	end,
	
	--ʩ����ͨ����������
	IsUseAtk = function(this)
		if Config.mouseLeft == Ctrl.ATK and Self:IsMouseLClicked() then
			return true;
		elseif Config.mouseRight == Ctrl.ATK and Self:IsMouseRClicked() then
			return true;
		else
			return false;
		end
	end,
	
	--�Ƿ�������ƶ�
	IsAutoRun = function(this)
		if Config.mouseLeft == Ctrl.MOVE and Self:IsMouseLClicked() then
			return true;
		elseif Config.mouseRight == Ctrl.MOVE and Self:IsMouseRClicked() then
			return true;
		else
			return false;
		end
	end,
	
	--�Ƿ���NPC�Ի�
	IsClickNpc = function(this)
		return Self:IsMouseLClicked() and Self:GetMouseActorType() == "NPC";
	end,
	
	ClickNpc = function(this)

	end,
	
	--ʹ�ü���ʱ�������ͨ��
	UseSkill = function(this, skillID)
		SkillMgr:PlaySkill(skillID);
	end,
	
	--����֮���������ʱʹ�ã���ʱ����鵱ǰ�����ܷ�ʩ��
	LinkSkill = function(this, skillID)
		SkillMgr:PlaySkill(skillID);
	end,
	
	--ȡ������
	CancelSkill = function(this)
		--Self:SendMsg{name = "CancelSkill", };
	end,
	
	--�л���������
	PlayAction = function(this, actionName)
		SkillMgr:PlaySkill(actionName);
		--Self:SendPlayAction(actionName);
		--Self:DebugPrint("[move]PlayAction:" .. actionName);
	end,
	
	StartMove = function(this)
		--Self:SendStartMove();
		--Self:DebugPrint("[luamove]startmove");
	end,
	
	StopMove = function(this)
		--Self:SendStopMove();
		--Self:DebugPrint("[luamove]stopmove");
	end,
	
	--��鼼�ܵ�ǰ�Ƿ�����һ���߽ӵ�������
	IsNextSkillRange = function(this, skillTable)
		return skillTable:IsEventTriggered("NextBegin");-- and (not skillTable:IsEventTriggered("NextEnd"));
	end,
	
	UpdateLinkSkill = function(this, skillTable, groupID, skillID)
		if Ctrl:IsNextSkillRange(skillTable) and skillTable.isInput then
			Ctrl:TurnToMouse();
			Ctrl:LinkSkill(skillID);
			skillTable.isInput = false;
		else
			if (Ctrl:IsUseSkill() == groupID) then
				skillTable.isInput = true;
			elseif Ctrl:IsUseSkillPressed(groupID) then
				skillTable.isInput = true;
			end
		end
	end,
	
	UpdateUseSkill = function(this, skillTable, groupID, skillID)
		if Ctrl:IsNextSkillRange(skillTable) and skillTable.isInput then
			Ctrl:TurnToAttackTarget();
			Ctrl:UseSkill(skillID);
			skillTable.isInput = false;
		else
			if (Ctrl:IsUseSkill() == groupID) then
				skillTable.isInput = true;
			end
		end
	end,
	
	--һ���������ӵ��������ܣ�
	--skillTable ���ƽű�
	--ent ���¼���
	--from ��ǰ���ܺ�
	--to Ҫ�л����ļ�����
	UpdateUseSkillSet = function(this, skillTable, ent, from, to)
		if skillTable:IsEventTriggered(ent) then 
			local skillID = Ctrl:IsUseSkill();
			
			if to ~= nil then
				for k, v in pairs(to) do
					if to[k] == skillID then
						Ctrl:TurnToAttackTarget();
						Ctrl:UseSkill(skillID);
						break;
					end
				end
			else
				if skillID ~= 0 and skillID ~= from then
					Ctrl:TurnToAttackTarget();
					Ctrl:UseSkill(skillID);
				end
			end
		end
	end,
	
	GetMouseActorType = function(this)
		return Self:GetMouseActorType();
	end,
	
	GetAttackTargetType = function(this)
		return Self:GetAttackTargetType();
	end,
	
	--Idle
	UpdateIdle = function(this, skillTable)
		if Ctrl:IsClickNpc() then
			Ctrl:ClickNpc();
		else
			if Self:IsKeyClicked(1) then
				Ctrl:TurnToMouse();
				SkillMgr:PlaySkill(200020);
				--Ctrl:LinkSkill(200020);
				return;
			end
			
			if Self:IsMouseRDown() then
				if Self:GetWeaponID() == 1 then
					SkillMgr:PlaySkill(200011);
				elseif Self:GetWeaponID() == 2 then
					SkillMgr:PlaySkill(200012);
				else
					SkillMgr:PlaySkill(200010);
				end
			elseif Ctrl:IsKeyboardRun() then
				Ctrl:TurnToKeyboardDir();
				Ctrl:PlayAction("Run");
			--[[
			elseif Ctrl:IsAutoRun() then
				Ctrl:PlayAction("AutoRun");
			elseif Ctrl:IsJump() then
				Ctrl:PlayAction("Jump");
			else
				local skillID = Ctrl:IsUseSkill();
				if skillID ~= 0 then
					Ctrl:TurnToMouse();
					Ctrl:UseSkill(skillID);
				end]]
			end
		end
	end,
	
	UpdateRun = function(this, skillTable)
		if Ctrl:IsDash() then
			Ctrl:UseSkill(GetSkillID("Dash"));
		elseif Ctrl:IsKeyboardRun() then
			if Self:IsMouseRDown() then
				if Self:GetWeaponID() == 1 then
					SkillMgr:PlaySkill(200011);
				elseif Self:GetWeaponID() == 2 then
					SkillMgr:PlaySkill(200012);
				else
					SkillMgr:PlaySkill(200010);
				end
			elseif Ctrl:IsJump() then
				Ctrl:PlayAction("JumpForward");
			elseif Ctrl:IsUseSkill() ~= 0 then
				Ctrl:TurnToMouse();
				Ctrl:UseSkill(Ctrl:IsUseSkill());
			else
				Ctrl:TurnToKeyboardDir();
			end
		else
			Ctrl:PlayAction("Idle");
		end
	end,
	
	UpdateAutoRun = function(this)
		if Ctrl:IsDash() then
			Ctrl:UseSkill(GetSkillID("Dash"));
		elseif Ctrl:IsUseSkill() ~= 0 then
			Ctrl:TurnToMouse();
			Ctrl:UseSkill(Ctrl:IsUseSkill());
		elseif Ctrl:IsKeyboardRun() then
			Ctrl:TurnToKeyboardDir();
			Ctrl:PlayAction("Run");
		elseif Ctrl:IsAutoRun() then
			Ctrl:PlayAction("AutoRun");
		end
	end,
}