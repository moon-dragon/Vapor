ui = {}
local FONT = love.graphics.newFont("entities/img/font.ttf", 48)
local player = require ("entities/code/player")
local cycleMusic = love.audio.newSource("entities/music/cycle_sound.wav")

function ui.load()

	-- Position of UI elements
	ui.timeX, ui.timeY = 10, 20
	ui.cycleX, ui.cycleY = 10, 60
	ui.healthX, ui.healthY = 10, 100

	-- Seconds that needs to passed before cycle resets
	ui.cycleLength = 10

	-- Health
	ui.health = 100

	ui.counter1 = 0
	ui.counter2 = 0
	ui.conversion = 0
	ui.cycleCounter = 0
end

function ui.update(dt)

	-- Updates the time
	ui.counter1 = ui.counter1 + 1
	if convert(ui.counter1, 100) >= 100 then
		ui.counter2 = ui.counter2 + 1
	end

	-- Updates the cycle count
	if convert(ui.counter2, ui.cycleLength) >= ui.cycleLength then
		-- Play once it reached a new cycle
		love.audio.play(cycleMusic)
		ui.cycleCounter = ui.cycleCounter + 1
		ui.counter2 = 0
	end

	ui.health = player.getHealth()
end

function ui.draw()
	love.graphics.setFont(FONT)
	love.graphics.printf("Time: " .. ui.counter2, ui.timeX, ui.timeY, 1000, left)
	love.graphics.printf("Cycle: " .. ui.cycleCounter, ui.cycleX, ui.cycleY, 1000, left)
	love.graphics.printf("Health: " .. ui.health, ui.healthX, ui.healthY, 1000, left)

end

-- Converts the time
function convert(current, max)
	return current % (max + 1)
end


return ui