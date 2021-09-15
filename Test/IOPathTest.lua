
local path1 = "C:\\\\Windows"
local path2 = "SysLib32"

local combinePath = Path.Combine(path1, path2)
assert(combinePath == "C://Windows/SysLib32")

local path3 = "file://root"
local path4 = "picture"
local combinePath2 = Path.Combine(path3, path4)
assert(combinePath2 == "file://root/picture")

local filePath = "D://Picture/profile3.jpg"
assert(Path.GetDirectoryName(filePath) == "D://Picture")
assert(Path.GetFileName(filePath) == "profile3.jpg")
assert(Path.GetFileNameWithoutExtension(filePath) == "profile3")
assert(Path.GetExtension(filePath) == "jpg")
