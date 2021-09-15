
--委托
local SetAge1Rst

local function SetAge1(i)
    SetAge1Rst = i
end
local delegate = Delegate.New(nil, SetAge1)
--使用Invoke调用
delegate:Invoke(2)
assert(SetAge1Rst == 2)


--实例委托
local SetNumberRst

local TestObject = class.extends("Test.TestObject", Object)
function TestObject:SetNumber(i)
    SetNumberRst = i
end

local testObj = TestObject.New()
--提供实例
local delegate2 = Delegate.New(testObj, TestObject.SetNumber)
delegate2:Invoke(3)
assert(SetNumberRst == 3)


--Events
local EventFunRst = 0
local function EventFun1()
    EventFunRst = EventFunRst + 3
end

local function EventFun2()
    EventFunRst = EventFunRst + 2
end

local event = Event.New()
event:Add(nil, EventFun1)
event:Add(Delegate.New(nil, EventFun2))
event:Invoke()

assert(EventFunRst == 5)