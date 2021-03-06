ui = {}
ui.face = {}
ui.animation = {}

local FONT = love.graphics.newFont("entities/img/font.ttf", 36)
local FONT2 = love.graphics.newFont("entities/img/font.ttf", 24)
local player = require ("entities/code/player")
local time = require ("entities/code/tools/time")
local fog = require ("entities/code/tools/fogOfWar")
local anim = require ("entities/code/animation/health_anim")

function ui.load()
	-- Load time
	time.load()

	-- Position of UI
	ui.posX, ui.posY = 0, 0

	-- Load BELLHOP_HEALTH'S animations
	ui.face.full = anim.Full()
	ui.face.nines = anim.Nines()
	ui.face.eights = anim.Eights()
	ui.face.sevens = anim.Sevens()
	ui.face.sixs = anim.Sixs()
	ui.face.fives = anim.Fives()
	ui.face.fours = anim.Fours()
	ui.face.threes = anim.Threes()
	ui.face.twos = anim.Twos()
	ui.face.ones = anim.Ones()

	-- Position of UI elements
	-- ui.timeX, ui.timeY = 10, 20
	-- ui.cycleX, ui.cycleY = 10, 60
	-- ui.healthX, ui.healthY = 10, 100
	  ui.ammoX, ui.ammoY = 10, 140
	-- ui.upgradeX, ui.upgradeY = 10, 180

	-- Keeps track of the current face animation
	ui.face.current = ui.face.full

	-- Animation current time
	ui.animation.currentTime = 0

	-- Animation duration
	ui.animation.currentDuration = 7


end

function ui.update(dt)
	-- Update currentTime of the animation
	ui.animation.currentTime = ui.animation.currentTime + dt

	-- Updates the face animation according to the player's health
	updateFace(player.getHealth())

	-- Update time
	time.update(dt)


	-- -- Updates the cycle count
	-- if convert(ui.counter2, ui.cycleLength) >= ui.cycleLength then
	-- 	-- Play once it reached a new cycle
	-- 	love.audio.play(cycleMusic)
	-- 	ui.cycleCounter = ui.cycleCounter + 1
	-- 	ui.counter2 = 0
	-- end

	-- ui.health = player.getHealth()
end

function ui.draw()
	-- Determine the index of the next animation
	local spriteNum = math.floor(ui.animation.currentTime * ui.animation.currentDuration % #ui.face.current) + 1
	
	-- Draw the face
	love.graphics.draw(ui.face.current[spriteNum], -25, 0)

	love.graphics.setFont(FONT)

	love.graphics.printf("Cycle: " .. time.getCycleCounter().. ", Time: " .. time.getTimeCounter(), 130, 43, 1000, left)
	love.graphics.printf("Health: " .. player.getHealth(), 130, 78, 1000, left)	

	love.graphics.setFont(FONT2)
	love.graphics.printf("Candle Timer: " .. tostring(fog.getTimer()), 130, 113, 1000, left)

	-- love.graphics.printf("Time: " .. ui.counter2, ui.timeX, ui.timeY, 1000, left)
	-- love.graphics.printf("Cycle: " .. ui.cycleCounter, ui.cycleX, ui.cycleY, 1000, left)
	-- love.graphics.printf("Health: " .. ui.health, ui.healthX, ui.healthY, 1000, left)
  	love.graphics.printf("Ammo: " .. player.getChances() .. "/" .. player.getMaxChances(), 130, ui.ammoY, 1000, left) 
  	--love.graphics.printf("UpgradePts: " .. player.getUpgradePts(), ui.upgradeX, ui.upgradeY, 1000, left)


end

-- Updates the face animation according to the player's health
function updateFace(health)
	if health > 90 then
		ui.face.current = ui.face.full
	elseif  90 >= health and health > 80 then
		ui.face.current = ui.face.nines
	elseif  80 >= health and health > 70 then
		ui.face.current = ui.face.eights
	elseif  70 >= health and health > 60 then
		ui.face.current = ui.face.sevens
	elseif  60 >= health and health > 50 then
		ui.face.current = ui.face.sixs
	elseif  50 >= health and health > 40 then
		ui.face.current = ui.face.fives
	elseif  40 >= health and health > 30 then
		ui.face.current = ui.face.fours
	elseif  30 >= health and health > 20 then
		ui.face.current = ui.face.threes
	elseif  20 >= health and health > 10 then
		ui.face.current = ui.face.twos
	elseif  10 >= health and health > 0 then
		ui.face.current = ui.face.ones
	end
end


return ui