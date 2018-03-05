bck = require 'bck'
slw = require 'slw'
suit = require 'suit'

function love.load()
	
end

function love.update(dt)
	suit.layout:reset(love.graphics.getWidth()*0.25, love.graphics.getHeight()*0.25)
	if suit.Button("Game", suit.layout:row(200, 50)).hit then
		require 'game'
	end
	if suit.Button("Map Editor", suit.layout:row()).hit then
		require 'editor'
	end
	if suit.Button("Object Editor", suit.layout:row()).hit then
		require 'objecteditor'
	end
end

function love.draw()
	suit.draw()
end

function love.keypressed(key, scancode, isrepeat)
	suit.keypressed(key)
end

function love.textinput(text)
	suit.textinput(text)
end
