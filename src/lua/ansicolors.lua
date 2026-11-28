-- Copyright 2009 Rob Hoelz, 2011 Enrique García Cota, 2026 Jamie Drinkell. See COPYING.
--- ANSI Terminal Colors for Lua.
--
-- *ansicolors.lua* is a simple Lua module for printing to the console in color.
-- This is a fork to add detection for new terminals that support ANSI codes (e.g. Windows Terminal).
--
-- ## Usage
--
-- ```lua
-- local colors = require('ansicolors')
-- print(colors('%{red}hello'))
-- print(colors('%{redbg}hello%{reset}'))
-- print(colors('%{bright red underline}hello'))
-- ```
--
-- The `colors()` function ensures that color attributes are reset at each end of the generated string.
-- If you want to generate complex strings piece-by-piece, use `colors.noReset()`,
-- which works exactly the same but without adding the reset codes at each end of the string.
--
-- ## Testing
--
-- The original Telescope tests have been ported to Busted.
--
-- @module ansicolors
local M = {}

--- Detect if ANSI escapes are supported.
-- @return truthy or falsey value whether the environment supports ANSI color sequences.
local function ansiSupport()
	local isWindows = type(package) == 'table' and type(package.config) == 'string' and
		package.config:sub(1, 1) == '\\'
	if isWindows then
		return os.getenv("ANSICON") or os.getenv('WT_SESSION')
	else
		return true
	end
end

--- ANSI Keys.
-- @table keys
local keys = {
	reset = 0, -- Reset any previously applied colors.
	bright = 1, -- Make foreground color bright (bold).
	dim = 2, -- Make foreground color dim.
	underline = 4, -- Underline text.
	blink = 5, -- Make text blink.
	reverse = 7, -- Reverse foreground and background.
	hidden = 8, -- Make text hidden.
	black = 30, -- Set foreground to black.
	red = 31, -- Set foreground to red.
	green = 32, -- Set foreground to green.
	yellow = 33, -- Set foreground to yellow.
	blue = 34, -- Set foreground to blue.
	magenta = 35, -- Set foreground to magenta.
	cyan = 36, -- Set foreground to cyan.
	white = 37, -- Set foreground to white.
	blackbg = 40, -- Set background to black.
	redbg = 41, -- Set background to red.
	greenbg = 42, -- Set background to green.
	yellowbg = 43, -- Set background to yellow.
	bluebg = 44, -- Set background to blue.
	magentabg = 45, -- Set background to magenta.
	cyanbg = 46, -- Set background to cyan.
	whitebg = 47 -- Set background to white.
}

local escapeString = string.char(27) .. '[%dm'

--- Inserts the escape character to the terminal number.
-- @param number number to insert.
-- @return Escape string with number added.
local function escapeNumber(number)
	return escapeString:format(number)
end

local supported = ansiSupport()

--- Converts key to terminal escape code.
-- @param str key to substitute with escape code.
-- @return String with escape codes substituted.
local function escapeKeys(str)
	if not supported then return "" end

	local buffer = {}
	local number
	for word in str:gmatch("%w+") do
		number = keys[word]
		assert(number, "Unknown key: " .. word)
		table.insert(buffer, escapeNumber(number))
	end

	return table.concat(buffer)
end

--- Replaces %{key} codes.
-- @param str String with %{key} entries to color in.
-- @return String with keys replaced for terminal sequences.
local function replaceCodes(str)
	str = string.gsub(str, "(%%{(.-)})", function(_, str) return escapeKeys(str) end)
	return str
end

--- Apply terminal colors with automatic reset.
-- @param str String with %{key} entries to color in.
-- @return String with keys replaced for terminal sequences.
local function ansicolors(str)
	str = tostring(str or '')
	return replaceCodes('%{reset}' .. str .. '%{reset}')
end

--- Replaces %{key} codes.
-- @function noReset
-- @param str String with %{key} entries to color in.
-- @return String with keys replaced for terminal sequences.
M.noReset = replaceCodes


--- Apply terminal colors with automatic reset (*__call* metamethod).
-- @function __call
-- @param str String with %{key} entries to color in.
-- @return String with keys replaced for terminal sequences.
return
	setmetatable(M, {__call = function(_, str) return ansicolors(str) end})

