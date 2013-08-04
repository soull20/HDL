triggers = {}

function triggers:OnTriggerEnter(triggerID)
	local trigger = self[triggerID];
	if trigger then
		trigger.entered = true;
		trigger:Enter();
	end
end

function triggers:OnTriggerLeave(triggerID)
	local trigger = self[triggerID];
	if trigger then
		trigger.entered = false;
		if trigger.Leave then
			trigger:Leave();
		end
	end
end

function triggers:Update()
	for k, v in pairs(self) do
		if v.entered and v.Update then
			v:Update();
		end
	end
end

--全局函数

function OnTriggerEnter(triggerID)
	triggers:OnTriggerEnter(triggerID);
end

function OnTriggerLeave(triggerID)
	triggers:OnTriggerLeave(triggerID);
end

function Update()
	triggers:Update();
end