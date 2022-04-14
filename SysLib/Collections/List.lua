-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/16 00:00
--- Description  : 数组封装类
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.Collections.List : SysLib.Object
local List, base = class.define("SysLib.Collections.List", SysLib.Object)

function List:constructor()
    self.m_arr = {}
    self.m_count = 0
end

function List:GetCount()
    return self.m_count
end

function List:Add(item)
    self.m_count = self.m_count + 1
    self.m_arr[self.m_count] = item
end

function List:AddRange(enumerable)
    for item in each(enumerable) do
        self:Add(item)
    end
end

function List:AddTableRange(tb)
    for index, value in ipairs(tb) do
        self:Add(value)
    end
end

function List:AddListRange(list, startIndex, count)
    local c = count or list:GetCount()
    local sti = startIndex or 1
    for i = sti, c do
        self:Add(list:Get(i))
    end
end

function List:Get(index)
    return self.m_arr[index]
end

function List:Clear()
    for i = 1, self.m_count do
        self.m_arr[i] = nil
    end
    self.m_count = 0
end

---@return boolean
function List:Contains(item)
    return self:IndexOf(item) ~= -1
end

function List:Insert(index, value)
    self.m_count = self.m_count + 1
    table.insert(self.m_arr, index, value)
end

---@return SysLib.Collections.List
function List:Clone()
    local list = List.new()
    for i = 1, self.m_count do
        list:Add(self.m_arr[i])
    end
    return list;
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
    if index < 1 or index > self.m_count then
        return
    end
    if index == self.m_count then
        self.m_arr[index] = nil
    else
        table.remove(self.m_arr, index)
    end
    self.m_count = self.m_count - 1
end

---@return number
function List:IndexOf(item)
    for i = 1, self.m_count do
        if self.m_arr[i] == item then
            return i;
        end
    end
    return -1;
end

function List:ForEach(func)
    for i = 1, self.m_count do
        func(self.m_arr[i])
    end
end

function List:GetEnumerator()
    local i = 0
    return function()
        i = i + 1
        if i <= self.m_count then
            return i, self.m_arr[i]
        end
        return nil
    end
end

function List:Equals(target)
    ---@type SysLib.Collections.List
    local list = target
    if self:GetCount() ~= list:GetCount() then
        return false
    end

    for i = 1, self:GetCount() do
        if self:Get(i) ~= list:Get(i) then
            return false
        end
    end
    return true
end

function List:GetTableRef()
    return self.m_arr
end

function List:GetTable()
    local tb = {}
    for i = 1, self.m_count do
        tb[i] = self.m_arr[i]
    end
    return tb
end

return List