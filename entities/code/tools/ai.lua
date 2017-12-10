-- Using Jumper pathfinding library - https://love2d.org/wiki/Jumper

local ai = {}

local mansion = require ("entities/map/map")

-- Libraries
local Grid = require ("entities/code/tools/jumper/jumper.grid")
local Pathfinder = require ("jumper.pathfinder")

-- tile ID 391 for wander tile in wanderable layer in map.lua
local walkable = 391

local pathLayer, pathMap, grid, myFinder

function ai.load()
	-- Get wanderable paths layer
	pathLayer = getMapLayer("wanderable")
	-- Convert to 2-D table map to use with grid & pathfinding library
	pathMap = loadDataToTable(pathLayer)

	-- Creates grid object
	grid = Grid(pathMap)
	-- Creates pathfinder object using Jump Point Search
	myFinder = Pathfinder(grid, 'JPS', walkable)
end

function ai.wanderFrom(startX, startY) -- right now with this, startX & Y need to be already within the walkable paths to work
									   -- need to either teleport entity outside their room into the walkable paths or mark the
									   -- doors and walk them out 
	-- Find a random end point
	local path = false
	while !path do
		math.randomseed(os.time())
		local endX = math.randomseed(pathLayer.height)
		local endY = math.randomseed(pathLayer.width)
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

-------------------- Helper Functions --------------------



-- Returns the data of the specified layer
function getMapLayer(name)
    for i = 1, #mansion.layers do
        if mansion.layers[i].name == name then
            return mansion.layers[i].data
        end
    end
end

-- Convert 1-D data table to 2-D table
function loadDataToTable(layer)
	local data = layer.data
	local table = {}

	for row = 1, layerData.height do
		table[row] = {}
		for col = 1, layer.width do
			local index = (row - 1) * layer.width + col
			table[row][col] = data[index]
	end

	return table
end

return ai