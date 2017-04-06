require "input"
suit = require "libs/suit"

function love.load()
	require "menu"
end

function love.keypressed(key)
	input.keypressed(key)
	if key == "`" then
		debug.debug() --enter love2d debug mode
	end
end
