require ("entities.code.player")
require ("entities.code.mapcontrol")
require ("entities.code.Entity")
require ("entities.code.TestEnt")


function love.load()
	map.load()
	player.load()
	bullet.load()
	-- testent.load()
	entity.load()
end

function love.update(dt)
	map.update()
	player.update(dt)
	bullet.update(dt)
	entity.update(dt)
	-- testent.update(dt)
  	-- entity.globalAgit(dt)

end

function love.draw()
	-- Makes the camera follow the player
	love.graphics.push()
  	love.graphics.translate(-player.x + love.graphics.getWidth() / 2, -player.y + love.graphics.getHeight() / 2)

  	-- Draw everything
	map.drawBaseLayer()
	player.draw()
	bullet.draw()
	entity.draw()
	-- testent.draw()
	map.drawTopLayer()

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