game = {}

bck.objects = slw.load("map/objects")
bck.world = slw.load("map/world")
if not bck.objects or not bck.world then
	error("Map missing or corrupt")
end

function love.update(dt)

end

frame = love.graphics.newCanvas(1,1) --hack for menu
function love.draw()

end
