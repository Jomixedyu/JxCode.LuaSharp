
local function SetAge1(i)
    Console.WriteLine("setAge1:", i)
end

local delegate = Delegate.New(nil, SetAge1)

--使用Invoke调用
delegate:Invoke(2)

local function SetAge2(i)
    Console.WriteLine("setAge2:", i)
end
--添加多播委托
delegate:Add(nil, SetAge2)
--使用()调用
delegate(4)

--创建实例对象
local TestObject = class.extends("Test.TestObject", Object)
function TestObject:SetNumber(i)
    Console.WriteLine("SetNumber:", i)
end
local testObj = TestObject.New()

Console.WriteLine("add instance method")
delegate:Add(testObj, TestObject.SetNumber)

delegate:Invoke(5)
