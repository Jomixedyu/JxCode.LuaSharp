---@class SysLib._NullObject : SysLib.Object
local _NullObject, base = class.extends("SysLib.NullObject", SysLib.Object)


function _NullObject:constructor()
    -- todo
end

NullObject = _NullObject.New()

return _NullObject