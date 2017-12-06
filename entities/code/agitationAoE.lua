require ("entities/code/Entity")

--[[

Would be better to initialize the squares in spawn.lua.
That way, an individual square is stored in each entity as 
an attribute. Then you can use For iv pairs to access each
entity's square and call bullet.collide() on it and the player.

]]
agitationAoE = {}

local function rect (x, y, w, h, color)
    return { x = x, y = y, width = w, height = h, color = color }
end

local function draw_rect(rect) --move to spawn.lua?
    
    for i,v in ipairs(entity.getEntities()) do
    --print(v.currentAgitation)
      if(v.currentAgitation == v.maxAgitation) then
        --Entity's agitationRectangle
        --print("l")
        local area = rect(v.x - 1000, v.y - 1000, 2000, 2000, white) --approximate center is fine
        love.graphics.setColor(unpack(rect.color))
        love.graphics.rectangle('line', rect.x, rect.y, rect.width, rect.height)
        agitationAoE.insert(area)
        --have to store area somewhere where bullet.collides() can access area's x,y,width,height
      end
    end
end

local function getAgitationAreas()
  return agitationAoE
end

local red = { 255, 0, 0, 100 }
local green = { 0, 255, 0, 255 }
local blue = { 0, 0, 255, 255 }
local white = {255, 255,255,255}

--local area = rect(v.x - 1000, v.y - 1000, 2000, 2000, white)

--function agitationAoE.update ()
    --have a check here that sees if the player collides with rect?
--end

function agitationAoE.draw()
    draw_rect(area)

end