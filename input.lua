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

--Snippet modified from http://w3.impa.br/~diego/software/luasocket/introduction.html#tcp
function openConnection()
 -- load namespace
 local socket = require("socket")
 -- create a TCP socket and bind it to the local host, at any port
 local server = assert(socket.bind("127.0.0.1", 50414)) -- Local IP, arbitrary ephemeral port
 -- find out which port the OS chose for us
 local ip, port = server:getsockname()
 -- print a message informing what's up
 print("Please telnet to localhost on port " .. port)
 print("After connecting, you have 10s to enter a line to be echoed")
 -- loop forever waiting for clients
 while 1 do
   -- wait for a connection from any client
   local client = server:accept()
   -- make sure we don't block waiting for this client's line
   client:settimeout(10)
   -- receive the line
   local line, err = client:receive()
   -- if there was no error, send it back to the client
   if not err then client:send(line .. "\n") end
   -- done with client, close the object
   client:close()
 end
end
openConnection()

function fn() -- Whenever there is an update to the display (which is supposed to be every frame but is also called in some emulators during when the display is paused)
 socket = require("socket")
 print(socket._VERSION)
end
gui.register(fn)
