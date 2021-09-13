-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:57
--- Description  : 字符串处理
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
local String = {}

local empty = ""
function String.Empty()
    return empty
end

---字符串切割
---@return table
function String:Split(delimiter)
    if delimiter == '' then return false end
    local pos = 0
    local arr = {}
    for st,sp in function() return string.find(self, delimiter, pos, true) end do
        table.insert(arr, string.sub(self, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(self, pos))
    return arr
end

---替换字符串
---@return string
function String:Replace(findStr, targetStr)
    return string.gsub(self, findStr, targetStr)
end

---清除空格
---@return string
function String:Trim()
    return string.gsub(self, "^%s*(.-)%s*$", "%1")
end

---转换为小写
---@return string
function String:ToLower()
    return string.lower(self)
end

---转换为大写
---@return string
function String:ToUpper()
    return string.upper(self)
end

---字符串格式化
---@return string
function String.Format(str, ...)
    local parms = {...}
    local result = str
    for index, value in ipairs(parms) do
        result = String.Replace(result, "{"..tostring(index-1).."}", tostring(value))
    end
    return result
end

---@return boolean
function String:Contains(char)
	local find_pos_begin, find_pos_end = string.find(self, char, 1, true)
	return find_pos_begin ~= nil
end
---@return boolean
function String:StartsWith(start_pattern)
	local find_pos_begin, find_pos_end = string.find(self, start_pattern, 1, true)
	return find_pos_begin == 1
end

---以某个字符串结尾
---@return boolean
function String:EndsWith(start_pattern)
	local find_pos_begin, find_pos_end = string.find(self, start_pattern, -#start_pattern, true)
	return find_pos_end == #self
end

---截取字符串，索引从1开始
---@return string
function String:Substring(startIndex, length)
    length = length or -1
    return string.sub(self, startIndex ,length)
end

---字符串转换为字节数组
---@return table
function String:ToCharArray()
    local tb = {}
    for i = 1, #self do
        tb[i] = string.byte(self, i)
    end
    return tb
end


---UTF8字符串长度
---@return number
function String:Length()
    return string.len(self)
end

---从字符数组创建字符串
---@param charArray table
---@return string
function String.New(charArray)
    return string.char(table.unpack(charArray))
end

---字符串长度（包含多字节字符）
---@return number
function String:CharLength()
    local index = 1
    local len = 0
    while index < #self do
        local char = string.byte(self, index)
        if char <= 127 then     -- 0xxxxxxx
            index = index + 1
        elseif char <= 223 then -- 110xxxxx
            index = index + 2
        elseif char <= 239 then -- 1110xxxx
            index = index + 3
        elseif char <= 247 then -- 11110xxx
            index = index + 4
        elseif char <= 251 then -- 111110xx
            index = index + 5
        elseif char <= 253 then -- 1111110x
            index = index + 6
        end
        len = len + 1
    end
    return len
end

---@param str string
function String:IndexOf(str)
    if not str or str == String.Empty() then
        return -1
    end
    
    local char = str:ToCharArray()
    local selfChar = self:ToCharArray()

    for i = 1, #selfChar do
        if selfChar[i] == char[1] and #char <= #selfChar - i then
            local matchNum = 0
            for c_i = 1, #char do
                if char[c_i] == selfChar[i + c_i - 1] then
                    matchNum = matchNum + 1
                end
            end

            if matchNum == #char then
                return i
            end

        end
    end

    return -1

    -- return string.find(self, str, 1)
end

function String:LastIndexOf(str)

    if not str or str == String.Empty() then
        return -1
    end

    local char = str:ToCharArray()
    local charLen = #char
    local selfChar = self:ToCharArray()
    local selfCharLen = #selfChar

    for i = selfCharLen, 1, -1 do
        if selfChar[i] == char[charLen] and charLen <= selfCharLen - i then
            local matchNum = 0

            for c_i = charLen, 1, -1 do
                if char[c_i] == selfChar[i - (charLen - c_i)] then
                    matchNum = matchNum + 1
                end
            end
            if matchNum == charLen then
                return i
            end
        end
    end

    return -1
    -- return string.find(self, str, -1)
end

string.Split = String.Split
string.Replace = String.Replace
string.Trim = String.Trim
string.ToLower = String.ToLower
string.ToUpper = String.ToUpper
string.Format = String.Format
string.Contains = String.Contains
string.StartsWith = String.StartsWith
string.EndsWith = String.EndsWith
string.Substring = String.Substring
string.Length = String.Length
string.ToCharArray = String.ToCharArray
string.CharLength = String.CharLength
string.IndexOf = String.IndexOf
string.LastIndexOf = String.LastIndexOf

return String