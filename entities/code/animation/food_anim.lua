local food = {}
local image = love.graphics.newImage

function food.foodSpinAnimation ()
	local foodSpin = 
	{
		image('entities/img/foodspin/foodspin1.png'),
		image('entities/img/foodspin/foodspin2.png'),
		image('entities/img/foodspin/foodspin3.png'),
		image('entities/img/foodspin/foodspin4.png'),
		image('entities/img/foodspin/foodspin5.png'),
		image('entities/img/foodspin/foodspin6.png'),
		image('entities/img/foodspin/foodspin7.png'),
		image('entities/img/foodspin/foodspin8.png')
	}
	return foodSpin
end

return food