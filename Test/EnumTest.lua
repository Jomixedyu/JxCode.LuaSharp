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

Console.WriteLine(Enum.HasFlag(fileType, FileType.JPG)) --result: true
Console.WriteLine(Enum.HasFlag(fileType, FileType.PNG)) --result: true
Console.WriteLine(Enum.HasFlag(fileType, FileType.GIF)) --result: false

---jpgName: string
local jpgName = Enum.GetName(FileType, FileType.JPG)

Console.WriteLine("EnumName: "..jpgName)