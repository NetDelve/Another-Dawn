gui = {}
gui.elements = {}

function gui.newButton(_id, _text, _x, _y, _sX, _sY, _key, _state)
	table.insert(gui.elements, {id = _id, text = _text, x = _x, y = _y, sX = _sX, sY = _sY, key = _key, state = _state})
end

function gui.mousePressed(x, y, button)
	for i,v in pairs(gui.elements) do
		if x >= v.x and x <= v.x+v.sX and y >= v.y and y <= v.y+v.sY then
			if v.state then
				v.state = false
			else
				v.state = true
			end
		end
	end
end

function gui.keyPressed(key, isRepeat)

end

function gui.draw()
	for i,v in pairs(gui.elements) do
		love.graphics.setColor(50,50,50)
		love.graphics.rectangle("fill", v.x, v.y, v.sX, v.sY)
		love.graphics.setColor(255,255,255)
		love.graphics.print(v.text, v.x + 10, v.y + 10)
	end
end

function gui.getState(id)
	return gui.elements[id].state
end

return gui
