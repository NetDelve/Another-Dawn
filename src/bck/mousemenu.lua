gui = {}
gui.elements = {}

function gui.newButton(_id, _x, _y, _sX, _sY, _key)
	table.insert(gui.elements, {id = _id, x = _x, y = _y, sX = _sX, sY = _sY, key = _key
end

function gui.mousePressed(x, y, button)

end

function gui.keyPressed(key, isRepeat)

end

function gui.getStatus(id)
	
end

return gui
