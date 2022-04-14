-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2021/09/13 15:24
--- Description  : Events
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.Event : SysLib.Object
local Event = class.define("SysLib.Event", SysLib.Object)

function Event:constructor()
    self.multiDelegate = SysLib.Collections.List.new()
end

---@overload fun(delegate)
function Event:Add(target, method)
    if not method then
        --delegate
        if target:GetType() ~= gettype(SysLib.Delegate) then
            throw(SysLib.ArgumentException.new("type error"))
        end
        self.multiDelegate:Add(target)
        return
    end
    self.multiDelegate:Add(SysLib.Delegate.new(target, method))
end

---@overload fun(delegate)
function Event:Remove(target, method)

    if not method then
        --delegate
        if target:GetType() ~= gettype(SysLib.Delegate) then
            throw(SysLib.ArgumentException.new("type error"))
        end
        self.multiDelegate:Remove(target)
        return
    end

    for index, item in each(self.multiDelegate) do
        if item.target == target and item.method == method then
            self.multiDelegate:RemoveAt(index)
            return
        end
    end
end

function Event:RemoveAll()
    self.multiDelegate:Clear()
end

function Event:Invoke(...)
    for index, value in each(self.multiDelegate) do
        value:Invoke(...)
    end
end

return Event