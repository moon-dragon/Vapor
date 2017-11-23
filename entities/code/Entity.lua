--this script will just define the functions to be used for entities

entity = {}
--ents is a count of how many entities have been spawned
ents = 0

function entity.spawn(table, x, y, img)
	local newent = table
	newent.x = x
	newent.y = y
	newent.xvel = 0
	newent.yvel = 0
	newent.ID = ents
	print ("ID of entity just spawned just now is " .. newent.ID)
	ents = ents + 1
	return newent
end

--in order for an entity to update, they must pass entity.update to love.update themselves
function entity.update(table, dt)
	
end

--This can be used to easily draw the entities
function entity.draw(table)
	if table ~= nil then
		if table.img ~= nil then 
			love.graphics.draw(table.img, table.x, table.y)
		else
			love.graphics.setColor(255,0,255)
			love.graphics.rectangle("fill",table.x, table.y, table.width, table.height)
		end
	end
end

--Because I am nice, I will allow players to check if their ent is being clicked with one simple function
function entity.checkForMouseDown(table)
	if table ~= nil then
		if love.mouse.getX() > table.x and love.mouse.getX() < table.x + table.width and love.mouse.getY() > table.y and love.mouse.getY() < table.y + table.height and love.mouse.isDown("l") == true then
			return true
		else
			return false
		end
	end
end
