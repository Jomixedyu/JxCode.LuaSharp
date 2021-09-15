-------------------ModuleInfo-------------------
--- Author       : jxy
--- Date         : 2020/03/17 10:04
--- Description  : 
--- https://github.com/JomiXedYu/JxCode.LuaSharp
------------------------------------------------
function table.copyarr(tab)
    local tmp = {}
    for i = 1, #tab do
        tmp[i] = tab[i]
    end
    return tmp
end

function table.deepcopy(object)
	local lookup_table = {}
	
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

function table.contains(tab, value)
	for _, v in pairs(tab) do
		if value == v then
			return true
		end
	end
	return false
end

function table.count(tab)
	local len = 0
	for key, value in pairs(tab) do
		len = len + 1
	end
	return len
end

function table.equals(a, b)
	for key, value in pairs(a) do
		if value ~= b[key] then
			return false
		end
	end
	return true
end