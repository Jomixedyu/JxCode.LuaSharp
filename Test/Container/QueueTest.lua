local queue = Queue.New()

queue:Enqueue("v1")
queue:Enqueue("v2")

assert(queue:GetCount() == 2)

local it = ""
queue:ForEach(function(item)
    it = it .. item
end)

assert(it == "v1v2")

assert(queue:Peek() == "v1")
assert(queue:Dequeue() == "v1")
assert(queue:Peek() == "v2")
assert(queue:GetCount() == 1)

queue:Clear()
assert(queue:GetCount() == 0)