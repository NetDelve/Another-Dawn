require "gamestates"
--suit = require "libs/suit"

Gamestate = require "libs.hump.gamestate"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.keypressed(key)
--	input.keypressed(key)
--	if key == "`" then
--		debug.debug() --enter love2d debug mode
--	end
end
