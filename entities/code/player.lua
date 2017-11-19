require ("entities.code.bullet")
player = {}


function player.load()
	player.bullDir = {x = 0, y = 0} --store player direction in table
	player.x = 480
	--player.chances = 5 -- basically the amount of times you can feed
	player.y = 416
	player.xvel = 0
	player.yvel = 0
	player.px = 15
	player.py = 14
	player.bloodscreen = love.graphics.newImage("entities/img/DeathThing.png")
	fall = true
	player.health = 100
	player.dir = "right"
	player.motion = {}
	player.motion.stand = love.graphics.newImage("entities/img/Guy.png")
	player.motion.run1 = love.graphics.newImage("entities/img/GuyRunA.png")
	player.motion.run2 = love.graphics.newImage("entities/img/GuyRunB.png")
	player.motion.fall = love.graphics.newImage("entities/img/GuyFall.png")
	player.motion.standL = love.graphics.newImage("entities/img/GuyL.png")
	player.motion.run1L = love.graphics.newImage("entities/img/GuyRunAL.png")
	player.motion.run2L = love.graphics.newImage("entities/img/GuyRunBL.png")
	player.motion.fallL = love.graphics.newImage("entities/img/GuyFallL.png")
	player.currentA = player.motion.stand
	player.Stime = love.timer.getTime()
	player.hit = 0
end

function player.update(dt)
	--update food chances over time
	player.phys(dt)
	player.move()
	player.fire(dt)
	player.xcollide()
	player.ycollide(dt)
	player.dyingAndStuff()
end

function player.draw()
	love.graphics.setColor(25,25,25)
	love.graphics.print("Health: " .. player.health, 50, 50)

	if player.health < 25 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player.bloodscreen, 0, 0)
	end

	love.graphics.setColor(255,255,255)
	if player.xvel ~= 0 and math.floor(player.yvel) == 0 then
		local CTime = love.timer.getTime()
		local count = CTime - math.floor(CTime)
		if count < 0.125 or (count > 0.375 and count < 0.5) or (count > 0.625 and count < 0.75) or (count > 0.875 and count < 1) then
			if player.dir == "right" then
				player.currentA = player.motion.run1
			else
				player.currentA = player.motion.run1L
			end
		else
			if player.dir == "right" then
				player.currentA = player.motion.run2
			else
				player.currentA = player.motion.run2L
			end
		end
	elseif player.yvel ~= 0 then
		if player.dir == "right" then
			player.currentA = player.motion.fall
		else
			player.currentA = player.motion.fallL
		end
	else
		if player.dir == "right" then
			player.currentA = player.motion.stand
		else
			player.currentA = player.motion.standL
		end
	end

	love.graphics.draw(player.currentA, player.x, player.y - 10, 0, 1.25, 1.25)
end

function player.phys(dt)
	player.x = player.x + player.xvel * dt
	player.y = player.y + player.yvel * dt
end

function player.move()
	if love.keyboard.isDown("a") then
		player.bullDir.x = -1 --testing only in x axis for now
		player.xvel = -100
		player.dir = "left"
	elseif love.keyboard.isDown("d") then
		player.bullDir.x = 1 -- waiting on map to be finished to implement y axis
		player.xvel = 100
		player.dir = "right"
	else
		player.xvel = 0
	end
	if love.keyboard.isDown("w") and fall == false then
		player.y = player.y - 10
		player.yvel = -200
		fall = true
	end
end

timer = 0
delay = 0.5 -- delay between bullets
function player.fire(dt)
	timer = timer + dt
    if timer == 0 or timer >= delay then
    	if love.keyboard.isDown("f") then
        	timer = 0
        	bullet.fire()
        end
    end
end

function player.xcollide()
	if player.xvel > 0 then
		player.px = math.ceil((player.x + 20)/32)
	elseif player.xvel < 0 then
		player.px = math.ceil(player.x/32) 
	else
		player.prex = 0
	end

	if TileTable[player.py][player.px] ~= 3 and TileTable[player.py][player.px] ~= 6 then
		player.xvel = 0
	end
end

function player.ycollide(dt)
	player.py = math.ceil(player.y/32)
	if (TileTable[player.py + 1][math.ceil(player.x/32)] == 3 and TileTable[player.py + 1][math.ceil((player.x + 20)/32)] == 3) or (TileTable[player.py + 1][math.ceil(player.x/32)] == 6 and TileTable[player.py + 1][math.ceil((player.x + 20)/32)] == 6) or player.health <= 0 then
		player.yvel = player.yvel + 300 * dt
	else
		if player.yvel > 350 then
			local bf = player.health
			player.health = player.health - ((player.yvel - 350)/2)
			print (bf - player.health)
			player.hit = bf - player.health
		end
		player.yvel = 0
		fall = false
	end
end

function player.dyingAndStuff()
	if player.health <= 0 then
		print("The player has died! Halting execution . . . ")
		player.fall = true
	end
end
