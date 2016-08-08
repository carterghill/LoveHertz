require('game')

FPSTimer = 0
frameCounter = 0
FPS = 0

function love.load()
	
	loadCurrentLevel() -- Loads our first level
	player = newPlayer() -- Creates our player
	addDamageTile(7, 10)
	addNoCollisionTile(0)
	addNoCollisionTile(24)
	setBackground('Images/blueSky.jpg')
	setFullscreen()

end

function love.draw()
	player.img:setFilter('nearest','nearest')
	if love.window.getFullscreen() then
		love.graphics.scale(love.graphics.getWidth( )/1280, love.graphics.getHeight( )/720)
	end
	drawGame() -- Calls some essential stuff, don't delete.
	drawPlayer(player)
	love.graphics.print(FPS, 0, 0)
end

function love.update(dt)
	update() -- Another important function, don't delete this!
	player_update(player,dt) -- Updates everything for the player object
	
	FPSTimer = FPSTimer + dt
	frameCounter = frameCounter + 1
	
	if FPSTimer > 1 then
		FPS = frameCounter
		frameCounter = 0
		FPSTimer = 0
	end
	
end