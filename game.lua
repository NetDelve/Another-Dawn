--load save here if required

require "player"
function love.update()

end

function love.draw()
	love.graphics.setBackgroundColor(100, 60, 100)
	
	love.graphics.rectangle("fill", player.x, player.y, 50, 50) --temporary "playermodel"
end
