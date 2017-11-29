
-- no default texture
defineProperty("image")
defineProperty("positionX")
defineProperty("positionY")
defineProperty("width")
defineProperty("height")

function draw(self) 
    drawTexture(get(image), get(positionX), get(positionY), get(width), get(height)) 
end

