map = {}

local mansion = require("entities/map/map")
local collision = require("entities/code/tools/collision")
local spawn = require("entities/code/tools/spawn")
local player = require("entities/code/player")

function map.load()

    -- Access all tileset
    local wallTileset = getTileset("purple_dungeon")
    local item1Tileset = getTileset("purple_dungeon_item1")
    local item2Tileset = getTileset("purple_dungeon_item2")

    -- Holds all the tiles from every tileset
    quads = {}

    -- Access the tileset image: WALL
    tilesetWall = love.graphics.newImage("entities/map/purple_dungeon.png")

    -- Access the tileset image: STATIC ITEMS1
    tilesetStaticItem1 = love.graphics.newImage("entities/map/purple_dungeon_item1.png")

    -- Access the tileset image: STATIC ITEMS2
    tilesetStaticItem2 = love.graphics.newImage("entities/map/purple_dungeon_item2.png")

    -- The number of tiles that makes up the HEIGHT and the WIDTH
    mapHeight, mapWidth = mansion.height, mansion.width

    -- Get Tilesets and Tiles WIDTH and HEIGHT: PURPLE_DUNGEON
    tileHeightWall, tileWidthWall, tilesetHeightWall, tilesetWidthWall = wallTileset.tileheight, wallTileset.tilewidth, wallTileset.imageheight, wallTileset.imagewidth

    -- Get Tilesets and Tiles WIDTH and HEIGHT: PURPLE_DUNGEON_ITEM1
    tileHeightItem1, tileWidthItem1, tilesetHeightItem1, tilesetWidthItem1 = item1Tileset.tileheight, item1Tileset.tilewidth, item1Tileset.imageheight, item1Tileset.imagewidth

    -- Get Tilesets and Tiles WIDTH and HEIGHT: PURPLE_DUNGEON_ITEM2
    tileHeightItem2, tileWidthItem2, tilesetHeightItem2, tilesetWidthItem2 = item2Tileset.tileheight, item2Tileset.tilewidth, item2Tileset.imageheight, item2Tileset.imagewidth

    -- Generate each tiles: PURPLE_DUNGEON
    addTileset(quads, tileWidthWall, tileHeightWall, tilesetWidthWall, tilesetHeightWall)

    -- Generate each tiles: PURPLE_DUNGEON_ITEMS1
    addTileset(quads, tileWidthItem1, tileHeightItem1, tilesetWidthItem1, tilesetHeightItem1)

    -- Generate each tiles: PURPLE_DUNGEON_ITEMS2
    addTileset(quads, tileWidthItem2, tileHeightItem2, tilesetWidthItem2, tilesetHeightItem2)

    -- The DATA info for the map's MIDDLEGROUND layer
    mansionMiddleground = getMapLayer("middleground")

    -- The DATA info for the map's FOREGROUND layer
    mansionForeground = getMapLayer("foreground")

    -- The DATA info for the map's STATIC ITEM1 layer
    mansionStaticItem1 = getMapLayer("static_wall_items1")

    -- The DATA info for the map's STATIC ITEM2 layer
    mansionStaticItem2 = getMapLayer("static_wall_items2")

    -- The DATA info for the map's STATIC ITEM3 layer
    mansionStaticItem3 = getMapLayer("static_wall_items3")

    -- The DATA info for the map's STATIC ITEM4 layer
    mansionStaticItem4 = getMapLayer("static_wall_items4")

    -- The DATA info for the map's STATIC ITEM5 layer
    mansionStaticItem5 = getMapLayer("static_wall_items5")

    -- The DATA info for the map's STATIC ITEM6 layer
    mansionStaticItem6 = getMapLayer("static_wall_items6")

    -- The DATA info for the map's STATIC ITEM7 layer
    mansionStaticItem7 = getMapLayer("static_wall_items7")

    -- List of wall objects (used for colllision)
    mansionWallObjects = collision.getWalls()

    -- List of spawn objects
    mansionSpawnPoints = spawn.getSpawnPoints()

end

function map.update(dt)

end

