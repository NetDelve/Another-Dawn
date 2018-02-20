slw = {}

function slw.save(_player, _map, _config, _filename)
	if _player ~= nil then
		for i, v in ipairs _player do
			file = io.open(_filename)
			file:io.write(v)
			file:io.close()
		end
	else if _map ~= nil then
		for i, v in ipairs _map do
			file = io.open(_filename)
			file:io.write(v)
			file:io.close()
		end
	end
	end
end

function slw.load(_filename)
end


