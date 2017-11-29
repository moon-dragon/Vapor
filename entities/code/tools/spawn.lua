local spawn = {}
local mansion = require ("entities/map/map")

function spawn.addEntity(monster)
	local entity = {}

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
	
	-- Current animation of the entity
	entity.current = entity.idleLeft

	-- Speed of the entity
	entity.speed = char.speed

	-- Spawn point of the entity
	entity.x, entity.y = position[1], position[2]

	return entity
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