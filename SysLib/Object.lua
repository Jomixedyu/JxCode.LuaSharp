-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/02/15 23:58
--- Description  : 所有类的基类
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
---@class SysLib.Object
---@field New fun()
local Object = class.extends("SysLib.Object")

--为了更好的智能提示，在Object中添加了New，但会覆盖原有的New方法
--所以先保存起来，然后在调用，本方法仅有在执行Object.New时才会执行，尽管这没有意义
local _new = Object.New
---@return self
function Object.New()
    _new()
end

function Object:constructor()

end

function Object:Dispose()

end
--virtual
function Object:Equals(target)
    return self == target
end

---@return Type
function Object:GetType()
    ---元数据时存在元表当中的，所以要获取元表
    local meta = getmetatable(self)
    assert(meta.__classType == class.ClassType.Instance , "该方法为实例方法")
    --返回类型对象指针
    return meta.__type
end

function Object:ToString()
    return "<class: "..self:GetType():GetName()..">"
end

return Object