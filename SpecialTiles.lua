damageTiles = {}

noCollisionTiles = {}

pointTiles = {}

function addDamageTile(tileNumber, damage)
	damageTiles[tileNumber] = damage
end

function addNoCollisionTile(tileNumber)
	noCollisionTiles[tileNumber] = 1
end

function addPointTile(tileNumber, points)
	pointTiles[tileNumber] = points
end

function isKillTile(index)
	return damageTiles[index] ~= nil
end

function isNoCollisionTile(index)
	return noCollisionTiles[index] ~= nil
end

function isPointTile(index)
	return pointTiles[index] ~= nil
end

function getDamage(index)
	if isKillTile(index) then
		return damageTiles[index]
	else
		return 0
	end
end

function getPoints(index)
	if isPointTile(index) then
		return pointTiles[index] 
	else
		return 0
	end
end

function checkTile(x)
	if noCollisionTiles[x] ~= nil then
		return "No Collision"
	end 
	if damageTiles[x] ~= nil then
		return "Damage"
	end
	if pointTiles[x] ~= nil then
		return "Point"
	end
end




