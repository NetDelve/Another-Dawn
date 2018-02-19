suit = require 'suit'

config = {gridSize = {x = 50, y = 50}} --TODO make own file
editor = {viewport = {x = 0, y = 0, moveSpeed = 500}} --for editor only settings and variables

bck.newArea("test", 0, 0, 50, 50)
bck.newObject("test", 1, 1, false, false)
bck.placeForeground("test", 2, 2, "test")

local HudCan = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight()/4)
local rMenuCan = love.graphics.newCanvas()
local lMenuCan = love.graphics.newCanvas()
local popupMenuCan = love.graphics.newCanvas()

love.keyboard.setKeyRepeat(true)
local input = {text = ""}
local objSearchInput = {text = ""}
function love.update(dt)
	suit.layout:reset(10, 10) --left menu (edit object)
	suit.Input(input, suit.layout:row(80, 30))
	
	suit.layout:reset(love.graphics.getWidth()-190, 10) --right menu (place object)
	suit.Input(objSearchInput, suit.layout:row(180, 30))
	for i,v in pairs(bck.objects) do
		if string.find(i, objSearchInput.text) ~= nil then
			local hit = false
			if type(v.image) == "imagedata" then
				if suit.ImageButton(v.image, suit.layout:row()).hit then hit = true end
			else
				if suit.Button("No Image", suit.layout:row()).hit then hit = true end
			end
			suit.Label(tostring(i), {color = {normal={fg={0,0,0}}}}, suit.layout:row())
			if hit then --object was clicked, place into world
				
			end
		end
	end

	suit.layout:reset(10, 10) --top menu (menu)

	suit.layout:reset(10, love.graphics.getHeight()-10) --info (mouse x,y)

	if not suit.hasKeyboardFocus() then --perhaps fix this so wasd can be used
		if love.keyboard.isDown("up") then
			editor.viewport.y = editor.viewport.y + editor.viewport.moveSpeed*dt
		elseif love.keyboard.isDown("down") then
			editor.viewport.y = editor.viewport.y - editor.viewport.moveSpeed*dt
		end
		if love.keyboard.isDown("left") then
			editor.viewport.x = editor.viewport.x + editor.viewport.moveSpeed*dt
		elseif love.keyboard.isDown("right") then
			editor.viewport.x = editor.viewport.x - editor.viewport.moveSpeed*dt
		end
	end

	if enableScripts then --TODO menu toggle
		bck.update(dt)
	end
	frame = bck.drawToCanvas(editor.viewport.x, editor.viewport.y, love.graphics.getWidth()-100, love.graphics.getHeight()-100)
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 0, 0)
	love.graphics.setBlendMode("alpha")

	love.graphics.setColor(200,200,200)
	love.graphics.rectangle("fill", love.graphics.getWidth()-200, 0, 200, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-25, love.graphics.getWidth(), 25)
	suit.draw()
end

function love.keypressed(key, scancode, isrepeat)
	suit.keypressed(key)
end

function love.textinput(text)
	suit.textinput(text)
end
