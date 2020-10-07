
---@class System.Runtime.Serialization
local Serialization = class.static("System.Runtime.Serialization")

local function GetLevelSpace(level)
    local space = ""
    for i = 1, level do
        space = space .. "    "
    end
    return space
end


function Serialization.Serialize(obj)

    local level = 0
    local isInit = false
    local sb = System.Text.StringBuilder.New()
    local ser

    ser = function(target)
        local _type = type(target)

        if _type == "number" then
            sb:Append(target)
        elseif _type == "boolean" then
            sb:Append(tostring(target))
        elseif _type == "string" then
            sb:Append(string.format("%q", target))
        elseif _type == "table" then
            --第一行不加回车
            if isInit then
                sb:AppendLine()
            else
                isInit = true
            end
            sb:Append(GetLevelSpace(level))
            sb:AppendLine("{")
            level = level + 1

            for k, v in pairs(target) do
                sb:Append(GetLevelSpace(level))
                sb:Append('[')
                ser(k)
                sb:Append("] = ")
                ser(v)
                sb:AppendLine(',')
            end

            local metatable = getmetatable(target)
            if metatable ~= nil and type(metatable.__index) == "table" then
                for k, v in pairs(metatable.__index) do
                    sb:Append(GetLevelSpace(level))
                    sb:Append('[')
                    ser(k)
                    sb:Append("]=")
                    ser(v)
                    sb:AppendLine(',')
                end
            end
            level = level - 1
            sb:Append(GetLevelSpace(level))
            sb:Append('}')
        elseif _type == "nil" then

        else
            error("can not serialize a " .. _type .. " type.")
        end

    end
    ser(obj)
    return sb:ToString()
end

function Serialization.Deserialize(luaScript)
    local t = type(luaScript)
    if t == "nil" or luaScript == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        luaScript = tostring(luaScript)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    luaScript = "return " .. luaScript
    local func = load(luaScript)
    if func == nil then
        return nil
    end
    return func()
end

return Serialization