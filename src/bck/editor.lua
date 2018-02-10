-- editor = {}
gui = require 'gui'

config = {gridSize = {x = 50, y = 50}} --TODO make own file
camX, camY = 0, 0

bck.newArea("test", 0, 0, 50, 50)
bck.newObject("test", 1, 1, false, false)
bck.placeForeground("test", 2, 2, "test")

local HudCan = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight()/4)
local rMenuCan = love.graphics.newCanvas()
local lMenuCan = love.graphics.newCanvas()
local popupMenuCan = love.graphics.newCanvas()

function love.update(dt)
	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
	frame = bck.drawToCanvas(camX, camY, love.graphics.getWidth()-100, love.graphics.getHeight()-100)
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 0, 0)
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-100, love.graphics.getWidth(), 100)
	gui.draw()
end

function love.keypressed(key, scancode, isrepeat)
	gui.keypressed(key, isrepeat)
end

function love.mousepressed(x, y, button)
	gui.mousepressed(x, y, button)
end
