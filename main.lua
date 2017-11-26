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
	map.draw()
	player.draw()
	bullet.draw()
	testent.draw()
end

function love.event.quit()
	love.event.quit()
end