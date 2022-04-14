local stack = Stack.new()

stack:Push("v1")
stack:Push("v2")

assert(stack:GetCount() == 2)

assert(stack:Peek() == "v2")
assert(stack:Pop() == "v2")
assert(stack:Peek() == "v1")
assert(stack:GetCount() == 1)

stack:Clear()
assert(stack:GetCount() == 0)