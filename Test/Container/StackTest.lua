local stack = Stack.New()

stack:Push("one")
stack:Push("two")
stack:Push("three")


Console.WriteLine("Count:", stack:GetCount())

Console.WriteLine("Peek:", stack:Peek())

Console.WriteLine("Pop:", stack:Pop())
Console.WriteLine("Pop:", stack:Pop())

Console.WriteLine("Count:", stack:GetCount())

stack:Clear()

Console.WriteLine("Clear:", stack:GetCount())