
local list = List.New()
list:Add("i1")
list:Add("i2")
list:Add(nil)
list:AddTableRange({"i3", "i4"})
assert(list:GetCount() == 5)

--可以使用三种遍历方式

-- 1.ForEach方法
local it1 = ""
list:ForEach(function(item)
    if not item then
        it1 = it1.."nil"
    else
        it1 = it1..item
    end
end)
assert(it1 == "i1i2nili3i4")

-- 2.迭代器
local it2 = ""
for index, value in list:GetEnumerator() do
    if not value then
        it2 = it2.."nil"
    else
        it2 = it2..value
    end
end
assert(it2 == "i1i2nili3i4")

-- 3.或者使用each
local it3 = ""
for index, value in each(list) do
    if not value then
        it3 = it3.."nil"
    else
        it3 = it3..value
    end
end
assert(it3 == "i1i2nili3i4")

assert(list:IndexOf("i2") == 2)
assert(list:IndexOf("i4") == 5)
assert(list:IndexOf("i5") == -1)

list:RemoveAt(2)
assert(list:GetCount() == 4)
list:Clear()
assert(list:GetCount() == 0)