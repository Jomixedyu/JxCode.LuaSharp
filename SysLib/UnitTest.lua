local testcount = 0
local errcount = 0

local function _ErrorHandle(err)
    print(err)
end

function require_test(name)
    return {
        name = name,
        invoke = function()
            require(name)
        end
    }
end

function unittest(tb)
    local errlist = {}
    for index, value in ipairs(tb) do
        xpcall(
            value.invoke,
            function()
                table.insert(errlist, value.name)
                print(debug.traceback())
            end
        )
    end
    print(string.format("--------unit fail list %d/%d : --------\n    %s", #errlist, #tb, table.concat(errlist, "\n    ")))
    print("--------------------------------------")
end
