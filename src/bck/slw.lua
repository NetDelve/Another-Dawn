local slw = {}

function slw.loaddata( filename )
--local tabledata = {}
slw.file = io.open(filename, "r")
--	for i, v in ipairs tabledata do
		slw.file:read()
--	end
slw.file:close()
end

function slw.savedata( tabledata , filename )
	slw.file = io.open( filename , "w" )
	for i, v in ipairs tabledata do
		if v == "one" then
			slw.file:write( "hit \n" )
		end
	end
	slw.file:close()
end

return slw
