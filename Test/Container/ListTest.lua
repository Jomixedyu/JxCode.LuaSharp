
local list = List.New()
list:Add("item1")
list:Add("item2")
list:Add("item3")

Console.WriteLine("listCount:", list:GetCount())

--可以使用三种遍历方式
Console.WriteLine("ForEachMemberFunction:")
list:ForEach(function(item)
    Console.WriteLine(item)
end)

Console.WriteLine("LuaForEach:")
for index, value in ipairs(list) do
    Console.WriteLine(value)
end

Console.WriteLine("Enumerable:")
for item in each(list) do
    Console.WriteLine(item)
end

Console.WriteLine("IndexOf:", list:IndexOf("item2")) -- 2
Console.WriteLine("IndexOf:", list:IndexOf("item4")) -- -1

--使用GetCount或#获得数量
list:RemoveAt(2)
Console.WriteLine("RemoveAt:", list:GetCount())
list:Clear()
Console.WriteLine("Clear:", #list)