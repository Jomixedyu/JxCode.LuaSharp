-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/08 21:12
--- Description  : SystemLoader
---                为了方便起见，只有System中的类型注释不是完整路径
---                如---@class Dictionary
------------------------------------------------
if JXCODE_LUASHARP_SYSTEM_SIMPLENAME == nil then
    JXCODE_LUASHARP_SYSTEM_SIMPLENAME = true
end
local _SMPL = JXCODE_LUASHARP_SYSTEM_SIMPLENAME
--LuaUtil
require "System.LuaExtension.TableUtil"
require "System.LuaExtension.FunctionUtil"
--Kernel
require "System.sysFunction"
System = {}
System.Object = require "System.Object" if _SMPL then Object = System.Object end
System.Type = require "System.Type"     if _SMPL then Type   = System.Type   end
--Exception
System.Exception                   = require "System.Exception.Exception"                   if _SMPL then Exception                   = System.Exception                   end
System.ApplicationException        = require "System.Exception.ApplicationException"        if _SMPL then ApplicationException        = System.ApplicationException        end
System.ArgumentException           = require "System.Exception.ArgumentException"           if _SMPL then ArgumentException           = System.ArgumentException           end
System.ArgumentNullException       = require "System.Exception.ArgumentNullException"       if _SMPL then ArgumentNullException       = System.ArgumentNullException       end
System.ArgumentOutOfRangeException = require "System.Exception.ArgumentOutOfRangeException" if _SMPL then ArgumentOutOfRangeException = System.ArgumentOutOfRangeException end
System.IOException                 = require "System.Exception.IOException"                 if _SMPL then IOException                 = System.IOException                 end
System.NotImplementedException     = require "System.Exception.NotImplementedException"     if _SMPL then NotImplementedException     = System.NotImplementedException     end
System.NullReferenceException      = require "System.Exception.NullReferenceException"      if _SMPL then NullReferenceException      = System.NullReferenceException      end
System.IndexOutOfRangeException    = require "System.Exception.IndexOutOfRangeException"    if _SMPL then IndexOutOfRangeException    = System.IndexOutOfRangeException    end
System.KeyNotFoundException        = require "System.Exception.KeyNotFoundException"        if _SMPL then KeyNotFoundException        = System.KeyNotFoundException        end
System.OverflowException           = require "System.Exception.OverflowException"           if _SMPL then OverflowException           = System.OverflowException           end
System.TimeOutException            = require "System.Exception.TimeoutException"            if _SMPL then TimeOutException            = System.TimeOutException            end
require "System.Exception.ExceptionCore"
--Common
System.BitMath      = require "System.BitMath"       if _SMPL then BitMath      = System.BitMath       end
System.BitConverter = require "System.BitConverter"  if _SMPL then BitConverter = System.BitConverter  end
System.Enum         = require "System.Enum"          if _SMPL then Enum         = System.Enum          end
System.Array        = require "System.Array"         if _SMPL then Array        = System.Array         end
System.String       = require "System.String"        if _SMPL then String       = System.String        end
System.DateTime     = require "System.DateTime"      if _SMPL then DateTime     = System.DateTime      end
--Collections
System.Collections = {}
System.Collections.IEnumerable = require "System.Collections.IEnumerable"  if _SMPL then IEnumerable = System.Collections.IEnumerable  end
System.Collections.List        = require "System.Collections.List"         if _SMPL then List        = System.Collections.List         end
System.Collections.Dictionary  = require "System.Collections.Dictionary"   if _SMPL then Dictionary  = System.Collections.Dictionary   end
System.Collections.Stack       = require "System.Collections.Stack"        if _SMPL then Stack       = System.Collections.Stack        end
System.Collections.Queue       = require "System.Collections.Queue"        if _SMPL then Queue       = System.Collections.Queue        end
--IO
System.IO = {}
System.IO.File = require "System.IO.File"  if _SMPL then File = System.IO.File end
System.IO.Path = require "System.IO.Path"  if _SMPL then Path = System.IO.Path end
--Text
System.Text = {}
System.Text.StringBuilder = require "System.Text.StringBuilder" if _SMPL then StringBuilder = System.Text.StringBuilder end
--Runtime
System.Runtime = {}
System.Runtime.Serialization = require "System.Runtime.Serialization" if _SMPL then Serialization = System.Runtime.Serialization end

System.Console = require "System.Console"      if _SMPL then Console   = System.Console   end
System.Delegate = require "System.Delegate"    if _SMPL then Delegate  = System.Delegate  end
System.Convert = require "System.Convert"      if _SMPL then Convert   = System.Convert   end
System.Activator = require "System.Activator"  if _SMPL then Activator = System.Activator end