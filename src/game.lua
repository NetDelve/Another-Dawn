game = {}
require 'player'

local mainCan = love.graphics.newCanvas( love.graphics.getWidth()+100, love.graphics.getHeight()+100 )

local hud={}
hud.h = love.graphics.getHeight()/4
hud.w = love.graphics.getWidth()
hud.canvas = love.graphics.newCanvas( hud.w, hud.h)


function game:draw()
     -- Start Canvas Assemble
     -- main canvas
     	love.graphics.setCanvas(mainCan)
		love.graphics.clear()
        	love.graphics.setBlendMode("alpha")
        	--love.graphics.setColor(255, 0, 0, 128)
		love.graphics.setColor(255, 255, 255, 255)
  		if player.sprite ~= nil then
			love.graphics.draw(player.sprite, player.x, player.y, player.sX, player.sY)
		else
			love.graphics.rectangle("fill", player.x+100, player.y+100, 50,50,15,15)
		end
	love.graphics.setCanvas()

     -- hud canvas
	love.graphics.setCanvas(hud.canvas)
		love.graphics.clear()
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.rectangle("fill",0,0, hud.w, hud.h)
	love.graphics.setCanvas()
     -- End Canvas Assemble
     	
     	love.graphics.setColor(255, 255, 255, 255)
     	--love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.setBlendMode("alpha")
    	love.graphics.draw(mainCan, 0, 0)
	love.graphics.draw(hud.canvas, 0, love.graphics.getHeight()-hud.h)

end

function game:update(dt)
	if love.keyboard.isDown("w") then
		player.y = player.y - dt*player.moveSpeed
	elseif love.keyboard.isDown("s")then
		player.y = player.y + dt*player.moveSpeed
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - dt*player.moveSpeed
	elseif love.keyboard.isDown("d") then
		player.x = player.x + dt*player.moveSpeed
	end
end
