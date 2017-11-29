-- draws texture independed of cockpit lighting system

-- no default texture
defineProperty("image")

function draw(self) 
    drawTexture(get(image), 0, 0, 100, 100, 1, 1, 1) 
end


