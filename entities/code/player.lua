require ("entities.code.bullet")
player = {}
animation = {}
wall = {}

local mansion = require ("entities/map/map")
local image = love.graphics.newImage
local isAWall, wallX, wallY, wallWidth, wallHeight = nil, nil, nil, nil, nil

function player.load()
	bullet.load()
	player.bullDir = {x = 0, y = 0} --store player direction in table
	
	-- Load BELLHOP'S animations
	player.idleLeft = IdleLeftAnimation()
	player.idleRight = IdleRightAnimation()
	player.walkingLeft = WalkingLeftAnimation()
	player.walkingRight = WalkingRightAnimation()

	-- Starting position of player
	player.x = mansion.layers[4].objects[1].x
	player.y = mansion.layers[4].objects[1].y

	-- Current animation of the player
	player.current = player.idleLeft

	-- Keep track of the last direction faced
	player.direction = "left"

	-- The player's speed (TEMPORARY)
	player.speed = 15

	-- Animation current time
	animation.currentTime = 0

	-- Animation duration
	animation.currentDuration = 0

	-- Walking animation duration
	animation.idleDuration = 1
	
	-- Idle animation duration
	animation.wakingDuration = 6

	-- List of wall objects (used for colllision)
	wall.objects = mansion.layers[3].objects

	-- player.x = 480
	-- player.y = 416
	--player.chances = 5 -- basically the amount of times you can feed
	player.xvel = 0
	player.yvel = 0
	player.px = 15
	player.py = 14
	player.bloodscreen = love.graphics.newImage("entities/img/DeathThing.png")
	fall = true
	player.health = 100
	player.dir = "right"
	-- player.motion = {}
	-- player.motion.stand = love.graphics.newImage("entities/img/bellhop/idleRight1.png")
	-- player.motion.run1 = love.graphics.newImage("entities/img/bellhop/walkingRight3.png")
	-- player.motion.run2 = love.graphics.newImage("entities/img/bellhop/walkingRight4.png")
	-- player.motion.fall = love.graphics.newImage("entities/img/bellhop/idleRight1.png") --have to use idleRight since we don't have a walking up or down PNG
	-- player.motion.standL = love.graphics.newImage("entities/img/bellhop/idleLeft1.png")
	-- player.motion.run1L = love.graphics.newImage("entities/img/bellhop/walkingLeft3.png")
	-- player.motion.run2L = love.graphics.newImage("entities/img/bellhop/walkingLeft4.png")
	-- player.motion.fallL = love.graphics.newImage("entities/img/bellhop/idleLeft1.png")
	-- player.currentA = player.motion.stand
	player.Stime = love.timer.getTime()
	player.hit = 0
end

function player.update(dt)
	--update food chances over time
	-- player.phys(dt)
	player.move(dt)
	player.fire(dt)
	bullet.update(dt)
--[[	player.xcollide()
	player.ycollide(dt)
	player.dyingAndStuff()--]]
end

