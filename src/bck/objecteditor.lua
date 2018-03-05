ok, bck.objects = slw.load("map/objects")
if not ok then error("Bad Object File: "..bck.objects) end

bck.loadImages()

local selectedObj = next(bck.objects)
local objSearchInput = {text = ""}
local objName = {text = selectedObj}
function love.update(dt)
	suit.layout:reset(10, 5) --top menu (menu)
	if suit.Button("Load", suit.layout:col(60, 15)).hit then
		ok, bck.objects = slw.load("map/objects")
		if not ok then error("Bad Object File: "..bck.objects) end
		bck.loadImages()
	end
	if suit.Button("Save", suit.layout:col()).hit then
		slw.save(bck.objects, "map/objects")
	end
	suit.layout:reset(love.graphics.getWidth()-190, 10)
	suit.Input(objSearchInput, suit.layout:row(180, 50))
	for i,v in pairs(bck.objects) do
		if string.find(i, objSearchInput.text) ~= nil then
			local hit = false
			if type(v.image) == "userdata" then
				if suit.ImageButton(v.image, suit.layout:row()).hit then hit = true end
			else
				if suit.Button(i, suit.layout:row()).hit then hit = true end
			end
			suit.Label(tostring(i), suit.layout:row())
			if hit then
				selectedObj = i
				objName.text = i
			end
		end
	end
	suit.layout:reset(10, 50)
	suit.Label("Object Name", suit.layout:row(300, 25))
	if suit.Input(objName, suit.layout:row()).submitted then
		bck.objects[objName.text] = bck.objects[selectedObj]
		selectedObj = objName.text
		bck.objects[objName.text] = nil
	end
	local inputs = {}
	for i,v in pairs(bck.objects[selectedObj]) do --TODO This bit is completely broken and needs to be rewritten
		if type(v) == "boolean" then
			table.insert(inputs, {checked = v, text = i})
			suit.Checkbox(inputs[table.maxn(inputs)], suit.layout:row())
			v = inputs[table.maxn(inputs)].checked
		elseif type(v) == "string" then
			suit.Label(i, suit.layout:row())
			table.insert(inputs, {text = v})
			suit.Input(inputs[table.maxn(inputs)], suit.layout:row())
			v = inputs[table.maxn(inputs)].text
		end
	end
end
