bck = {}
bck.objects = {} --contains object definitions
bck.world = {} --contains area tables that contain objects

--Normal Game Stuff

function bck.loadWorld(file)
	bck.objects, bck.world = require(file)
	for i,v in ipairs(bck.objects) do
		if v.imageFile ~= false and v.imageFile ~= nil then
			v.image = love.graphics.newImage(v.imageFile) --load all object images
		end
	end
end

function bck.update(dt) --TODO multithread object scripts
	for i,area in pairs(bck.world) do
		for o,object in ipairs(area.foreground) do
			if bck.objects[object.type].script ~= nil then
				if not pcall(bck.objects[object.type].script(i,o)) then --run object script with error protection, i and o are to tell the script what object to run on
					--error
				end
			end
		end
	end
end

function bck.drawForeground(camX, camY, sX, sY)
	for i,area in pairs(bck.world) do
		for i,object in ipairs(area.foreground) do
			if (object.x+area.x)+object.sX >= camX and (object.x+area.x) <= sX+camX and (object.y+area.y)+object.sY >= camY and (object.y+area.y) <= sY+camY then
				love.graphics.setColor(255,255,255,255)
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, object.x+area.x, object.y+area.y)
				else
					love.graphics.rectangle("fill", object.x+area.x, object.y+area.y, bck.objects[object.type].sX, bck.objects[object.type].sY)	--missing image, draw some error thing
				end
			end
		end
	end
end

function bck.drawBackground(camX, camY, sX, sY)
	for i,area in pairs(bck.world) do
		for i,object in ipairs(area.background) do
			if (object.x+area.x)+object.sX >= camX and (object.x+area.x) <= sX+camX and (object.y+area.y)+object.sY >= camY and (object.y+area.y) <= sY+camY then
				love.graphics.setColor(255,255,255,255)				
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, object.x+area.x, object.y+area.y)
				else
					love.graphics.rectangle("fill", object.x+area.x, object.y+area.y, bck.objects[object.type].sX, bck.objects[object.type].sY)	--missing image, draw some error thing
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

function bck.newArea(id, _x, _y, _sX, _sY)
	bck.world[id] = {x = _x, y = _y, sX = _sX, sY = _sY, foreground = {}, background = {}}
end

function bck.placeForeground(area, _x, _y, _type)
	bck.world[area].foreground = {x = _x, y = _y, type = _type}
end

function bck.placeBackground(area, _x, _y, _type)
	bck.world[area].background = {x = _x, y = _y, type = _type}
end

return bck
