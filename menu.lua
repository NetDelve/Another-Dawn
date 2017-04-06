require "game-art/loadArt"
function love.draw()
	love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("Another Dawn" , 10, 30)
	suit.draw()
end

function love.update(dt)
	if suit.Button("Play Game", 50,100, 150,30).hit then
		require "game"
	end
	if suit.Button("Development Editor", 50,200, 150,30).hit then
		require "editor"
	end
end
