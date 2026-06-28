-- Lua Minesweeper - LÖVE Platform

local swpr = require('logic')
local cell_imgs

function love.load()
	cell_imgs = love.graphics.newArrayImage{
		"assets/1.png",
		"assets/2.png",
		"assets/3.png",
		"assets/4.png",
		"assets/5.png",
		"assets/6.png",
		"assets/7.png",
		"assets/8.png",
		"assets/open.png",
		"assets/hidden.png",
		"assets/flag.png",
		"assets/mine.png"
	}
end

function love.draw()
    for i=1, 8 do
		for k=1, 8 do
			love.graphics.drawLayer(cell_imgs, i, (i * 50), (k * 50), 0, 0.15, 0.15)
		end
	end
end
