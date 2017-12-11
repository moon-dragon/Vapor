entity = {}

-- All entities that currently exist in the map
entities = {}

globalAgitationTimer = 10
damageTimer = 0
moveTimer = 0

local spawn = require("entities/code/tools/spawn")
local movement = require("entities/code/tools/movement")

function entity.load()
	-- Adds 3 entity
	spawn.addEntity("frankenstein", entities)
	spawn.addEntity("ghost", entities)
	spawn.addEntity("witch", entities)

	-- -- TEMPORARY
	-- spawn.addEntity("ghost", entities)
	-- spawn.addEntity("ghost", entities)
	-- spawn.addEntity("witch", entities)

	-- spawn.addEntity("witch", entities)
	-- spawn.addEntity("ghost", entities)
	-- spawn.addEntity("witch", entities)
end

function entity.update(dt)
  --movement.movementXDelay(dt)
  --movement.movementYDelay(dt)
	-- TEMPORARY MOVEMENT (Currently all idle)
	--movement.movement(movement.movementXDelay(dt), movement.movementYDelay(dt), entities, 1, dt)
  movement.movement(0, 0, entities, 1, dt)
	movement.movement(0, 0, entities, 2, dt)
	movement.movement(0, 0, entities, 3, dt)

	--movement.movement(0, 0, entities, 4, dt)
	--movement.movement(0, 0, entities, 5, dt)
	--movement.movement(0, 0, entities, 6, dt)

	--movement.movement(0, 0, entities, 7, dt)
	--movement.movement(0, 0, entities, 8, dt)
	--movement.movement(0, 0, entities, 9, dt)
--Delay timer
--[[
  moveTimer = moveTimer - dt
  if moveTimer <= 0 then
    movement.movement(math.random(0, 2), math.random(0, 2), entities, 1, dt)
    movement.movement(math.random(0, 2), math.random(0, 2), entities, 2, dt)
    movement.movement(math.random(0, 2), math.random(0, 2), entities, 3, dt)

    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 4, dt)
    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 5, dt)
    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 6, dt)

    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 7, dt)
    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 8, dt)
    -- movement.movement(math.random(0, 2), math.random(0, 2), entities, 9, dt)
    moveTimer = moveTimer + 3 --every .25 seconds potentially change direction
  end
]]
  entity.agitationDamageCheck(dt)
  
  for i,v in ipairs(entity.getEntities()) do
    if v.currentAgitation == v.maxAgitation then
      --print("hi")
      spawn.grow_area(dt)
      --print("hi")
    end
  end
end

function entity.draw()
	for i = 1, #entities do
		spawn.drawEntity(entities[i])
	end
  
  	entity.agitationDraw()
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
    table.currentAgitation = table.currentAgitation + (1 * table.agitationLevel)
  end
end


function entity.decrementAgit(table)
  if(table.currentAgitation > 0) then
    table.currentAgitation = table.currentAgitation - 1
    -- print ("agitation of frankenstein is " ..table.currentAgitation)
  end
end

--Just draws entity agitation area
function entity.agitationDraw()
  --max agitation check and AoE damage
  for i,v in ipairs(entities) do
    if(v.currentAgitation >= v.maxAgitation) then
      spawn.draw_area(v.area)
    end
  end
end

--Actually deals damage to the player upon max agitation
function entity.agitationDamageCheck(dt)
  --max agitation check and AoE damage
  for i,v in ipairs(entities) do
    if(v.currentAgitation >= v.maxAgitation) then
        if(bullet.collides(player,v.area)) then --area is the entity's agitation area
          entity.agitationDamage(dt)
        end
    end
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

function entity.agitationDamage(dt)
  damageTimer = damageTimer - dt
  if damageTimer <= 0 then
    player.isDamaged()
    damageTimer = damageTimer + 5
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
