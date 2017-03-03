--Script to run with an emulator with support for Lua scripting, mainly VBA-rr.

--Resources:
--Info: http://tasvideos.org/EmulatorResources/VBA/LuaScriptingFunctions.html
--Emulator download: http://adelikat.tasvideos.org/emulatordownloads/vba-rerecording/vba-v24m-svn-r480.7z
--Windows binary only, Linux supposedly not supported

--Function skeleton from http://tasvideos.org/LuaScripting.html

--Declarations here
function fn() -- Whenever there is an update to the display (which is supposed to be every frame but is also called in some emulators during when the display is paused)
 --Statements
end
gui.register(fn)
