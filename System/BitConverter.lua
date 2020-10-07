-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/10/06 21:28
--- Description  : 字节类型转换
------------------------------------------------

local BitConverter = class.static("System.BitConverter")


BitConverter.IsLittleEndian = true -- const

---@param num number @int
---@return table
function BitConverter.GetBytesByInt(num)
    local tb = {}
    for i = 4, 1, -1 do
        local l = 2 ^ ((i-1) * 8)
        tb[i] = math.floor(num / l)
        if tb[i] ~= 0 then
            num = num - l
        end
    end
    return tb
end

---@param bytesArray table
---@param startIndex number
---@param length number
---@return number
function BitConverter.ToNumber(bytesArray, startIndex, length)
    local num = 0
    for i = 1, length do
        local index = startIndex + i - 1
        num = num + bytesArray[index] * (2^((i-1)*8))
    end
    return num
end

return BitConverter