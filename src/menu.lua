menu={}
suit = require "libs/suit"

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function menu:draw()
	love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.print("Another Dawn" , width/2-12, height/2-100)
	suit.draw()
end

function menu:update(dt)
	if suit.Button("Play Game", width/2-50,height/2-100+50, 150,30).hit then
		Gamestate.switch(game)
	end
	if suit.Button("Development Editor", width/2-50,height/2, 150,30).hit then
		--GameState.switch(editorMenu)
	end
end
