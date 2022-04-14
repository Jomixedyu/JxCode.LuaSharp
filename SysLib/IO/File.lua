-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/14 00:19
--- Description  : 文件读写
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

---@class SysLib.IO.File
local File = class.static("SysLib.IO.File")

---读取文件中的所有文本
---@param path string
---@return string
function File.ReadAllText(path)
    local r = File.ReadAllLines(path)
    return table.concat(r:GetTableRef(), "\n")
end

---读取文件中的所有行
---@param path string
---@return SysLib.Collections.List
function File.ReadAllLines(path)
    local strs = SysLib.Collections.List.new()
    for line in io.lines(path) do
        strs:Add(line)
    end
    return strs
end

---将文本写入文件
---@param path string
---@param content string
function File.WriteAllText(path, content)
    local fp = io.open(path, 'w')
    fp:write(content)
    fp:close()
end

---将所有行写入文件
---@param path string
---@param contents SysLib.Collections.List
function File.WriteAllLines(path, contents)
    local strs = table.concat(contents, '\n')
    File.WriteAllText(path, strs)
end

---追加文本至文件最后
---@param path string
---@param contents SysLib.Collections.List
function File.AppendAllLines(path, contents)
    local str = table.concat(contents, '\n')
    File.AppendAllText(path, str)
end

---追加文本至文件最后
---@param path string
---@param content string
function File.AppendAllText(path, content)
    local fp = io.open(path, 'a+')
    fp:write(content)
    fp:close()
end

---文件是否存在
---@param path string
---@return boolean
function File.Exist(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

---删除文件
---@param path string
function File.Delete(path)
    os.remove(path)
end

---复制文件
---@param sourceFileName string
---@param destFileName string
function File.Copy(sourceFileName, destFileName)
    local sfp = io.open(sourceFileName, "rb")
    local len = sfp:seek("end")
    sfp:seek("set", 0)
    local data = sfp:read(len)
    local dfp = io.open(destFileName, "wb")
    dfp:write(data)
    sfp:close()
    dfp:close()
end

---移动文件
---@param sourceFileName string
---@param destFileName string
function File.Move(sourceFileName, destFileName)
    File.Copy(sourceFileName, destFileName)
    File.Delete(sourceFileName)
end

return File