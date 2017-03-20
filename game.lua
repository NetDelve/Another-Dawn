--load save here if required

require "player"

map = {} --objects to be rendered are put here, recalculated every time a new area is loaded
mapAreas = {} --list of areas that will be put into the rendering queue

function love.update(dt)
	if love.keyboard.isDown("a") then --would probably be a good idea to add a "inputconf.lua" file at some point
		player.x = player.x - dt*player.moveSpeed
	elseif love.keyboard.isDown("d") then
		player.x = player.x + dt*player.moveSpeed
	elseif love.keyboard.isDown("w") then
		player.y = player.y - dt*player.moveSpeed
	elseif love.keyboard.isDown("s") then
		player.y = player.y + dt*player.moveSpeed
	end
end

function love.draw()
	love.graphics.setBackgroundColor(100, 60, 100)
	for i,v in ipairs(map) do
		love.graphics.draw(v.sprite, v.x, v.y)
	end
	love.graphics.rectangle("fill", player.x, player.y, 50, 50) --temporary "playermodel"
end
