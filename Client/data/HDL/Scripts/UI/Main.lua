dt = 
{
	LEFT = 0,
	CENTER = 1,
}

function SetCenterPos(back, top)
	local x = back:GetPos().x + (back:GetSize().x - top:GetSize().x) / 2;
	local y = back:GetPos().y + (back:GetSize().y - top:GetSize().y) / 2;
	
	top:SetPos{x = x, y = y};
end

function SetScreenCenter(t)
	local screenSize = Client:GetScreenSize();
	t:SetPos{x = (screenSize.x - t:GetSize().x) / 2.0, y = (screenSize.y - t:GetSize().y) / 2.0};
end

function LerpXY(t1, t2, w)
	local t = {};
	t.x = t1.x * (1.0 - w) + t2.x * w;
	t.y = t1.y * (1.0 - w) + t2.y * w;
	
	return t;
end

function Lerp(t1, t2, w)
	return t1 * (1.0 - w) + t2 * w;
end
----------------------------------------------------------------------------------------------------------------------------------
--登录界面
login = {}

function login:Init()
	self.selectTex = Client:NewTexture{file="MiniUI/select.png"};
	
	local screenSize = Client:GetScreenSize();
	
	self.selectTex:SetPos{x=0, y=0};
	self.selectTex:SetSize(screenSize);

	--初始化角色选择的背景
	self.roleBg = {};
	for i=0, 3 do
		local t = {};
		t.bg0 = Client:NewTexture{file="MiniUI/role_bg_0.png"};
		t.bg1 = Client:NewTexture{file="MiniUI/role_bg_1.png"};
		
		local posX = (screenSize.x / 4) * i + (screenSize.x / 4 - t.bg0:GetSize().x) / 2.0;
		local posY = 100;
		
		t.bg0:SetPos{x = posX, y = posY};
		t.bg1:SetPos{x = posX, y = posY};
		
		self.roleBg[i] = t;
	end
	
	self.active = true;
end

function login:Update()
	if not self.active then
		return
	end
	
	local mouseX = Client:GetMouseX();
	local mouseY = Client:GetMouseY();
	
	if Client:IsMouseLClicked() then
		Client:DebugPrint("clicked");
		
		local t = self.roleBg[0];
		if t.bg0:IsMouseOver() then
			Client:EnterWorld();
			self.active = false;
		end
	end
end

function login:Render()
	if not self.active then
		return
	end
	
	--背景
	if self.selectTex then
		self.selectTex:Render();
	end
	
	--每个角色的背景
	for i = 0, 3 do
		local t = self.roleBg[i];
		
		if t.bg0:IsMouseOver() then
			t.bg1:Render();
			Client:EnterWorld();
			self.active = false;
		else
			t.bg0:Render();
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------
--死亡对话框

deathDlg = {}

function deathDlg:Init()
	self.active = false;
	self.bloodTex = Client:NewTexture{file = "MiniUI/blood.png"};
	self.bgTex = Client:NewTexture{file = "MiniUI/death_bg.png"};
	self.btnTex0 = Client:NewTexture{file = "MiniUI/death_btn_0.png"};
	self.btnTex1 = Client:NewTexture{file = "MiniUI/death_btn_1.png"};
	
	local screenSize = Client:GetScreenSize();
	self.bgTex:SetPos{x = (screenSize.x - self.bgTex:GetSize().x) / 2.0, y = (screenSize.y - self.bgTex:GetSize().y) / 2.0};
	self.btnTex0:SetPos{x = self.bgTex:GetPos().x + (self.bgTex:GetSize().x - self.btnTex0:GetSize().x) / 2.0, y = self.bgTex:GetPos().y + 160};
	self.btnTex1:SetPos(self.btnTex0:GetPos());
	self.bloodTex:SetSize(screenSize);
end

function deathDlg:Update()
	if not self.active then
		return;
	end
	
	if Client:IsMouseLClicked() and self.btnTex0:IsMouseOver() then
		self.active = false;
		Client:Rebirth();
	end
end

function deathDlg:Render()
	if not self.active then
		return;
	end
	
	local screenSize = Client:GetScreenSize();
	
	Client:RenderRect{x = 0, y = 0, w = screenSize.x, h = screenSize.y, r = 50, g = 0, b = 0, a = 200};
	self.bloodTex:Render();
	self.bgTex:Render();
	
	if self.btnTex0:IsMouseOver() then
		self.btnTex1:Render();
	else
		self.btnTex0:Render();
	end
end

----------------------------------------------------------------------------------------------------------------------------------
--游戏结束

