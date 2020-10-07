
Console.WriteLine("IsLittleEndian: ", System.BitConverter.IsLittleEndian)

--number to bytes
local bytes = BitConverter.GetBytesByInt(258)
Console.WriteLine("bytes: ", Serialization.Serialize(bytes))


local num = BitConverter.ToNumber(bytes, 1, 4)
Console.WriteLine("bytesToNumber: ", num)