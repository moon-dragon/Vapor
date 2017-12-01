map = {}

local mansion = require("entities/map/map")
local collision = require("entities/code/tools/collision")
local spawn = require("entities/code/tools/spawn")

function map.load()

    -- Access the map tileset
    tileset = love.graphics.newImage("entities/map/purple_dungeon.png")

    -- The number of tiles that makes up the HEIGHT and the WIDTH
    mapHeight, mapWidth = mansion.height, mansion.width

    -- The HEIGHT and WIDTH of a tile
    tileHeight, tileWidth = mansion.tilesets[1].tileheight, mansion.tilesets[1].tilewidth

    -- WIDTH and HEIGHT of the tileset
    tilesetHeight, tilesetWidth = mansion.tilesets[1].imageheight, mansion.tilesets[1].imagewidth

    -- Generate each tiles
    quads = generateTileset(tileWidth, tileHeight, tilesetWidth, tilesetHeight)

    -- The DATA info for the map's MIDDLEGROUND layer
    mansionMiddleground = getMiddleground()

    -- The DATA info for the map's FOREGROUND layer
    mansionForeground = getForeground()

    -- List of wall objects (used for colllision)
    mansionWallObjects = collision.getWalls()

    -- List of spawn objects
    mansionSpawnPoints = spawn.getSpawnPoints()

end

function map.update(dt)

end

-- Renders the map: MIDDLEGROUND
function map.middleGroundDraw()

    for i = 1, #mansionMiddleground do
        local colIndex = i % mapWidth
        if colIndex == 0 then
            colIndex = mapWidth
        end
        local rowIndex = math.ceil(i / mapWidth)
        local currentDataIndex = mansionMiddleground[i]
        if currentDataIndex ~= nil and currentDataIndex ~= 0 then
            love.graphics.draw(tileset, quads[currentDataIndex], (colIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight)
        end

    end
end


-- Renders the map: FOREGROUND
function map.foreGroundDraw()

    for i = 1, #mansionForeground do
        local colIndex = i % mapWidth
        if colIndex == 0 then
            colIndex = mapWidth
        end
        local rowIndex = math.ceil(i / mapWidth)
        local currentDataIndex = mansionForeground[i]
        if currentDataIndex ~= nil and currentDataIndex ~= 0 then
            love.graphics.draw(tileset, quads[currentDataIndex], (colIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight)
        end
    end
end

-- Renders the map: WALL COLLISION
function map.wallObjectsDraw()
    for i = 1, #mansionWallObjects do
        love.graphics.rectangle("fill", mansionWallObjects[i].x, mansionWallObjects[i].y, mansionWallObjects[i].width, mansionWallObjects[i].height)
    end
end

-- Render the map: SPAWN POINTS
function map.monsterSpawnPointsDraw()
    for i = 1, #mansionSpawnPoints do
        love.graphics.rectangle("fill", mansionSpawnPoints[i].x, mansionSpawnPoints[i].y, mansionSpawnPoints[i].width, mansionSpawnPoints[i].height)
    end
end


------ HELPER FUNCTION ------

-- Put each tile in a tileset in a table of QUADS
function generateTileset(tileWidth, tileHeight, tilesetWidth, tilesetHeight)
    local quad = love.graphics.newQuad
    local quads = {}
    local posx, posy = 0, 0
    for x = 1, tilesetHeight/tileHeight do
        for y = 1, tilesetWidth/tileWidth do
            table.insert(quads, quad(posx, posy, tileWidth, tileHeight, tilesetWidth, tilesetHeight))
            posx = posx + tileWidth
        end
        posy = posy + tileHeight
        posx = 0
    end
    return quads

end

-- Returns the data of the MIDDLEGROUND layer
function getMiddleground()
    for i = 1, #mansion.layers do
        if mansion.layers[i].name == "middleground" then
            return mansion.layers[i].data
        end
    end
end

-- Returns the data of the FOREGROUND layer
function getForeground()
    for i = 1, #mansion.layers do
        if mansion.layers[i].name == "foreground" then
            return mansion.layers[i].data
        end
    end
end