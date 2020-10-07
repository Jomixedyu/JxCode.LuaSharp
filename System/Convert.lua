-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/15 23:59
--- Description  : 类型转换操作类
------------------------------------------------
---@class System.Convert
local Convert = class.static("System.Convert")

function Convert.ToInt(s)
    return math.floor(tonumber(s))
end

function Convert.ToBoolean(v)
    local _type = type(v)
    if _type == 'nil' then
        return false
    elseif _type == 'number' then
        return v ~= 0
    elseif _type == 'string' then
        local t = {
            ['true'] = true,
            ['false'] = false,
        }
        local str = v:ToLower()
        if str == "true" then
            return true
        elseif str == "false" then
            return false
        else
            throw(System.ArgumentException.New("value is not true or false"))
        end
    else
        throw(System.ArgumentException.New("Type Error"))
    end
end

number = {}
number.Parse = tonumber

bool = {}
bool.Parse = Convert.ToBoolean

return Convert