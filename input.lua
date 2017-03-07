--Script to run with an emulator with support for Lua scripting, mainly VBA-rr.

--Requires LuaSocket which wasn't too easy to access from VBA-rr. What worked for me was downloading the directory to C:\Lua and setting environment variables (in Windows):
--LUA_CPATH = C:\Lua\?.dll;?.dll
--LUA_PATH = C:\Lua\lua\?.lua;?.lua

--Resources:
--Info: http://tasvideos.org/EmulatorResources/VBA/LuaScriptingFunctions.html
--Emulator download: http://adelikat.tasvideos.org/emulatordownloads/vba-rerecording/vba-v24m-svn-r480.7z
--Windows binary only, Linux supposedly not supported

--Function skeleton from http://tasvideos.org/LuaScripting.html

--Declarations here
function fn() -- Whenever there is an update to the display (which is supposed to be every frame but is also called in some emulators during when the display is paused)
 socket = require("socket")
 print(socket._VERSION)
end
gui.register(fn)
