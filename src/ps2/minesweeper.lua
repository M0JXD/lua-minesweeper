--[[ Lua Minesweeper - Enceladus (PS2) Platform

Screen.setMode(NTSC, 640, 448, CT24, INTERLACED, FIELD)

--]]

local swpr = require('minesweeper/logic')

local function menu()


end

local function game()

end

-- START --

while true do
	Screen.clear()

	Screen.flip()
	Screen.waitVblankStart()
end

System.exitToBrowser()
