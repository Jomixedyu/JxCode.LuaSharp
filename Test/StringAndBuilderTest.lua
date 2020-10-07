
local str = "Hello_World"
--常用函数
Console.WriteLine("lower: "..str:ToLower())
Console.WriteLine("upper: "..str:ToUpper())
Console.WriteLine("StartWith Hello: "..tostring(str:StartsWith("Hello")))
Console.WriteLine("EndWith Worl: "..tostring(str:EndsWith("Worl")))
local splitArr = str:Split('_')
Console.WriteLine("Split: "..splitArr[1]..", "..splitArr[2])
Console.WriteLine("Contains _: "..tostring(str:Contains('_')))

Console.WriteLine("IndexOf: "..tostring(str:IndexOf('o')))
Console.WriteLine("LastIndexOf: "..tostring(str:LastIndexOf('o')))

local space = "  "..str.."  "
Console.WriteLine("Trim: "..space:Trim())

--中文字符的长度获取
local zhStr = "Hello渔"
Console.WriteLine("zhStr len: "..tostring(zhStr:Length())) --result: 8
Console.WriteLine("zhStr charlen: "..tostring(zhStr:CharLength())) --result: 6

--字符数组
local strCharArr = str:ToCharArray()
Console.WriteLine("charArr: "..Serialization.Serialize(strCharArr))
local newStr = String.New(strCharArr)
Console.WriteLine("NewString: "..newStr)

local sb = StringBuilder.New()
sb:Append("hello")
sb:AppendLine("world")
Console.WriteLine("StringBuilder:", sb:ToString())