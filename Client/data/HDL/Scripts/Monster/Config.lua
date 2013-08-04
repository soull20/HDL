Config =
{
	isMain = false,
	normalSkill = 1111011,
	rightSkill = 0,	
	rigidTime = 0.3,
	
	--���������õ��ƶ��ٶ�
	moveSpeed = 2.0,
	--�����������ٶ�
	jumpSpeed = 5.0,
	--���������õ�ս��̬
	isBattleState = true,
	
	--�����ƶ�
	Run = 
	{
		--�����ص�ʱ��
		leftStepEventTime = 0.59,
		--�����ص���Ч
		leftStepSound = "fst-male-dirt-metal-03.wav",
		--�����ص�ʱ��
		rightStepEventTime = 0.18,
		--�ҽŲ���ص���Ч
		rightStepSound = "fst-male-dirt-metal-04.wav",	
	},
	
	--�����ƶ�
	Walk =
	{
		--�����ص�ʱ��
		leftStepEventTime = 0.59,
		--�����ص���Ч
		leftStepSound = "fst-male-dirt-metal-03.wav",
		--�����ص�ʱ��
		rightStepEventTime = 0.18,
		--�ҽŲ���ص���Ч
		rightStepSound = "fst-male-dirt-metal-04.wav",	
	},
	
	--����
	BlowOff =
	{
		--���ʱ����Ч
		downEffect = 0,
	},
	
	--��ͨ����1
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
	
	--��ͨ����1
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