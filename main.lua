local player = require ("entities.code.player")
local map = require ("entities.code.mapcontrol")
local entity = require ("entities.code.Entity")
local ui = require ("entities.code.tools.ui")
require ("entities.code.TestEnt")


function love.load()
	-- Play the uploaded music
	music = love.audio.newSource("entities/music/Liquid_Spear_Waltz.wav")
	music:setLooping(true)
	love.audio.play(music)

	-- Load the map
	map.load()

	-- Load the player and its initial position
	player.load()
	playerx, playery = player.getPlayerSpawn()

	-- Starting Scale of the map
	scaleX, scaleY = 0.8, 0.8

	-- Load all the entity
	entity.load()

	-- Load the User Interface
	ui.load()

	-- testent.load()

end

function love.update(dt)

	-- Update the player movement and its position
	player.update(dt)
	playerx, playery = player.getPosition()

	-- Update entity movement and its agiation status
	entity.update(dt)
  	entity.globalAgit(dt)
  	
  	-- Updates the User Interface
  	ui.update(dt)


  	-- testent.update(dt)
end

function love.draw()
	-- ------------------ SCALING ----------------------
	-- scale = 0.2 -- lower number = zoom out
	-- screenWidth = love.graphics.getWidth() / scale;
	-- screenHeight = love.graphics.getHeight() / scale;
	-- love.graphics.scale(scale)
  
  ----------- PLAYER CAMERA MOVEMENT --------------

	love.graphics.push()

	-- Scale the map
	love.graphics.scale(scaleX, scaleY)
	
	-- Makes the camera follow the player
	love.graphics.translate(-playerx + (love.graphics.getWidth() / 2) * (1/scaleX), -playery + (love.graphics.getHeight() / 2) * (1/scaleY))

  	-- love.graphics.translate(-playerx + screenWidth / 2, -playery + screenHeight / 2)

  	-- Draw the map
	map.drawBaseLayer()
	
	-- Draw the player
	player.draw()

	-- Draw all the entities and their agitation status
	entity.draw()

	-- Draw the map
	map.drawTopLayer()

	-- testent.draw()
	love.graphics.pop()

	--------------- USER INTERFACE -----------------
	love.graphics.push()
  	love.graphics.translate(ui.timeX, ui.timeY)
  	
  	-- Draw the user interface
  	ui.draw()

	love.graphics.pop()
end


--------------- WINDOW CONFIGURATION -------------------

function love.keypressed(key, isrepeat)
	-- Toggle between FULLSCREEN and WINDOW
	if key == 'm' then
		if fullscreen then
			fullscreen = false
		else
			fullscreen = true
		end
		love.window.setFullscreen(fullscreen)
	end
end

-- Change the scale using the scroll wheel
function love.wheelmoved(x, y)
    if 0.7 <= scaleX and scaleX <= 1.0 or 0.7 <= scaleY and scaleY <= 1.0 then
    	if y > 0 then
    		scaleX = pickUpperScale(scaleX + 0.1, 1.0)
    		scaleY = pickUpperScale(scaleY + 0.1, 1.0)
    	elseif y < 0 then
    		scaleX = pickLowerScale(scaleX - 0.1, 0.7)
    		scaleY = pickLowerScale(scaleY - 0.1, 0.7)
    	end
    end
end

-- Only used for scaling
function pickUpperScale(choice1, choice2)
	if choice1 < choice2 then
		return choice1
	else
		return choice2
	end
end

function pickLowerScale(choice1, choice2)
	if choice1 > choice2 then
		return choice1
	else
		return choice2
	end
end
