 local witch = {}
local image = love.graphics.newImage

function witch.IdleLeftAnimation()
	local idleLeft =
	{
		image('entities/img/witch/idleLeft1.png'),
		image('entities/img/witch/idleLeft2.png'),
		image('entities/img/witch/idleLeft3.png'),
		image('entities/img/witch/idleLeft4.png'),
		image('entities/img/witch/idleLeft5.png'),
		image('entities/img/witch/idleLeft6.png'),
		image('entities/img/witch/idleLeft7.png'),
		image('entities/img/witch/idleLeft8.png'),
		image('entities/img/witch/idleLeft9.png'),
		image('entities/img/witch/idleLeft10.png'),
		image('entities/img/witch/idleLeft11.png'),
		image('entities/img/witch/idleLeft12.png'),
		image('entities/img/witch/idleLeft13.png'),
		image('entities/img/witch/idleLeft14.png'),
		image('entities/img/witch/idleLeft15.png'),
		image('entities/img/witch/idleLeft16.png'),
		image('entities/img/witch/idleLeft17.png'),
		image('entities/img/witch/idleLeft18.png'),
		image('entities/img/witch/idleLeft19.png')
	}
	return idleLeft
end

function witch.IdleRightAnimation()
	local idleRight =
	{
		image('entities/img/witch/idleRight1.png'),
		image('entities/img/witch/idleRight2.png'),
		image('entities/img/witch/idleRight3.png'),
		image('entities/img/witch/idleRight4.png'),
		image('entities/img/witch/idleRight5.png'),
		image('entities/img/witch/idleRight6.png'),
		image('entities/img/witch/idleRight7.png'),
		image('entities/img/witch/idleRight8.png'),
		image('entities/img/witch/idleRight9.png'),
		image('entities/img/witch/idleRight10.png'),
		image('entities/img/witch/idleRight11.png'),
		image('entities/img/witch/idleRight12.png'),
		image('entities/img/witch/idleRight13.png'),
		image('entities/img/witch/idleRight14.png'),
		image('entities/img/witch/idleRight15.png'),
		image('entities/img/witch/idleRight16.png'),
		image('entities/img/witch/idleRight17.png'),
		image('entities/img/witch/idleRight18.png'),
		image('entities/img/witch/idleRight19.png')
	}
	return idleRight
end

function witch.WalkingLeftAnimation()
	local walkingLeft =
	{
		image('entities/img/witch/walkingLeft1.png'),
		image('entities/img/witch/walkingLeft2.png'),
		image('entities/img/witch/walkingLeft3.png'),
		image('entities/img/witch/walkingLeft4.png'),
		image('entities/img/witch/walkingLeft5.png'),
		image('entities/img/witch/walkingLeft6.png'),
		image('entities/img/witch/walkingLeft7.png'),
		image('entities/img/witch/walkingLeft8.png'),
		image('entities/img/witch/walkingLeft9.png'),
		image('entities/img/witch/walkingLeft10.png'),
		image('entities/img/witch/walkingLeft11.png')
	}
	return walkingLeft
end

function witch.WalkingRightAnimation()
	local walkingRight = 
	{
		image('entities/img/witch/walkingRight1.png'),
		image('entities/img/witch/walkingRight2.png'),
		image('entities/img/witch/walkingRight3.png'),
		image('entities/img/witch/walkingRight4.png'),
		image('entities/img/witch/walkingRight5.png'),
		image('entities/img/witch/walkingRight6.png'),
		image('entities/img/witch/walkingRight7.png'),
		image('entities/img/witch/walkingRight8.png'),
		image('entities/img/witch/walkingRight9.png'),
		image('entities/img/witch/walkingRight10.png'),
		image('entities/img/witch/walkingRight11.png')
	}
	return walkingRight
end

return witch