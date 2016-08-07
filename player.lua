require("map")			-- we need map.lua and everything in it, so this line makes that happen!
require("levels")		-- we also need to know about the levels we've written. They're in levels.lua
require("SpecialTiles")
require("collision")

function newPlayer()
	p= {
		name = "Player 1",
		x = Levels[currentLevel].startX, 
		y = Levels[currentLevel].startY, 
		img = nil, 
		walk = 200, 
		jump = 500,
		accel = 1400, 
		ySpeed = 0, 
		xSpeed = 0,
		width = 0,
		height = 0,
		jumped = false,
		takenDamage = false,
		damageTime = 0,
		health = 100,
		maxHealth = 100,
		maxFall = 400,
		score = 0,
		up = 'w',
		down = 's',
		left = 'a',
		right = 'd'
	}
	p.img = love.graphics.newImage("Images/guy.png")
	p.width = p.img:getWidth()
	p.height = p.img:getHeight()
	return p;
end

function setPlayerPos(player,x,y)
	player.x = x
	player.y = y
end

function onPoint(player, points)
	player.score = player.score + points
end

function setName(player, name)
	player.name = name
end
	
function drawScore(player, x, y)
	text = player.name .. "'s Score:"
	love.graphics.print(text, x, y)
	width = font:getWidth( text )+2
	love.graphics.print(player.score, x+width, y)
end

function onDamage(player, x)
	if player.takenDamage == false then
		player.xSpeed = -player.xSpeed
		player.ySpeed = -player.ySpeed
		player.health = player.health - x
		player.takenDamage = true
	end
end

function damageBoost(player, dt)
	if player.damageTime < 2 and player.takenDamage then
		player.damageTime = player.damageTime + dt
	else
		player.takenDamage = false
		player.damageTime = 0
	end
end

function updatePos(player, dt)
	player.x = player.x + player.xSpeed*dt
	player.y = player.y + player.ySpeed*dt
end

function setWalk(player, x)
	player.walk = x
end

function setAccel(player, number)
	player.accel = number
end

function setImage(player, location)
	player.img = love.graphics.newImage(location)
	player.width = p.img:getWidth()
	player.height = p.img:getHeight()
end

function setJump(player, number)
	player.jump = number
end

function getHealth(player)
	return player.health
end

function isDead(player)
	return player.health <= 0
end

function setHealth(player, x)
	if x > player.maxHealth then
		player.health = player.maxHealth
	else
		player.health = x
	end
end

function addHealth(player, x)
	if x + player.health > player.maxHealth then
		player.health = player.maxHealth
	else
		player.health = player.health + x
	end
end

function subHealth(player, x)
	if player.health - x <= 0 then
		player.health = 0
	else
		player.health = player.health - x
	end
end

function setMaxFall(player, x)
	player.maxFall = x
end

function setUp(player, x)
	player.up = x
end

function setDown(player, x)
	player.down = x
end

function setLeft(player, x)
	player.left = x
end

function setRight(player, x)
	player.right = x
end

function onScreen (player)

	if player.x > 1 and 
	player.x + player.width + 1 < getPixelWidth() and
	player.y+player.height < getPixelHeight() and
	player.y > 1 then
		
		return true
	else
		return false
	end

end

function moveLeft (player, dt)
	left = checkLeft(player)

	if left == "No Collision" then
		if (player.xSpeed < -player.walk) then
			player.xSpeed = -player.walk
		end
		if (player.xSpeed > -player.walk) then
			player.xSpeed = player.xSpeed - player.accel*dt
		end
	elseif(left == "Collision") then
		player.xSpeed = 0
		setOffset(player, "Left")
	end
end

function moveDown (player, dt)
	down = checkDown(player)
	
	if down == "No Collision" then
		if (player.ySpeed < -player.walk) then
			player.ySpeed = -player.walk
		end
		if (player.ySpeed < player.walk) then
			player.ySpeed = player.ySpeed + player.accel*dt
		end
	elseif(down == "Collision") then
		player.ySpeed = 0
		setOffset(player, "Down")
	end
end

function moveUp (player, dt)
	up = checkUp(player)

	if up == "No Collision" then
		if (player.ySpeed > player.walk) then
			player.ySpeed = player.walk
		end
		if (player.ySpeed > -player.walk) then
			player.ySpeed = player.ySpeed - player.accel*dt
		end
	elseif(up == "Collision") then
		player.ySpeed = 0
		setOffset(player, "Up")
	end

