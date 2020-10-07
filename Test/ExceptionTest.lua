

local function TestFunction()
    throw(ArgumentException.New("参数错误"))
    -- throw(IOException.New("文件打开错误"))
    -- throw(IndexOutOfRangeException.New("下标越界"))
    -- throw(8)
    -- error("遇到了一个错误")
end

try(function()
    TestFunction()
end)
.catch(gettype(ArgumentException), function(_e)
    ---@type ArgumentException
    local e = _e
    Console.WriteLine("ArgumentException")
    Console.WriteLine(e:ToString())
end)
.catch(gettype(IOException), function(_e)
    ---@type IOException
    local e = _e
    Console.WriteLine("IOException")
    Console.WriteLine(e:ToString())
end)
.catch(gettype(Exception), function(_e)
    --捕捉所有框架类型的异常
    ---@type Exception
    local e = _e
    Console.WriteLine("Exception")
    Console.WriteLine(e:ToString())
end)
.catch(function(e)
    --捕捉所有其他异常
    Console.WriteLine("other exception")
    Console.WriteLine(tostring(e))
end)
.finally(function()
    --无论是否发生异常该函数必定执行
    Console.WriteLine("finally function")
end)