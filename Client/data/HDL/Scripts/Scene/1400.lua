
function OnSceneLoaded()

end

function OnSceneUnLoaded()

end


--�������·�����ƶ�ʱ�������¼�
function OnCameraActionEvent(name, actionID)
	if name == "Finished" and actionID == 0 then
		Self:DebugPrint("camera action finished:" .. actionID);
		Self:PlayCameraAction(1);
	end
end

--�������·�����ƶ�ʱ������뿪������
function OnCameraTrigger(enter, triggerID)
	if enter then
		Self:DebugPrint("camera enter trigger:" .. triggerID);
		Self:DestructObject(1);
		Self:ShakeCamera(5.0, 0.3);
	else
		Self:DebugPrint("camera leave trigger:" .. triggerID);
	end
end