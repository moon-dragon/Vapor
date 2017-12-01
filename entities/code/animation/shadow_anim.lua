local shadow = {}
local image = love.graphics.newImage

function shadow.Animation()
	local shadow =
	{
		image('entities/img/shadow/shadow1.png'),
		image('entities/img/shadow/shadow2.png'),
		image('entities/img/shadow/shadow3.png')
	}
	return shadow
end

return shadow