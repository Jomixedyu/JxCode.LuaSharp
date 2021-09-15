local Person = class.extends("Test.OOPTest.Person", SysLib.Object)
function Person:constructor(name, age)
    self.name = name
    self.age = age
end

local Student, base = class.extends("Test.OOPTest.Student", Person)
function Student:constructor(name, age, score)
    base.constructor(self, name, age)
    self.score = score
end
function Student:ToString() --override const
    return string.format("name: %s, age: %s, score: %s", self.name, tostring(self.age), tostring(self.score))
end

local zhangsan = Student.New("zhangsan", 24, 100)
-- Activator.CreateInstance(gettype(Student), "zhangsan", 24, 100)

assert(zhangsan:ToString() == "name: zhangsan, age: 24, score: 100")

---@type Type
local studentType = zhangsan:GetType()
assert(studentType == gettype(Student))
assert(studentType:GetName() == "Test.OOPTest.Student")

assert(studentType:IsSubclassOf(gettype(Person)) == true)
assert(studentType:IsSubclassOf(gettype(SysLib.Collections.List)) == false)
assert(studentType:IsInstanceOfType(zhangsan) == true)
assert(gettype(Person):IsInstanceOfType(zhangsan) == true)
assert(gettype(List):IsInstanceOfType(zhangsan) == false)
