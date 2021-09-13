-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/14 01:38
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---
---@class SysLib.IEnumerable : SysLib.Object
local IEnumerable, base = class.extends("SysLib.Collections.IEnumerable", SysLib.Object)

function each(ienumerable)
    return ienumerable:GetEnumerator()
end

function IEnumerable:GetEnumerator()
    throw(SysLib.NotImplementedException.New())
end

return IEnumerable