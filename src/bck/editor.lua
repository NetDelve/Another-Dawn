function love.update(dt)
	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
end

function love.draw()
	bck.draw(camX, camY)
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight()) --right place object menu
end
