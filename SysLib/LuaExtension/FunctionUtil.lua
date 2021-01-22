-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/20 20:02
--- Description  : 
------------------------------------------------
---@class FunctionUtil
FunctionUtil = {}

---params打包，避免nil截断
function FunctionUtil.ParamsPack(...)
    local params = {...}
    params.__pack_params_count = select("#", ...)
    return params
end

---解包params
function FunctionUtil.ParamsUnPack(pack_table)
    return table.unpack(pack_table, 1, pack_table.__pack_params_count)
end
