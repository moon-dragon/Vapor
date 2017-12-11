entity = {}

-- All entities that currently exist in the map
entities = {}

local globalAgitationTimer = 10
local spawnMusic = love.audio.newSource("entities/music/knocking.wav")

local spawn = require("entities/code/tools/spawn")
local movement = require("entities/code/tools/movement")
local monster = require ("entities/code/tools/monster")
local time = require ("entities/code/tools/time")

function entity.load()

	-- Determine the chosen cycle the monster would spawn
	entity.chosenCycle = nil

	-- Add 3 starting entities
	spawn.addEntity("frankenstein", entities)
	spawn.addEntity("ghost", entities)
	spawn.addEntity("witch", entities)

end

function entity.update(dt)

	-- If there's no chosen cycle and the mansion is not full, choose now
	if entity.chosenCycle == nil and spawn.getStatus() == false then
		local j = spawn.generateCycleSpawn()
		entity.chosenCycle = time.getCycleCounter() + j
	end

	-- If the chosenCycle matches with the current cycle and it's in the middle of the day, spawn the monster
	if entity.chosenCycle ~= nil and time.getCycleCounter() == entity.chosenCycle and time.getTimeCounter() == math.floor(time.getCycleLength()/2) then
		entity.spawnMonster(monster.getAMonster())
	end

	-- TEMPORARY MOVEMENT (Currently all idle)
	movement.movement(0, 0, entities, 1, dt)
	movement.movement(0, 0, entities, 2, dt)
	movement.movement(0, 0, entities, 3, dt)

end

function entity.draw()
	for i = 1, #entities do
		spawn.drawEntity(entities[i])
	end
end


-- Spawn monster and reset the chosen cycle
function entity.spawnMonster(monster)
	love.audio.play(spawnMusic)
	spawn.addEntity(monster, entities)
	entity.chosenCycle = nil
end


-- TEMPORARY
function entity.getChosenCycle()
	return entity.chosenCycle
end



function entity.incrementAgit(table)
  if(table.currentAgitation <= table.maxAgitation) then
    table.currentAgitation = table.currentAgitation + (1 * table.agitationLevel)
  end
end


function entity.decrementAgit(table)
  if(table.currentAgitation > 0) then
    table.currentAgitation = table.currentAgitation - 1
    -- print ("agitation of frankenstein is " ..table.currentAgitation)
  end
end


function entity.getEntities()
  return entities
end


function entity.globalAgit(dt)
  --print("globalagit")
  globalAgitationTimer = globalAgitationTimer- dt
  if globalAgitationTimer <= 0 then
	for i,v in pairs(entities) do
    --print("ent.update")
    entity.incrementAgit(v) 
    end
    globalAgitationTimer = globalAgitationTimer + 5
  end
end

return entity

-- --in order for an entity to update, they must pass entity.update to love.update themselves
-- function entity.update(dt)
  
-- end

--This can be used to easily draw the entities
-- function entity.draw(table)
-- 	if table ~= nil then
-- 		if table.img ~= nil then 
-- 			love.graphics.draw(table.img, table.x, table.y)
-- 		else
-- 			love.graphics.setColor(255,0,255)
-- 			love.graphics.rectangle("fill",table.x, table.y, table.width, table.height)
-- 		end
-- 	end
-- end

--Because I am nice, I will allow players to check if their ent is being clicked with one simple function
--[[
function entity.checkForMouseDown(table)
	if table ~= nil then
		if love.mouse.getX() > table.x and love.mouse.getX() < table.x + table.width and love.mouse.getY() > table.y and love.mouse.getY() < table.y + table.height and love.mouse.isDown("l") == true then
			return true
		else
			return false
		end
	end
end
]]