gameOver = {}

function gameOver:Init()
	self.active = false;
	self.tex = Client:NewTexture{file = "MiniUI/game_over.png"};
	SetScreenCenter(self.tex);
end

function gameOver:Update()
end

function gameOver:Render()
	if not self.active then
		return;
	end
	
	local screenSize = Client:GetScreenSize();
	Client:RenderRect{x = 0, y = 0, w = screenSize.x, h = screenSize.y, r = 10, g = 10, b = 10, a = 220};
	self.tex:Render();
end

----------------------------------------------------------------------------------------------------------------------------------
--血条

bloodBar = {}

function bloodBar:Init()
	self.bgTex = Client:NewTexture{file = "MiniUI/blood_bar.png"};
	self.curHP = 1.0;
	self.curMP = 1.0;
end

function bloodBar:Update()
	if self.hpFadeTo then
		self.hpFadeTo.curTime = self.hpFadeTo.curTime + Client:TimeDelta();
		if self.hpFadeTo.curTime <= self.hpFadeTo.maxTime then
			local w = self.hpFadeTo.curTime / self.hpFadeTo.maxTime;
			self.curHP = self.hpFadeTo.from * (1.0 - w) + self.hpFadeTo.to * w;
		else
			self.curHP = self.hpFadeTo.to;
			self.hpFadeTo = nil;
		end
	end
	
	if self.mpFadeTo then
		self.mpFadeTo.curTime = self.mpFadeTo.curTime + Client:TimeDelta();
		if self.mpFadeTo.curTime <= self.mpFadeTo.maxTime then
			local w = self.mpFadeTo.curTime / self.mpFadeTo.maxTime;
			self.curMP = self.mpFadeTo.from * (1.0 - w) + self.mpFadeTo.to * w;
		else
			self.curMP = self.mpFadeTo.to;
			self.mpFadeTo = nil;
		end
	end
end

function bloodBar:Render()
	self.bgTex:Render();
	
	local pos = self.bgTex:GetPos();
	local size = self.bgTex:GetSize();
	local border = 5;
	
	--血量
	Client:RenderRect{x = pos.x + border, y = pos.y + border, w = (size.x - border * 2) * self.curHP, h = size.y / 2.0 - border * 2, r = 100, g = 0, b = 0, a = 255};
	
	--怒气
	Client:RenderRect{x = pos.x + border, y = pos.y + size.y / 2.0 + border, w = (size.x - border * 2) * self.curMP, h = size.y / 2.0 - border * 2, r = 100, g = 100, b = 0, a = 255};
end

function bloodBar:SetHP(hp)
	if hp < 0 then
		hp = 0;
	end
	
	self.hpFadeTo = {};
	self.hpFadeTo.from = self.curHP;
	self.hpFadeTo.to = hp;
	self.hpFadeTo.maxTime = 0.3;
	self.hpFadeTo.curTime = 0.0;
end

function bloodBar:SetMP(mp)
	if mp < 0 then
		mp = 0;
	end
	
	self.mpFadeTo = {};
	self.mpFadeTo.from = self.curMP;
	self.mpFadeTo.to = mp;
	self.mpFadeTo.maxTime = 0.3;
	self.mpFadeTo.curTime = 0.0;
end

function bloodBar:IsDied()
	return self.curHP <= 0.0;
end

----------------------------------------------------------------------------------------------------------------------------------
--Alpha

alphaModifier = {}

function alphaModifier:New(t)
	t = t or {};
	setmetatable(t, {__index = self});
	return t;
end

function alphaModifier:Init(target, from, to, t)
	self.target = target;
	self.from = from;
	self.to = to;
	self.maxTime = t;
	self.curTime = 0.0;
	self.active = true;
end

function alphaModifier:Update()
	if not self.active then
		return;
	end
	
	self.curTime = self.curTime + Client:TimeDelta();
	if self.curTime <= self.maxTime then
		local w = self.curTime / self.maxTime;
		self.target:SetAlpha(Lerp(self.from, self.to, w));
	else
		self.target:SetAlpha(self.to);
		self.active = false;
	end
end

----------------------------------------------------------------------------------------------------------------------------------
--物件的移动

moveModifier = {}

function moveModifier:New(t)
	t = t or {};
	setmetatable(t, {__index = self});
	return t;
end

function moveModifier:Init(target, fromPos, toPos, maxTime)
	self.target = target;
	self.fromPos = {x = fromPos.x, y = fromPos.y};
	self.toPos = {x = toPos.x, y = toPos.y};
	self.maxTime = maxTime;
	self.curTime = 0.0;
	self.active = true;
