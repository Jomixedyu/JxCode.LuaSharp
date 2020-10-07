-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/16 00:00
--- Description  : 数组封装类，可以用lua迭代器访问
------------------------------------------------
---@class System.Collections.List : System.Object
local List, base = class.extends("System.Collections.List", System.Object)

function List:constructor()
    
end

function List:GetCount()
    return #self
end

function List:Add(item)
    assert(item ~= nil , "Warning: ArgumentNull")
    self[#self + 1] = item
end

function List:AddRange(ienumerator)
    for item in each(ienumerator) do
        self:Add(item)
    end
end

function List:Clear()
    for i = 1, #self do
        self[i] = nil
    end
end

---@return boolean
function List:Contains(item)
    if self:IndexOf(item) ~= -1 then
        return true
    else
        return false
    end
end

function List:Insert(index, value)
    table.insert(self, index, value)
end

---@return System.Collections.List
function List:Clone()
    local list = List.New()
    for i = 1, #self do
        list[i] = self[i]
    end
end

function List:Remove(item)
    if item == nil then
        return
    end
    for i = 1, self:GetCount() do
        if self[i] == item then
            table.remove(self, i)
            break
        end
    end
end

function List:RemoveAt(index)
    table.remove(self, index)
end

---@return number
function List:IndexOf(item)
    for i = 1, self:GetCount() do
        if self[i] == item then
            return i;
        end
    end
    return -1;
end

function List:ForEach(func)
    for i, v in ipairs(self) do
        func(v)
    end
end

function List:GetEnumerator()
    local i = 0
    return function()
        i = i + 1
        local ret = self[i]
        return ret
    end
end

---@return System.Collections.List
function List.ArrayToList(table)
    local list = List.New()
    for i = 1, #table do
        list:Add(table[i])
    end
    return list
end

return List