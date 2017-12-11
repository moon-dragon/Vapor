-- Using Jumper pathfinding library - https://love2d.org/wiki/Jumper
ai = {}

local mansion = require("entities/map/map")
local entities = require("entities/code/Entity")

-- Libraries
local Grid = require("entities.code.tools.jumper.grid")
local Pathfinder = require("entities.code.tools.jumper.pathfinder")

-- tile ID 391 for wander tile in wanderable layer in map.lua
local walkable = 391

local pathLayer, pathMap, grid, myFinder, spawnPoints

function ai.load()
	-- Get wanderable paths layer
	pathLayer = ai.getMapLayer("wanderable")

	-- Convert to 2-D table map to use with grid & pathfinding library
	pathMap = ai.loadDataToTable(pathLayer)

	-- Creates grid object
	grid = Grid(pathMap)

	-- Creates pathfinder object using Jump Point Search
	myFinder = Pathfinder(grid, 'JPS', walkable)

	-- Get all spawn points from map layer
	spawnPoints = ai.getSpawnPoints()
end

function wander(entityID)
	-- get a random spawn point object
	local randomSpawnPt = ai.chooseSpawnPoint()
	local spawnX = math.floor(randomSpawnPt.x / mansion.width)
	local spawnY = math.floor(randomSpawnPt.y / mansion.height)

	-- get table of random path
	local pathTable = ai.randomPath(spawnX, spawnY)

	-- move monster to random spawn point
	entity.teleport(entityID, randomSpawnPt.X, randomSpawnPt.Y)

	-- start monster on random path

end






-------------------- Helper Functions --------------------

-- Returns the data of the specified layer
function ai.getMapLayer(name)
    for i = 1, #mansion.layers do
        if mansion.layers[i].name == name then
            return mansion.layers[i]
        end
    end
end

-- Convert 1-D data table to 2-D table
function ai.loadDataToTable(layer)
	local data = layer.data
	local table = {}

	for row = 1, layer.height do
		table[row] = {}
		for col = 1, layer.width do
			local index = (row - 1) * layer.width + col
			table[row][col] = data[index]
		end
	end

	return table
end

-- Returns all the objects that deals with wander spawning
function ai.getSpawnPoints()
	for i = 1, #mansion.layers do
		if mansion.layers[i].name == "wander_spawn" then
			return mansion.layers[i].objects
		end
	end
end

-- Returns a random spawn point object
function ai.chooseSpawnPoint()
	math.randomseed(os.time())
	local number = math.random(#spawnPoints)
	return spawnPoints[number]
end

-- Find a random path and put in table
function ai.randomPath(startX, startY)
	local path = false
	math.randomseed(os.time())
	while not path do
		local endX = math.random(pathLayer.height)
		local endY = math.random(pathLayer.width)
		print (startX, startY, endX, endY)
		path = myFinder:getPath(startX, startY, endX, endY) -- returns false if no path found 
	end

	local result = {}
	for node, i in path:nodes() do
		result[i] = {}
		result[i][1] = node:getX()
		result[i][2] = node:getY()
	end
	-- Return table of nodes for path result
	return result
end

return ai