-- editor = {}
suit = require 'suit'

config = {gridSize = {x = 50, y = 50}} --TODO make own file
camX, camY = 0, 0
camSpeed = 500

bck.newArea("test", 0, 0, 50, 50)
bck.newObject("test", 1, 1, false, false)
bck.placeForeground("test", 2, 2, "test")

local HudCan = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight()/4)
local rMenuCan = love.graphics.newCanvas()
local lMenuCan = love.graphics.newCanvas()
local popupMenuCan = love.graphics.newCanvas()

local input = {text = ""}
function love.update(dt)
	suit.layout:reset(10, 10) --left menu (edit object)
	suit.Input(input, suit.layout:row(80, 30))
	
	suit.layout:reset(love.graphics.getWidth()-90, 10) --right menu (place object)

	suit.layout:reset(10, 10) --top menu (menu)

	suit.layout:reset(10, love.graphics.getHeight()-10)

	if not suit.anyActive() then
		if love.keyboard.isDown("w") then
			camY = camY - camSpeed*dt
		elseif love.keyboard.isDown("s") then
			camY = camY + camSpeed*dt
		elseif love.keyboard.isDown("a") then
			camX = camX + camSpeed*dt
		elseif love.keyboard.isDown("d") then
			camX = camX - camSpeed*dt
		end
	end

	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
	frame = bck.drawToCanvas(camX, camY, love.graphics.getWidth()-100, love.graphics.getHeight()-100)
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 0, 0)
	love.graphics.setBlendMode("alpha")

	--[[love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-100, love.graphics.getWidth(), 100)]]
	suit.draw()
end

function love.keypressed(key, scancode, isrepeat)
	suit.keypressed(key)
end

function love.textinput(text)
	suit.textinput(text)
end
