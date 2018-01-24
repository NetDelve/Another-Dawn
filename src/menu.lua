menu={}
suit = require "libs/suit"

function menu:draw()
	love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("Another Dawn" , 10, 30)
	suit.draw()
end

function menu:update(dt)
	if suit.Button("Play Game", 50,100, 150,30).hit then
		Gamestate.switch(game)
	end
	if suit.Button("Development Editor", 50,200, 150,30).hit then
		GameState.switch(editorMenu)
	end
end
