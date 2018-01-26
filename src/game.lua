game = {}
Camera = require "libs.hump.camera"
require 'player'

camera = Camera(player.x, player.y)

local floorCan = love.graphics.newCanvas( 100, 100 )
local mainCan = love.graphics.newCanvas( love.graphics.getWidth()+100, love.graphics.getHeight()+100 )

local hud={}
hud.h = love.graphics.getHeight()/4
hud.w = love.graphics.getWidth()
hud.canvas = love.graphics.newCanvas( hud.w, hud.h)


function game:draw()
     -- Start Canvas Assemble
     -- floor canvas
     	love.graphics.setCanvas(floorCan)
	love.graphics.setCanvas()
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
	
	local dx,dy = player.x - camera.x, player.y - camera.y
    	camera:move(dy/2, dx/2)
end

--require "mapHandler"
--require "findImage"

--mapHandler.loadWorld("map/testWorld/globalIndex", "map/testWorld/globalImages")
--require "map/testWorld/globalScript"

--cam = {x = 0, y = 0}

--function love.update(dt)
--	if love.keyboard.isDown("w") then --would probably be a good idea to add a "inputconf.lua" file at some point
--		player.y = player.y - dt*player.moveSpeed
--	elseif love.keyboard.isDown("s") then
--		player.y = player.y + dt*player.moveSpeed
--	end
--	if love.keyboard.isDown("a") then
--		player.x = player.x - dt*player.moveSpeed
--	elseif love.keyboard.isDown("d") then
--		player.x = player.x + dt*player.moveSpeed
--	end
--	
--	cam.x, cam.y = player.x, player.y
--
--	if mapHandler.recalculateCheck(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y) then
--		mapHandler.recalculateAreas(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y)
--	end
--	mapHandler.runObjectScripts()
--end

--function love.draw()
--	for i,v in ipairs(mapHandler.map) do
--		if not v.sprite then
--			love.graphics.setColor(0,0,0)
--			love.graphics.rectangle("fill", v.x-cam.x, v.y-cam.y, v.sX, v.sY)
--		else
--			love.graphics.draw(v.sprite, v.x-cam.x, v.y-cam.y)
--		end
--	end
--	love.graphics.setColor(255,255,255)
--	love.graphics.rectangle("fill", (love.graphics.getWidth()/2)-player.sX, (love.graphics.getHeight()/2)-player.sY, 50, 50, 15, 15) --temporary "playermodel"
--end
