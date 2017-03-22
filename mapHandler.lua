mapHandler = {}

function mapHandler.loadWorld(indexFile) --loads new world
	mapHandler.map = {} --objects to be rendered are put here, recalculated every time a new area is loaded
	mapHandler.globalIndex = require(indexFile) --load array of all avalible areas
	mapHandler.loadedAreas = {}
	--mapHandler.loadAllImages() functionality to be collapsed into here
end

function mapHandler.loadArea(id) --loads area, but if called manually will get overwriten by recalculateAreas() if area isn't on screen
	for i,v in ipairs(mapHandler.globalIndex) do
		if v.id == id then
			local insertTable = require(v.areaFile)
			for i,v in ipairs(insertTable) do
				if v.scriptFile ~= nil then
					v.script = require(v.scriptFile)
				end
				table.insert(mapHandler.map, v)
			end
			return true
		end
	end
	return false
end

function mapHandler.recalculateCheck(x, y, sX, sY) --checks to see if there is a area that could be drawn/seen but isn't loaded
	drawableAreas = {}
	for i,v in ipairs(mapHandler.globalIndex) do
		if v.x >= x and (v.x+v.sX) <= x+sX and v.y >= y and (v.y+v.sY) <= x+sY then
			table.insert(drawableAreas, i)
		end
	end
	for i,v in ipairs(drawableAreas) do
		isInArray = false
		for o,b in ipairs(mapHandler.loadedAreas) do
			if i == o then
				isInArray = true
			end
		end
		if not isInArray then
			return true
		end
	end
	return false
end

function mapHandler.recalculateAreas(x, y, sX, sY) --manages loaded areas based on player/camera position
	mapHandler.map = {}
	mapHandler.loadedAreas = {}
	for i,v in ipairs(mapHandler.globalIndex) do
		if v.x >= x and (v.x+v.sX) <= x+sX and v.y >= y and (v.y+v.sY) <= x+sY then
			table.insert(mapHandler.loadedAreas, i)
		end
	end
	for i,v in ipairs(mapHandler.loadedAreas) do
		mapHandler.loadArea(mapHandler.globalIndex[v].id)
	end
end

function mapHandler.runObjectScripts() --run all loaded object scripts
	for i,v in ipairs(mapHandler.map) do
		if v.script ~= nil then
			v = v.script(v)
		end
	end
end

return mapHandler
