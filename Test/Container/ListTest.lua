
local list = List.New()
list:Add("item1")
list:Add("item2")
list:Add(nil)
list:Add("item3")

Console.WriteLine("listCount:", list:GetCount())

--可以使用三种遍历方式

-- 1.ForEach方法
Console.WriteLine("ForEachMemberFunction:")
list:ForEach(function(item)
    Console.WriteLine(item)
end)

-- 2.迭代器
Console.WriteLine("Enumerator:")
for index, value in list:GetEnumerator() do
    Console.WriteLine(value)
end

-- 3.或者使用each
Console.WriteLine("Each:")
for index, value in each(list) do
    Console.WriteLine(value)
end

Console.WriteLine("item2 IndexOf:", list:IndexOf("item2")) -- 2
Console.WriteLine("item4 IndexOf:", list:IndexOf("item4")) -- -1

--使用GetCount或#获得数量
list:RemoveAt(2)
Console.WriteLine("RemoveAt:", list:GetCount())
list:Clear()