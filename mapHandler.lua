mapHandler = {}
mapHandler.map = {} --objects to be rendered are put here, recalculated every time a new area is loaded
mapHandler.globalIndex = require "map/globalIndex" --load array of all avalible areas
mapHandler.loadedAreas = {}

function mapHandler.loadAllSprites() --loads all images for all map areas, hopefully temporary until dynamic image loading is implimented
	
end

function mapHandler.recalculateCheck(x, y, sX, sY) --checks to see if there is a area that could be drawn/seen but isn't loaded
	drawableAreas = {}
	for i,v in ipairs(mapHandler.globalIndex) do
		if v.x >= x and (v.x+v.sX) <= x+sX and v.y >= y and (v.y+v.sY) <= x+sY then
			table.insert(drawableAreas, v)
		end
	end
	for i,v in ipairs(drawableAreas) do
		isInArray = false
		for o,b in ipairs(mapHandler.globalIndex) do
			if i == o then
				isInArray = true
				break
			end
		end
		if not isInArray then
			return true
			break
		end
	end
	return false
end

function mapHandler.recalculateAreas(x, y, sX, sY) --manages loaded areas based on player/camera position
	mapHandler.map = {}
	mapHandler.loadedAreas = {}
	for i,v in ipairs(mapHandler.globalIndex) do
		if v.x >= x and (v.x+v.sX) <= x+sX and v.y >= y and (v.y+v.sY) <= x+sY then
			table.insert(mapHandler.loadedAreas, v)
		end
	end
	for i,v in ipairs(mapHandler.loadedAreas) do
end

return mapHandler
