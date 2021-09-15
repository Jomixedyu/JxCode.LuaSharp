--Enum
local FileType = {
    TXT = 1,
    JPG = 2,
    PNG = 4,
    GIF = 8,
    PSD = 16,
}

local _fileType = FileType.JPG

local fileType = Enum.NewFlag(FileType.JPG, FileType.PNG)

assert(Enum.HasFlag(fileType, FileType.JPG) == true)
assert(Enum.HasFlag(fileType, FileType.PNG) == true)
assert(Enum.HasFlag(fileType, FileType.GIF) == false)

---jpgName: string
local jpgName = Enum.GetName(FileType, FileType.JPG)

assert(jpgName == "JPG")