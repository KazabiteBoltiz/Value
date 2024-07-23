local RepS = game.ReplicatedStorage
local Packages = RepS.Packages
local Signal = require(Packages.Signal)

local Value = {}
Value.__index = Value

function Value.new(valueType, default)
	local self = setmetatable({}, Value)
	self.Value = default	
	
	self.Changed = Signal.new()
	self.SetTo = Signal.new()
	
	self.Changed:Fire(default)
	
	return self
end

function Value:Set(value)
	local prevValue = self.Value
	self.SetTo:Fire(prevValue, value)
	if value ~= prevValue then
		self.Value = value
		self.Changed:Fire(prevValue, value)
	end
end

function Value:Get()
	return self.Value
end

return Value
