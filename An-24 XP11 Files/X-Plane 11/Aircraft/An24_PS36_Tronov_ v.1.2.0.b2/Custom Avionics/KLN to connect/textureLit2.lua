-- draws texture independed of cockpit lighting system

-- no default texture
defineProperty("image")
defineProperty("brt2")


function draw(self) 
    drawTexture(get(image), 0, 0, 100, 100, get(brt2),get(brt2), get(brt2)) 
--      drawTexture(get(image), 0, 0, 100, 100, 1, 1, 1) 
end


