local frankenstein = {}
local image = love.graphics.newImage

function frankenstein.IdleLeftAnimation()
	local idleLeft =
	{
		image('entities/img/frankenstein/idleLeft1.png'),
		image('entities/img/frankenstein/idleLeft2.png'),
		image('entities/img/frankenstein/idleLeft3.png'),
		image('entities/img/frankenstein/idleLeft4.png'),
		image('entities/img/frankenstein/idleLeft5.png')
	}
	return idleLeft
end

function frankenstein.IdleRightAnimation()
	local idleRight =
	{
		image('entities/img/frankenstein/idleRight1.png'),
		image('entities/img/frankenstein/idleRight2.png'),
		image('entities/img/frankenstein/idleRight3.png'),
		image('entities/img/frankenstein/idleRight4.png'),
		image('entities/img/frankenstein/idleRight5.png')
	}
	return idleRight
end

function frankenstein.WalkingLeftAnimation()
	local walkingLeft =
	{
		image('entities/img/frankenstein/walkingLeft1.png'),
		image('entities/img/frankenstein/walkingLeft2.png'),
		image('entities/img/frankenstein/walkingLeft3.png'),
		image('entities/img/frankenstein/walkingLeft4.png'),
		image('entities/img/frankenstein/walkingLeft5.png'),
		image('entities/img/frankenstein/walkingLeft6.png'),
		image('entities/img/frankenstein/walkingLeft7.png'),
		image('entities/img/frankenstein/walkingLeft8.png'),
		image('entities/img/frankenstein/walkingLeft9.png'),
		image('entities/img/frankenstein/walkingLeft10.png'),
		image('entities/img/frankenstein/walkingLeft11.png')
	}
	return walkingLeft
end

function frankenstein.WalkingRightAnimation()
	local walkingRight = 
	{
		image('entities/img/frankenstein/walkingRight1.png'),
		image('entities/img/frankenstein/walkingRight2.png'),
		image('entities/img/frankenstein/walkingRight3.png'),
		image('entities/img/frankenstein/walkingRight4.png'),
		image('entities/img/frankenstein/walkingRight5.png'),
		image('entities/img/frankenstein/walkingRight6.png'),
		image('entities/img/frankenstein/walkingRight7.png'),
		image('entities/img/frankenstein/walkingRight8.png'),
		image('entities/img/frankenstein/walkingRight9.png'),
		image('entities/img/frankenstein/walkingRight10.png'),
		image('entities/img/frankenstein/walkingRight11.png')
	}
	return walkingRight
end

return frankenstein