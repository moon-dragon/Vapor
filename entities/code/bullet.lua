--https://love2d.org/wiki/Tutorial:Fire_Toward_Mouse for the overall bullet implementation
--https://love2d.org/forums/viewtopic.php?t=47565 to make the bullets fire based on player direction and not mouse direction
bullet = {}
bulletSpeed = 0

function bullet.load()
	bulletSpeed = 200
end
  
function bullet.draw()
	for i,v in ipairs(bullet) do
		love.graphics.circle("fill", v.x, v.y, 60)
	end
end

function bullet.update(dt)
	for i,v in ipairs(bullet) do
		v.x = v.x + (v.dx * dt)
		v.y = v.y + (v.dy * dt)
    for j,k in ipairs(entities) do
      print("2nd for")
      if(bullet.collides(v,k)) then
        print("hit")
      end
    end
	end
end

function bullet.collides(one,two)
  print("collides")
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

	table.insert(bullet, {x = startX, y = startY, dx = player.bullDir.x * bulletSpeed, dy = player.bullDir.y * bulletSpeed})
end