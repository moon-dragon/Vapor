local player = {}
local image = love.graphics.newImage

function player.IdleLeftAnimation()
	local idleLeft =
	{
		image('entities/img/bellhop/idleLeft1.png'),
		image('entities/img/bellhop/idleLeft2.png'),
		image('entities/img/bellhop/idleLeft3.png')
	}
	return idleLeft
end

function player.IdleRightAnimation()
	local idleRight = 
	{
		image('entities/img/bellhop/idleRight1.png'),
		image('entities/img/bellhop/idleRight2.png'),
		image('entities/img/bellhop/idleRight3.png')
	}
	return idleRight
end

function player.WalkingLeftAnimation()
	local walkingLeft =
	{
		image('entities/img/bellhop/walkingLeft1.png'),
		image('entities/img/bellhop/walkingLeft2.png'),
		image('entities/img/bellhop/walkingLeft3.png'),
		image('entities/img/bellhop/walkingLeft4.png'),
		image('entities/img/bellhop/walkingLeft5.png'),
		image('entities/img/bellhop/walkingLeft6.png'),
		image('entities/img/bellhop/walkingLeft7.png')
	}
	return walkingLeft
end

function player.WalkingRightAnimation()
	local walkingRight =
	{
		image('entities/img/bellhop/walkingRight1.png'),
		image('entities/img/bellhop/walkingRight2.png'),
		image('entities/img/bellhop/walkingRight3.png'),
		image('entities/img/bellhop/walkingRight4.png'),
		image('entities/img/bellhop/walkingRight5.png'),
		image('entities/img/bellhop/walkingRight6.png'),
		image('entities/img/bellhop/walkingRight7.png')
	}
	return walkingRight
end

return player