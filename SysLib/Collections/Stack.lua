-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/17 16:53
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.Collections.Stack : SysLib.Object
local Stack = class.extends("SysLib.Collections.Stack", SysLib.Object)

function Stack:constructor()
    self._list = {}
end

function Stack:Push(value)
    if value then
        table.insert(self._list, value)
    end
end

function Stack:Pop()
    if #self._list ~= 0 then
        local top = self._list[#self._list]
        table.remove(self._list)
        return top
    else
        return nil
    end
end

function Stack:Peek()
    if #self._list ~= 0 then
        return self._list[#self._list]
    end
    return nil
end

function Stack:GetCount()
    return #self._list
end

function Stack:Clear()
    for i = 1, #self._list do
        self._list[i] = nil
    end
end

function Stack:GetEnumerator()
    local i = 0
    return function()
        i = i + 1
        return self._list[i]
    end
end

return Stack
