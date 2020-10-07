local dict = Dictionary.New()

dict:Add("user1", "pw1")
dict:Add("user2", "pw2")
dict:Add("user3", "pw3")

Console.WriteLine("Count: ", dict:GetCount())

--直接用key获取value
Console.WriteLine("user1: ", dict["user1"])

--三种遍历方式
Console.WriteLine("ForEachMemberFunction:")
dict:ForEach(function(k, v)
    Console.WriteLine(k, v)
end)

Console.WriteLine("LuaForEach:")
for key, value in pairs(dict) do
    Console.WriteLine(key, value)
end

Console.WriteLine("Enumerable:")
for k, value in each(dict) do
    Console.WriteLine(k, value)
end

Console.WriteLine("ContainsKey user3: ", dict:ContainsKey("user3"))
Console.WriteLine("ContainsKey user4: ", dict:ContainsKey("user4"))

Console.WriteLine("Dict Count: ", dict:GetCount())

local keys = dict:GetKeys()
local values = dict:GetValues()

for i = 1, dict:GetCount() do
    Console.WriteLine("keyValuePair: ", keys[i], values[i])
end

--可以用GetCount和#获取字典元素数量
dict:Remove("user2")
Console.WriteLine("Remove: ", dict:GetCount())
dict:Clear()
Console.WriteLine("Clear: ", #dict)
