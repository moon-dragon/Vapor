map = {}

function map.load()

    -- Access the generated code for the map
    local mansion = require("entities/map/map")

    -- Access the map tileset
    tileset = love.graphics.newImage("entities/map/dungeon.png")

    -- The number of tiles that makes up the HEIGHT and the WIDTH
    mapHeight, mapWidth = mansion.height, mansion.width

    -- The HEIGHT and WIDTH of a tile
    tileHeight, tileWidth = 192, 192

    -- WIDTH and HEIGHT of the tileset
    local tilesetHeight, tilesetWidth = tileset:getHeight(), tileset:getWidth()

    -- Generate each tiles
    local quad = love.graphics.newQuad
    quads = 
    {
        -- Format: x, y, tileWidth, TileHeight, TilesetWidth, TilesetHeight
        --         x: x coordinate of the targeted tile
        --         y: y coordinate of the targeted tile
        quad(  0,   0, 192, 192, tilesetWidth, tilesetHeight),
        quad(192,   0, 192, 192, tilesetWidth, tilesetHeight),
        quad(384,   0, 192, 192, tilesetWidth, tilesetHeight),
        quad(  0, 192, 192, 192, tilesetWidth, tilesetHeight),
        quad(192, 192, 192, 192, tilesetWidth, tilesetHeight),
        quad(384, 192, 192, 192, tilesetWidth, tilesetHeight),
        quad(  0, 384, 192, 192, tilesetWidth, tilesetHeight),
        quad(192, 384, 192, 192, tilesetWidth, tilesetHeight),
        quad(384, 384, 192, 192, tilesetWidth, tilesetHeight)
    }

    -- The DATA info for the map's 1ST LAYER
    tileTable = mansion.layers[1].data

end

function map.update(dt)

end

function map.draw()

    -- Renders the map
    for i = 1, #tileTable do
        local colIndex = i % mapWidth
        local rowIndex = math.ceil(i / mapWidth)
        local currentDataIndex = tileTable[i]
        if currentDataIndex ~= nil and currentDataIndex ~= 0 then
            love.graphics.draw(tileset, quads[currentDataIndex], (colIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight)
        end
    end

end




-- map = {}

-- function map.load()
--     local tmap = require("entities/map/map")

--     Tileset = love.graphics.newImage('entities/map/dungeon.png')
--     MapW, MapH = tmap.width, tmap.height
-- 	TileW, TileH = 192, 192
-- 	tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
-- 	Quads = {}
-- 	Quads [1] = love.graphics.newQuad (0,0,TileW, TileH, tilesetW, tilesetH)
-- 	Quads [2] = love.graphics.newQuad (192,0,TileW, TileH, tilesetW, tilesetH)
-- 	Quads [3] = love.graphics.newQuad (384,0,TileW,TileH,tilesetW,tilesetH)
--     Quads [4] = love.graphics.newQuad (0,192,TileW, TileH, tilesetW, tilesetH)
--     Quads [5] = love.graphics.newQuad (192,192,TileW, TileH, tilesetW, tilesetH)
--     Quads [6] = love.graphics.newQuad (384,192,TileW,TileH,tilesetW,tilesetH)
--     Quads [7] = love.graphics.newQuad (0,384,TileW, TileH, tilesetW, tilesetH)
--     Quads [8] = love.graphics.newQuad (192,384,TileW, TileH, tilesetW, tilesetH)
--     Quads [9] = love.graphics.newQuad (384,384,TileW,TileH,tilesetW,tilesetH)

--     TileTable = tmap.layers[1].data
	
-- end

-- function map.update()

-- end

-- function map.draw()
--     -- scale graphics to zoom out
--     love.graphics.scale(0.15)

--     -- translate view to follow - to be implemented -
--     tx = 0
--     ty = 0
--     love.graphics.translate(tx, ty)

--     -- draw map data in TileTable
--     for index = 1, #TileTable do
--         local columnIndex = index % MapW
--         local rowIndex = math.ceil(index / MapW)
--         local number = TileTable[index]
--         if number ~= nil and number ~= 0 then
--             love.graphics.draw(Tileset, Quads[number], (columnIndex-1)*TileW, (rowIndex-1)*TileH)
--         end
--     end

-- end


