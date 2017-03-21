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
keys = {"A", "B", "select", "start", "right", "left", "up", "down", "R", "L"}

--Opens a connection to 127.0.0.1:50414 and returns the client object.
--Snippet modified from http://w3.impa.br/~diego/software/luasocket/introduction.html#tcp
function openConnection()
 -- load namespace
 socket = require("socket")
 -- create a TCP socket and bind it to the local host, at any port
 server = assert(socket.bind("127.0.0.1", 50414)) -- Local IP, arbitrary ephemeral port
 -- find out which port the OS chose for us
 local ip, port = server:getsockname()
 -- wait for a connection from any client
 local client = server:accept()

 return client
end

function closeConnection()
 -- done with client, close the object
 client:close()
end

--May be needed depending on the exact input received. Also removes garbage of unknown origin.
--Input: The exact name of a key surrounded by whitespace (might be subject to change)
--Output: The exact name of a key as contained in keys, or nil if none was found.
function processInput(line)
 for _, key in ipairs(keys) do
  if string.find(line, key) ~= nil then
   return key
  end
 end

 return nil
end

--Set key as held for the next frame
function setKey(key)
 local c = {} --table of keys and their heldness
 if key ~= nil then c[key] = true end --set given key as held
 joypad.set(1, c) --set table joypad 1
end

client = openConnection()
client:settimeout(0) -- make non-blocking

while true do
 local line, err = client:receive()
 if not err then
  local key = processInput(line)
  setKey(key)
  client:send(line .. "\n") -- looks like something needs to be sent back to continue
 end

 emu.frameadvance()
end
