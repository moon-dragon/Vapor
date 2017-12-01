--this script will just define the functions to be used for entities

-- entity = {}
-- --ents is a count of how many entities have been spawned
-- ents = 0

entity = {}
--all entities that currently exist in the map
entities = {}

globalAgitationTimer = 5

local spawn = require("entities/code/tools/spawn")
local movement = require("entities/code/tools/movement")

function entity.load()
	spawn.addEntity("frankenstein", entities)
	spawn.addEntity("ghost", entities)
	spawn.addEntity("witch", entities)
end

function entity.update(dt)
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

-- function entity.spawn(table, x, y, width, height)
-- 	local newent = table
-- 	newent.x = x
-- 	newent.y = y
-- 	newent.xvel = 0
-- 	newent.yvel = 0
--   newent.width = width
--   newent.height = height
-- 	newent.ID = ents
--   newent.agitation = 3
--   print ("agitation of frankenstein is " ..newent.agitation)
-- 	print ("ID of entity just spawned just now is " .. newent.ID)
-- 	ents = ents + 1
-- 	return newent
-- end

function entity.incrementAgit(table)
  if(table.currentAgitation <= table.maxAgitation) then
    table.currentAgitation = table.currentAgitation + 1
  end
end


function entity.decrementAgit(table)
  if(table.currentAgitation > 0) then
    table.currentAgitation = table.currentAgitation - 1
    print ("agitation of frankenstein is " ..table.currentAgitation)
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
