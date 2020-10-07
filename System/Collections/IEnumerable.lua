-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/14 01:38
--- Description  : 
------------------------------------------------
---
---@class System.IEnumerable : System.Object
local IEnumerable, base = class.extends("System.Collections.IEnumerable", System.Object)

function each(ienumerator)
    return ienumerator:GetEnumerator()
end

function IEnumerable:GetEnumerator()
    throw(System.NotImplementedException.New())
end

return IEnumerable