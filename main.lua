require('game')

function love.load()
	
	loadCurrentLevel() -- Loads our first level
	player = newPlayer() -- Creates our player
	addDamageTile(7, 10)
	addNoCollisionTile(0)
	addNoCollisionTile(24)
	setBackground('Images/blueSky.jpg')

end

function love.draw()
	drawGame() -- Calls some essential stuff, don't delete.
	drawPlayer(player)
end

function love.update(dt)
	update() -- Another important function, don't delete this!
	player_update(player,dt) -- Updates everything for the player object
end