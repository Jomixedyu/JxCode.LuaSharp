-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/23 19:31
--- Description  : 有序字典
------------------------------------------------
---@class System.Collections.Dictionary : System.Object
local Dictionary, base = class.extends("System.Collections.Dictionary", System.Object)

---private:
local getmetatable = getmetatable

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
    local meta = getmetatable(self)
    meta.__meta_index = {}
    meta.__meta_count = 0
end

function Dictionary:Add(key, value)
    local k = rawget(self, key)
    assert(k == nil, "Existing key "..tostring(key))

    self[key] = value
    local meta = getmetatable(self)
    meta.__meta_count = meta.__meta_count + 1
    meta.__meta_index[meta.__meta_count] = key
end


function Dictionary:Remove(key)
    assert(self[key] ~= nil , "key not found")

    local meta = getmetatable(self)

    local index = indexof(meta.__meta_index, key)
    assert(index ~= -1, "not found")
    
    table.remove(meta.__meta_index, index)
    meta.__meta_count = meta.__meta_count - 1;
    self[key] = nil
end

function Dictionary:Clear()
    local meta = getmetatable(self)
    for _, key in ipairs(meta.__meta_index) do
        self:Remove(key)
    end
end

---@return number
function Dictionary:GetCount()
    local meta = getmetatable(self)
    return meta.__meta_count
end

---@return boolean
function Dictionary:ContainsKey(key)
    return self[key] ~= nil and true or false
end

---@return boolean
function Dictionary:ContainsValue(value)
    for _, v in pairs(self) do
        if v == value then
            return true
        end
    end
    return false
end

function Dictionary:ForEach(fun)
    local m = getmetatable(self)
    local tempIndex = {}
    --拷贝一份，防止在外面循环时对字典操作可能会出现的错误
    for i = 1, m.__meta_count do
        tempIndex[i] = m.__meta_index[i]
    end
    for _, value in ipairs(tempIndex) do
        fun(value, self[value])
    end
    tempIndex = nil
end

function Dictionary:GetEnumerator()
    local i = 0
    local m = getmetatable(self)
    local tempIndex = {}
    --拷贝一份，防止在外面循环时对字典操作可能会出现的错误
    for i = 1, m.__meta_count do
        tempIndex[i] = m.__meta_index[i]
    end
    return function()
        i = i + 1
        return tempIndex[i], self[tempIndex[i]]
    end
end

---@return table
function Dictionary:GetKeys()
    return table.copyArray(getmetatable(self).__meta_index)
end

---@return table
function Dictionary:GetValues()
    local tmp = {}
    local m = getmetatable(self)
    for i = 1, m.__meta_count do
        tmp[i] = self[m.__meta_index[i]]
    end
    return tmp
end

return Dictionary;


