local gui = {}
local gui.elements = {}

function gui.newButton(_id, _text, _x, _y, _sX, _sY, _state)
	table.insert(gui.elements, {button, id = _id, text = _text, x = _x, y = _y, sX = _sX, sY = _sY, state = _state})
end

function gui.newTextbox(_id, _x, _y, _key)
	table.insert(gui.elements, {textbox, id=_id, x=_x, y=_y, key=_key})
end

function gui.newSlider(_id, _x, _y, _num)
	table.insert(gui.elements, {slider, id=_id, x=_x, y=_y, num=_num})
end

function gui.newMenu(_id)
	table.insert(gui.elements, {menu,id=_id})
end

function gui.newTextBox()

end

function gui.mousepressed(x, y, button)
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

function gui.keypressed(key, isrepeat)

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
