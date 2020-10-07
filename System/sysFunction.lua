-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/02/15 23:55
--- Description  : 基础函数
---    核心关键字
---        class.static(name) 静态类
---        class.extends(name, base) 类形声明
---        delete(obj) （不建议使用）执行该对象的所有析构函数（但并不会回收，可以当做IDisposable
---        gettype(Class) 获取类型原型
---        typeof(Class) 正常情况下和gettype功能一样，如果有其他框架也使用该函数，则行为会有些区别
---        isinstance(obj) 判断是否为实例对象
---        istype(obj, type) ---判断实例是否为某类型或某类型的子类
---        isapptype(type) 检查类型是否为框架内类型
---        isappinstance(instance) 检查对象是否为框架内实例
------------------------------------------------
local getmetatable = getmetatable
local rawget = rawget
local rawset = rawset

class = {}

---类/实例 枚举
---@class ClassType
class.ClassType = {
    Class = "Class",
    Instance = "Instance",
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
    class.__appTypes[className] = System.Type.New(className, tb)
    return tb
end


---继承
---@param className string
---@param base class
---@param classType ClassType
function class.extends(className, base)

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
    base = base or Object
    classMeta.__index = base
    --标记为类型
    classMeta.__classType = class.ClassType.Class
    --设置类型名
    classMeta.__className = className
    

    --如果Type初始化了就注册，没初始化说明本次是第一次执行（Object）或第二次执行（Type）
    --随后将在Type类型准备完毕后，对Object和Type进行补偿
    if System.Type then
        local type = System.Type.New(_className, _class, base)
        --注册进应用程序域
        class.__appTypes[_className] = type
    end

    --设置元数据关联
    setmetatable(_class, classMeta)
    
    --类型的实例化方法
    _class.New = function(...)

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
        --初始化Object和Type时因Type未初始化完毕无法获取基类，所以仅进行一次构造
        if System.Type then
            --从基类开始执行构造函数
            local ctor
            ctor = function(b, ...)
                local mt = getmetatable(b)
                --第一次运行是实例类型，寻找原型后开始向基类递归
                if mt.__classType == class.ClassType.Instance then
                    if b.GetType then
                        local baseProto = b:GetType().m_protoType
                        --进入原型
                        ctor(baseProto, ...)
                        return --构造完毕
                    end
                else
                    --递归至最基层后开始运行构造函数
                    local baseProto = gettype(b).m_baseProtoType
                    if baseProto ~= nil then
                        ctor(baseProto, ...)
                    end
                end
                if rawget(b, "constructor") then
                    b.constructor(obj, ...)
                end
            end
            ctor(obj, ...)
        else
            obj:constructor(...)
        end

        return obj
    end

    return _class, base
end

---析构对象
function delete(obj)
    local meta = getmetatable(obj)
    assert(meta.__classType == class.ClassType.Instance, "TypeException")
    local now_base = meta.__index
    while now_base do
        if rawget(now_base, "destructor") then
            now_base:destructor()
        end
        now_base = gettype(now_base):GetBaseClass()
    end
end

---获取类的类型 功能就是typeof，怕typeof冲突可以用这个
---@return System.Type
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

--有些框架同样会使用typeof关键字造成冲突
--使用typeof会判断类型并选择正确的方法执行
--也可以直接删除本段，框架内对象一律使用gettype
local _typeof = typeof
---@return System.Type
function typeof(_class)
    if _class == nil then
        return nil
    end 
    local meta = getmetatable(_class)
    --本框架
    if type(_class) == "table" and meta and meta.__className then
        return class.__appTypes[meta.__className]
    else
        --其他框架
        if not _typeof then
            return _typeof(_class)
        else
            return nil
        end
    end
end

---是否为实例对象
---@return boolean
function isinstance(target)
    local m = getmetatable(target)
    if m.__classType then
        return m.__classType == class.ClassType.Instance
    end
end

---判断实例是否为某类型或某类型的子类
---@param type System.Type
---@return boolean
function istype(instance, type)
    --实例和类型为null直接为false
    if instance == nil or type == nil then
        return false
    end
    return type:IsInstanceOfType(instance)
end

---判断类型是否存在于框架与程序之中
---@param type System.Type
---@return boolean
function isapptype(type)
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
function isappinstance(instance)
    if not instance then
        return false
    end
    if not instance.GetType then
        return false
    end
    return isapptype(instance:GetType())
end