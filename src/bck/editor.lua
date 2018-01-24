gui = require 'gui'

config = {viewportSize = {x = 640, y = 480}}

bck.newArea("test", 0, 0, 500, 500)
bck.newObject("test", 50, 50, false, false)
bck.placeForeground("test", 10, 10, "test")

function love.update(dt)
	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
	frame = bck.drawToCanvas(camX, camY, config.viewportSize.x, config.viewportSize.y)
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 0, 0, (love.graphics.getWidth()-100)/config.viewportSize.x, love.graphics.getHeight()/config.viewportSize.y)
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight()) --right place object menu
end
