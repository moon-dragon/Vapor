entity = {}

-- All entities that currently exist in the map
entities = {}

local spawnMusic = love.audio.newSource("entities/music/knocking.wav")

local globalAgitationTimer = 10
local damageTimer = 0
local moveTimer = 0

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

	-- Keeps track of time for movement
	counter1 = 0
	counter2 = 0

	-- The length of each set of movements
	movementDuration = 1

	-- Check to see if the player is moving
	isMoving = false


end

function entity.update(dt)
	entity.agitationDamageCheck(dt)
  
	  -- for i,v in ipairs(entity.getEntities()) do
	  --   if v.currentAgitation == v.maxAgitation then
	  --     --print("hi")
	  --     spawn.grow_area(dt)
	  --     --print("hi")
	  --   end
	  -- end
  
	-- If there's no chosen cycle and the mansion is not full, choose now
	if entity.chosenCycle == nil and spawn.getStatus() == false then
		local j = spawn.generateCycleSpawn()
		entity.chosenCycle = time.getCycleCounter() + j
	end

	-- If the chosenCycle matches with the current cycle and it's in the middle of the day, spawn the monster
	if entity.chosenCycle ~= nil and time.getCycleCounter() == entity.chosenCycle and time.getTimeCounter() == math.floor(time.getCycleLength()/2) then
		entity.spawnMonster(monster.getAMonster())
	end

	-- MOVEMENT

		if isMoving == false then
			for i = 1, #entities do
				spawn.seCurrentMovement(math.random(0, 2), math.random(0, 2), entities, i)
			end
			isMoving = true
		end
		for i = 1, #entities do
			local x, y = spawn.getCurrentMovement(entities,i)
			movement.movement(x, y, entities, i, dt)
		end

		counter1 = counter1 + 1
		if counter1 % 101 >= 100 then
			counter2 = counter2 + 1
		end
		
		if counter2 == movementDuration then
			direction = false
			counter1 = 0
			counter2 = 0
			movementDuration = math.random(1, 2)
			isMoving = false
		end

end

function entity.draw()
	for i = 1, #entities do
		spawn.drawEntity(entities[i])
	end
  
  	entity.agitationDraw()
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
