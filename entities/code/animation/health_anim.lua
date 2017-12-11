local health = {}
local image = love.graphics.newImage

function health.Full()
	local full = 
	{
		image('entities/img/bellhop_health/full1.png'),
		image('entities/img/bellhop_health/full2.png'),
		image('entities/img/bellhop_health/full3.png'),
		image('entities/img/bellhop_health/full4.png'),
		image('entities/img/bellhop_health/full5.png'),
		image('entities/img/bellhop_health/full6.png'),
		image('entities/img/bellhop_health/full7.png')
	}
	return full
end

function health.Nines()
	local nines =
	{
		image('entities/img/bellhop_health/90s1.png'),
		image('entities/img/bellhop_health/90s2.png'),
		image('entities/img/bellhop_health/90s3.png'),
		image('entities/img/bellhop_health/90s4.png'),
		image('entities/img/bellhop_health/90s5.png'),
		image('entities/img/bellhop_health/90s6.png'),
		image('entities/img/bellhop_health/90s7.png')
	}
	return nines
end

function health.Eights()
	local eights = 
	{
		image('entities/img/bellhop_health/80s1.png'),
		image('entities/img/bellhop_health/80s2.png'),
		image('entities/img/bellhop_health/80s3.png'),
		image('entities/img/bellhop_health/80s4.png'),
		image('entities/img/bellhop_health/80s5.png'),
		image('entities/img/bellhop_health/80s6.png'),
		image('entities/img/bellhop_health/80s7.png')
	}
	return eights
end

function health.Sevens()
	local sevens = 
	{
		image('entities/img/bellhop_health/70s1.png'),
		image('entities/img/bellhop_health/70s2.png'),
		image('entities/img/bellhop_health/70s3.png'),
		image('entities/img/bellhop_health/70s4.png'),
		image('entities/img/bellhop_health/70s5.png'),
		image('entities/img/bellhop_health/70s6.png'),
		image('entities/img/bellhop_health/70s7.png')
	}
	return sevens
end

function health.Sixs()
	local sixs = 
	{
		image('entities/img/bellhop_health/60s1.png'),
		image('entities/img/bellhop_health/60s2.png'),
		image('entities/img/bellhop_health/60s3.png'),
		image('entities/img/bellhop_health/60s4.png'),
		image('entities/img/bellhop_health/60s5.png'),
		image('entities/img/bellhop_health/60s6.png'),
		image('entities/img/bellhop_health/60s7.png')
	}
	return sixs
end

function health.Fives()
	local fives = 
	{
		image('entities/img/bellhop_health/50s1.png'),
		image('entities/img/bellhop_health/50s2.png'),
		image('entities/img/bellhop_health/50s3.png'),
		image('entities/img/bellhop_health/50s4.png'),
		image('entities/img/bellhop_health/50s5.png'),
		image('entities/img/bellhop_health/50s6.png'),
		image('entities/img/bellhop_health/50s7.png')
	}
	return fives
end

function health.Fours()
	local fours = 
	{
		image('entities/img/bellhop_health/40s1.png'),
		image('entities/img/bellhop_health/40s2.png'),
		image('entities/img/bellhop_health/40s3.png'),
		image('entities/img/bellhop_health/40s4.png'),
		image('entities/img/bellhop_health/40s5.png'),
		image('entities/img/bellhop_health/40s6.png'),
		image('entities/img/bellhop_health/40s7.png')
	}
	return fours
end

function health.Threes()
	local threes = 
	{
		image('entities/img/bellhop_health/30s1.png'),
		image('entities/img/bellhop_health/30s2.png'),
		image('entities/img/bellhop_health/30s3.png'),
		image('entities/img/bellhop_health/30s4.png'),
		image('entities/img/bellhop_health/30s5.png'),
		image('entities/img/bellhop_health/30s6.png'),
		image('entities/img/bellhop_health/30s7.png')
	}
	return threes
end

function health.Twos()
	local twos = 
	{
		image('entities/img/bellhop_health/20s1.png'),
		image('entities/img/bellhop_health/20s2.png'),
		image('entities/img/bellhop_health/20s3.png'),
		image('entities/img/bellhop_health/20s4.png'),
		image('entities/img/bellhop_health/20s5.png'),
		image('entities/img/bellhop_health/20s6.png'),
		image('entities/img/bellhop_health/20s7.png')
	}
	return twos
end

function health.Ones()
	local ones = 
	{
		image('entities/img/bellhop_health/10s1.png'),
		image('entities/img/bellhop_health/10s2.png'),
		image('entities/img/bellhop_health/10s3.png'),
		image('entities/img/bellhop_health/10s4.png'),
		image('entities/img/bellhop_health/10s5.png'),
		image('entities/img/bellhop_health/10s6.png'),
		image('entities/img/bellhop_health/10s7.png')
	}
	return ones
end

return health