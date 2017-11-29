-- draw texture

-- no default texture
defineProperty("image")

function draw(self) 
    drawTexture(get(image), 0, 0, 100, 100) 
end

