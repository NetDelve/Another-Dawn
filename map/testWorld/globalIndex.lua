--Index of all avalible areas
local mapIndex = {}
table.insert(mapIndex, require "/map/testWorld/test/index")

--Images for world
local mapImages = {}
mapImages.stone = love.graphics.newImage("/map/testWorld/images/ground_rock.png")

return mapIndex, mapImages
