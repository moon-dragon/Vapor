player = {}
animation = {}
wall = {}

local bullet = require ("entities.code.bullet")
local mansion = require ("entities/map/map")
local anim = require ("entities/code/animation/player_anim")
local collision = require ("entities/code/tools/collision")
local isAWall, wallX, wallY, wallWidth, wallHeight = nil, nil, nil, nil, nil
local upgradePoints = 0 --@Patrick don't know the specifics of your implementation but i'll go with this for now

function player.load()
	bullet.load()
	player.bullDir = {x = 0, y = -1} --store player direction in table
	
	-- Load BELLHOP'S animations
	player.idleLeft = anim.IdleLeftAnimation()
	player.idleRight = anim.IdleRightAnimation()
	player.walkingLeft = anim.WalkingLeftAnimation()
	player.walkingRight = anim.WalkingRightAnimation()

	-- Starting position of player
	player.x, player.y = player.getPlayerSpawn()
  
  	-- Player width/height
  	player.width = 100
  	player.height = 400

	-- Current animation of the player
	player.current = player.idleLeft

	-- Keep track of the last direction faced
	player.direction = "left"

	-- The player's speed
	-- player.speed = 8

	-- -- The player's speed (TESTING PURPOSES)
	player.speed = 20

	-- Animation current time
	animation.currentTime = 0

	-- Animation duration
	animation.currentDuration = 0

	-- Walking animation duration
	animation.idleDuration = 3
	
	-- Idle animation duration
	animation.walkingDuration = 9

	-- List of wall objects (used for colllision)
	wall.objects = collision.getWalls()

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
  player.upgradeChances()
  player.upgradeChancesRestored()
  --player.freeze(dt)
  player.restoreChances(dt)
  --player.restoreFreezeAmmo(dt)
	bullet.update(dt)
--[[	player.xcollide()
	player.ycollide(dt)
	player.dyingAndStuff()--]]
end

function player.draw()
	bullet.draw()
	-- -- love.graphics.setColor(25,25,25)
	-- love.graphics.print("Health: " .. player.health, 50, 50)

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

function player.isDamaged()
  if player.health > 0 then
    player.health = player.health - 25
  end
end

function player.move(dt)
	-- Update currentTime of the animation
	animation.currentTime = animation.currentTime + dt

	----- PLAYER MOVEMENT -----

	-- RIGHT direction
	if love.keyboard.isDown('d') then 				
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(player.x + player.speed, player.y, player.current[1], wall.objects)
		if not isAWall then
			player.x = player.x + player.speed
		else
			player.x =  wallX - player.current[1]:getWidth()
		end

		-- Plays the WALKING RIGHT animation
		player.current = player.walkingRight
		player.direction = "right"

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.walkingDuration


		player.bullDir.x = 1 
		player.bullDir.y = 0
	-- LEFT direction
	elseif love.keyboard.isDown('a') then 			
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(player.x - player.speed, player.y, player.current[1], wall.objects)
		if not isAWall then
			player.x = player.x - player.speed
		else
			player.x =  wallX + wallWidth
		end


		-- Plays the WALKING LEFT animation
		player.current = player.walkingLeft
		player.direction = "left"

		-- Change the duration of each sprite in the walking animation
		animation.currentDuration = animation.walkingDuration

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

		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(player.x, player.y - player.speed, player.current[1], wall.objects)
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
		animation.currentDuration = animation.walkingDuration

		player.bullDir.y = -1
		player.bullDir.x = 0

	-- DOWN movement
	elseif love.keyboard.isDown('s') then
		
		isAWall, wallX, wallY, wallWidth, wallHeight = collision.CollisionCheck(player.x, player.y + player.speed, player.current[1], wall.objects)
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
		animation.currentDuration = animation.walkingDuration

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
delay = 0.3 --freezing gun will have 0 delay, but 100 "chances" that decrease each .5 second you hold the fire button,
local chances = 5
local chancesRestored = 1 --the chances restored over time
local maxChances = 5
--local freezeAmmo = 100
local chanceTimer = 5
--local freezeTimer  = 5
--local stunTimer = 2

function player.restoreChances(dt)
  chanceTimer = chanceTimer - dt
  if chanceTimer <= 0 then
    if chances < maxChances then
      chances = chances + chancesRestored
      if chances > maxChances then --if I'm at 4 chances and add 2 to give me 6 total chances when my max is 5
        chances = maxChances -- set it to the allowed max
      end
    end
    chanceTimer = chanceTimer + 2 --every 2 seconds a chance is restored
  end
end

function player.fire(dt) --dt
	timer = timer + dt
    if (timer == 0 or timer >= delay) and love.keyboard.isDown("f") then --(timer == 0 or timer >= delay) and love.keyboard.isDown("f")
      timer = 0
        if chances > 0 then
        chances = chances - 1
        --print(chances)
        bullet.fire()
      end
    end
end

function player.incChancesRestored()
  chancesRestored = chancesRestored + 1
end

function player.incMaxChances()
  maxChances = maxChances + 1
end

function player.decUpgradePts()
  upgradePoints = upgradePoints - 1
end

function player.incUpgradePts()
  upgradePoints = upgradePoints + 1
end

function player.getUpgradePts()
  return upgradePoints
end

function player.getChances()
  return chances
end

function player.getMaxChances()
  return maxChances
end

function player.upgradeChances()
  if upgradePoints > 0 then
    if love.keyboard.isDown("u") then
      player.incMaxChances()
      --print(maxChances)
      --print("upgraded")
      player.decUpgradePts()
      --print(upgradePoints)
    end
  end
end

function player.upgradeChancesRestored()
  if upgradePoints > 0 then
    if love.keyboard.isDown("o") then
      player.incChancesRestored()
      player.decUpgradePts()
    end
  end
end

      
--[[
function player.freeze(dt)
  timer = timer + dt
    if freezeAmmo > 0 and love.keyboard.isDown("r") then --(timer == 0 or timer >= delay) and love.keyboard.isDown("f")
      timer = 0
      freezeAmmo = freezeAmmo - 1
      --print(freezeAmmo)
      bullet.fire()
    end
end
]]

--[[
function player.freezeStun(entity,dt) -- this method could also be thought of as a temporary setter for entity's speed
  stunTimer = stunTimer - dt
  print(entity.speed)
  tempSpeed = 0
  tempSpeed = entity.speed
  entity.speed = 0

  if stunTimer <= 0 then
    end
    entity.speed = tempSpeed
    print(entity.speed)
    --return entity.speed

  --print(entity.speed)
end


function player.restoreFreezeAmmo(dt)
  freezeTimer = freezeTimer - dt
  if freezeTimer <= 0 then
    if freezeAmmo < 100 then
      freezeAmmo = freezeAmmo + 20
      if freezeAmmo > 100 then
        freezeAmmo = 100
      end
      --print(freezeAmmo)
    end
    freezeTimer = freezeTimer + 2 --every 2 seconds a chance is restored
  end
end
]]

function player.getPlayerSpawn()
	for i = 1, #mansion.layers do
		if mansion.layers[i].name == "player" then
			return mansion.layers[i].objects[1].x, mansion.layers[i].objects[1].y
		end
	end
end

function player.getHealth()
	return player.health
end

function player.getPosition()
	return player.x, player.y
end

return player