end

function moveRight (player, dt)

	right = checkRight(player)

	if right == "No Collision" then
		if (player.xSpeed > player.walk) then
			player.xSpeed = player.walk
		end
		if (player.xSpeed < player.walk) then
			player.xSpeed = player.xSpeed + player.accel*dt
		end
	elseif(right == "Collision") then
		player.xSpeed = 0
		setOffset(player, "Right")
	end
		
	
end

function setOffset(player, direction)

	if direction == "Right" then
		pos = player.x
	
		offset = player.x + player.width - math.floor((player.x + player.width)/16)*16

		if offset < 8 then
			player.x = player.x - offset 
		else
			player.x = player.x + (16-offset)
		end
		
	elseif direction == "Left" then
	
		offset = player.x - math.floor(player.x/16)*16

		if offset > 8 then
			player.x = player.x + (16-offset) 
		else
			player.x = player.x - offset 
		end
	
	elseif direction == "Down" then
	
		offset = player.y + player.height - math.floor((player.y+player.height)/16)*16

		if offset < 8 then
			player.y = player.y - offset
		else
			player.y = player.y + (16-offset)
		end
	
	elseif direction == "Up" then
	
		offset = player.y - math.floor(player.y/16)*16

		if offset > 8 then
			player.y = player.y + (16-offset) 
		else
			player.y = player.y - offset
		end
	end


end

function applyGravity (player, dt)

	down = checkDown(player)
	
	if down ~= "Collision" then
		if player.ySpeed + player.accel*dt < player.maxFall then
			player.ySpeed = player.ySpeed + player.accel*dt
		else
			player.ySpeed = player.maxFall
		end
	else
		player.ySpeed = 0
		setOffset(player, "Down")
	end

end

function movement(player, dt)

	if gravity == true then
		up = checkUp(player)

		if(up == "Collision") then
			player.ySpeed = 0
			player.y = player.y + 2
		end
	end
	
	if love.keyboard.isDown( player.right ) then
		moveRight(player, dt)
	end

	if love.keyboard.isDown( player.left ) then
		moveLeft(player, dt)
	end

	if gravity then
		applyGravity(player, dt)
		if love.keyboard.isDown( player.up ) then
			jump(player, dt)
		end
	else
		
		if love.keyboard.isDown( player.up ) then
			moveUp(player, dt)
		end
		if love.keyboard.isDown( player.down ) then
			moveDown(player, dt)
		end
		
	end

	player.y = player.y + player.ySpeed*dt
	player.x = player.x + player.xSpeed*dt
	
	friction(player, gravity, dt)
	
end

function jump (player, dt)

	if checkDown(player) == "No Collision" then
		-- Do nothing if not grounded
	elseif player.ySpeed == 0 and player.jumped == false then

		player.y = player.y
		player.ySpeed = -player.jump

	end	
	player.jumped = true
end

function friction (player, gravity, dt)

	if (love.keyboard.isDown( player.right ) == false and love.keyboard.isDown( player.left ) == false) 
	or (love.keyboard.isDown( player.right ) and love.keyboard.isDown( player.left ))then
		
		if player.xSpeed > 15 then
			player.xSpeed = player.xSpeed - player.accel*dt
			
			if checkRight(player) ~= "No Collision" then
				setOffset(player, "Right")
			end
		elseif	player.xSpeed < -15 then
			player.xSpeed = player.xSpeed + player.accel*dt
			
			if checkLeft(player) ~= "No Collision" then
				setOffset(player, "Left")
			end
		else	
			player.xSpeed = 0
		end
		
	end
	
	if ((love.keyboard.isDown( player.down ) == false and love.keyboard.isDown( player.up ) == false)
	or (love.keyboard.isDown( player.down ) and love.keyboard.isDown( player.up )))
	and gravity == false then
		
		if player.ySpeed > 15 then
			player.ySpeed = player.ySpeed - player.accel*dt
			
			if checkDown(player) ~= "No Collision" then
				setOffset(player, "Down")
			end
		elseif	player.ySpeed < -15 then
			player.ySpeed = player.ySpeed + player.accel*dt
			
			if checkUp(player) ~= "No Collision" then
				setOffset(player, "Up")
			end
		else	
			player.ySpeed = 0
		end

	end

end