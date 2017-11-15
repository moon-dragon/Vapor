require "player"
require "mapcontrol"
require "Entity"
require "TestEnt"
function love.load()
map.load()
player.load()
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
