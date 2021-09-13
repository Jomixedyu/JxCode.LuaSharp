-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/06/04 03:02
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class System.Array
local Array = class.static("System.Array")


---从第一个元素开始复制Array中的一系列元素，将它们粘贴到另一Array中（从第一个元素开始）。
---@param sourceArray table @包含要复制的数据的Array
---@param sourceIndex number @它表示sourceIndex中复制开始处的索引
---@param destinationArray table @接收数据的Array
---@param destinationIndex number @它表示destinationArray中储存开始处的索引
---@param length number @复制的长度
---@return table
function Array.Copy1(sourceArray, sourceIndex, destinationArray, destinationIndex, length)
    for i = 0, length - 1 do
        destinationArray[destinationIndex + i] = sourceArray[sourceIndex + i]
    end
end

---从第一个元素开始复制Array中的一系列元素，将它们粘贴到另一Array中（从第一个元素开始）。
---@param sourceArray table @包含要复制的数据的Array
---@param destinationArray table @接收数据的Array
---@param length number @复制的长度
---@return table
function Array.Copy2(sourceArray, destinationArray, length)
    for i = 1, length do
        destinationArray[i] = sourceArray[i]
    end
end

---在Array中搜寻指定对象，并返回首个匹配项的索引
---@param array table @要搜索的数组
---@param value any @要查找的值
---@return number @索引值（从1开始），-1为未找到
function Array.IndexOf(array, value)
    for i = 1, #array do
        if array[i] == value then
            return i
        end
    end
    return -1
end

---在Array中搜寻指定对象，并返回最后一个匹配项的索引
---@param array table @要搜索的数组
---@param value any @要查找的值
---@return number @索引值（从1开始），-1为未找到
function Array.LastIndexOf(array, value)
    for i = #array, 1, -1 do
        if array[i] == value then
            return i
        end
    end
    return -1
end

return Array