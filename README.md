# VocalBoy
A voice control application for lua-script-supported GameBoy emulators using jVoiceXML.

Version: 0.1
Credits: The jVoiceXML team
Authors: August Janse, Ah-Zau Marang, Robin Kammerlander, Tedy Warsitha

# Minimum Requirements

- A lua-script-supported GameBoy emulator
- Node.js + node http-server
- J2SE 1.5
- ANT 1.7

# General procedure

1. Install.
2. Start the emulator, load the game and input.lua lua script.
3. Start the voice recognizer.

# Installing

Please check the requirements. If anything is missing, refer to the following instructions.

## Voice recognizer
If you don't already have node.js, download and install it according to their instructions. You will also need the http-server package. While node is installed, run npm install http-server -g to install this package.

# Running the voice recognition application.

Refer to these guidelines for your OS.

## Unix
In unix all you have to do is to run sh ./startup.sh inside /server/bin. There is also a shutdown script available of things don't shut down smoothly when terminating the startup script.

## Windows
Identical scripts are also available for Windows. You can find these as .exe or .bat files.

// TODO Append code for automation of node http-server. For now one must manually run http-server ./server to start the server.

What happens is that the run script starts a node http server which will be used be the voice recognizer application in order to read the voice-xml files. Voice commands are mapped to a set of text commands that are sent through telnet to the lua-script-supported emulator. The emulator then interprets the commands as scripted input and the user witnesses the interaction of the game.

