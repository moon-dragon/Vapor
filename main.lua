require ("entities.code.player")
require ("entities.code.mapcontrol")
require ("entities.code.Entity")
require ("entities.code.TestEnt")

function love.load()
	map.load()
	player.load()
	bullet.load()
	testent.load()
end

function love.update(dt)
	map.update()
	player.update(dt)
	bullet.update(dt)
	testent.update(dt)
  entity.globalAgit(dt)
end

function love.draw()
	-- Makes the camera follow the player
	love.graphics.push()
  	love.graphics.translate(-player.x + love.graphics.getWidth() / 2, -player.y + love.graphics.getHeight() / 2)

  	-- Draw everything
	map.middleGroundDraw()
	player.draw()
	bullet.draw()
	testent.draw()
	map.foreGroundDraw()


	love.graphics.pop()
end

function love.event.quit()
	love.event.quit()
end

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