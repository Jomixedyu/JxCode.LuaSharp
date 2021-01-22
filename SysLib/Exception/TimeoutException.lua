-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/10/04 02:33
--- Description  : 
------------------------------------------------

---@class SysLib.TimeoutException : SysLib.Exception
local TimeoutException, base = class.extends("SysLib.TimeoutException", SysLib.Exception)


return TimeoutException