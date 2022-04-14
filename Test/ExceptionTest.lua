
local errCode = 0

local function TestFunction()
    throw(ArgumentException.new("参数错误"))
    -- throw(IOException.new("文件打开错误"))
    -- throw(IndexOutOfRangeException.new("下标越界"))
    -- throw(8)
    -- error("遇到了一个错误")
end

try(function()
    TestFunction()
end)
.catch(gettype(ArgumentException), function(_e)
    errCode = 1
end)
.catch(gettype(IOException), function(_e)
    errCode = 2
end)
.catch(gettype(Exception), function(_e)
    errCode = 3
end)
.catch(function(e)
    errCode = 4
end)
.finally(function()
    --无论是否发生异常该函数必定执行
end)

assert(errCode == 1)