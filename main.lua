_DEBUG = true

require "SysLib._include"

if _DEBUG then
    
    unittest({
        require_test "Test.IOFileTest",
        require_test "Test.IOPathTest",
        require_test "Test.StringAndBuilderTest",
        require_test "Test.EnumTest",
        require_test "Test.DelegateEventsTest",
        require_test "Test.ExceptionTest",
        require_test "Test.OOPTest",
        require_test "Test.BitConverterTest",
        require_test "Test.Container.ListTest",
        require_test "Test.Container.DictionaryTest",
        require_test "Test.Container.StackTest",
        require_test "Test.Container.QueueTest",
        require_test "Test.SerializerTest",
    })

end
