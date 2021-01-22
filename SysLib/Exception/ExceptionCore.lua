

---抛出错误，可以抛任何对象 try都可以捕捉
function throw(exception)
    --框架内类型
    if isappinstance(exception) and istype(exception, gettype(SysLib.Exception)) then
        exception:SetStackTrack(debug.traceback())
    end

    error(exception)
end

function try(func)
    local success, throwObj = pcall(func)

    local rtnTable = {}
    rtnTable.m_isCatched = false

    ---@param type Type
    ---@overload fun(catchFunc:function)
    rtnTable.catch = function(type, catchFunc)

        if rtnTable.m_isCatched then
            return rtnTable
        end

        --重载交换形参
        if catchFunc == nil then
            catchFunc = type
            type = nil
        end

        --执行出错
        if not success then
            
            if not type then
                --类型不存在，直接捕获
                rtnTable.m_isCatched = true
                catchFunc(throwObj)
            elseif isapptype(type) and isappinstance(throwObj) and istype(throwObj, type) then
                --抛出类型与捕捉类型都是框架类型，进行判断
                rtnTable.m_isCatched = true
                catchFunc(throwObj)
            end

        end

        return rtnTable
    end

    rtnTable.finally = function(func)
        func()
    end

    return rtnTable
end
