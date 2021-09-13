-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/04 19:41
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.BitMath
local BitMath = class.static("SysLib.BitMath")


local function _and(n1, n2)
    return n1 == 1 and n2 == 1 and 1 or 0
end

local function _or(n1, n2)
    return (n1 == 1 or n2 == 1) and 1 or 0
end

local function _xor(n1, n2)
    return n1 + n2 == 1 and 1 or 0
end

local function _opr(n1, n2, action)
    if n1 < n2 then n2, n1 = n1, n2 end
    local rst = 0
    local shift = 1
    while n1 ~= 0 do
        local ra = n1 % 2
        local rb = n2 % 2
        rst = rst + shift * action(ra, rb)
        n1 = math.floor(n1 / 2)
        n2 = math.floor(n2 / 2)
        shift = shift * 2
    end
    return rst
end

function BitMath.And(n1, n2)
    return _opr(n1, n2, _and)
end

function BitMath.Or(n1, n2)
    return _opr(n1, n2, _or)
end

function BitMath.Xor(n1, n2)
    return _opr(n1, n2, _xor)
end

function BitMath.Not(num)
    return num > 0 and -(num + 1) or -num - 1
end

function BitMath.LShift(num, shift)
    return num * (2 ^ shift)
end

function BitMath.RShift(num, shift)
    return math.floor(num / (2 ^ num))
end

return BitMath