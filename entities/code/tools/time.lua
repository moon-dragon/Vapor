time = {}

local cycleMusic = love.audio.newSource("entities/music/cycle_sound.wav")

function time.load()
	-- Seconds that needs to passed before cycle resets
	time.cycleLength = 10

	time.counter1 = 0
	time.counter2 = 0
	time.conversion = 0
	time.cycleCounter = 0
end

function time.update(dt)
	-- Updates the time
	time.counter1 = time.counter1 + 1
	if convert(time.counter1, 100) >= 100 then
		time.counter2 = time.counter2 + 1
	end

	-- Updates the cycle count
	if convert(time.counter2, time.cycleLength) >= time.cycleLength then
		-- Play once it reached a new cycle
		love.audio.play(cycleMusic)
		time.cycleCounter = time.cycleCounter + 1
		time.counter2 = 0
	end
end

-- Return the current time of the currentcycle
function time.getTimeCounter()
	return time.counter2
end

-- Return which cycle the player is in
function time.getCycleCounter()
	return time.cycleCounter
end

-- Return the length of time that needs to pass before cycle resets
function time.getCycleLength()
	return time.cycleLength
end

-- Converts the time
function convert(current, max)
	return current % (max + 1)
end

return time