local ghost = {}
local image = love.graphics.newImage

function ghost.IdleLeftAnimation()
	local idleLeft =
	{
		image('entities/img/ghost/idleLeft1.png'),
		image('entities/img/ghost/idleLeft2.png'),
		image('entities/img/ghost/idleLeft3.png'),
		image('entities/img/ghost/idleLeft4.png'),
		image('entities/img/ghost/idleLeft5.png'),
		image('entities/img/ghost/idleLeft6.png')
	}
	return idleLeft
end

function ghost.IdleRightAnimation()
	local idleRight =
	{
		image('entities/img/ghost/idleRight1.png'),
		image('entities/img/ghost/idleRight2.png'),
		image('entities/img/ghost/idleRight3.png'),
		image('entities/img/ghost/idleRight4.png'),
		image('entities/img/ghost/idleRight5.png'),
		image('entities/img/ghost/idleRight6.png')
	}
	return idleRight
end

function ghost.WalkingLeftAnimation()
	local walkingLeft =
	{
		image('entities/img/ghost/walkingLeft1.png'),
		image('entities/img/ghost/walkingLeft2.png'),
		image('entities/img/ghost/walkingLeft3.png'),
		image('entities/img/ghost/walkingLeft4.png'),
		image('entities/img/ghost/walkingLeft5.png'),
		image('entities/img/ghost/walkingLeft6.png'),
		image('entities/img/ghost/walkingLeft7.png'),
		image('entities/img/ghost/walkingLeft8.png'),
		image('entities/img/ghost/walkingLeft9.png'),
		image('entities/img/ghost/walkingLeft10.png'),
		image('entities/img/ghost/walkingLeft11.png')
	}
	return walkingLeft
end

function ghost.WalkingRightAnimation()
	local walkingRight = 
	{
		image('entities/img/ghost/walkingRight1.png'),
		image('entities/img/ghost/walkingRight2.png'),
		image('entities/img/ghost/walkingRight3.png'),
		image('entities/img/ghost/walkingRight4.png'),
		image('entities/img/ghost/walkingRight5.png'),
		image('entities/img/ghost/walkingRight6.png'),
		image('entities/img/ghost/walkingRight7.png'),
		image('entities/img/ghost/walkingRight8.png'),
		image('entities/img/ghost/walkingRight9.png'),
		image('entities/img/ghost/walkingRight10.png'),
		image('entities/img/ghost/walkingRight11.png')
	}
	return walkingRight
end

return ghost