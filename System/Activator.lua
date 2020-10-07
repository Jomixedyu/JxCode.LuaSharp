-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/04/22 14:17
--- Description  : 按类型创建实例
------------------------------------------------
local Activator = class.static("System.Activator")

---@param type Type
---@param ... Object
function Activator.CreateInstance(type, ...)
    return type.m_protoType.New(...)
end

return Activator