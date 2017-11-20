map = {}

function map.load()
    local tmap = require("entities/map/map")

    Tileset = love.graphics.newImage('entities/map/dungeon.png')
    MapW, MapH = tmap.width, tmap.height
	TileW, TileH = 192, 192
	tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	Quads = {}
	Quads [1] = love.graphics.newQuad (0,0,TileW, TileH, tilesetW, tilesetH)
	Quads [2] = love.graphics.newQuad (192,0,TileW, TileH, tilesetW, tilesetH)
	Quads [3] = love.graphics.newQuad (384,0,TileW,TileH,tilesetW,tilesetH)
    Quads [4] = love.graphics.newQuad (0,192,TileW, TileH, tilesetW, tilesetH)
    Quads [5] = love.graphics.newQuad (192,192,TileW, TileH, tilesetW, tilesetH)
    Quads [6] = love.graphics.newQuad (384,192,TileW,TileH,tilesetW,tilesetH)
    Quads [7] = love.graphics.newQuad (0,384,TileW, TileH, tilesetW, tilesetH)
    Quads [8] = love.graphics.newQuad (192,384,TileW, TileH, tilesetW, tilesetH)
    Quads [9] = love.graphics.newQuad (384,384,TileW,TileH,tilesetW,tilesetH)

    TileTable = tmap.layers[1].data
	
end

function map.update()

end

function map.draw()
    -- scale graphics to zoom out
    love.graphics.scale(0.15)

    -- translate view to follow - to be implemented -
    tx = 0
    ty = 0
    love.graphics.translate(tx, ty)

    -- draw map data in TileTable
    for index = 1, #TileTable do
        local columnIndex = index % MapW
        local rowIndex = math.ceil(index / MapW)
        local number = TileTable[index]
        if number ~= nil and number ~= 0 then
            love.graphics.draw(Tileset, Quads[number], (columnIndex-1)*TileW, (rowIndex-1)*TileH)
        end
    end

end


