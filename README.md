# JxCode.LuaSharp
![](https://img.shields.io/github/license/JomiXedYu/JxCode.LuaSharp?style=for-the-badge)
![](https://img.shields.io/github/v/release/JomiXedYu/JxCode.LuaSharp?style=for-the-badge)
![](https://img.shields.io/github/release-date/JomiXedYu/JxCode.LuaSharp?style=for-the-badge)

该库提供了类型系统、常用容器、常用类库与异常处理等工具，拥有实用且轻量的工具可以轻量开发简单的程序，本着lua语言的定位，该库并不会增加更多繁重的内容，复杂功能推荐使用宿主语言实现。  

## Feature
* 拥有C#关键字与类型系统的Lua面向对象系统，拥有常用的容器、类库、try-catch异常处理等工具，更适用于熟悉.Net的Lua/Unity开发者。
* 本框架使用Pascal命名规则，核心级函数（关键字）为全小写，私有成员可以使用m_member或者__menmber来提醒其他开发者不要来使用该成员。
* 可以用于普通Lua开发或者嵌入其他程序中执行，可用于Unity开发。
* 推荐使用VSCode + EmmyLua插件进行开发，同时对VSCode的代码片段Snippets进行配置，可以达到同比VS的快速开发。
## Contents
- [JxCode.LuaSharp](#jxcodeluasharp)
  - [Feature](#feature)
  - [Contents](#contents)
  - [将库引入项目](#将库引入项目)
  - [类型与对象](#类型与对象)
  - [字符串](#字符串)
  - [位运算](#位运算)
  - [枚举类型与Flag](#枚举类型与flag)
  - [运算符重载](#运算符重载)
  - [类型转换](#类型转换)
  - [迭代器](#迭代器)
  - [容器](#容器)
  - [抛出异常与捕捉异常](#抛出异常与捕捉异常)
  - [文件处理](#文件处理)
  - [委托](#委托)
  - [事件](#事件)
  - [单元测试](#单元测试)
  - [序列化](#序列化)
  - [实用工具](#实用工具)


## 将库引入项目
将SysLib文件夹放进你的工程目录  
在使用之前（一般在程序入口处）使用require加载库，如：
```lua
SYSLIB_SIMPLENAME = true
require "SysLib._include"
```
其中```SYSLIB_SIMPLENAME = true```可以让该库中的类使用短名称，正常情况下使用类需要使用完全限定名如```System.Collection.List.new()```，如果在加载库前将该全局变量设置为true则可以使用短名称```List.new()```

## 类型与对象
类使用class.define关键字来继承，一个lua模块对应一个类，基类是可选的，如果不写则继承于SysLib.Object
```lua
class.define(类名, 基类)
```
为了标识每个类的不同，可以采用路径全名的命名方式来声明。
```lua
local List, base = class.define("SysLib.Collections.List", Object)
```
自定义类型声明
```lua
local TestClass, base = class.define("TestClass", Object)
--构造函数
function TestClass:constructor()
    base.constructor(self)
    Console.WriteLine("Hello World")
end

return TestClass
```
关于构造函数：  
- 类型中使用constructor函数作为构造函数  
- 如果一个类不存在一个构造函数则默认使用上一级基类的构造函数  
- 如果一个类存在一个构造函数，并且基类非Object类型时，则需要满足基类的构造，在构造函数开始时使用```base.constructor(self, ...)```进行基类的初始化

实例化
```lua
local tc = TestClass.new()
```
或者
```lua
local tc = TestClass()
```
如果给类型添加

支持type对比，gettype为本框架的类型获取关键字
```lua
tc:GetType() == gettype(TestClass) -- true
```
判断一个实例是否属于类型（包含派生）：  
```lua
istype(tc, gettype(TestClass)) --true
istype(tc, gettype(Object)) --true
istype(tc, gettype(Human)) --false
```
或者使用Class而不是Type
```lua
instanceof(tc, TestClass) --true
instanceof(tc, Object) --true
instanceof(tc, Human) --false
```

对继承类型判定
```lua
--确定 Type 是否派生自 Object
gettype(Type):IsSubclassOf(typeof(Object))
```
支持Equals的重写的对比:  
```lua
tc:Equals(target)
```
Object静态方法，对比地址：
```lua
Object.Equals(tc, target)
```

声明静态类
```lua
local Manamger = class.static("Manamger")
```

## 字符串
可以让字符串变量当做对象来使用，例如
```lua
local str = "Hello World"
str:Replace("World", "God")
str:Length()
-- 获取字符串长度（包含中文等字符）
str:CharLength()
```
如果直接操作字符串则需要使用静态方法  
```lua
local str = String.Replace("Hello World", "World", "God")
```
字符串构建 StringBuilder类
```lua
local sb = StringBuilder.new()
sb:Append("you")
sb:Append(" and ")
sb:Append("me")
sb:AppendLine("AppendLine")
sb:ToString()
```

## 位运算
* BitMath类， And、Or、Xor、Not、LShift、RShift

## 枚举类型与Flag
lua中直接拿表当枚举类型，框架内只是提供了一些处理的方法，如Flag等。  
```lua
AnimalType = {
    Human = 1,
    Dog = 2,
    Cat = 4,
    Bird = 8,
}
```
* 按值获取枚举名
    ```lua
    Enum.GetName(AnimalType, 2)
    ```
* 支持Flag（由位运算“或”驱动）
    ```lua
    --C#: Animal animals = AnimalType.Dog | AnimalType.Cat;
    local animals = Enum.NewFlag(AnimalType.Dog, AnimalType.Cat)
    
    local rst = Enum.HasFlag(animals, AnimalType.Dog)
    ```

## 运算符重载
```lua
---@class TestClass
local TestClass, base = class.define("TestClass", Object)

function TestClass:constructor(n1)
    self.n = n1
end

---运算符重载
function TestClass.operatorAdd(target, target2)
    return TestClass.new(target.n + target2.n)
end

return TestClass
```
运算符重载直接在类中实现，可以搭配VSCode配置Snippets代码片段来达到使用VS的快速开发。 
重载方法名有：
| 函数名      | 重载符号 |
| ----------- | -------- |
| operatorAdd | +        |
| operatorSub | -        |
| operatorMul | *        |
| operatorDiv | /        |
| operatorEq  | ==       |
| Invoke      | ()       |

## 类型转换
Convert类和对应类型的Parse方法
```lua
--基础类型转换
local cint = Convert.ToInt("36.6")
local cint2 = int.Parse("36.6")

local cnum = Convert.ToNumber("66.66")
local cnum = number.Parse("66.66")

local cstr = Convert.ToString(6666)
local cstr2 = tostring(6666)

local cbol = Convert.ToBoolean("true")
local cbo2 = Convert.ToBoolean("true")
local cbo3 = bool.Parse("true")
```
BitConverter 

## 迭代器
lua默认的迭代器只可以对table进行访问，但是该库的四大容器并不是直接储存在table中，这也是为了避免原方法被覆盖，所以可以使用each来遍历四大迭代器。  
如果想继续使用lua原生迭代器，可以使用容器的GetEnumerator方法获取迭代器。  
同样的，容器需要扩展时

## 容器
常用的List和Dictionary实现了GetEnumerator方法，可以直接使用each迭代器，同时也支持lua原版的ipairs与pairs迭代器，并且容器拥有ForEach方法迭代器。  
```lua
local arr = List.new()
arr:Add("苟利国家生死以")
arr:Add("岂因祸福避趋之")
--三种遍历方式 都可以
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
```

## 抛出异常与捕捉异常
```lua
local function TestFunction()
    throw(ArgumentException.new("参数错误"))
    -- throw(IOException.new("文件打开错误"))
    -- throw(IndexOutOfRangeException.new("下标越界"))
    -- throw(8)
    -- error("遇到了一个错误")
end

try(function()
    TestFunction()
end)
.catch(gettype(ArgumentException), function(_e)
    ---@type ArgumentException
    local e = _e
    Console.WriteLine("ArgumentException")
    Console.WriteLine(e:ToString())
end)
.catch(gettype(IOException), function(_e)
    ---@type IOException
    local e = _e
    Console.WriteLine("IOException")
    Console.WriteLine(e:ToString())
end)
.catch(gettype(Exception), function(_e)
    --捕捉所有框架类型的异常
    ---@type Exception
    local e = _e
    Console.WriteLine("Exception")
    Console.WriteLine(e:ToString())
end)
.catch(function(e)
    --捕捉所有其他异常
    Console.WriteLine("other exception")
    Console.WriteLine(tostring(e))
end)
.finally(function()
    --无论是否发生异常该函数必定执行
    Console.WriteLine("finally function")
end)
```

## 文件处理
文件读写提供函数：  
- File.ReadAllText(path)
- File.ReadAllLines(path)
- File.WriteAllText(path, content)
- File.WriteAllLines(path, contents)
- File.AppendAllText(path, content)
- File.AppendAllLines(path, contents)
- File.Exist(path)
- File.Copy(path, targetPath)
- File.Move(path, targetPath)
- File.Delete(path)

路径操作函数：  
- Path.IsRootPath(path)
- Path.Combine(path1, path2)
- Path.GetDirectoryName(path)
- Path.GetExtension(path)
- Path.GetFileName(path)
- Path.GetFileNameWithoutExtension(path)
## 委托
无实例的函数委托
```lua
local function SetAge1(i)
    Console.WriteLine("setAge1:", i)
end
local delegate = Delegate.new(nil, SetAge1)
--使用Invoke调用
delegate:Invoke(2)
```
有实例的函数委托
```lua
local TestObject = class.define("Test.TestObject", Object)
function TestObject:SetNumber(i)
    Console.WriteLine("SetNumber:", i)
end

local testObj = TestObject.new()
--提供实例
local deleg = Delegate.new(testObj, TestObject.SetNumber)
--不光可以使用Invoke，还可以直接用()
deleg(5)
```

## 事件
事件采用多播委托的形式实现
```lua
local function EventFun1()
    Console.WriteLine("EventFun1")
end

local function EventFun2()
    Console.WriteLine("EventFun2")
end

local event = Event.new()
event:Add(nil, EventFun1)
event:Add(Delegate.new(nil, EventFun2))
event:Invoke()
```

## 单元测试
引入库之后，既可使用单元测试模块:  
单元测试以模块为单位，一个模块就是一项测试，一般测试放在Test文件夹中
```lua
if _DEBUG then
    unittest({
        require_test "Test.IOFileTest",
        require_test "Test.IOPathTest",
        require_test "Test.StringAndBuilderTest",
        require_test "Test.EnumTest",
        require_test "Test.DelegateEventsTest",
        require_test "Test.ExceptionTest",
        require_test "Test.OOPTest",
        require_test "Test.BitConverterTest",
        require_test "Test.Container.ListTest",
        require_test "Test.Container.DictionaryTest",
        require_test "Test.Container.StackTest",
        require_test "Test.Container.QueueTest",
        require_test "Test.SerializerTest",
    })
end
```
在进行单元测试时最好使用`_DEBUG`来确定是否执行。  
## 序列化
* 序列化方法，将lua表转换为字符串，或将字符串反序列化为lua语句/表
* Lua表的拓展功能，数组拷贝、深拷贝等

## 实用工具
* 序列化方法，将lua表转换为字符串，或将字符串反序列化为lua语句/表
* Lua表的拓展功能，数组拷贝、深拷贝等