-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/10/04 01:56
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.ArgumentNullException : SysLib.ArgumentException
local ArgumentNullException, base = class.extends("SysLib.ArgumentNullException", SysLib.ArgumentException)


return ArgumentNullException