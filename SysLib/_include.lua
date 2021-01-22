-------------------ModuleInfo-------------------
--- Author       : jx
--- Date         : 2020/03/08 21:12
--- Description  : SysLibLoader
---                为了方便起见，只有SysLib中的类型注释不是完整路径
---                如---@class Dictionary
------------------------------------------------

if SYSLIB_SIMPLENAME == nil then
    SYSLIB_SIMPLENAME = true
end
local _SMPL = SYSLIB_SIMPLENAME
--LuaUtil
require "SysLib.LuaExtension.TableUtil"
require "SysLib.LuaExtension.FunctionUtil"
--Kernel
SysLib = {}
require "SysLib.OOPCore"
SysLib.Object = require "SysLib.Object" if _SMPL then Object = SysLib.Object end
SysLib.Type = require "SysLib.Type"     if _SMPL then Type   = SysLib.Type   end
SysLib.Nullable = require "SysLib.Nullable" if _SMPL then Nullable = SysLib.Nullable end
require "SysLib.NullObject"
--Exception
SysLib.Exception                   = require "SysLib.Exception.Exception"                   if _SMPL then Exception                   = SysLib.Exception                   end
SysLib.ApplicationException        = require "SysLib.Exception.ApplicationException"        if _SMPL then ApplicationException        = SysLib.ApplicationException        end
SysLib.ArgumentException           = require "SysLib.Exception.ArgumentException"           if _SMPL then ArgumentException           = SysLib.ArgumentException           end
SysLib.ArgumentNullException       = require "SysLib.Exception.ArgumentNullException"       if _SMPL then ArgumentNullException       = SysLib.ArgumentNullException       end
SysLib.ArgumentOutOfRangeException = require "SysLib.Exception.ArgumentOutOfRangeException" if _SMPL then ArgumentOutOfRangeException = SysLib.ArgumentOutOfRangeException end
SysLib.IOException                 = require "SysLib.Exception.IOException"                 if _SMPL then IOException                 = SysLib.IOException                 end
SysLib.NotImplementedException     = require "SysLib.Exception.NotImplementedException"     if _SMPL then NotImplementedException     = SysLib.NotImplementedException     end
SysLib.NullReferenceException      = require "SysLib.Exception.NullReferenceException"      if _SMPL then NullReferenceException      = SysLib.NullReferenceException      end
SysLib.IndexOutOfRangeException    = require "SysLib.Exception.IndexOutOfRangeException"    if _SMPL then IndexOutOfRangeException    = SysLib.IndexOutOfRangeException    end
SysLib.KeyNotFoundException        = require "SysLib.Exception.KeyNotFoundException"        if _SMPL then KeyNotFoundException        = SysLib.KeyNotFoundException        end
SysLib.OverflowException           = require "SysLib.Exception.OverflowException"           if _SMPL then OverflowException           = SysLib.OverflowException           end
SysLib.TimeOutException            = require "SysLib.Exception.TimeoutException"            if _SMPL then TimeOutException            = SysLib.TimeOutException            end
require "SysLib.Exception.ExceptionCore"
--Common
SysLib.BitMath      = require "SysLib.BitMath"       if _SMPL then BitMath      = SysLib.BitMath       end
SysLib.BitConverter = require "SysLib.BitConverter"  if _SMPL then BitConverter = SysLib.BitConverter  end
SysLib.Enum         = require "SysLib.Enum"          if _SMPL then Enum         = SysLib.Enum          end
SysLib.Array        = require "SysLib.Array"         if _SMPL then Array        = SysLib.Array         end
SysLib.String       = require "SysLib.String"        if _SMPL then String       = SysLib.String        end
SysLib.DateTime     = require "SysLib.DateTime"      if _SMPL then DateTime     = SysLib.DateTime      end
--Collections
SysLib.Collections = {}
SysLib.Collections.IEnumerable = require "SysLib.Collections.IEnumerable"  if _SMPL then IEnumerable = SysLib.Collections.IEnumerable  end
SysLib.Collections.List        = require "SysLib.Collections.List"         if _SMPL then List        = SysLib.Collections.List         end
SysLib.Collections.Dictionary  = require "SysLib.Collections.Dictionary"   if _SMPL then Dictionary  = SysLib.Collections.Dictionary   end
SysLib.Collections.Stack       = require "SysLib.Collections.Stack"        if _SMPL then Stack       = SysLib.Collections.Stack        end
SysLib.Collections.Queue       = require "SysLib.Collections.Queue"        if _SMPL then Queue       = SysLib.Collections.Queue        end
--IO
SysLib.IO = {}
SysLib.IO.File = require "SysLib.IO.File"  if _SMPL then File = SysLib.IO.File end
SysLib.IO.Path = require "SysLib.IO.Path"  if _SMPL then Path = SysLib.IO.Path end
--Text
SysLib.Text = {}
SysLib.Text.StringBuilder = require "SysLib.Text.StringBuilder" if _SMPL then StringBuilder = SysLib.Text.StringBuilder end
--Runtime
SysLib.Runtime = {}
SysLib.Runtime.Serialization = require "SysLib.Runtime.Serialization" if _SMPL then Serialization = SysLib.Runtime.Serialization end

SysLib.Console = require "SysLib.Console"      if _SMPL then Console   = SysLib.Console   end
SysLib.Delegate = require "SysLib.Delegate"    if _SMPL then Delegate  = SysLib.Delegate  end
SysLib.Convert = require "SysLib.Convert"      if _SMPL then Convert   = SysLib.Convert   end
SysLib.Activator = require "SysLib.Activator"  if _SMPL then Activator = SysLib.Activator end