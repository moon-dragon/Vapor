require ("entities.code.player")
require ("entities.code.mapcontrol")
require ("entities.code.Entity")
require ("entities.code.TestEnt")

example = {}

function love.load()
	map.load()
	player.load()
	--bullet.load()
	--testent.load()
end

function love.update(dt)
	map.update(dt)
	player.update(dt)
	--bullet.update(dt)
	--testent.update(dt)
end

function love.draw()

	-- Makes the camera follow the player
	love.graphics.push()
  	love.graphics.translate(-player.x + love.graphics.getWidth() / 2, -player.y + love.graphics.getHeight() / 2)

  	-- Draw everything
	map.draw()
	player.draw()
	--bullet.draw()
	--testent.draw()


	love.graphics.pop()

end

function love.event.quit()
	love.event.quit()
end