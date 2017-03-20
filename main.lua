require "game-art/artinclude"

function love.draw()
  love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("name: " .. name, 10, 30 )
end