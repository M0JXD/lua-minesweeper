--[[ Lua Minesweeper Game Logic

-- Game Types --

Beginner: 8x8 with 10 mines
Intermediate: 16x16 with 40 mines
Expert: 30x16 with 99 mines

-- Board Data --

The main board is represented by a 2D Matrix.
Each 'cell' may be one the following values:

nil for hidden cell
A number between 1 and 9 for a revealed cell adjacent to 'n' amount of mines
0 for a revealed cell with no mine
-1 for a hidden mine
-2 for a user flagged cell with no mine
-3 for a user flagged cell with a mine

This data can be used to plot after each move.

--]]

local M = {}

math.randomseed(os.time())

-- Constants --

M.BEGINNER = 0
M.INTERMEDIATE = 1
M.EXPERT = 2

M.REVEALED = 0
M.MINE = -1
M.FLAG = -2
M.MINE_FLAG = -3

-- Functions --

function M.is_flagged(board, x, y)
	return board[x][y] < -1
end

-- Setup a board based on the first click spot and the game mode
function M.setup_game(x, y, mode)
	local rows = mode == M.BEGINNER and 8 or M.INTERMEDIATE and 16 or 30
	local columns = mode == M.EXPERT and 16 or rows
	local mines = mode == M.BEGINNER and 10 or M.INTERMEDIATE and 40 or 99

	board = {}
	for x=1, columns do
		board[i] = {}
	end

	-- No goto use as need 5.1 compat
	local amount = 0
	while true do
		local x = math.random(1, columns)
		local y = math.random(1, rows)
		if not board[x][y] then
			board[x][y] = M.MINE
			amount = amount + 1
		end
		if amount == mines then break end
	end

	return board
end

-- Toggles flag on a cell
function M.flag_cell(board, x, y)
	if board[x][y] == M.MINE then
		board[x][y] = M.MINE_FLAG
	elseif board[x][y] == M.FLAG then
		board[x][y] = nil
	elseif board[x][y] == M.MINE_FLAG then
		board[x][y] = M.MINE
	else -- must be a nil cell
		board[x][y] = M.FLAG
	end
	return board
end

function M.click_cell(board, x, y)
	if board[x][y] == M.MINE then
		return 'LOST'
	elseif board[x][y] == nil then
		-- I need some kind of recursive algo here
	end
end

return M
