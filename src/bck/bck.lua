bck = {}
bck.objects = {} --contains object definitions
bck.world = {} --contains area tables that contain objects

--Normal Game Stuff

function bck.loadWorld(file)
	bck.objects, bck.world = require(file)
	for i,v in ipairs(bck.objects) do
		if v.imageFile then
			v.image = love.graphics.newImage(v.imageFile)
		end
	end
end

function bck.update(dt) --TODO multithread object scripts
	for i,area in ipairs(bck.world) do
		for o,object in ipairs(area.foreground) do
			if bck.objects[object.type].script ~= nil then
				if not pcall(bck.objects[object.type].script(i,o) then --run object script with error protection, i and o are to tell the script what object to run on
					--error
				end
			end
		end
	end
end

function bck.drawForeground(camX, camY, sX, sY)
	for i,area in ipairs(bck.world) do
		for i,object in ipairs(area.foreground) do
			if object.x+object.sX >= camX and object.x <= sX+camX and object.y+object.sY >= camY and object.y <= sY+camY then
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, object.x, object.y)
				else
					--missing image, draw some error thing
				end
			end
		end
	end
end

function bck.drawBackground(camX, camY, sX, sY)
	for i,area in ipairs(bck.world) do
		for i,object in ipairs(area.background) do
			if object.x+object.sX >= camX and object.x <= sX+camX and object.y+object.sY >= camY and object.y <= sY+camY then
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, object.x, object.y)
				else
					--missing image, draw some error thing
				end
			end
		end
	end
end

function bck.drawToCanvas(camX, camY, sX, sY) --Viewport camera/offset, viewport size
	local canvas = love.graphics.newCanvas(sX, sY)
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		love.graphics.setBlendMode("alpha")
		bck.drawBackground(camX, camY, sX, sY)
		bck.drawForeground(camX, camY, sX, sY)
	love.graphics.setCanvas()
	return canvas
end

--Editor Stuff

function bck.newObject(type, _sX, _sY, _solid, _imageFile, _script)
	bck.objects[type] = {sX = _sX, sY = _sY, solid = _solid, imageFile = _imageFile, script = _script}
end

function bck.placeObject(area, _x, _y, _type)
	bck.world[area] = {x = _x, y = _y, sX = _sX, sY = _sY, type = _type}
end

return bck
