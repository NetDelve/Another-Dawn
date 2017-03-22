require "player"
require "mapHandler"

mapHandler.loadWorld("map/testWorld/globalIndex")

cam = {x = 0, y = 0}

function love.update(dt)
	if love.keyboard.isDown("w") then --would probably be a good idea to add a "inputconf.lua" file at some point
		player.y = player.y - dt*player.moveSpeed
	elseif love.keyboard.isDown("s") then
		player.y = player.y + dt*player.moveSpeed
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - dt*player.moveSpeed
	elseif love.keyboard.isDown("d") then
		player.x = player.x + dt*player.moveSpeed
	end
	
	cam.x, cam.y = player.x, player.y

	if mapHandler.recalculateCheck(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y) then
		mapHandler.recalculateAreas(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y)
	end
end

function love.draw()
	for i,v in ipairs(mapHandler.map) do
		if not v.sprite then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill", v.x-cam.x, v.y-cam.y, v.sX, v.sY)
		else
			love.graphics.draw(v.sprite, v.x-cam.x, v.y-cam.y)
		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", (love.graphics.getWidth()/2)-player.sX, (love.graphics.getHeight()/2)-player.sY, 50, 50, 15, 15) --temporary "playermodel"
	love.graphics.print("Objects: "..table.maxn(mapHandler.map))
end
