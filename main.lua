require "input"
suit = require "libs/suit"

function love.load()
	require "menu"
end

function love.keypressed(key)
	input.keypressed(key)
end