function map.drawBaseLayer()
    -- Renders the map: MIDDLEGROUND
    drawTileLayer(mansionMiddleground, tilesetWall, quads, tileWidthWall, tileHeightWall)

    -- Render the map: STATIC ITEMS1, STATIC ITEMS2, STATIC ITEMS4, and STATIC ITEMS7
    drawTileLayer(mansionStaticItem1, tilesetStaticItem1, quads, tileWidthItem1, tileHeightItem1)
    drawTileLayer(mansionStaticItem4, tilesetStaticItem2, quads, tileWidthItem2, tileHeightItem2)
    drawTileLayer(mansionStaticItem7, tilesetStaticItem2, quads, tileWidthItem2, tileHeightItem2)
    drawTileLayer(mansionStaticItem2, tilesetStaticItem1, quads, tileWidthItem1, tileHeightItem1)

    -- Draws all the spawn points on the map
    -- drawObjectLayer(mansionSpawnPoints)
end

function map.drawTopLayer()
    -- Renders the map: FOREGROUND
    drawTileLayer(mansionForeground, tilesetWall, quads, tileWidthWall, tileHeightWall)

    -- Render the map: STATIC ITEMS3, STATIC ITEMS5, and STATIC ITEMS6
    drawTileLayer(mansionStaticItem5, tilesetStaticItem2, quads, tileWidthItem2, tileHeightItem2)
    drawTileLayer(mansionStaticItem6, tilesetStaticItem2, quads, tileWidthItem2, tileHeightItem2)
    drawTileLayer(mansionStaticItem3, tilesetStaticItem1, quads, tileWidthItem1, tileHeightItem1)

    -- -- Draws all collision obects
    -- drawObjectLayer(mansionWallObjects)
end

------ HELPER FUNCTION ------

-- Put each tile in a tileset in a table of QUADS
function addTileset(quads, tileWidth, tileHeight, tilesetWidth, tilesetHeight)
    local quad = love.graphics.newQuad
    local posx, posy = 0, 0
    for x = 1, tilesetHeight/tileHeight do
        for y = 1, tilesetWidth/tileWidth do
            table.insert(quads, quad(posx, posy, tileWidth, tileHeight, tilesetWidth, tilesetHeight))
            posx = posx + tileWidth
        end
        posy = posy + tileHeight
        posx = 0
    end
end

-- Returns the data of the specified layer
function getMapLayer(name)
    for i = 1, #mansion.layers do
        if mansion.layers[i].name == name then
            return mansion.layers[i].data
        end
    end
end

-- Returns the tilseset object specified
function getTileset(name)
    for i = 1, #mansion.tilesets do
        if mansion.tilesets[i].name == name then
            return mansion.tilesets[i]
        end
    end
end

-- Draws the map with the given parameters
function drawTileLayer(mapData, tilseset, quad, tileWidth, tileHeight)
    for i = 1, #mapData do
        local colIndex = i % mapWidth
        if colIndex == 0 then
            colIndex = mapWidth
        end
        local rowIndex = math.ceil(i / mapWidth)
        local currentDataIndex = mapData[i]
        if currentDataIndex ~= nil and currentDataIndex ~= 0 then
            -- If it's within the boundary of the window
            local x, y = (colIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight
            if checkWindowBoundary(x, y, 0.5) then
                love.graphics.draw(tilseset, quad[currentDataIndex], x, y)
            end
        end
    end
end

-- Draws the map with the map object
function drawObjectLayer(mapObject)
    for i = 1, #mapObject do
        love.graphics.rectangle("fill", mapObject[i].x, mapObject[i].y, mapObject[i].width, mapObject[i].height)
    end
end

-- Returns true if the given x and y is within the boundary of the game window
function checkWindowBoundary(x, y, scale)
    local posx, posy = player.getPosition()
    local boundx, boundy = math.ceil((love.graphics.getWidth()/2) * (1/scale)), math.ceil((love.graphics.getHeight()/2) * (1/scale))
    if x <= (posx + boundx) and x >= (posx - boundx) and y <= (posy + boundy) and y >= (posy - boundy) then
        return true
    end
    return false
end
return map