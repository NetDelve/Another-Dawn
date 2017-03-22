require "game-art/loadArt"
function love.draw()
	love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("Another Dawn v0.0.2" , 10, 30 )
	suit.draw()
end

function love.update(dt)
	if suit.Button("Play Game", 50,100, 150,30).hit then
		require "game" --no touchy
	end
end
