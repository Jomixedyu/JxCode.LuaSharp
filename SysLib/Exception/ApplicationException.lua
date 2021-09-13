-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/10/04 02:29
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.ApplicationException : SysLib.Exception
local ApplicationException, base = class.extends("SysLib.ApplicationException", SysLib.Exception)


return ApplicationException