--https://love2d.org/wiki/Tutorial:Fire_Toward_Mouse for the overall bullet implementation
--https://love2d.org/forums/viewtopic.php?t=47565 to make the bullets fire based on player direction and not mouse direction
bullet = {}
bulletSpeed = 0

function bullet.load()
	bulletSpeed = 1500
end
  
function bullet.draw()
	for i,v in ipairs(bullet) do
		love.graphics.rectangle("fill", v.x, v.y, 50,50)
	end
end

function bullet.update(dt)
	for i,v in ipairs(bullet) do
		v.x = v.x + (v.dx * dt)
		v.y = v.y + (v.dy * dt)
    for j,k in ipairs(entity.getEntities()) do --how is it iterating through entities? how does it know where it is or what im talking about
      --print("2nd for")
      --print(k.x , k.y) --prints 256,256 so frankenstein is inserting itself to entities table properly, and
      --the loop is iterating through the proper values of franken's x and y
      if(bullet.collides(v,k)) then
        print("hit")
        entity.decrementAgit(k)
        table.remove(bullet,i) --automatically undraw?
      end
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