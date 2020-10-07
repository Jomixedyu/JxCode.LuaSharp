-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/15 23:59
--- Description  : 控制台接口
------------------------------------------------
local Console = class.static("System.Console")

function Console.WriteLine(...)
    print(...)
end

function Console.Write(...)
    print(...)
end

return Console