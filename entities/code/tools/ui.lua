ui = {}
local FONT = love.graphics.newFont("entities/img/font.ttf", 48)
local player = require ("entities/code/player")
local time = require ("entities/code/tools/time")
local fog = require ("entities/code/tools/fogOfWar")

function ui.load()

	-- Load time
	time.load()

	-- Position of UI elements
	ui.timeX, ui.timeY = 10, 20
	ui.cycleX, ui.cycleY = 10, 60
	ui.healthX, ui.healthY = 10, 100


end

function ui.update(dt)

	-- Update time
	time.update(dt)

end

function ui.draw()
	love.graphics.setFont(FONT)
	love.graphics.printf("Time: " .. time.getTimeCounter(), ui.timeX, ui.timeY, 1000, left)
	love.graphics.printf("Cycle: " .. time.getCycleCounter(), ui.cycleX, ui.cycleY, 1000, left)
	love.graphics.printf("Health: " .. player.getHealth(), ui.healthX, ui.healthY, 1000, left)
	love.graphics.printf("Candle Timer: " .. tostring(fog.getTimer()), 10, 140, 1000, left)

end


return ui