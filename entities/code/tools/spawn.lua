local spawn = {}
local mansion = require ("entities/map/map")
local neighbor = require ("entities/code/tools/neighbor")
local color = {255, 0, 0, 255} --red


--agitation area dimensions, basically a rectangle object
local function agitationArea (posx, posy, w, h, color)
	return { x = posx, y = posy, width = w, height = h, color = color }
end


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

	-- Load ENTITY'S animations
	entity.idleLeft = anim.IdleLeftAnimation()
	entity.idleRight = anim.IdleRightAnimation()
	entity.walkingLeft = anim.WalkingLeftAnimation()
	entity.walkingRight = anim.WalkingRightAnimation()

	-- The ID of the monster
	entity.ID = #entityTable + 1

	-- The type of monster
	entity.name = string.lower(monster)

	-- The list of the monster's enemies
	entity.nemesis = char.nemesis
	
	-- Current animation of the entity
	entity.current = entity.idleLeft

	-- Keep track of the last direction faced
	entity.direction = "left"

	-- Entity's dimension
	entity.height, entity.width = entity.current[1]:getHeight(), entity.current[1]:getWidth()

	-- Speed of the entity
	entity.speed = char.speed

	-- Max and Current agitation of a monster
	entity.maxAgitation, entity.currentAgitation = char.maxAgitation, 0

	-- Spawn point and room number of the entity
	entity.x, entity.y, entity.roomNumber = chooseSpawnPoint()
	
  	-- Entity's area of agitation
  	entity.area = agitationArea(entity.x - 1000, entity.y - 1000, 2000, 2000, color) --problem doesn't have to do with these dimensions
  
	-- Returns the rate of agiation of the monster
	entity.agitationLevel = agitationLevel(entity.roomNumber, entity.nemesis, entityTable)

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

-- Draw the entity's agitation area
function spawn.draw_area(agitationArea)
        love.graphics.setColor(unpack(agitationArea.color))
        love.graphics.rectangle('line', agitationArea.x, agitationArea.y, agitationArea.width, agitationArea.height)
        love.graphics.setColor(255, 255, 255, 255)
end

-- Draws the specified entity
function spawn.drawEntity(entity)
	-- Determines the index of the next animation
	local spriteNum = math.floor(entity.animation.currentTime * entity.animation.currentDuration % #entity.current) + 1
	
	-- Draws the entity
	love.graphics.draw(entity.current[spriteNum], entity.x, entity.y)
  	
  	-- Print current agitation
	local FONT = love.graphics.newFont("entities/img/font.ttf", 32)
	love.graphics.setFont(FONT)
	love.graphics.printf(entity.currentAgitation, entity.x + 80, entity.y - 30 , 40, left)
end


-- Returns all the objects that deals with entity spawning
function spawn.getSpawnPoints()
	for i = 1, #mansion.layers do
		if mansion.layers[i].name == "monster_spawn" then
			return mansion.layers[i].objects
		end
	end
end







------ HELPER FUNCTION ------

-- Returns the position of the monster spawn objects in map table
function  getSpawnLayerPos()
	for i = 1, #mansion.layers do
		if mansion.layers[i].name == "monster_spawn" then
			return i
		end
	end
end

-- Returns a random spawn point (and room number) in a pool of available spawn points
function chooseSpawnPoint()
	-- Choose a random spawn point
	local spawnPoints = availableSpawnPoints()
	local number = love.math.random(#spawnPoints)
	local chosenSpawn = spawnPoints[number]

	-- Update the availability of the chosen point
	updateOccupationStatus(chosenSpawn[1], chosenSpawn[2], true)

	return chosenSpawn[1], chosenSpawn[2], chosenSpawn[3]

end

-- Change the status of the specified spawn point
function updateOccupationStatus(x, y, bool)
	local points = spawn.getSpawnPoints()
	for i = 1, #points do
		if x == points[i].x and y == points[i].y then
			mansion.layers[getSpawnLayerPos()].objects[i].properties["isOccupied"] = bool
			break
		end
	end
end

-- Returns all the available spawn points (and the room numbers) on the map:
--	 - Meaning that if one entity already spawned in a specific room,
--	   no one can spawn in that room.
function availableSpawnPoints()
	local spawnPoints = {}
	-- Lists all the spawn points in the map
	local points = spawn.getSpawnPoints()

	-- Lists all the AVAILABLE spawn points in map
	for i = 1, #points do
		if not points[i].properties["isOccupied"] then
			table.insert(spawnPoints, {points[i].x, points[i].y, points[i].properties["roomNumber"]})
		end
	end
	return spawnPoints
end

-- Check if the specified value is in the table
function contains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end

-- Returns the rate of agitation the entity would have
function agitationLevel(roomNumber, monsterNemesis, entityTable)
	-- Returns all the neighbor's room number
	local neighborList = neighbor.checkNeighbor(roomNumber)
	local agitationLevel = 1

	-- Return false if specified room number does not have a neighbor or the monster does not hate anyone
	if neighborList == {} or #monsterNemesis == 0 then
		return agitationLevel
	end

	for i = 1, #entityTable do
		-- Checks to see if the room number specified is actually a neighbor
		if contains(neighborList, entityTable[i].roomNumber) then
			-- Check to see if the neighbor's name is in the nemesis table of monster
			if contains(monsterNemesis, entityTable[i].name) then
				-- Increase agitation for monster as well
				entityTable[i].agitationLevel = entityTable[i].agitationLevel + 1
				-- Increase agitation
				agitationLevel = agitationLevel + 1
			end
		end
	end
	return agitationLevel
end

return spawn