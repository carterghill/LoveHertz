-- Returns the highest tile number on the player's left edge
function checkLeft(player)
	
	x1 = math.ceil((player.y+1)/16)
	y1 = math.ceil((player.x-2)/16)
	x2 = math.ceil((player.y+player.height-4)/16)
	y2 = math.ceil((player.x-2)/16)
	
	top = map[x1][y1]
	bottom = map[x2][y2]
	
	if checkTile(top) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(top))
		return "Damage"
	elseif checkTile(bottom) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(bottom))
		return "Damage"
	elseif (checkTile(top) == "Damage" or checkTile(bottom) == "Damage") and
	player.takenDamage == true then
		return "Collision"
	elseif(checkTile(top)) == "Point" or checkTile(bottom) == "Point" then
		if checkTile(top) == "Point" then
			deleteTile(x1,y1)
			onPoint(player,getPoints(top))
		end
		if checkTile(bottom) == "Point" then
			deleteTile(x2, y2)
			onPoint(player,getPoints(bottom))
		end
		return "Point"
	elseif(checkTile(top) == "No Collision" and checkTile(bottom) == "No Collision") then
		return "No Collision"
	else
		return "Collision"
	end

end

-- Returns the highest tile number on the player's right edge
function checkRight(player)

	x1 = math.ceil((player.y+2)/16)
	y1 = math.ceil((player.x+player.width+2)/16)
	x2 = math.ceil((player.y+player.height-4)/16)
	y2 = math.ceil((player.x+player.width+2)/16)

	top = map[x1][y1]
	bottom = map[x2][y2]	

	if checkTile(top) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(top))
		return "Damage"
	elseif checkTile(bottom) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(bottom))
		return "Damage"
	elseif (checkTile(top) == "Damage" or checkTile(bottom) == "Damage") and
	player.takenDamage == true then
		return "Collision"
	elseif(checkTile(top)) == "Point" or checkTile(bottom) == "Point" then
		if checkTile(top) == "Point" then
			deleteTile(x1,y1)
			onPoint(player,getPoints(top))
		elseif checkTile(bottom) == "Point" then
			deleteTile(x2, y2)
			onPoint(player,getPoints(bottom))
		end
		return "Point"
	elseif(checkTile(top) == "No Collision" and checkTile(bottom) == "No Collision") then
		return "No Collision"
	else
		return "Collision"
	end
	
end

function checkDown(player)

	x1 = math.ceil((player.y+5+player.height)/16)
	y1 = math.ceil((player.x+1)/16)
	x2 = math.ceil((player.y+5+player.height)/16)--math.ceil((player.y+3+player.height)/16)
	y2 = math.ceil((player.x+player.width-1)/16)

	right = map[x1][y1]
	left = map[x2][y2]
	
	if checkTile(right) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(right))
		return "Damage"
	elseif checkTile(left) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(left))
		return "Damage"
	elseif (checkTile(right) == "Damage" or checkTile(left) == "Damage") and
	player.takenDamage == true then
		return "Collision"
	elseif(checkTile(right)) == "Point" or checkTile(left) == "Point" then
		if checkTile(right) == "Point" then
			deleteTile(x1,y1)
			onPoint(player,getPoints(right))
		end
		if checkTile(left) == "Point" then
			deleteTile(x2, y2)
			onPoint(player,getPoints(left))
		end
		return "Point"
	elseif(checkTile(right) == "No Collision" and checkTile(left) == "No Collision") then
		return "No Collision"
	else
		return "Collision"
	end
end

function checkUp(player) 

	y1 = math.ceil((player.y-1)/16)
	x1 = math.ceil((player.x+1)/16)
	y2 = math.ceil((player.y-1)/16)
	x2 = math.ceil((player.x+player.width-1)/16)
	left = map[y1][x1]
	right = map[y2][x2]	
	
	if checkTile(right) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(right))
		return "Damage"
	elseif checkTile(left) == "Damage" and player.takenDamage == false then
		onDamage(player, getDamage(left))
		return "Damage"
	elseif (checkTile(right) == "Damage" or checkTile(left) == "Damage") and
	player.takenDamage == true then
		return "Collision"
	elseif(checkTile(right)) == "Point" or checkTile(left) == "Point" then
		if checkTile(right) == "Point" then
			deleteTile(y1,x1)
			onPoint(player,getPoints(right))
		end
		if checkTile(left) == "Point" then
			deleteTile(y2, x2)
			onPoint(player,getPoints(left))
		end
		return "Point"
	elseif(checkTile(right) == "No Collision" and checkTile(left) == "No Collision") then
		return "No Collision"
	else
		setOffset(player, "Up")
		return "Collision"
	end
end
