--this script will just define the functions to be used for entities

entity = {}
entities = {} --all entities that currently exist in the map
--ents is a count of how many entities have been spawned
ents = 0

function entity.spawn(table, x, y, width, height)
	local newent = table
	newent.x = x
	newent.y = y
	newent.xvel = 0
	newent.yvel = 0
  newent.width = width
  newent.height = height
	newent.ID = ents
  newent.agitation = 3
  --print ("agitation of frankenstein is " ..newent.agitation)
	print ("ID of entity just spawned just now is " .. newent.ID)
	ents = ents + 1
	return newent
end

function entity.incrementAgit(table)
  if(table.agitation <= 4) then
    table.agitation = table.agitation + 1
  end
end


function entity.decrementAgit(table)
  if(table.agitation > 0) then
    table.agitation = table.agitation - 1
    --print ("agitation of frankenstein is " ..table.agitation)
  end
end


function entity.getEntities()
  return entities
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
