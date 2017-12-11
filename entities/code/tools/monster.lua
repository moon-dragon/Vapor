monster = {}
local monsters = {}

-- The list of monsters
table.insert(monsters, "frankenstein")
table.insert(monsters, "ghost")
table.insert(monsters, "witch")


-- Return a random monster from the list
function monster.getAMonster()
	return monsters[love.math.random(1, #monsters)]
end


return monster