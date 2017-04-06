function findImage(_image, _type)
	if _type == "local" then
		for i,v in ipairs(mapHandler.mapImages) do
			if v.name == _image then
				return v.image
			end
		end
	else
		for i,v in ipairs(images) do
			if v.name == _image then
				return v.image
			end
		end
	end
end

return findImage
