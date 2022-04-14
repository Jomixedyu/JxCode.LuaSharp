-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:58
--- Description  : 委托
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.Delegate : SysLib.Object
---@field New fun(target, method):SysLib.Delegate
local Delegate, base = class.define("SysLib.Delegate", SysLib.Object)

function Delegate:constructor(target, method)
    self.target = target
    self.method = method
end

function Delegate:Invoke(...)
    if self.target ~= nil then
        --instance
        self.method(self.target, ...)
    else
        --static
        self.method(...)
    end
end

function Delegate:Equals(target)
    return self.target == target.target and self.method == target.method
end

return Delegate
