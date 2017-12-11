local movement = {}

local collision = require ("entities/code/tools/collision")
local spawn = require ("entities/code/tools/spawn")

-- Move the specified entity in a specific direction
-- Format:
-- 		- XDirection: 1 defines left movement, 2 defines right movement
--		- YDirection: 1 defines up movement, 2 defines down movement
--		- entityTable: the table that holds all of the entity
--		- entityID: the ID of an entity
-- 		- dt: Delta time

--[[
--local testCount = 0
function movement.movementXDelay(dt)
  --Delay timer
  moveTimer = moveTimer - dt
  if moveTimer <= 0 then
    XDirection = math.random(0,2)
    testCount = testCount + 1
    --print(testCount)
    --print(XDirection)
  end
  --print(XDirection)
  moveTimer = moveTimer + 2 --every 2 seconds potentially change direction
  return XDirection
end

function movement.movementYDelay(dt)
  --Delay timer
  moveTimer = moveTimer - dt
  if moveTimer <= 0 then
    YDirection = math.random(0,2)
  end
  --print(YDirection)
  moveTimer = moveTimer + 2 --every 2 seconds potentially change direction
  return YDirection
end
]]

function movement.movement(XDirection, YDirection, entityTable, entityID, dt) --make xd and yd local vars, 
	local isAWall, wallX, wallY, wallWidth, wallHeight = false, 0, 0, 0, 0
  

	-- Find the entity with the matching entityID
	local entity = entityTable[entityID]

	-- Update currentTime of the animation
	entity.animation.currentTime = entity.animation.currentTime + dt

	-- RIGHT direction
	if XDirection == 2 then 				
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(entity.x + entity.speed, entity.y, entity.current[1], collision.getWallsAndDoors())
		if not isAWall then
      --while XDirection == 2 do
        entity.x = entity.x + entity.speed
      --end
		else
			entity.x =  wallX - entity.current[1]:getWidth()
		end

		-- update entity coordinate
		entityTable[entityID].x = entity.x

		-- Plays the WALKING RIGHT animation
		entity.current = entity.walkingRight
		entity.direction = "right"

		-- Change the duration of each sprite in the walking animation
		entity.animation.currentDuration = entity.animation.walkingDuration

	-- LEFT direction
	elseif XDirection == 1 then 			
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(entity.x - entity.speed, entity.y, entity.current[1], collision.getWallsAndDoors())
		if not isAWall then
			entity.x = entity.x - entity.speed
		else
			entity.x =  wallX + wallWidth
		end

		-- update entity coordinate
		entityTable[entityID].x = entity.x


		-- Plays the WALKING LEFT animation
		entity.current = entity.walkingLeft
		entity.direction = "left"

		-- Change the duration of each sprite in the walking animation
		entity.animation.currentDuration = entity.animation.walkingDuration

	else
		-- Determine which idle animation to execute depending on the last direction faced
		if entity.direction == "left" then
			entity.current = entity.idleLeft

			-- Change the duration of each sprite in the idle animation
			entity.animation.currentDuration = entity.animation.idleDuration
		elseif entity.direction == "right" then
			entity.current = entity.idleRight

			-- Change the duration of each sprite in the idle animation
			entity.animation.currentDuration = entity.animation.idleDuration
		end 
	end

	-- UP movement
	if YDirection == 1 then

		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(entity.x, entity.y - entity.speed, entity.current[1], collision.getWallsAndDoors())
		if not isAWall then
			entity.y = entity.y - entity.speed
		else
			entity.y =  wallY + wallHeight
		end

		-- update entity coordinate
		entityTable[entityID].y = entity.y

		-- Determine which walking animation to play
		if entity.direction == "left" then
			-- Plays the WALKING LEFT animation
			entity.current = entity.walkingLeft
			
		elseif entity.direction == "right" then
			-- Plays the WALKING RIGHT animation
			entity.current = entity.walkingRight
		end

		-- Change the duration of each sprite in the walking animation
		entity.animation.currentDuration = entity.animation.walkingDuration

	-- DOWN movement
	elseif YDirection == 2 then
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(entity.x, entity.y + entity.speed, entity.current[1], collision.getWallsAndDoors())
		if not isAWall then
			entity.y = entity.y + (entity.speed)
		else
			entity.y = wallY - entity.current[1]:getHeight()
		end

		-- update entity coordinate
		entityTable[entityID].y = entity.y

		-- Determine which walking animation to play
		if entity.direction == "left" then
			-- Plays the WALKING LEFT animation
			entity.current = entity.walkingLeft
			
		elseif entity.direction == "right" then
			-- Plays the WALKING RIGHT animation
			entity.current = entity.walkingRight
		end

		-- Change the duration of each sprite in the walking animation
		entity.animation.currentDuration = entity.animation.walkingDuration

	end
	entityTable[entityID] = entity
end




return movement