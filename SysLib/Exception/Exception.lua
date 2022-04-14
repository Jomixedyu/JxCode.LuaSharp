-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/10/04 02:29
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.Exception : SysLib.Object
local Exception = class.define("SysLib.Exception", SysLib.Object)

function Exception:constructor(message)
    self.m_message = message or String.Empty()
    self.m_track = String.Empty()
end

function Exception:GetMessage()
    return self.m_message
end

function Exception:SetStackTrack(value)
    self.m_track = value
end
function Exception:GetStackTrack()
    return self.m_track
end

function Exception:ToString()
    return self:GetType():GetName()..": "..self.m_message..self.m_track
end

return Exception