
local aFile = "D:\\a.txt"
local content = "lua script"
--写入到文件
File.WriteAllText(aFile, content)
--追加内容
File.AppendAllText(aFile, "\nAppendContent")
--复制
File.Copy(aFile, "D:\\copy.txt")
--移动 改名
File.Move("D:\\copy.txt", "D:\\copyMove.txt")
--读取
local str = File.ReadAllText(aFile)

assert(str == content.."\nAppendContent")

File.Delete(aFile)
File.Delete("D:\\copyMove.txt")