local struct = {
    name = "jason",
    age = 17,
    score = {
        english = 100,
        math = 0
    }
}
local luaSerData = Serialization.Serialize(struct)
local luaDeserObj = Serialization.Deserialize(luaSerData)

assert(luaDeserObj.name == "jason")
assert(luaDeserObj.age == 17)
assert(luaDeserObj.score.english == 100)
