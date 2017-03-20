--load save here if required

require "player"
--would probably be a good idea to add a "inputconf.lua" file at some point
function love.update(dt)
	if love.keyboard.isDown("w") then
		player.x = player.x - dt*player.moveSpeed
	elseif love.keyboard.isDown("s") then
		player.x = player.x + dt*player.moveSpeed
	elseif love.keyboard.isDown("a") then
		player.y = player.y - dt*player.moveSpeed
	elseif love.keyboard.isDown("d") then
		player.y = player.y + dt*player.moveSpeed
	end
end

function love.draw()
	love.graphics.setBackgroundColor(100, 60, 100)
	
	love.graphics.rectangle("fill", player.x, player.y, 50, 50) --temporary "playermodel"
end
