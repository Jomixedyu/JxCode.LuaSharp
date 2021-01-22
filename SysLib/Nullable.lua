---@class SysLib.Nullable : SysLib.Object
local Nullable, base = class.extends("SysLib.Nullable", SysLib.Object)


function Nullable:constructor(value)
    self.value = value
end

function Nullable:HasValue()
    return self.value ~= nil
end

function Nullable:Value()
    return self.value
end


Nullable.Null = Nullable.New(nil)


return Nullable