-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/10/04 02:33
--- Description  : 
------------------------------------------------

---@class System.TimeoutException : System.Exception
local TimeoutException, base = class.extends("System.TimeoutException", System.Exception)


return TimeoutException