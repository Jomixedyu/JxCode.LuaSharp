# LuaSharp

### 为什么说适合熟悉C#的Lua开发者
* 使lua拥有面向对象的关键字与方法，关键字、方法名、抽象层基本采用自.Net规则。

## 可以在这里看到的内容
* 拥有类(class)，类型(Type)，实例(instance) 继承等面向对象的系统
* 直接在类中写重载运算符。
* 支持gettype(class) / typeof(class) 使用obj:GetType() 方法，每个类型对象唯一
* istype关键字，istype(obj, class)，相当于C#的is，istype可判断继承关系。
* List动态数组，Dictionary有序字典，Stack与Queue常用四容器。
* 新增``` for item in each(ienumertor) do end ```语法，只要是实现了GetEnumerator方法的容器，都可以使用each进行迭代。
* 位运算
* 支持Flag的枚举类
* Delegate委托，支持多播，委托同时可以像C#一样支持使用Invoke()或者直接()执行。
* 字符串的处理类，让字符串变量拥有成员方法，如```str:Replace("a", "b")```
* IO操作，File.WriteAllText 文件读写、复制、删除等操作方法，Path 路径相关操作类
* 字符串构建器，Text.StringBuilder
* throw抛出异常与try...catch...finally异常捕捉
* Lua对象的的序列化与反序列化

### 关于命名
本框架使用Pascal命名规则，核心级函数（关键字）为全小写，私有成员可以使用m_member或者__menmber来提醒其他开发者不要来使用该成员。

### 用途
* 普通Lua开发
* UnityEngine

### 关于智能提示
本框架推荐使用VSCode + EmmyLua插件进行开发，同时对VSCode的代码片段Snippets进行配置，可以达到同比VS的快速开发。  


## 类型与对象
类型的实现结构在最下面  
类使用class.extends关键字来继承，一个lua模块对应一个类，基类是可选的，如果不写则继承于System.Object
```lua
class.extends(类名, 基类)
```
为了标识每个类的不同，可以采用路径全名的命名方式来声明。
```lua
local List, base = class.extends("System.Collections.List", Object)
```
样例
```lua
local TestClass, base = class.extends("TestClass", Object)
--构造函数
function TestClass:constructor()
    Console.WriteLine("Hello World")
end

return TestClass
```

实例化，（C#的new关键字，放在后面是为了更好的智能提示，如果想更接近语法，还提供了new(TestClass)(params)的方法，但是默认没有智能提示。  
```lua
local tc = TestClass.New()
```
支持type对比，（C#的typeof关键字）：  
gettype为本框架的类型获取，而typeof是在声明前先对typeof进行保存在覆盖声明，使用时会判断参数是否为本框架的类型，如果不是则调用保存的typeof方法，主要应对和别的框架一起使用时可能会造成的冲突，如xLua。（注：如其他含有typeof的框架启动于本框架之后，并没对typeof进行处理的话则会出现错误，xLua是在启动之前）
```lua
tc:GetType() == gettype(TestClass)
tc:GetType() == typeof(TestClass)
```
支持包含基类的类型判断，（C#的is关键字）：  
```lua
istype(tc, TestClass) --true
istype(tc, Object) --true
istype(tc, Human) --false
```
对继承类型判定
```lua
--确定 Type 是否派生自 Object
typeof(Type):IsSubclassOf(typeof(Object))
```
支持Equals的重写:  
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
* operatorAdd +
* operatorSub -
* operatorMul *
* operatorDiv /
* operatorEq  ==
* Invoke      ()

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
for item in each(arr) do  --IEnumerator迭代器
    Console.WriteLine("IEnumerator数组迭代器: "..item)
end

for index, value in ipairs(arr) do --lua迭代器
    Console.WriteLine("Lua数组迭代器: "..value)
end

arr:ForEach(function(i, v)  --容器迭代器
    Console.WriteLine("容器数组迭代器: "..v)
end)
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
C#在语言层面实现委托，将实例封装在委托对象中，而Lua使用类似函数指针的方式对其操作，虽然可以用闭包匿名函数的方式来将self保存起来，但是却必须一直保存着匿名函数的引用，否则在进行多播时会无法移除。


### 额外的其他东西
* 序列化方法，将lua表转换为字符串，或将字符串反序列化为lua语句/表
* Lua表的拓展功能，数组拷贝、深拷贝等


## 类型结构
继承与静态方法都会生成一个Type，类名可以使用路径（命名空间）来限定唯一，使用class.extends方法同时会给类添加New方法
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/extends.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/extends.jpg)

在调用New之后，先分配新对象，为新对象添加类型对象指针（为了不干扰类成员所以添加在了元表中），在从本类递归查找至最基类（Object）后，从Object一层一层的调用构造函数（constructor）直到本类型构造完毕。（因为构造时传入了新对象，而类型的成员变量都是在构造函数中进行初始化的，所以新对象拥有基类到本类的所有构造出的成员变量，而方法则是通过虚函数(通过lua的__index实现)的方式访问。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/new.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/new.jpg)

继承关系，使用Lua元表metatable中的__index字段访问虚函数，通过lua的":"符号，可以默认传入self(this)指针为隐藏参数，所以在类型方法中self实际就是方法调用者，也就是实例对象。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/instance.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/instance.jpg)

GetType是Object的非虚函数，任何继承于Object的实例对象都可以调用该方法，前面说到，在New时会在实例对象的元表中附加了类型对象指针，直接指向了本类唯一的Type，执行GetType时直接将该指针返回。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/gettype.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/gettype.jpg)

typeof则是通过类型元表中的名字，在AppDomain中查找后返回。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/typeof.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/typeof.jpg)

istype是包含继承关系的，所以直接调用的Type中的IsInstanceOfType方法。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/istype.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/istype.jpg)


Activator，Type中保存了类型的原型，可以通过Type来实例化对象，但其实在Lua中直接New就可以了，没什么用。
![https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/activator.jpg](https://raw.githubusercontent.com/Jayshonyves/picrepository/master/lua/luatype/activator.jpg)