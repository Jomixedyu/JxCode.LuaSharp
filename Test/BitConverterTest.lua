assert(SysLib.BitConverter.IsLittleEndian, true)
--number to bytes
local bytes = BitConverter.GetBytesByInt(258)
assert(table.equals(bytes, {2, 1, 0, 0}))
--bytes to number
local num = BitConverter.ToNumber(bytes, 1, 4)
assert(num == 258)