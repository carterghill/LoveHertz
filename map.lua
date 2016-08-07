--[[
	Joel Hill
	joel.hill.87@gmail.com
	
	map.lua contains functions used to load a tilemap as defined in a lua table,
	and displays it on the screen.
	
	This file refers to a "texture atlas" a lot. That is the image we made our map out of.
	For more info on what a texture atlas is, start here:
	https://en.wikipedia.org/wiki/Texture_atlas
]]


tileheight	= 16 -- the height of each tile in pixels
tilewidth 	= 16 -- the width of each tile in pixels

mapwidth 	= 0 -- width of the map in units of tiles
mapheight 	= 0 -- the height of the map in units of tiles

windowWidth 	= 0
windowHeight 	= 0


map 		= {} -- A table that will contain all of the level data
mapQuads	= {} -- A table that will contain all of the quads

--[[
This function takes in a level instance, loads the level image, 
and creates a new sprite batch from the image.
It also generates all of the "quads" we need.
Levels are defined in levelDef.lua
]]
function LoadLevel(level)

	windowWidth, windowHeight = love.window.getDimensions()
	
	map = level.tilemap				-- get the tilemap from the level
	mapheight = table.getn(map)		-- figure out how tall it is....
	mapwidth = table.getn(map[1])	-- ... and how wide it is.
	imagePath = level.imagePath		-- also, get the image we made the map with.
	image = love.graphics.newImage(imagePath)		-- load up that image!
	
	--[[ What does the spriteBatch do?
		From love2d docs, "Using a single image, draw any number of identical copies of the image using 
		a single call to love.graphics.draw()."
		This is exactly what we need to make a level from a texture atlas!
	]]
	spriteBatch = love.graphics.newSpriteBatch( image, (mapheight*mapwidth) )
	
	--We also need our quads to be loaded.
	--Go to initQuads for more details!
	if image ~= nil then
		mapQuads = initQuads(image);
	end
	--All ready to draw our level!
end

--[[
	For every tile described in our "map" table, if the number is not zero,
	we grab the "quad" (a small square chunk of our texture atlas), tell it where to be
	on the screen, and add it to our spriteBatch. 
	
	BONUS QUESTION!
	
	WHOA!! I did something silly here that will cause a lot of work for the computer!
	Can you find the mistake? The code still works, but it's not at all efficient!
	
	Hint: Every time the screen refreshes (which is a lot!) this function will be called....
	-Joel	
]]
function DrawLevel()
	for i = 1, mapheight do
		for j = 1, mapwidth do
			index = map[i][j]
			if index ~= 0 then
				quad = mapQuads[index]
				spriteBatch:add(quad, (j-1)*tilewidth, (i-1)*tileheight)
			end
		end
	end
	--here, all of the quads have been added, and now we draw all of them at once!
	xOffset , yOffset = calculateOffset(windowWidth, windowHeight)
	love.graphics.draw(spriteBatch)--, xOffset, yOffset)
end

--[[
	Quads are used to display only part of an image.
	In our case, we want a "quad" for every tile in our texture atlas (the master image)
	This function calculates how may we need, where they should be, and then makes each one.
	All the quads are stored in the empty quads table.
]]
function initQuads(im)
	listQuads = {}
	widthQuads = (im:getWidth()/tilewidth)
	heightQuads = (im:getHeight()/tileheight)
	count = 0
	for j = 1, heightQuads do
		for i = 1, widthQuads do
			count = count + 1
			listQuads[count] = 
				love.graphics.newQuad((i-1)*tilewidth,(j-1)*tileheight,tilewidth,tileheight,im:getWidth(),im:getHeight())
			
		end
	end
	return listQuads
	
end

function love.resize(w, h)
  print(("Window resized to width: %d and height: %d."):format(w, h))
  windowWidth = w
  windowHeight = h 
end

--helper functions

function calculateOffset(width, height)
	y = height - (mapheight*tileheight)		-- want the map on the bottom of the screen
	x = (width - (mapwidth * tilewidth))/2
	return x, y
end

function getNumQuads(image, tilew, tileh)
	widthQuads = (image:getWidth()/tilew)
	heightQuads = (image:getHeight()/tileh)
	return widthQuads*heightQuads
end

function getIndex(x, y)
	indX = math.floor(x/tilewidth) + 1
	indY = math.floor(y/tileheight) + 1
	return indX, indY
end

function getPixelHeight()
	return (tileheight*mapheight)
end

function getPixelWidth()
	return (tilewidth*mapwidth)
end
