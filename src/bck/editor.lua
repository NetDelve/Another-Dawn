-- editor = {}
--gui = require 'gui'

config = {gridSize = {x = 50, y = 50}} --TODO make own file
camX, camY = 0, 0

bck.newArea("test", 0, 0, 50, 50)
bck.newObject("test", 1, 1, false, false)
bck.placeForeground("test", 2, 2, "test")

local HudCan = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight()/4)
local rMenuCan = love.graphics.newCanvas()
local lMenuCan = love.graphics.newCanvas()
local popupMenuCan = love.graphics.newCanvas()

function love.update(dt)
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

	if type(editorState) == "string" then
		love.graphics.setColor(125,125,125)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 50)
		love.graphics.setColor(255,255,255,255)
		love.graphics.print(editorState..": "..textbox, 10, 10)
	end

	--[[love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", love.graphics.getWidth()-100, 0, 100, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-100, love.graphics.getWidth(), 100)
	gui.draw()]]
end

textbox = ""
function love.keypressed(key, scancode, isrepeat)
	if not editorState then
		if key == "o" then --new object
			editorState = "newObject"
		elseif key == "f" then --place object
			editorState = "placeForeground"
		elseif key == "b" then
			editorState = "placeBackground"
		elseif key == "a" then --new area
			editorState = "newArea"
		end
	elseif key == "backspace" then
		textbox = string.sub(textbox, 1, string.len(textbox)-1)
	elseif key == "return" then
		if editorState == "newObject" then
			--bck.newObject(textbox, 
		elseif editorState == "placeObject" then
		
		elseif editorState == "newArea" then
		
		end
		editorState = false
		textbox = ""
	end
	--gui.keypressed(key, isrepeat)
end

function love.textinput(text)
	if type(editorState) == "string" then
		textbox = textbox..text
	end
end

function love.mousepressed(x, y, button)
	--gui.mousepressed(x, y, button)
end
