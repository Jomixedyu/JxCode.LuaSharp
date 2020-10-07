-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/14 00:25
--- Description  : 字符串构建
------------------------------------------------
---@class System.Text.StringBuilder : System.Object
local StringBuilder, base = class.extends("System.Text.StringBuilder", System.Object)
System.Text.StringBuilder = StringBuilder

function StringBuilder:constructor()
    self.m_strs = {}
end

---@param content string
function StringBuilder:Append(content)
    table.insert(self.m_strs, content)
end

---@param content string
function StringBuilder:AppendLine(content)
    if content then
        table.insert(self.m_strs, content)
    end
    table.insert(self.m_strs, "\n")
end

---@return string
function StringBuilder:ToString()
    return table.concat(self.m_strs)
end

function StringBuilder:Clear()
    self.m_strs = {}
end

return StringBuilder
