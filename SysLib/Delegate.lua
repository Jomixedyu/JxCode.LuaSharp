-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/15 23:58
--- Description  : 委托（函数指针封装）
------------------------------------------------
---@class SysLib.Delegate : SysLib.Object
---@field New fun(obj, methodPointer):SysLib.Delegate
local Delegate = class.extends("SysLib.Delegate", SysLib.Object)

function Delegate:constructor(obj, methodPointer)
    self.multiDelegate = SysLib.Collections.List.New()
    if methodPointer == nil then
        methodPointer = obj
        obj = nil
    end
    if methodPointer then
        self:Add(obj, methodPointer)
    end
end

---@overload fun(funcPointer:function)
function Delegate:Add(obj, methodPointer)
    local struct = {
        target = obj,
        methodPointer = methodPointer
    }
    self.multiDelegate:Add(struct)
end

function Delegate:Remove(obj, methodPointer)
    --multi
    for index, value in ipairs(self.multiDelegate) do
        if value.target == obj and v.methodPointer == methodPointer then
            self.multiDelegate:RemoveAt(index)
            break
        end
    end
end

function Delegate:RemoveAll()
    self.multiDelegate:Clear()
end
function Delegate:Invoke(...)
    for index, v in ipairs(self.multiDelegate) do
        if v.target ~= nil then
            --instance
            v.methodPointer(v.target, ...)
        else
            --static
            v.methodPointer(...)
        end
    end
end

return Delegate
