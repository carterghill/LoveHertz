require("map")			-- we need map.lua and everything in it, so this line makes that happen!
require("levels")		-- we also need to know about the levels we've written. They're in levels.lua
require("SpecialTiles")
require("player")

currentLevel = 1
player = nil
level = nil
gameOver = false
gameStart = false
gravity = true
background = nil
levelLoaded = false

--[[
	Draw an image that was loaded in love.load 
	(putting love.graphics.newImage in love.draw would cause the image to be reloaded every frame, 
	which would cause issues).
]]
function drawGame()

	if gameStart and not gameOver then
		drawBackground()
		DrawLevel()		-- map.lua. Draws all images loaded when LoadLevel was called.
	end
	if not gameStart and not gameOver then
		--- draw start screen
		drawStartScreen()
	end
	
	if gameOver then
		drawGameOverScreen()
	end
	
end

--[[
	Sets the background using a file path
	Ex: setBackground('images/sunset.jpg')
]]
function setBackground(x)
	background = love.graphics.newImage(x)
end

function setGravity(x)
	gravity = x
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.keyreleased(key)
	if key == "w" then
		player.jumped = false
	end
end

function setFullscreen()
	if love.window.getFullscreen() == false then
		love.window.setMode(1280,720, {fullscreen = true} )
	else 
		love.window.setMode(1280,720, {fullscreen = false} )
	end
end

function player_update(player, dt)

	if player.takenDamage == true then
		damageBoost(player, dt)
	end
	
	if player.y > love.graphics.getHeight() then
		onPlayerDie()
	end
	
	movement(player,dt)
	
end

function update()

	if love.keyboard.isDown('t') and levelLoaded == false then
		loadNextLevel()
		levelLoaded = true
	end

	if love.keyboard.isDown(' ') and not gameStart then
		gameStart = true
		gameOver = false
	end 
	
	if love.keyboard.isDown(' ') and gameOver then
		gameStart = true
		gameOver = false
		loadCurrentLevel()
	end 
	
	if not gameStart or gameOver then
		return
	end

end

function drawPlayer(player)
	-- if the player table exists, draw the image saved there.
	if player ~= nil and gameStart and not gameOver then
		love.graphics.draw(player.img, player.x, player.y)
	end
end

function onPlayerDie()
	gameOver = true
end

function onLevelEnd()
	if hasNextLevel() then
		loadNextLevel()
	end
end

function loadCurrentLevel()
	if font == nil then
		font = love.graphics.newFont(12)
	end
	level = Levels[currentLevel]
	if level ~= nil then
		LoadLevel(level)
	end
end

function hasNextLevel()
	return currentLevel <= table.getn(Levels)
end

function loadNextLevel()
	if currentLevel < #Levels then
		currentLevel = currentLevel + 1
		loadCurrentLevel()
		player.x = Levels[currentLevel].startX
		player.y = Levels[currentLevel].startY
	end
end

function drawStartScreen()
	love.graphics.print("Press Space To Start", 400, 300)
end

function drawGameOverScreen()
	love.graphics.print("GAME OVER", 400, 300)
end

function drawBackground()
	if background ~= nil then
		love.graphics.draw(background,0,0)
	end
end
