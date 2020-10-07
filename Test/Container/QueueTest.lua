local queue = Queue.New()

queue:Enqueue("value1")
queue:Enqueue("value2")
queue:Enqueue("value3")

Console.WriteLine("Count:", queue:GetCount())

queue:ForEach(function(item)
    Console.WriteLine("item: ", item) 
end)

Console.WriteLine("Peek:", queue:Peek())

Console.WriteLine("Dequeue:", queue:Dequeue())
Console.WriteLine("Dequeue:", queue:Dequeue())

Console.WriteLine("Count:", queue:GetCount())

queue:Clear()
Console.WriteLine("Clear:", queue:GetCount())