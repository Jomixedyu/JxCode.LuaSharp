
--委托
local SetAge1Rst

local function SetAge1(i)
    SetAge1Rst = i
end
local delegate = Delegate.new(nil, SetAge1)
--使用Invoke调用
delegate:Invoke(2)
assert(SetAge1Rst == 2)


--实例委托
local SetNumberRst

local TestObject = class.define("Test.TestObject", Object)
function TestObject:SetNumber(i)
    SetNumberRst = i
end

local testObj = TestObject.new()
--提供实例
local delegate2 = Delegate.new(testObj, TestObject.SetNumber)
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

local event = Event.new()
event:Add(nil, EventFun1)
event:Add(Delegate.new(nil, EventFun2))
event:Invoke()

assert(EventFunRst == 5)