end

function moveModifier:Update()
	if not self.active then
		return;
	end
	
	self.curTime = self.curTime + Client:TimeDelta();
	if self.curTime <= self.maxTime then
		local w = self.curTime / self.maxTime;
		self.target:SetPos(LerpXY(self.fromPos, self.toPos, w));
	else
		self.target:SetPos(self.toPos);
		self.active = false;
	end
end
----------------------------------------------------------------------------------------------------------------------------------
--怪物头顶跳字

damage = {}

function damage:New(t)
	t = t or {}
	setmetatable(t, {__index = self});
	return t;
end

function damage:Init(x, y, subHP)
	self.number = subHP
	
	local screenSize = Client:GetScreenSize();
	self.pos = {x = x, y = y,};
	self.alpha = 255;
	
	self.moveModifier = moveModifier:New();
	self.moveModifier:Init(self, self:GetPos(), {x = self.pos.x, y = self.pos.y - 32,}, 0.5);
	self.alphaModifier = alphaModifier:New();
	self.alphaModifier:Init(self, self:GetAlpha(), 0, 1.0);
end

function damage:Update()
	self.moveModifier:Update();
	self.alphaModifier:Update();
end

function damage:Render()
	game.damageFont:DrawText{text = self.number, dt = dt.CENTER, x = self.pos.x, y = self.pos.y, w = 100, h = 100, r = 255, g = 0, b = 0, a = self.alpha, };
end

function damage:SetPos(t)
	self.pos = t;
end

function damage:GetPos()
	return self.pos;
end

function damage:GetAlpha()
	return self.alpha;
end

function damage:SetAlpha(a)
	self.alpha = a;
end

----------------------------------------------------------------------------------------------------------------------------------
--主界面

game = {}

function game:Init()
	self.active = true;
	
	--加载图片，并计算总长度
	local totalWidth = 0;
	
	self.curWeaponBgTex = Client:NewTexture{file = "MiniUI/cur_weapon_bg.png"};
	totalWidth = totalWidth + self.curWeaponBgTex:GetSize().x;
	
	self.headTex = Client:NewTexture{file = "MiniUI/head.png"};
	totalWidth = totalWidth + self.headTex:GetSize().x;
	
	self.weaponSelectTex = {};
	for i = 0, 5 do
		local t = {};
		t.tex0 = Client:NewTexture{file = "MiniUI/weapon_select_0.png"};
		t.tex1 = Client:NewTexture{file = "MiniUI/weapon_select_1.png"};
		totalWidth = totalWidth + t.tex0:GetSize().x;
		
		--if i < 4 then
		--	t.weaponTex = Client:NewTexture{file = "MiniUI/weapon_" .. i .. ".png"};
		--end
		
		self.weaponSelectTex[i] = t;
	end
	
	self.coinTex = Client:NewTexture{file = "MiniUI/coin.png"};
	totalWidth = totalWidth + self.coinTex:GetSize().x;
	
	self.coinBtn = {};
	self.coinBtn.tex0 = Client:NewTexture{file = "MiniUI/coin_btn_0.png"};
	self.coinBtn.tex1 = Client:NewTexture{file = "MiniUI/coin_btn_1.png"};
	self.moneyTex = Client:NewTexture{file = "MiniUI/money.png"};
	self.usingWeapon = Client:NewTexture{file = "MiniUI/using_weapon.png"};
	bloodBar:Init();
	
	--设置位置
	local screenSize = Client:GetScreenSize();
	
	local curX = (screenSize.x - totalWidth) / 2.0;
	
	local size = self.curWeaponBgTex:GetSize();
	self.curWeaponBgTex:SetPos{x = curX, y = screenSize.y - size.y};
	curX = curX + size.x;
	
	local size = self.headTex:GetSize();
	self.headTex:SetPos{x = curX, y = screenSize.y - size.y};
	curX = curX + size.x;
	
	bloodBar.bgTex:SetPos{x = curX, y = screenSize.y - bloodBar.bgTex:GetSize().y - self.weaponSelectTex[0].tex0:GetSize().y};
	
	for i = 0, 5 do
		local t = self.weaponSelectTex[i];
		
		local size = t.tex0:GetSize();
		t.tex0:SetPos{x = curX, y = screenSize.y - size.y};
		t.tex1:SetPos{x = curX, y = screenSize.y - size.y};
		
		--if t.weaponTex then
		--	SetCenterPos(t.tex0, t.weaponTex);
		--end
		
		curX = curX + size.x;
	end
	
	local size = self.coinTex:GetSize();
	self.coinTex:SetPos{x = curX, y = screenSize.y - size.y - self.moneyTex:GetSize().y / 2.0};
	curX = curX + size.x;
	
	SetCenterPos(self.coinTex, self.coinBtn.tex0);
	SetCenterPos(self.coinTex, self.coinBtn.tex1);
	
	self.moneyTex:SetPos{x = self.coinTex:GetPos().x, y = screenSize.y - self.moneyTex:GetSize().y};
	SetCenterPos(self.curWeaponBgTex, self.usingWeapon);
	
	deathDlg:Init();
	gameOver:Init();
	
	self.font = Client:NewFont{font = "微软雅黑", size = 20, bold = 1};
	self.damageFont = Client:NewFont{font = "微软雅黑", size = 20, bold = 1};
	
	self:AddWeapon(1);
	self:AddWeapon(2);
	self:AddWeapon(3);
	Client:SwitchWeapon(3);
	
	--测试掉血
	self.damages = {};
	--self.damages[1] = damage:New();
	--self.damages[1]:Init();
