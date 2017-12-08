--first we must require the entity library 
require("entities.code.Entity")
--[[
now we will define our entity as a table
our entity definition will be a table telling us everything we need to know about this entity
such as it's image
--]]




testent = {}

function testent.load()
	testent.phys = true --whether the entity can fall or not
	testent.img = love.graphics.newImage("entities/img/frankenstein_idle6.png")--the image that entity will display
	testent.width = 16 --used for horizontal collision (coming soon)
	testent.height = 16 --used for vertical collision
	--Lets put the entity in the game on the entity's load function
	--franken = entity.spawn(testent, 128, 128)
	franken = entity.spawn(testent, 1000, 1000)

    -- need somekind of a variable like speed to make the monster move
    franken.speed = 10
end


--pl means the player. idk which one is an init function (assumed .load() functions are the init function)

function testent.update(pl, dt)
    
	entity.update(franken, dt)
    --[[
    -- this is all done once the monsters reach max agitation
    -- this part makes the monster point toward player
    testent.angle = math.getAngle(pl.x, pl.y, testent.z, testent.y)
    testent.walked = 0
    testent.nsteps = 1

    -- this part is for the direction towards the player
    testent.dirx = pl.x - testent.x
    testent.diry = pl.y - testent.y
    testent.dirx, testent.diry, _ = math.normalize(testent.dirx, testent.diry)

    -- this part updates the angle

    testent.angle = math.getAngle(pl.x, pl.y, testent.x, testent.y)


        testent.walked = testent.walked + (testent.speed * dt)


    -- this part is to make the monsters pause after certain steps

    if testent.walked > 30 then
        testent.walked = 0
        if testent.nsteps < 4 then
            testent.nsteps = testent.nsteps +1

        else
            testent.nsteps = 0
        end
    end

    --]]






	--[[
    if entity.checkForMouseDown(franken) == true then
		franken = nil
		print("It's gone!")
	end
    ]]--
end

function testent.draw()
	entity.draw(franken)
end






