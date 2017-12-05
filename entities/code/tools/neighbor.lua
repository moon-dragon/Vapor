neighbor = {}
local mansion = require ("entities/map/map")
local assignedNeighbor = {}

-- Room number 1
table.insert(assignedNeighbor, {})
-- Room number 2
table.insert(assignedNeighbor, {3})
-- Room number 3
table.insert(assignedNeighbor, {2, 4, 5})
-- Room number 4
table.insert(assignedNeighbor, {3, 5})
-- Room number 5
table.insert(assignedNeighbor, {3, 4})
-- Room number 6
table.insert(assignedNeighbor, {7})
-- Room number 7
table.insert(assignedNeighbor, {6})
-- Room number 8
table.insert(assignedNeighbor, {9})
-- Room number 9
table.insert(assignedNeighbor, {8})
-- Room number 10
table.insert(assignedNeighbor, {11})
-- Room number 11
table.insert(assignedNeighbor, {10, 12})
-- Room number 12
table.insert(assignedNeighbor, {11})

-- Returns the room that is neighboring the specified room number
function neighbor.checkNeighbor(roomNumber)
	return assignedNeighbor[roomNumber]
end

return neighbor