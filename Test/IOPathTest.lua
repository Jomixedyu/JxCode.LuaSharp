
local path1 = "C:\\\\Windows"
local path2 = "SysLib32"

local combinePath = Path.Combine(path1, path2)
Console.WriteLine("CombinePath: "..combinePath)

local path3 = "file://root"
local path4 = "picture"
local combinePath2 = Path.Combine(path3, path4)
Console.WriteLine("CombinePath2: "..combinePath2)

local filePath = "D://Picture/profile3.jpg"
Console.WriteLine("GetDirectoryName: "..Path.GetDirectoryName(filePath))
Console.WriteLine("GetFileName: "..Path.GetFileName(filePath))
Console.WriteLine("GetFileNameWithoutExtension: "..Path.GetFileNameWithoutExtension(filePath))
Console.WriteLine("GetExtension: "..Path.GetExtension(filePath))