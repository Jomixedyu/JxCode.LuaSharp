local dict = Dictionary.New()

dict:Add("user1", 1)
dict:Add("user2", 2)
dict:Add("user3", 3)

assert(dict:GetCount() == 3)

assert(dict:Get("user1") == 1)
assert(dict:Get("user3") == 3)

--三种遍历方式

local e1 = 0
local e1k = ""
dict:ForEach(function(k, v)
    e1k = e1k..k
    e1 = e1 + v
end)
assert(e1k == "user1user2user3")
assert(e1 == 6)


local e2 = 0
local e2k = ""
for k, v in dict:GetEnumerator() do
    e2k = e2k..k
    e2 = e2 + v
end
assert(e2k == "user1user2user3")
assert(e2 == 6)

local e3 = 0
local e3k = ""
for k, v in each(dict) do
    e3k = e3k..k
    e3 = e3 + v
end
assert(e3k == "user1user2user3")
assert(e3 == 6)

dict:Remove("user2")
assert(dict:GetCount() == 2)
dict:Clear()
