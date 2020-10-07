local Person, base = class.extends("Test.OOPTest.Person", Object)
function Person:constructor(name, age)
    self.name = name
    self.age = age
end

local Student = class.extends("Test.OOPTest.Student", Person)
--构造函数中，前面的参数列表必须一致
function Student:constructor(name, age, score)
    self.score = score
end
function Student:ToString() --override const
    return "name: "..self.name..", age: "..tostring(self.age)..", score: "..tostring(self.score)
end


local zhangsan = Student.New("zhangsan", 24, 100)
-- Activator.CreateInstance(gettype(Student), "zhangsan", 24, 100)

Console.WriteLine(zhangsan:ToString())

---@type Type
local studentType = zhangsan:GetType()

Console.WriteLine("Type: "..tostring(zhangsan:GetType() == gettype(Student)))
Console.WriteLine("TypeName: "..studentType:GetName())

Console.WriteLine("Student是Person的派生类: "..tostring(studentType:IsSubclassOf(gettype(Person))))
Console.WriteLine("Student是List的派生类: "..tostring(studentType:IsSubclassOf(gettype(List))))
Console.WriteLine("zhangsan是Student的实例对象: "..tostring(studentType:IsInstanceOfType(zhangsan)))
Console.WriteLine("zhangsan是Person的实例对象: "..tostring(gettype(Person):IsInstanceOfType(zhangsan)))
Console.WriteLine("zhangsan是List的实例对象: "..tostring(gettype(List):IsInstanceOfType(zhangsan)))