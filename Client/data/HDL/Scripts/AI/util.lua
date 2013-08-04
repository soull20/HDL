vector = {}

function vector:New(t)
	t = t or {};
	
	setmetatable(t, {__index = self});
	
	return t;
end

function vector:Length()
	return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
end

function vector:Normalize()
	local length = self:Length();
	
	self.x = self.x / length;
	self.y = self.y / length;
	self.z = self.z / length;
end

function vector:Add(other)
	local vec = vector:New();
	vec.x = self.x + other.x;
	vec.y = self.y + other.y;
	vec.z = self.z + other.z;
	
	return vec;
end

function vector:Sub(other)
	local vec = vector:New();
	vec.x = self.x - other.x;
	vec.y = self.y - other.y;
	vec.z = self.z - other.z;
	
	return vec;
end

function vector:Rand()
	self.x = math.random() - 0.5;
	self.y = math.random() - 0.5;
	self.z = math.random() - 0.5;
end

function vector:Set(other)
	self.x = other.x;
	self.y = other.y;
	self.z = other.z;
end
