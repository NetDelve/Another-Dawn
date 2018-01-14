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
		for o,object in ipairs(area) do
			if bck.objects[object.type].script ~= nil then
				if not pcall(bck.objects[object.type].script(i,o) then --run object script with error protection, i and o are to tell the script what object to run on
					--error
				end
			end
		end
	end
end

function bck.draw(camX, camY)
	for i,area in ipairs(bck.world) do
		for i,object in ipairs(area) do
			if object.x+object.sX >= camX and object.x <= love.graphics.getWidth()+camX and object.y+object.sY >= camY and object.y <= love.graphics.getHeight()+camY and bck.objects[object.type].image ~= nil then
				love.graphics.draw(bck.objects[object.type].image, object.x, object.y) --TODO add image scaling
			end
		end
	end
end

--Editor Stuff

function bck.newObject(type, _sX, _sY, _solid, _imageFile, _script)
	bck.objects[type] = {sX = _sX, sY = _sY, solid = _solid, imageFile = _imageFile, script = _script}
end

function bck.placeObject(area, _x, _y, _type)
	bck.world[area] = {x = _x, y = _y, sX = _sX, sY = _sY, type = _type}
end

return bck