function player.draw()
	bullet.draw()
	-- love.graphics.setColor(25,25,25)
	love.graphics.print("Health: " .. player.health, 50, 50)

	if player.health < 25 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player.bloodscreen, 0, 0)
	end

	-- Determines the index of the next animation
	local spriteNum = math.floor(animation.currentTime * animation.currentDuration % #player.current) + 1
	
	-- Draws the player
	love.graphics.draw(player.current[spriteNum], player.x, player.y)

	-- love.graphics.setColor(255,255,255)
	-- if player.xvel ~= 0 and math.floor(player.yvel) == 0 then
	-- 	local CTime = love.timer.getTime()
	-- 	local count = CTime - math.floor(CTime)
	-- 	if count < 0.125 or (count > 0.375 and count < 0.5) or (count > 0.625 and count < 0.75) or (count > 0.875 and count < 1) then
	-- 		if player.dir == "right" then
	-- 			player.currentA = player.motion.run1
	-- 		else
	-- 			player.currentA = player.motion.run1L
	-- 		end
	-- 	else
	-- 		if player.dir == "right" then
	-- 			player.currentA = player.motion.run2
	-- 		else
	-- 			player.currentA = player.motion.run2L
	-- 		end
	-- 	end
	-- elseif player.yvel ~= 0 then
	-- 	if player.dir == "right" then
	-- 		player.currentA = player.motion.fall
	-- 	else
	-- 		player.currentA = player.motion.fallL
	-- 	end
	-- else
	-- 	if player.dir == "right" then
	-- 		player.currentA = player.motion.stand
	-- 	else
	-- 		player.currentA = player.motion.standL
	-- 	end
	-- end

	-- love.graphics.draw(player.currentA, player.x, player.y - 10, 0, 1.25, 1.25)
end

-- function player.phys(dt)
-- 	player.x = player.x + player.xvel * dt
-- 	player.y = player.y + player.yvel * dt
-- end

function player.move(dt)
	-- Update currentTime of the animation
	animation.currentTime = animation.currentTime + dt

	----- PLAYER MOVEMENT -----

	-- RIGHT direction
	if love.keyboard.isDown('d') then 				
		
		isAWall, wallX, wallY, wallWidth, wallHeight = CollisionCheck(player.x + player.speed, player.y, player.current[1], wall.objects)
		if not isAWall then
			player.x = player.x + player.speed
		else
			player.x =  wallX - player.current[1]:getWidth()
		end

		-- Plays the WALKING RIGHT animation
		player.current = player.walkingRight
		player.direction = "right"

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.wakingDuration


		player.bullDir.x = 1 
		player.bullDir.y = 0
	-- LEFT direction
	elseif love.keyboard.isDown('a') then 			
		
		isAWall, wallX, wallY, wallWidth, wallHeight = CollisionCheck(player.x - player.speed, player.y, player.current[1], wall.objects)
		if not isAWall then
			player.x = player.x - player.speed
		else
			player.x =  wallX + wallWidth
		end


		-- Plays the WALKING LEFT animation
		player.current = player.walkingLeft
		player.direction = "left"

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.wakingDuration

		player.bullDir.x = -1
		player.bullDir.y = 0
	else
		-- Determine which idle animation to execute depending on the last direction faced
		if player.direction == "left" then
			player.current = player.idleLeft

			-- Change the duration of each sprite in the idle animation
			animation.currentDuration = animation.idleDuration
		elseif player.direction == "right" then
			player.current = player.idleRight

			-- Change the duration of each sprite in the idle animation
			animation.currentDuration = animation.idleDuration
		end 
	end

	-- UP movement
	if love.keyboard.isDown('w') then

		isAWall, wallX, wallY, wallWidth, wallHeight = CollisionCheck(player.x, player.y - player.speed, player.current[1], wall.objects)
		if not isAWall then
			player.y = player.y - player.speed
		else
			player.y =  wallY + wallHeight
		end

		-- Determine which walking animation to play
		if player.direction == "left" then
			-- Plays the WALKING LEFT animation
			player.current = player.walkingLeft
			
		elseif player.direction == "right" then
			-- Plays the WALKING RIGHT animation
			player.current = player.walkingRight
		end

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.wakingDuration

		player.bullDir.y = -1
		player.bullDir.x = 0

	-- DOWN movement
	elseif love.keyboard.isDown('s') then
		
		isAWall, wallX, wallY, wallWidth, wallHeight = CollisionCheck(player.x, player.y + player.speed, player.current[1], wall.objects)
		if not isAWall then
			player.y = player.y + (player.speed)
		else
			player.y = wallY - player.current[1]:getHeight()
		end

		-- Determine which walking animation to play
		if player.direction == "left" then
			-- Plays the WALKING LEFT animation
			player.current = player.walkingLeft
			
		elseif player.direction == "right" then
			-- Plays the WALKING RIGHT animation
			player.current = player.walkingRight
		end

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.wakingDuration

		player.bullDir.y = 1
		player.bullDir.x = 0
	end

	---------------------------

-- I TOOK PLAYER.BULLDIR.X and PLAYER.BULLDIR.Y and put it above


	-- if love.keyboard.isDown("a") then
	-- 	player.bullDir.x = -1
	-- 	player.bullDir.y = 0
	-- 	player.xvel = -1000
	-- 	player.dir = "left"
	-- elseif love.keyboard.isDown("d") then
	-- 	player.bullDir.x = 1 
	-- 	player.bullDir.y = 0
	-- 	player.xvel = 1000
	-- 	player.dir = "right"
	-- else
	-- 	player.xvel = 0
	-- end
	
	-- if love.keyboard.isDown("w") then
	-- 	player.bullDir.y = -1
	-- 	player.bullDir.x = 0
	-- 	player.yvel = -1000
	-- 	player.dir = "up"
	-- elseif love.keyboard.isDown("s") then
	-- 	player.bullDir.y = 1
	-- 	player.bullDir.x = 0
	-- 	player.yvel = 1000
	-- 	player.dir = "down"
	-- else
	-- 	player.yvel = 0
	-- end

	-- diagonal bullet direction
	if love.keyboard.isDown("a") and love.keyboard.isDown("w") then
		player.bullDir.x = -1
		player.bullDir.y = -1
	end
	if love.keyboard.isDown("d") and love.keyboard.isDown("w") then
		player.bullDir.x = 1 
		player.bullDir.y = -1
	end
	if love.keyboard.isDown("a") and love.keyboard.isDown("s") then
		player.bullDir.x = -1
		player.bullDir.y = 1
	end
	if love.keyboard.isDown("d") and love.keyboard.isDown("s") then
		player.bullDir.x = 1 
		player.bullDir.y = 1
	end
end


-- delay between bullets
timer = 0
delay = 0.3
function player.fire(dt)
	timer = timer + dt
    if (timer == 0 or timer >= delay) and love.keyboard.isDown("f") then
    	timer = 0
    	bullet.fire()
    end
end

------ HELPER FUNCTION  ------

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
function CollisionCheck(playerPosX, playerPosY, playerObject, wallObjects)
	local width, height = playerObject:getWidth(), playerObject:getHeight()
	for i = 1, #wallObjects do
		if CheckCollision(playerPosX, playerPosY, width, height, wallObjects[i].x, wallObjects[i].y, wallObjects[i].width, wallObjects[i].height) then
			return true, wallObjects[i].x, wallObjects[i].y, wallObjects[i].width, wallObjects[i].height
		end
	end
	return false
end

---- LOAD ALL ANIMATIONS  ----
function IdleLeftAnimation()
	local idleLeft =
	{
		image('entities/img/bellhop/idleLeft1.png'),
		image('entities/img/bellhop/idleLeft2.png'),
		image('entities/img/bellhop/idleLeft3.png')
	}
	return idleLeft
end

function IdleRightAnimation()
	local idleRight = 
	{
		image('entities/img/bellhop/idleRight1.png'),
		image('entities/img/bellhop/idleRight2.png'),
		image('entities/img/bellhop/idleRight3.png')
	}
	return idleRight
end

function WalkingLeftAnimation()
	local walkingLeft =
	{
		image('entities/img/bellhop/walkingLeft1.png'),
		image('entities/img/bellhop/walkingLeft2.png'),
		image('entities/img/bellhop/walkingLeft3.png'),
		image('entities/img/bellhop/walkingLeft4.png'),
		image('entities/img/bellhop/walkingLeft5.png'),
		image('entities/img/bellhop/walkingLeft6.png'),
		image('entities/img/bellhop/walkingLeft7.png'),
		image('entities/img/bellhop/walkingLeft8.png'),
		image('entities/img/bellhop/walkingLeft9.png'),
		image('entities/img/bellhop/walkingLeft10.png')
	}
	return walkingLeft
end

function WalkingRightAnimation()
	local walkingRight =
	{
		image('entities/img/bellhop/walkingRight1.png'),
		image('entities/img/bellhop/walkingRight2.png'),
		image('entities/img/bellhop/walkingRight3.png'),
		image('entities/img/bellhop/walkingRight4.png'),
		image('entities/img/bellhop/walkingRight5.png'),
		image('entities/img/bellhop/walkingRight6.png'),
		image('entities/img/bellhop/walkingRight7.png'),
		image('entities/img/bellhop/walkingRight8.png'),
		image('entities/img/bellhop/walkingRight9.png'),
		image('entities/img/bellhop/walkingRight10.png')
	}
	return walkingRight
end





--[[function player.xcollide()
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
end--]]
