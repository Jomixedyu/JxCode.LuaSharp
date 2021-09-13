-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:59
--- Description  : 控制台接口
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
local Console = class.static("SysLib.Console")

function Console.WriteLine(...)
    print(...)
end

function Console.Write(...)
    print(...)
end

return Console