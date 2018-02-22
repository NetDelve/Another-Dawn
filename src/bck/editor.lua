suit = require 'suit'

config = {gridSize = {x = 50, y = 50}} --TODO make own file
editor = {} --for editor only settings and variables
editor.viewport = {x = 0, y = 0, moveSpeed = 500}
editor.selected = {area = "test", object = 0, layer = "", objectType = "test", tool = "select"}
editor.view = {areaBoundries = true}
editor.colorBreathing = {value=0, dir = true, speed = 255}

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
	suit.layout:reset(10, 35) --left menu (edit object)
	suit.Input(input, suit.layout:row(180, 30))
	
	suit.layout:reset(love.graphics.getWidth()-190, 35) --right menu (place object)
	suit.Label("Mouse Tool", {color = {normal={fg={0,0,0}}}}, suit.layout:row(180, 30))
	if suit.Button("Select", suit.layout:row(60, 30)).hit then
		editor.selected.tool = "select"
	end
	if suit.Button("Place", suit.layout:col()).hit then
		editor.selected.tool = "place"
	end
	if suit.Button("Remove", suit.layout:col()).hit then
		editor.selected.tool = "remove"
	end
	suit.layout:reset(love.graphics.getWidth()-190, 100)
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
			if hit then
				objectType = i
			end
		end
	end

	suit.layout:reset(10, 10) --top menu (menu)

	suit.layout:reset(10, love.graphics.getHeight()-15) --bottom menu (general info)
	local x, y = bck.transformToGrid(love.mouse.getX()-200-editor.viewport.x, love.mouse.getY()-25-editor.viewport.y)
	suit.Label("Mouse: "..x..","..y, {color = {normal={fg={0,0,0}}}, align = "left"}, suit.layout:col(200,10))

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
	frame = bck.drawToCanvas(editor.viewport.x, editor.viewport.y, love.graphics.getWidth()-400, love.graphics.getHeight()-50)

	if editor.colorBreathing.dir then
		editor.colorBreathing.value = editor.colorBreathing.value + editor.colorBreathing.speed*dt
	else
		editor.colorBreathing.value = editor.colorBreathing.value - editor.colorBreathing.speed*dt
	end
	if editor.colorBreathing.value >= 255 then
		editor.colorBreathing.dir = false
	elseif editor.colorBreathing.value <= 0 then
		editor.colorBreathing.dir = true
	end
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode("alpha", "premultiplied")
	love.graphics.draw(frame, 200, 25)
	love.graphics.setBlendMode("alpha")
	if editor.view.areaBoundries then
		love.graphics.setColor(editor.colorBreathing.value, 0, 0)
		love.graphics.rectangle("line", editor.viewport.x+(bck.world[editor.selected.area].x*config.gridSize.x), editor.viewport.y+(bck.world[editor.selected.area].y*config.gridSize.y), bck.world[editor.selected.area].sX*config.gridSize.x, bck.world[editor.selected.area].sY*config.gridSize.y)
	end
	love.graphics.setColor(0,0,editor.colorBreathing.value)
	if editor.selected.layer == "foreground" then
		local x = editor.viewport.x+200+(bck.world[editor.selected.area].x+bck.world[editor.selected.area].foreground[editor.selected.object].x)*config.gridSize.x
		local y = editor.viewport.y+25+(bck.world[editor.selected.area].y+bck.world[editor.selected.area].foreground[editor.selected.object].y)*config.gridSize.y
		local sX = bck.objects[bck.world[editor.selected.area].foreground[editor.selected.object].type].sX*config.gridSize.x
		local sY = bck.objects[bck.world[editor.selected.area].foreground[editor.selected.object].type].sY*config.gridSize.y
		love.graphics.rectangle("line", x, y, sX, sY)
	elseif editor.selected.layer == "background" then

	end

	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 25)
	love.graphics.rectangle("fill", 0, 0, 200, love.graphics.getHeight())
	love.graphics.rectangle("fill", love.graphics.getWidth()-200, 0, 200, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-25, love.graphics.getWidth(), 25)
	suit.draw()
end

function love.mousepressed(x, y, button, istouch)
	if x > 200 and x < love.graphics.getWidth()-200 and y > 25 and y < love.graphics.getHeight()-25	then
		local gridX, gridY = bck.transformToGrid(x-200-editor.viewport.x, y-25-editor.viewport.y)
		if editor.selected.tool == "select" then
			local object, area, layer = 0, "", ""
			if button == 1 then
				object, area, layer = bck.findObject(gridX, gridY, "foreground")
			elseif button == 2 then
				object, area, layer = bck.findObject(gridX, gridY, "background")
			end
			if object ~= nil then
				editor.selected.area = area
				editor.selected.object = object
				editor.selected.layer = layer
			end
		elseif editor.selected.tool == "place" then
			if button == 1 then
				bck.placeForeground(editor.selected.area, gridX, gridY, editor.selected.objectType)
			elseif button == 2 then
				bck.placeBackground(editor.selected.area, gridX, gridY, editor.selected.objectType)
			end
		elseif editor.selected.tool == "remove" then
			
		end
	end
end

function love.keypressed(key, scancode, isrepeat)
	suit.keypressed(key)
end

function love.textinput(text)
	suit.textinput(text)
end
