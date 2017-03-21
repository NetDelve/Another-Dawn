require "input"
suit = require "libs/suit"

function menu()
	require 'menu'
end

function playgame()
require 'game'
end

function love.load()
	menu()
end

function love.keypressed(key)
	input.keypressed(key)
end