end

function game:ShowDamage(x, y, subHP)
	local dmg = damage:New();
	dmg:Init(x, y, subHP);
	
	self.damages[table.getn(self.damages) + 1] = dmg	
end

function game:Update()
	if not self.active then
		return;
	end
	
	bloodBar:Update();
	deathDlg:Update();
	gameOver:Update();
	
	for i = 0, 5 do
		local t = self.weaponSelectTex[i];
		if Client:IsMouseLClicked() and t.tex0:IsMouseOver() and t.id then
			Client:SwitchWeapon(t.id);
		end
		
		if Client:IsKeyClicked(i + 1) and t.id then
			Client:SwitchWeapon(t.id);
		end
	end
	
	--[[
	if Client:IsMouseRClicked() then
		bloodBar:SetHP(bloodBar.curHP - 0.3);
	end
	
	if Client:IsMouseLClicked() then
		bloodBar:SetMP(bloodBar.curMP - 0.1);
	end]]
	
	--测试掉血
	--self.damages[1]:Update();
	for k, v in pairs(self.damages) do
		v:Update();
	end
end

function game:Render()
	if not self.active then
		return;
	end
	
	self.curWeaponBgTex:Render();
	self.headTex:Render();
	for i = 0, 5 do
		local t = self.weaponSelectTex[i];
		if t.tex0:IsMouseOver() then
			t.tex1:Render();
		else
			t.tex0:Render();
		end
		
		if t.weaponTex then
			t.weaponTex:Render();
		end
	end
	self.coinTex:Render();
	if self.coinBtn.tex0:IsMouseOver() then
		self.coinBtn.tex1:Render();
	else
		self.coinBtn.tex0:Render();
	end
	
	self.moneyTex:Render();
	
	local moneyPos = self.moneyTex:GetPos();
	local moneySize = self.moneyTex:GetSize();
	self.font:DrawText{text = "100", dt = dt.CENTER, x = moneyPos.x, y = moneyPos.y, w = moneySize.x, h = moneySize.y, r = 255, g = 255, b = 0, a = 255, };
	
	self.usingWeapon:Render();
	
	bloodBar:Render();
	deathDlg:Render();
	gameOver:Render();
	
	--测试掉血
	--self.damages[1]:Render();
	for k, v in pairs(self.damages) do
		v:Render();
	end
end

function game:AddWeapon(id)
	for i = 0, 5 do
		local t = self.weaponSelectTex[i];
		
		if t.id == nil then
			t.id = id;
			t.weaponTex = Client:NewTexture{file = "MiniUI/weapon_" .. id .. ".png"};
			SetCenterPos(t.tex0, t.weaponTex);
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------

function Init()
	--login:Init();
	game:Init();
	game.active = true;
end

function Update()
	login:Update();
	game:Update();
end

function Render()
	login:Render();
	game:Render();
end

function AddWeapon(weaponID)
	game:AddWeapon(weaponID);
end

function ShowGame()
	game:Init();
	game.active = true;
end

function OnReload()
	login.active = false;
	ShowGame();
end

function Damage(x, y, subHP)
	game:ShowDamage(x, y, subHP);
end

function SetHP(hp)
	bloodBar:SetHP(hp);
end

function SetSP(sp)
	bloodBar:SetMP(sp);
end

function ShowDeathDlg()
	deathDlg.active = true;
end