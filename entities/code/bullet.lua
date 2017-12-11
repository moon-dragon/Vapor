--https://love2d.org/wiki/Tutorial:Fire_Toward_Mouse for the overall bullet implementation
--https://love2d.org/forums/viewtopic.php?t=47565 to make the bullets fire based on player direction and not mouse direction
bullet = {}
bullet.animation = {}
bullet.food = {}
bulletSpeed = 0

local collision = require("entities/code/tools/collision")
local anim = require ("entities/code/animation/food_anim")

function bullet.load()
	bulletSpeed = 1500

  bullet.food = anim.foodSpinAnimation()

  -- Animation current time
  bullet.animation.currentTime = 0

  -- Animation duration
  bullet.animation.currentDuration = 7
end
  
function bullet.draw()
	for i,v in ipairs(bullet) do
    -- Determine the index of the next animation
    local spriteNum = math.floor(ui.animation.currentTime * ui.animation.currentDuration % #ui.face.current) + 1
  
    -- Draw rge bullet
    love.graphics.draw(bullet.food[spriteNum], v.x, v.y)
    -- love.graphics.rectangle("fill", v.x, v.y, 50,50)
	end
end

function bullet.update(dt)
	for i,v in ipairs(bullet) do
    --------- BULLET MOVEMENT ---------
		v.x = v.x + (v.dx * dt)
		v.y = v.y + (v.dy * dt)

    --------- MONSTER COLLISION ---------
    for j,k in ipairs(entity.getEntities()) do
      if bullet.collides(v,k) then
        --print("hit")
        entity.decrementAgit(k)
        table.remove(bullet,i) --automatically undraw?
      --elseif(bullet.collides(v,k) and love.keyboard.isDown("r")) then
        --player.freezeStun(k,dt)
        --table.remove(bullet,i)
      end
    end

    -------- WALL/OBJECT COLLISION --------
    doesCollide = collision.BulletCollisionCheck(v.x, v.y, v.height, v.width)
    if doesCollide then
      table.remove(bullet, i)
    end


	end
end

function bullet.collides(one,two) --edited to be simpler, only take account of the object's x/y
  --print("collides")
  return (
        one.x <= two.x + two.width and
        one.x + one.width >= two.x and
        one.y <= two.y + two.height and
        one.y + one.height >= two.y
    )
  end
  

function bullet.fire()
	local startX = player.x --+ player.width / 2
	local startY = player.y --+ player.height / 2

	table.insert(bullet, {x = startX, y = startY, dx = player.bullDir.x * bulletSpeed, dy = player.bullDir.y * bulletSpeed, width = 50, height = 50})
end

return bullet
