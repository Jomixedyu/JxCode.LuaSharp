local str = "Hello_World"
--常用函数
assert(str:ToLower() == "hello_world")
assert(str:ToUpper() == "HELLO_WORLD")

assert(str:StartsWith("Hello") == true)
assert(str:StartsWith("wHello") == false)

assert(str:EndsWith("World") == true)
assert(str:EndsWith("Worl") == false)

local splitArr = str:Split("_")
assert(splitArr[1] == "Hello")
assert(splitArr[2] == "World")

assert(str:Contains("_") == true)
assert(str:Contains(".") == false)

assert(str:IndexOf("o") == 5)
assert(str:LastIndexOf("o") == 8)

local space = "  " .. str .. "  "
assert(space:Trim() == str)

--中文字符的长度获取
local zhStr = "Hello渔"
assert(zhStr:Length() == 8)
assert(zhStr:CharLength() == 6)

--字符数组
local strCharArr = str:ToBytes()
assert(
    table.equals(
        strCharArr,
        {
            string.byte("H"),
            string.byte("e"),
            string.byte("l"),
            string.byte("l"),
            string.byte("o"),
            string.byte("_"),
            string.byte("W"),
            string.byte("o"),
            string.byte("r"),
            string.byte("l"),
            string.byte("d")
        }
    )
)

local newStr = String.New(strCharArr)
assert(newStr == str)

-- StringBuilder
local sb = StringBuilder.New()
sb:AppendLine("hello")
sb:Append("world")
assert(sb:ToString() == "hello\nworld")
