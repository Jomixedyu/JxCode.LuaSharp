local struct = {
    name = "jason",
    age = 17,
    score = {
        english = 100,
        math = 0
    }
}
local luaSerData = Serialization.Serialize(struct)

Console.WriteLine("SerializeData: \n"..luaSerData)


local deserObj = Serialization.Deserialize(luaSerData)
Console.WriteLine("Deserialize:")
Console.WriteLine(deserObj.name)
Console.WriteLine(deserObj.age)
Console.WriteLine(deserObj.score.english)