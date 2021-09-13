--委托
local function SetAge1(i)
    Console.WriteLine("setAge1:", i)
end
local delegate = Delegate.New(nil, SetAge1)
--使用Invoke调用
delegate:Invoke(2)


--实例委托
local TestObject = class.extends("Test.TestObject", Object)
function TestObject:SetNumber(i)
    Console.WriteLine("SetNumber:", i)
end

local testObj = TestObject.New()
--提供实例
local delegate2 = Delegate.New(testObj, TestObject.SetNumber)
delegate2:Invoke(3)


--Events
local function EventFun1()
    Console.WriteLine("EventFun1")
end

local function EventFun2()
    Console.WriteLine("EventFun2")
end

local event = Event.New()
event:Add(nil, EventFun1)
event:Add(Delegate.New(nil, EventFun2))
event:Invoke()