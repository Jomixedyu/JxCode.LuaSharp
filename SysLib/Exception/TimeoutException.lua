-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/10/04 02:33
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.TimeoutException : SysLib.Exception
local TimeoutException, base = class.define("SysLib.TimeoutException", SysLib.Exception)


return TimeoutException