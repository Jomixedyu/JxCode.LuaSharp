-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:59
--- Description  : 时间与日期操作类
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.DateTime : SysLib.Object
local DateTime, base = class.extends("SysLib.DateTime", SysLib.Object)

function DateTime:constructor(near, mouth, day, hour, min, sec)
    self.m_near = near or 0
    self.m_mouth = mouth or 0
    self.m_day = day or 0
    self.m_hour = hour or 0
    self.m_min = min or 0
    self.m_sec = sec or 0
end

function DateTime.Now()
    local n = os.date("%Y")
    local m = os.date("%m")
    local d = os.date("%d")
    local H = os.date("%H")
    local M = os.date("%M")
    local S = os.date("%S")
    return DateTime.new(n, m, d, H, M, S)
end

function DateTime:ToString()
    return String.Format(
        "{0}-{1}-{2} {3}:{4}:{5}",
        self.m_near,
        self.m_mouth,
        self.m_day,
        self.m_hour,
        self.m_min,
        self.m_sec
    )
end

return DateTime
