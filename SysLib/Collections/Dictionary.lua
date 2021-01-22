-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/23 19:31
--- Description  : 有序字典
------------------------------------------------
---@class SysLib.Collections.Dictionary : SysLib.Object
local Dictionary, base = class.extends("SysLib.Collections.Dictionary", SysLib.Object)

local function indexof(table, key)
    for index, value in ipairs(table) do
        if value == key then
            return index
        end
    end
    return -1
end

---public:
function Dictionary:constructor()
    self.m_dict = {}
    self.m_index = {}
    self.m_count = 0
end

function Dictionary:Add(key, value)
    assert(key ~= nil, "key is null")
    assert(not self:ContainsKey(key), "existing key "..tostring(key))
    self.m_dict[key] = value
    self.m_count = self.m_count + 1
    self.m_index[self.m_count] = key
end

function Dictionary:Get(key)
    return self.m_dict[key]
end

function Dictionary:Remove(key)
    local index = indexof(self.m_index, key)
    assert(index ~= -1, "key not found")

    table.remove(self.m_index, index)
    self.m_count = self.m_count - 1
    self.m_dict[key] = nil
end

function Dictionary:Clear()
    for _, key in ipairs(self.m_index) do
        self:Remove(key)
    end
end

---@return number
function Dictionary:GetCount()
    return self.m_count
end

---@return boolean
function Dictionary:ContainsKey(key)
    return indexof(self.m_index, key) ~= -1
end

---@return boolean
function Dictionary:ContainsValue(value)
    for _, v in pairs(self.m_dict) do
        if v == value then
            return true
        end
    end
    return false
end

function Dictionary:ForEach(func)
    for _, key in ipairs(self.m_index) do
        func(key, self.m_dict[key])
    end
end

function Dictionary:GetEnumerator()
    local i = 0
    return function()
        i = i + 1
        local key = self.m_index[i]
        return key, self.m_index[key]
    end
end

---@return table
function Dictionary:GetKeys()
    return table.copyArray(self.m_index)
end

---@return table
function Dictionary:GetValues()
    local tmp = {}
    for i = 1, self.m_count do
        tmp[i] = self.m_dict[self.m_index[i]]
    end
    return tmp
end

return Dictionary;


