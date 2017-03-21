function love.draw()
  love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("Another Dawn v0.0.2" , 10, 30 )
  love.graphics.print("Hit 'o' to play" , 10, 60 )
end

function love.update(dt)
	if love.keyboard.isDown("o") then 
		playgame()
	end
end