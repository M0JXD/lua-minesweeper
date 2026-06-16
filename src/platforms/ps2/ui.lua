--[[ Minesweeper UI for Enceladus on PS2



Screen.setMode(NTSC, 640, 448, CT24, INTERLACED, FIELD)

--]]

Font.fmLoad()

local function menu()

	return choice
end

-- Given the users first "safe" guess, place the mines anywhere but there
local function place_mines(x, y, mode)
	math.randomseed(os.clock())
end



-- START --

while true do
	Screen.clear()

	Screen.flip()
	Screen.waitVblankStart()
end

System.exitToBrowser()
