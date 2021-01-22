-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/10/04 01:56
--- Description  : 
------------------------------------------------

---@class SysLib.ArgumentNullException : SysLib.ArgumentException
local ArgumentNullException, base = class.extends("SysLib.ArgumentNullException", SysLib.ArgumentException)


return ArgumentNullException