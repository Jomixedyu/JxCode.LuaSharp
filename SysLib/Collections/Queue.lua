-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/17 16:48
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.Collections.Queue : SysLib.Object
local Queue, base = class.extends("SysLib.Collections.Queue", SysLib.Object)

function Queue:constructor()
    self._list = {}
    self.tail = 0
    self.head = 1
end

function Queue:Peek()
    if self.head > self.tail then
        return nil
    else
        return self._list[self.head]
    end
end

function Queue:Enqueue(value)
    if self.tail == 0 then
        self.head = 1
    end
    self.tail = self.tail + 1
    self._list[self.tail] = value
end

function Queue:Dequeue()
    if self.head > self.tail then
        return nil
    else
        local value = self._list[self.head]
        self._list[self.head] = nil
        self.head = self.head + 1
        return value
    end
end

function Queue:Contains(value)
    if value == nil then
        return false
    end
    for k, v in pairs(self._list) do
        if v == value then
            return true
        end
    end
    return false
end

function Queue:ForEach(fun, ...)
    for k = self.head, self.tail do
        fun(self._list[k], ...)
    end
end

function Queue:GetCount()
    return self.tail - self.head + 1
end

function Queue:Clear()
    self._list = {}
    self.tail = 0
    self.head = 1
end

function Queue:GetEnumerator()
    local i = self.head
    return function()
        i = i + 1
        return self._list[i]
    end
end

return Queue
