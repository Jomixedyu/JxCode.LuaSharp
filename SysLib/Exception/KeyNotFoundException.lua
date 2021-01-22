-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/10/04 02:32
--- Description  : 
------------------------------------------------

---@class SysLib.KeyNotFoundException : SysLib.Exception
local KeyNotFoundException, base = class.extends("SysLib.KeyNotFoundException", SysLib.Exception)


return KeyNotFoundException