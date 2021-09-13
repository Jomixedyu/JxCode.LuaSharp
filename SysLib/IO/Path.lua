-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/04/22 02:07
--- Description  : 路径操作
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.IO.Path
local Path = class.static("SysLib.IO.Path")

local DirectorySeparatorChar = '\\'
local DirectorySeparatorCharCode = string.byte(DirectorySeparatorChar)
local AltDirectorySeparatorChar = '/'
local AltDirectorySeparatorCharCode = string.byte(AltDirectorySeparatorChar)
local VolumeSeparatorChar = ':'
local VolumeSeparatorCharCode = string.byte(VolumeSeparatorChar)


local function NormalizePath(path)
    if String.Contains(path, DirectorySeparatorChar) then
        return String.Replace(path, DirectorySeparatorChar, AltDirectorySeparatorChar)
    end
    return path
end

---@param path string
---@return boolean
function Path.IsRootPath(path)
    if not path or #path < 1 then
        return false
    end

    path = NormalizePath(path)

    if #path > 3 and 
        string.byte(path, #path-2) == VolumeSeparatorCharCode and
        string.byte(path, #path-1) == AltDirectorySeparatorCharCode and
        string.byte(path, #path  ) == AltDirectorySeparatorCharCode then
        return true
    end

    local c = string.byte(path, 1)
    if #path >= 1 and (c == DirectorySeparatorCharCode or c == AltDirectorySeparatorCharCode) then
        return true
    end

    return false
end

---将两个字符串组合成一个路径
---@param path1 string
---@param path2 string
---@return string
function Path.Combine(path1, path2)
    if path1:Length() == 0 then
        return path2
    end
    if path2:Length() == 0 then
        return path1
    end
    if Path.IsRootPath(path2) then
        return path2
    end

    local c = string.char(string.byte(path1, #path1))
    if c ~= DirectorySeparatorChar and c ~= AltDirectorySeparatorChar and c ~= VolumeSeparatorChar then
        return (path1..AltDirectorySeparatorChar..path2):Replace(DirectorySeparatorChar, AltDirectorySeparatorChar)
    end
    return path1..path2
end

---返回指定路径字符串额目录信息
---@param path string
---@return string
function Path.GetDirectoryName(path)
    path = NormalizePath(path)
    local index = path:LastIndexOf(AltDirectorySeparatorChar)
    if index ~= -1 then
        path = path:Substring(1, index - 1)
    end
    
    return path
end

---返回指定路径字符串额扩展名
---@param path string
---@return string
function Path.GetExtension(path)
    path = Path.GetFileName(path)
    local index = path:LastIndexOf('.')
    if index ~= -1 then
        path = path:Substring(index + 1)
    end
    return path
end

---返回指定路径字符串的文件名和扩展名
---@param path string
---@return string
function Path.GetFileName(path)
    path = NormalizePath(path)
    local index = path:LastIndexOf(AltDirectorySeparatorChar)
    if index ~= -1 then
        path = path:Substring(index + 1)
    end
    return path
end

---返回不具有扩展名的指定路径字符串的文件名
---@param path string
---@return string
function Path.GetFileNameWithoutExtension(path)
    path = Path.GetFileName(path)
    if path:Contains('.') then
        path = path:Substring(1, path:LastIndexOf('.') - 1)
    end
    return path
end

return Path