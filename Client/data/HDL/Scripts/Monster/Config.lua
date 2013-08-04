Config =
{
	isMain = false,
	normalSkill = 1111011,
	rightSkill = 0,	
	rigidTime = 0.3,
	
	--服务器设置的移动速度
	moveSpeed = 2.0,
	--服务器上升速度
	jumpSpeed = 5.0,
	--服务器设置的战斗态
	isBattleState = true,
	
	--快速移动
	Run = 
	{
		--左脚落地的时间
		leftStepEventTime = 0.59,
		--左脚落地的音效
		leftStepSound = "fst-male-dirt-metal-03.wav",
		--左脚落地的时间
		rightStepEventTime = 0.18,
		--右脚步落地的音效
		rightStepSound = "fst-male-dirt-metal-04.wav",	
	},
	
	--慢速移动
	Walk =
	{
		--左脚落地的时间
		leftStepEventTime = 0.59,
		--左脚落地的音效
		leftStepSound = "fst-male-dirt-metal-03.wav",
		--左脚落地的时间
		rightStepEventTime = 0.18,
		--右脚步落地的音效
		rightStepSound = "fst-male-dirt-metal-04.wav",	
	},
	
	--击飞
	BlowOff =
	{
		--落地时的特效
		downEffect = 0,
	},
	
	--普通攻击1
	Attack1 =
	{
		skillID = "Attack1",	
		
		Attack1 =
		{
			time = 0.37,
			effectID = 11110112,	
		},
		
		SwordLight1 = 
		{
			startTime = 0.31,
			endTime = 0.47,
			tex = "TrailLight/Textures/MUX_Trail08.dds",	
		},
		
		Attack2 =
		{
			time = nil,
			effectID = nil,	
		},
		
		SwordLight2 = 
		{
			startTime = nil,
			endTime = nil,
			tex = nil,	
		},
		
		Sound = 
		{
			time = 0.17,
			sound = "atk-hammer-01.wav",	
		},
	},
	
	--普通攻击1
	Attack2 =
	{
		skillID = "Attack2",	
		
		Attack1 =
		{
			time = 0.37,
			effectID = 11110112,	
		},
		
		SwordLight1 = 
		{
			startTime = 0.62,
			endTime = 0.78,
			tex = "TrailLight/Textures/MUX_Trail08.dds",	
		},
		
		Attack2 =
		{
			time = 1.0,
			effectID = 11110112,	
		},
		
		SwordLight2 = 
		{
			startTime = 1.64,
			endTime = 1.78,
			tex = "TrailLight/Textures/MUX_Trail08.dds",	
		},
		
		Sound = 
		{
			time = 0.17,
			sound = "atk-hammer-01.wav",	
		},
	},
}