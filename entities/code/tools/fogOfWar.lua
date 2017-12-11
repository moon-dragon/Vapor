fog = {}

local time = require ("entities.code.tools.time")
local counter = 0

function fog.load()
	-- Starting size of the fog
	fog.fogRadius = 120

	-- Check if the fog of war is active
	fog.isFogOfWarActive = true

	-- Check if light is on
	fog.isLightOn = false

	fog.timer = 5

end

function fog.update(dt)
	-- Activate fog of war mechanic every 4 cycle
	fog.isFogOfWarActive = checkFog(4)
	if fog.isLightOn then
		counter = counter + 1
		if counter % 101 >= 100 and fog.timer ~= 0 then
			fog.timer = fog.timer - 1
		end
	end

	if fog.timer == 0 then
		fog.isLightOn = false
		fog.toggleLight(fog.isLightOn)
	end
	restoreChances(dt)
end

-- Limits the view of the player
function fog.drawFogOfWar(x, y, radius)
	local function stencil()
		-- Draw the visible circle
		love.graphics.circle("fill", x + 90, y + 97, radius, 16)
	end

	love.graphics.setColor(0, 0, 0, 0)

	-- Draw the visible circle
	stencil()
	--Set the stencil
	love.graphics.stencil(stencil)
	--Set the stenciltest
	love.graphics.setStencilTest("greater", 0)
	love.graphics.setColor(255, 255, 255, 255)
end

local chanceTimer = 5
function restoreChances(dt)
	chanceTimer = chanceTimer - dt
  	if chanceTimer <= 0 then
    	if fog.timer < 5 and fog.isLightOn == false then
      		fog.timer = fog.timer + 1
    	end
    	chanceTimer = chanceTimer + 2 --every 2 seconds a chance is restored
  end
end

function fog.toggleLight(bool)
	if bool and fog.timer > 0 then
		fog.fogRadius = 300
	else
		fog.fogRadius = 120
	end
end


--------------- SETTERS AND  GETTERS -------------------
function fog.setIsLightOn(bool)
	fog.isLightOn = bool
end

function fog.getIsLightOn()
	return fog.isLightOn
end

function fog.getFogRadius()
	return fog.fogRadius
end

function fog.getIsFogOfWarActive()
	return fog.isFogOfWarActive
end

function fog.getTimer()
	return fog.timer
end


--------------- HELPER FUNCTION -------------------
function checkFog(cycle)
	return (time.getCycleCounter() % cycle == 0 and time.getCycleCounter() ~= 0) and true or false
end

return fog