local collision = {}

-- Check if the two object specified is overlapping
-- Format:
-- 		x1, y1: 1st object coordinates
-- 		w1, h1: (w)idth and (h)eight of the 1st object
-- 		x2, y2: 2nd object coordinates
-- 		w2, h2: (w)idth and (h)eight of the 2nd object
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
	     x2 < x1+w1 and
	     y1 < y2+h2 and 
	     y2 < y1+h1
end

-- Check if player is colliding with an object:
--  	Returns true and objects coordination and dimnesions if there's collision on the next player movement
--  	Returns false if there's no collision on the next player movement
function collision.CollisionCheck(playerPosX, playerPosY, playerObject, wallObjects)
	local width, height = playerObject:getWidth(), playerObject:getHeight()
	for i = 1, #wallObjects do
		if CheckCollision(playerPosX, playerPosY, width, height, wallObjects[i].x, wallObjects[i].y, wallObjects[i].width, wallObjects[i].height) then
			return true, wallObjects[i].x, wallObjects[i].y, wallObjects[i].width, wallObjects[i].height
		end
	end
	return false
end

return collision