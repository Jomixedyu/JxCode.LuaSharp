-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:55
--- Description  : 基础函数
---    核心关键字
---        class.static(name) 静态类
---        class.define(name, base) 类形声明
---        gettype(Class) 获取类型
---        instanceof(inst, Class) 判断对象是否是某类或子类的实例
---        istype(obj, type) ---判断实例是否为某类型或某类型的子类
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------

local getmetatable = getmetatable
local setmetatable = setmetatable
local rawget = rawget
local rawset = rawset

class = {}

---类/实例 枚举
---@class ClassType
class.ClassType = {
    Class = 0,
    Instance = 1,
}

--类型字典：每个class的Type是唯一的 字典结构<string, Type>
class.__appTypes = {}


--为了匿名类获取随机的类名
local randomClassIndex = 0
local function getRandomClassName()
    randomClassIndex = randomClassIndex + 1
    return "unknowClass"..randomClassIndex
end

--类型的元数据存在于Type之中，使用gettype(class)或typeof(class)获取Type
--对象拥有类型对象指针，使用obj:GetType()获取Type


function class.static(className)
    className = className or getRandomClassName()
    local tb = {}
    class.__appTypes[className] = SysLib.Type.new(className, tb)
    return tb
end


---继承
---@param className string
---@param base class
---@param classType ClassType
function class.define(className, base)

    --类型，原型
    local _class = {}
    
    --没有类型名就随机给一个
    local _className = className
    if _className == "" or _className == nil then
        _className = getRandomClassName()
    end

    --设置类型元数据
    local classMeta = {}
    --Object进入到这里的时候还没有Object对象所以Object的基类为nil，这也是判断继承底层的标志
    --其他类型不填写base则会自动继承自Object

    base = base or SysLib.Object
    classMeta.__index = base
    --标记为类型
    classMeta.__classType = class.ClassType.Class
    --设置类型名
    classMeta.__className = className
    

    --如果Type初始化了就注册，没初始化说明本次是第一次执行（Object）或第二次执行（Type）
    --随后将在Type类型准备完毕后，对Object和Type进行延迟注册
    if SysLib.Type then
        local type = SysLib.Type.new(_className, _class, base)
        --注册进应用程序域
        class.__appTypes[_className] = type
    end

    --设置元数据关联
    setmetatable(_class, classMeta)
    
    --类型的实例化方法
    
    classMeta.__call = function(t, ...)

        local instanceMetatable = {}
        --继承
        instanceMetatable.__index = _class
        --类型对象指针
        instanceMetatable.__type = class.__appTypes[_className]
        --实例类型
        instanceMetatable.__classType = class.ClassType.Instance
        --运算符重载 + - * / ==
        --rawget获取表中的字段，而不是元表
        if rawget(_class, "operatorAdd") ~= nil then
            instanceMetatable.__add = rawget(_class, "operatorAdd")
        end
        if rawget(_class, "operatorSub") ~= nil then
            instanceMetatable.__sub = rawget(_class, "operatorSub")
        end
        if rawget(_class, "operatorMul") ~= nil then
            instanceMetatable.__mul = rawget(_class, "operatorMul")
        end
        if rawget(_class, "operatorDiv") ~= nil then
            instanceMetatable.__div = rawget(_class, "operatorDiv")
        end
        if rawget(_class, "operatorEq") ~= nil then
            instanceMetatable.__eq = rawget(_class, "operatorEq")
        end
        --Invoke调用执行
        if rawget(_class, "Invoke") ~= nil then
            instanceMetatable.__call = rawget(_class, "Invoke")
        end
        --重载tostring函数到对象的ToString方法
        instanceMetatable.__tostring = function(obj)
            return obj:ToString()
        end

        --新建的对象
        local obj = {}
        --将元数据附加给实例
        setmetatable(obj, instanceMetatable)
        obj:constructor(...)

        return obj
    end
    _class.new = function(...)
        return classMeta.__call(nil, ...)
    end
    return _class, base
end


---获取类的Type
---@return SysLib.Type
function gettype(_class)
    if _class == nil then
         return nil
    end 
    local meta = getmetatable(_class)
    if meta == nil or meta.__className == nil then
        return nil
    end
    return class.__appTypes[meta.__className]
end

function instanceof(inst, Class)
    return istype(inst, gettype(Class))
end

---判断实例是否为某类型或某类型的子类
---@param type SysLib.Type
---@return boolean
function istype(instance, type)
    --实例和类型为null直接为false
    if instance == nil or type == nil then
        return false
    end
    return type:IsInstanceOfType(instance)
end

---判断类型是否存在于框架与程序之中
---@param type SysLib.Type
---@return boolean
function class.isapptype(type)
    if not type then
        return false
    end
    if not type.GetName or _G.type(type.GetName) ~= "function" then
        return false
    end
    local name = type:GetName()

    return class.__appTypes[name] ~= nil
end

---判断实例对象是是否存在于框架与程序之中
---@return boolean
function class.isappinstance(instance)
    if not instance then
        return false
    end
    if not instance.GetType then
        return false
    end
    return class.isapptype(instance:GetType())
end