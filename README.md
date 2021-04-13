# LuaSharp

[https://img.shields.io/badge/Release-1.0.0-brightgreen]()

### 为什么说适合熟悉C#的Lua开发者
* 拥有C#关键字与类型系统的Lua面向对象系统，拥有常用的容器、类库、try-catch异常处理等工具，更适用于熟悉.Net的Lua/Unity开发者。 

## 可以在这里看到的内容
* 拥有类(class)，类型(Type)，实例(instance) 继承等面向对象的系统
* throw抛出异常与try...catch...finally异常捕捉
* 直接在类中写重载运算符，如```function operatorAdd(target)```。
* 支持gettype(class) 使用obj:GetType() 方法，每个类型对象唯一
* istype关键字，istype(obj, class)，可判断实例是否属于类型。
* List动态数组，Dictionary有序字典，Stack与Queue常用四容器。
* 新增```each(ienumerable)```语法，只要是实现了GetEnumerator方法的容器，都可以使用each进行迭代。
* 位运算
* 支持Flag的枚举类
* Delegate委托，支持多播，委托同时可以像C#一样支持使用Invoke()或者直接()执行。
* 字符串类，让字符串变量拥有成员方法，如```str:Replace("a", "b")```
* 字符串其他封装，如普通的Length()长度与CharLength()可以包含中文长度的函数等。
* IO操作，File.WriteAllText 文件读写、复制、删除等操作方法，Path 路径相关操作类
* 字符串构建器StringBuilder，减少字符串连接的GC
* Lua对象的序列化与反序列化

### 关于命名
本框架使用Pascal命名规则，核心级函数（关键字）为全小写，私有成员可以使用m_member或者__menmber来提醒其他开发者不要来使用该成员。

### 用途
* 普通Lua开发
* UnityEngine

### 关于智能提示
本框架推荐使用VSCode + EmmyLua插件进行开发，同时对VSCode的代码片段Snippets进行配置，可以达到同比VS的快速开发。  

### 如何使用本库
将SysLib文件夹放进你的工程目录  
在使用之前（一般在程序入口处）使用require加载库，如：
```lua
SYSLIB_SIMPLENAME = true
require "SysLib._include"
```
其中```SYSLIB_SIMPLENAME = true```可以让该库中的类使用短名称，正常情况下使用类需要使用完全限定名如```System.Collection.List.New()```，如果在加载库前将该全局变量设置为true则可以使用短名称```List.New()```

## 类型与对象
类使用class.extends关键字来继承，一个lua模块对应一个类，基类是可选的，如果不写则继承于SysLib.Object
```lua
class.extends(类名, 基类)
```
为了标识每个类的不同，可以采用路径全名的命名方式来声明。
```lua
local List, base = class.extends("SysLib.Collections.List", Object)
```
自定义类型声明
```lua
local TestClass, base = class.extends("TestClass", Object)
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
local tc = TestClass.New()
```
支持type对比，gettype为本框架的类型获取关键字
```lua
tc:GetType() == gettype(TestClass) -- true
```
判断一个实例是否属于类型：  
```lua
istype(tc, TestClass) --true
istype(tc, Object) --true
istype(tc, Human) --false
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
local sb = StringBuilder.New()
sb:Append("you")
sb:Append(" and ")
sb:Append("me")
sb:AppendLine("AppendLine")
sb:ToString()
```

## 枚举类型
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
local TestClass, base = class.extends("TestClass", Object)

function TestClass:constructor(n1)
    self.n = n1
end

---运算符重载
function TestClass.operatorAdd(target, target2)
    return TestClass.New(target.n + target2.n)
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

## 容器
常用的List和Dictionary实现了GetEnumerator方法，可以直接使用each迭代器，同时也支持lua原版的ipairs与pairs迭代器，并且容器拥有ForEach方法迭代器。  
```lua
local arr = List.New()
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
    throw(ArgumentException.New("参数错误"))
    -- throw(IOException.New("文件打开错误"))
    -- throw(IndexOutOfRangeException.New("下标越界"))
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
* File.ReadAllText(path)
* File.ReadAllLines(path)
* File.WriteAllText(path, content)
* File.WriteAllLines(path, contents)
* File.AppendAllText(path, content)
* File.AppendAllLines(path, contents)
* File.Exist(path)
* File.Copy(path, targetPath)
* File.Move(path, targetPath)
* File.Delete(path)

## 位运算
* BitMath类， And、Or、Xor、Not、LShift、RShift


## 委托
C#在语言层面实现委托，将实例封装在委托对象中，而Lua则需要对对象进行绑定（类似于C++std）


### 额外的其他东西
* 序列化方法，将lua表转换为字符串，或将字符串反序列化为lua语句/表
* Lua表的拓展功能，数组拷贝、深拷贝等
