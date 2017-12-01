local spawn = {}
local mansion = require ("entities/map/map")

-- Adds a new entity to the list of entities
-- Format:
-- 		- monster: the name of the monster
-- 		- entityTable: the table that holds all of the entity
function spawn.addEntity(monster, entityTable)
	local entity = {}

	-- Holds any variables that deals with animation
	entity.animation = {}

	-- Load the appropriate animation and characterristic of the entity
	local anim = require ("entities/code/animation/" .. string.lower(monster) .. "_anim")
	local char = require ("entities/code/characteristics/" .. string.lower(monster) .. "_char")

	-- Generate a random spawn point from the list
	local position = availableSpawnPoints()[math.random(1, #availableSpawnPoints())]

	-- Load ENTITY'S animations
	entity.idleLeft = anim.IdleLeftAnimation()
	entity.idleRight = anim.IdleRightAnimation()
	entity.walkingLeft = anim.WalkingLeftAnimation()
	entity.walkingRight = anim.WalkingRightAnimation()

	-- The ID of the monster
	entity.ID = #entityTable + 1
	
	-- Current animation of the entity
	entity.current = entity.idleLeft

	-- Keep track of the last direction faced
	entity.direction = "left"

	-- Entity's dimension
	entity.height, entity.width = entity.current[1]:getHeight(), entity.current[1]:getWidth()

	-- Speed of the entity
	entity.speed = char.speed

	-- Max agitation of a monster
	entity.maxAgitation, entity.currentAgitation = char.maxAgitation, 0

	-- Spawn point of the entity
	entity.x, entity.y = position[1], position[2]

	-- Animation current time
	entity.animation.currentTime = 0
	
	-- Animation duration
	entity.animation.currentDuration = 1

	-- Walking animation duration
	entity.animation.idleDuration = char.animation.idleDuration

	-- Idle animation duration
	entity.animation.walkingDuration = char.animation.walkingDuration

	-- Insert the newly created entity in entityTable
	table.insert(entityTable, entity)
end

-- Draws the specified entity
function spawn.drawEntity(entity)
	-- Determines the index of the next animation
	local spriteNum = math.floor(entity.animation.currentTime * entity.animation.currentDuration % #entity.current) + 1
	
	-- Draws the entity
	love.graphics.draw(entity.current[spriteNum], entity.x, entity.y)
end

-- Returns all the available spawn points on the map:
--	 - Meaning that if one entity already spawned in a specific room,
--	   no one can spawn in that room.
function availableSpawnPoints()
	local spawnPoints = {}
	-- Lists all the spawn points in the map
	local points = mansion.layers[5].objects

	-- Lists all the AVAILABLE spawn points in map
	for i = 1, #points do
		if not points[i].properties["isOccupied"] then
			table.insert(spawnPoints, {points[i].x, points[i].y})
			points[i].properties["isOccupies"] = true
		end
	end

	return spawnPoints
end

return spawn