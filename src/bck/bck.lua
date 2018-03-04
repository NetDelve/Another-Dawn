bck = {}
bck.objects = {} --contains object definitions
bck.world = {} --contains area tables that contain objects

--Standard Functions

function bck.loadWorld(file)
	bck.objects, bck.world = require(file)
	for i,v in ipairs(bck.objects) do
		if v.imageFile ~= false and v.imageFile ~= nil then
			v.image = love.graphics.newImage(v.imageFile) --load all object images
		end
	end
end

local function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function bck.drawForeground(camX, camY, sX, sY)
	love.graphics.setColor(255,255,255,255)
	for i,area in pairs(bck.world) do
		local areaRealX = area.x*config.gridSize.x
		local areaRealY = area.y*config.gridSize.y
		local areaRealSX = area.sX*config.gridSize.x
		local areaRealSY = area.sY*config.gridSize.y
		if checkCollision(areaRealX, areaRealY, areaRealSX, areaRealSY, camX, camY, sX, sY) then
			for i,object in ipairs(area.foreground) do
				local objRealX = object.x*config.gridSize.x
				local objRealY = object.y*config.gridSize.y
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, camX+(objRealX+areaRealX), camY+(objRealY+areaRealY))
				else
					love.graphics.rectangle("fill", camX+(objRealX+areaRealX), camY+(objRealY+areaRealY), bck.objects[object.type].sX*config.gridSize.x, bck.objects[object.type].sY*config.gridSize.y)	--missing image, draw some error thing
				end
			end
		end
	end
end

function bck.drawBackground(camX, camY, sX, sY)
	love.graphics.setColor(255,255,255,255)
	for i,area in pairs(bck.world) do
		local areaRealX = area.x*config.gridSize.x
		local areaRealY = area.y*config.gridSize.y
		local areaRealSX = area.sX*config.gridSize.x
		local areaRealSY = area.sY*config.gridSize.y
		if checkCollision(areaRealX, areaRealY, areaRealSX, areaRealSY, camX, camY, sX, sY) then
			for i,object in ipairs(area.background) do
				local objRealX = object.x*config.gridSize.x
				local objRealY = object.y*config.gridSize.y
				if bck.objects[object.type].image ~= nil then
					love.graphics.draw(bck.objects[object.type].image, camX+(objRealX+areaRealX), camY+(objRealY+areaRealY))
				else
					love.graphics.rectangle("fill", camX+(objRealX+areaRealX), camY+(objRealY+areaRealY), bck.objects[object.type].sX*config.gridSize.x, bck.objects[object.type].sY*config.gridSize.y)	--missing image, draw some error thing
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

--Scripts/Processing

function bck.updateCollisionMap() --TODO

end

function bck.updatePositions(dt) --TODO for objects that are pushed

end

function bck.updateScripts(dt) --TODO multithread object scripts
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

--Editor/Debug

function bck.newObject(type, _sX, _sY, _solid, _imageFile, _script)
	bck.objects[type] = {sX = _sX, sY = _sY, solid = _solid, imageFile = _imageFile, script = _script}
end

function bck.newArea(id, _x, _y, _sX, _sY)
	bck.world[id] = {x = _x, y = _y, sX = _sX, sY = _sY, foreground = {}, background = {}}
end

function bck.placeForeground(area, _x, _y, _type)
	table.insert(bck.world[area].foreground, {x = _x, y = _y, type = _type})
	return table.maxn(bck.world[area].foreground)
end

function bck.placeBackground(area, _x, _y, _type)
	table.insert(bck.world[area].background, {x = _x, y = _y, type = _type})
	return table.maxn(bck.world[area].background)
end

function bck.findArea(x, y) --does not handle overlaping areas, although it probably should
	for i,v in pairs(bck.world) do
		if checkCollision(x, y, 0.1, 0.1, v.x, v.y, v.sX, v.sY) then
			return i
		end
	end
end

function bck.findObject(x, y, layer)
	local area = bck.findArea(x,y)
	if area ~= nil then
		if not layer or layer == "foreground" then
			for i,v in ipairs(bck.world[area].foreground) do
				if checkCollision(x, y, 0.1, 0.1, v.x+bck.world[area].x, v.y+bck.world[area].y, bck.objects[v.type].sX, bck.objects[v.type].sY) then
					return i, area, "foreground"
				end
			end
		end
		if not layer or layer == "background" then
			for i,v in ipairs(bck.world[area].background) do
				if checkCollision(x, y, 0.1, 0.1, v.x+bck.world[area].x, v.y+bck.world[area].y, bck.objects[v.type].sX, bck.objects[v.type].sY) then
					return i, area, "background"
				end
			end
		end
	end
end

function bck.transformToGrid(x, y)
	return math.floor(x/config.gridSize.x), math.floor(y/config.gridSize.y)
end

--QOL Functions (unsure if they will stay here)

function bck.round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

return bck
