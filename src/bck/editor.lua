function love.update(dt)
	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
	frame = bck.drawToCanvas(camX, camY, config.viewportSize.y, config.viewportSize.y)
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 0, 0, love.graphics.getWidth()-100, love.graphics.getHeight())
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight()) --right place object menu
end
