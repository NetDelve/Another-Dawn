local serpent = require 'serpent/serpent'
slw = {}

function slw.save(table, path)
	local file = io.open(love.filesystem.getSource().."/"..path, "w")
	file:write(serpent.block(table))
	file:close()
end

function slw.load(path)
	local file = io.open(love.filesystem.getSource().."/"..path, "r")
	if not file then
		return false
	else
		local ok, result = serpent.load(file:read("*a"))
		file:close()
		return ok, result
	end
end

return slw
