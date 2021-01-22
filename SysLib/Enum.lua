-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/04 19:43
--- Description  : 
------------------------------------------------
---@class SysLib.Enum
local Enum = class.static("SysLib.Enum")


---@return number
function Enum.NewFlag(...)
    local t = {...}
    local result = 0
    for i = 1, #t do
        if result ~= 0 then
            result = BitMath.Or(result, t[i])
        else
            result = t[1]
        end
    end
    return result
end


function Enum.HasFlag(enum, flag)
    local bitPos = 0

    while flag ~= 0 do
        flag = math.floor(flag / 2)
        if flag ~= 0 then --最后为0时不增加位置
            bitPos = bitPos + 1
        end
    end
    
    for i = 1, bitPos do
        enum = math.floor(enum / 2)
    end

    local enummod = enum % 2
    if enummod == 1 then
        return true
    else
        return false
    end
end

---用值获取名字
function Enum.GetName(enum, value)
    for k, v in pairs(enum) do
        if value == v then
            return k
        end
    end
end



return Enum