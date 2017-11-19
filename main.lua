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
	testent.update(dt)
end

function love.draw()
	map.draw()
	player.draw()
	testent.draw()
end

function love.event.quit()
	love.event.quit()
end