require "mapHandler"
require "input"
require "findImage"

input.addKeyToggle("showAreaLines", "f2")

mapHandler.loadWorld("map/testWorld/globalIndex", "map/testWorld/globalImages")
require "map/testWorld/globalScript"

cam = {x = 0, y = 0, moveSpeed = 500}
local objectSearch = {text = "", submitted = false}
searchTable = {}
function love.update(dt)
	if not suit.hasKeyboardFocus(objectSearch) then
		if love.keyboard.isDown("w") then --would probably be a good idea to add a "inputconf.lua" file at some point
			cam.y = cam.y - dt*cam.moveSpeed
		elseif love.keyboard.isDown("s") then
			cam.y = cam.y + dt*cam.moveSpeed
		end
		if love.keyboard.isDown("a") then
			cam.x = cam.x - dt*cam.moveSpeed
		elseif love.keyboard.isDown("d") then
			cam.x = cam.x + dt*cam.moveSpeed
		end
	end

	if mapHandler.recalculateCheck(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y) then
		mapHandler.recalculateAreas(cam.x, cam.y, love.graphics.getWidth()-cam.x, love.graphics.getHeight()-cam.y)
	end
	mapHandler.runObjectScripts()
	suit.Input(objectSearch, love.graphics.getWidth() - 195, 10, 190, 30)
	searchTable = {}
	for i,v in ipairs(images) do
		if string.find("global."..v.name, objectSearch.text) ~= nil then
			table.insert(searchTable, {name = v.name, object = i, global = true})
		end
	end
	for i,v in ipairs(mapHandler.mapImages) do
		if string.find("map."..v.name, objectSearch.text) ~= nil then
			table.insert(searchTable, {name = v.name, object = i, global = false})
		end
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	for i,v in ipairs(mapHandler.map) do
		if not v.sprite then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill", v.x-cam.x, v.y-cam.y, v.sX, v.sY)
		else
			love.graphics.draw(v.sprite, v.x-cam.x, v.y-cam.y)
		end
	end
	love.graphics.setColor(255,255,255)
	if input.getKeyToggle("showAreaLines") then
		for i,v in ipairs(mapHandler.globalIndex) do
			love.graphics.rectangle("line", v.x-cam.x, v.y-cam.y, v.sX, v.sY)
		end
	end
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", love.graphics.getWidth() - 200, 0, 200, love.graphics.getHeight())
	love.graphics.setColor(255,255,255)
	suit.draw()
	_pos = 100
	for i,v in ipairs(searchTable) do
		if v.global then
			_name = "global."..v.name
		else
			_name = "map."..v.name
		end
		love.graphics.print(_name, love.graphics.getWidth()-195, _pos)
		_pos = _pos + 25
	end
end

function love.textinput(t)
    suit.textinput(t)
end

function love.keypressed(key, scancode, isRepeat)
    suit.keypressed(key)
	input.keypressed(key)
end
