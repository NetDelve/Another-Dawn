local area = {}
table.insert(area, {x = 0, y = 0, sX = 50, sY = 50, sprite = findImage("grass"), scriptFile = nil}) --test object
table.insert(area, {x = 0, y = 150, sX = 50, sY = 50, sprite = findImage("stone", "local"), scriptFile = "map/testWorld/test/script"}) --test object with script
return area
