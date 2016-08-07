require('player')

running = {}
walking = {}
shooting = {}
sprite = 1
anim = 0
currentList = running

function add(x, y)
	return x+y
end

function addSprite(list, image)
	list[table.getn(list)+1] = nil
	list[table.getn(list)+1] = love.graphics.newImage(image)
end

function animLoad(player)
	addSprite(walking,'tmp-0.gif' )
	addSprite(running,'Images/runRight/tmp-0.gif' )
	addSprite(running,'Images/runRight/tmp-1.gif' )
	addSprite(running,'Images/runRight/tmp-2.gif' )
	addSprite(running,'Images/runRight/tmp-3.gif' )
	addSprite(running,'Images/runRight/tmp-4.gif' )
	addSprite(running,'Images/runRight/tmp-5.gif' )
	addSprite(running,'Images/runRight/tmp-6.gif' )
	addSprite(running,'Images/runRight/tmp-7.gif' )
	addSprite(running,'Images/runRight/tmp-8.gif' )
	addSprite(running,'Images/runRight/tmp-9.gif' )
	player.img = currentList[1]
end
	
function love.draw(dt)
	love.graphics.draw(player.img, player.x, player.y)
	love.graphics.print(table.getn(currentList), 0, 0)
end

function animUpdate(player, dt)
	anim = anim + dt
	player.img = currentList[sprite]
	if anim > 0.044 then
		anim = 0
		sprite = sprite + 1 
		if sprite > table.getn(currentList) then
			sprite = 1
		end
	end
	if love.keyboard.isDown('d') then
		currentList = running
	else
		currentList = walking
		sprite = 1
	end
end