--���������Ϣ
--������������Ϣ
--Self:DebugPrint("camera action finished:" .. actionID);

--�������
--����1��ʱ��
--����2��ǿ��
--Self:ShakeCamera(5.0, 0.3); 

--�������·��
--����: ·����XML�е�����
--Self:PlayCameraAction(1);

--�����е������忪ʼ����
--����: �������ID
--Self:DestructObject(1);

function OnSceneLoaded()
	Self:ShowDevilUI();
	
	Self:PreloadActor(850000);
	Self:PreloadActor(850001);
	Self:PreloadActor(850002);
	Self:PreloadActor(850003);
	Self:PreloadActor(850004);
	Self:PreloadActor(850005);
	Self:PreloadActor(850006);
	Self:PreloadActor(850007);
	Self:PreloadActor(850008);
	Self:PreloadActor(850009);
	Self:PreloadActor(850010);
	Self:PreloadActor(850011);
	Self:PreloadActor(850012);
	Self:PreloadActor(850013);
	Self:PreloadActor(850014);
	Self:PreloadActor(850015);
	Self:PreloadActor(850016);
end

function OnSceneUnLoaded()
	Self:HideDevilUI();
end

----------------------------------------------------------------------------------------------------------------------
--�������·�����ƶ�ʱ�������¼�
function OnCameraActionEvent(name, actionID)
	if name == "Finished" and actionID == 1 then
		Self:PlayCameraAction(2);
	elseif name == "Finished" and actionID == 2 then
		Self:PlayCameraAction(3);
	elseif name == "Finished" and actionID == 3 then
		Self:SoundPause("20096");
		Self:ShowUI();		-- display UI again	
	end

	if name == "Finished" and actionID ==  0 then
		Self:SoundPause("20097");
		Self:ShowUI();		-- display UI again
	end
end
 
----------------------------------------------------------------------------------------------------------------------
--�������·�����ƶ�ʱ������뿪������
function OnCameraTrigger(enter, triggerID)
	if enter and triggerID == 20099 then
		Self:DestructObject(2);
		Self:ShakeCamera(5.0, 0.4);
	elseif enter and triggerID == 20100 then
		--Self:DestructObject(2);
		Self:DestructObject(1);
		Self:ShakeCamera(5.0, 0.4);
	elseif enter and triggerID == 20094 then
		Self:SoundPlay("20097");
	elseif enter and triggerID == 20095 then
		Self:SoundPlay("20096");
	end
end