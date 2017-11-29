
-- no default texture
defineProperty("image")
defineProperty("position_x")
defineProperty("position_y")
defineProperty("width")
defineProperty("height")

function draw(self) 
    drawTexture(get(image), get(position_x), get(position_y), get(width), get(height)) 
end

