--load save here if required

require "player"
require "mapHandler"

function love.update(dt)
	if love.keyboard.isDown("w") then --would probably be a good idea to add a "inputconf.lua" file at some point
		player.y = player.y - dt*player.moveSpeed
	elseif love.keyboard.isDown("s") then
		player.y = player.y + dt*player.moveSpeed
	elseif love.keyboard.isDown("a") then
		player.x = player.x - dt*player.moveSpeed
	elseif love.keyboard.isDown("d") then
		player.x = player.x + dt*player.moveSpeed
	end
	
	if mapHandler.recalculateCheck(0, 0, love.graphics.getWidth(), love.graphics.getHeight()) then
		mapHandler.recalculateAreas(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	end
end

function love.draw()
	love.graphics.setBackgroundColor(0, 180, 200)
	for i,v in ipairs(mapHandler.map) do
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", v.x, v.y, v.sX, v.sY)
		--love.graphics.draw(v.sprite, v.x, v.y)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", player.x, player.y, 50, 50, 15, 15) --temporary "playermodel"
	love.graphics.print("Objects: "..table.maxn(mapHandler.map))
end
