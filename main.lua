local player = require ("entities.code.player")
local map = require ("entities.code.mapcontrol")
require ("entities.code.Entity")
require ("entities.code.tools.ui")
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
	----------- PLAYER CAMERA MOVEMENT --------------
	-- Makes the camera follow the player
	love.graphics.push()
  	love.graphics.translate(-playerx + love.graphics.getWidth() / 2, -playery + love.graphics.getHeight() / 2)

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

function love.event.quit()
	love.event.quit()
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