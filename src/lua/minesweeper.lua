-- Copyright 2025-2026 Jamie Drinkell. See LICENSE.
--- Lua platform implementation for Lua Minesweeper.
--
-- The Lua platform is a box standard Lua script to run in a Lua interpreter.
-- It's a simple CLI program, but it is in colour no less! (should that be supported by your terminal).
-- It should be compatible with most Lua versions and LuaJIT. Please open an issue if you have issues with a version!
-- It simply queries you on the next move and reprints the board. Please use a monospace font in your terminal!
--
-- ## How to play
--
-- At the start, choose from `beginner`, `intermediate` or `expert` modes. Shorthands `b`, `i` and `e` can be used.
-- To sweep from a cell, enter it's coordinate, e.g. `H7`. "yx" style coordinates should also work if you're a psychopath.
-- To toggle the flag on a cell, prefix or postfix the coordinate with a `#`, e.g. `#B6`.
-- Quit at anytime with `q` or `quit`.
--
-- ## Board layout
--
-- An example beginner mode game looks like this:
--
-- ```
--   Lua Minesweeper
--
--   A B C D E F G H
-- 1 . . . . . . 1 F
-- 2 1 1 1 . . . 1 1
-- 3 # # 2 1 1 . . .
-- 4 # # # F 1 . . .
-- 5 # # # # 2 . 1 1
-- 6 # # # # 2 1 2 F
-- 7 # # # # # # # #
-- 8 # # # # # # # #
--
-- Enter your next move:
-- ```
--
-- Where:
--
-- - The lines of letters and numbers show the coordinate system
-- - `#` is an unswept hidden cell
-- - `.` is a clear cell
-- - `F` is a flag
-- - Numbers are... the numbers of adjacent mines
-- - `*` for the mines upon losing or winning
--
-- ## Credits
--
-- - PUC-Rio for [Lua](https://www.lua.org).
-- - Inspiration for which ASCII characters to use: <https://www.asciiart.eu/ascii-games/minigames/ascii-minesweeper>
-- - Rob Hoelz and Enrique García Cota for the ansicolors library: <https://github.com/kikito/ansicolors.lua>
--
-- ## TODO/IDEAS
--
-- Instead of entering, we could allow user to navigate the grid with the arrow keys?

-- @script minesweeper

local swpr = require('logic')
local colors = require('ansicolors')
local markers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ$%&!'

local function clear_screen()
	local clear_cmd = package.config:sub(1, 1) == '/' and 'clear' or 'cls'
	os.execute(clear_cmd)
end

--- Interpret what the user's move is.
local function interpret_move(move)
	local x, y, action
	if move:find('#') then
		action = 'flag'
	else
		action = 'sweep'
	end
	local match = move:match('[&!%a$%%]')
	if match then x = markers:find(match:upper(), 1 ,true) end
	y = tonumber(move:match('%d+'))
	if x == nil or y == nil then action = 'bad' end
	if move == 'q' or move == 'quit' then action = 'q' end
	return x, y, action
end

local function plot_cells(x, y, board)
	local fail = false
	local top_ref = y > 9 and '  ' or ' '
	for i = 1, x do top_ref = top_ref .. ' ' .. markers:sub(i, i) end
	io.write(colors('%{dim}' ..top_ref) .. '\n')

	for i = 1, y do
		local row = ((i < 10 and y > 9) and ' ' or '') .. colors('%{dim}' .. i) .. ' '
		for k = 1, x do
			if board[k][i] == nil then
				row = row .. colors('%{bright}#') .. ' '
			elseif board[k][i] == 0 then
				row = row .. colors('%{dim}.') .. ' '
			elseif board[k][i] == 'M' then
				fail = true
				row = row .. colors('%{bright red}*') .. ' '
			elseif board[k][i] == 1 then
				row = row .. colors('%{blue}1') .. ' '
			elseif board[k][i] == 2 then
				row = row .. colors('%{green}2') .. ' '
			elseif board[k][i] == 3 then
				row = row .. colors('%{yellow}3') .. ' '
			elseif board[k][i] == 4 then
				row = row .. colors('%{magenta}4') .. ' '
			elseif board[k][i] == 5 then
				row = row .. colors('%{red}5') .. ' '
			elseif board[k][i] == 6 then
				row = row .. colors('%{cyan}6') .. ' '
			elseif board[k][i] == 7 then
				row = row .. colors('%{dim magenta}7') .. ' '
			elseif board[k][i] == 8 then
				row = row .. colors('%{dim white}8') .. ' '
			elseif board[k][i] == 'F' then
				row = row .. colors('%{bright yellow}F') .. ' '
			end
		end
		io.write(row .. '\n')
	end
	return fail
end

clear_screen()
io.write('Welcome to Lua Minesweeper! Choose an option: ')

local mode = io.read()
mode = mode:lower()
repeat
	if mode == 'b' or mode == 'beginner' then
		break
	elseif mode == 'i' or mode == 'intermediate' then
		break
	elseif mode == 'e' or mode == 'expert' then
		break
	elseif mode == 'q' or mode == 'quit' then
		os.exit()
	elseif mode == 'h' or mode == 'help' then
		print('\n===== Lua Minesweeper Help =====')
		print('beginner (b)     - Start a beginner game.')
		print('intermediate (i) - Start an intermediate game.')
		print('expert (e)       - Start an expert game.')
		print('quit (h)         - Quit Lua Minesweeper.')
		print('help (h)         - Show this help text.')
		print(
			'To play the game, enter coordinates starting with the (X axis) letter, e.g. "H7" or "!16".')
		print('To place a flag, prefix the coordinate with a # symbol, e.g. "#H7" or "#!16"')
		io.write('\nChoose an option: ')
	else
		io.write("Invalid option selected! Please try again: ")
	end
	mode = io.read()
until false

io.write("Starting a game of Minesweeper!\n\n")
local columns, rows, board = swpr.get_details(mode)
plot_cells(columns, rows, board)

io.write('\nEnter your first move: ')
local valid, win, action = false, false
repeat
	local mv_x, mv_y, action = interpret_move(io.read())
	if action == 'sweep' then
		board = swpr.setup_game(mv_x, mv_y, mode)
		valid = true
	elseif action == 'q' then
		io.write('\nQuitting Lua Minesweeper, goodbye!\n ')
		os.exit()
	else
		io.write('Invalid input! Try again: ')
	end
	if action == 'q' or action == 'quit' then os.exit() end
until valid
clear_screen()

local action
repeat
	clear_screen()
	io.write('  Lua Minesweeper\n\n')
	local fail = plot_cells(columns, rows, board)
	if fail then
		io.write('\nYou lost :(\n')
		os.exit()
	end

	io.write('\nEnter your next move: ')
	local valid = false
	repeat
		local mv_x, mv_y
		mv_x, mv_y, action = interpret_move(io.read())
		if action == 'flag' then
			board, win = swpr.toggle_flag(mv_x, mv_y)
			valid = true
		elseif action == 'sweep' then
			board, win = swpr.sweep_cell(mv_x, mv_y)
			valid = true
		elseif action == 'q' then break
		else
			io.write('Invalid input! Try again: ')
		end
	until valid
until action == 'q' or win

if win then
	clear_screen()
	io.write('  Lua Minesweeper\n\n')
	plot_cells(columns, rows, board)
	io.write('\nYou won! :)\n ')
else
	io.write('\nQuitting Lua Minesweeper, goodbye!\n ')
end
