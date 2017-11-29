
-- no default texture
defineProperty("image")
defineProperty("position_x", 0)
defineProperty("position_y", 0)
defineProperty("width", 100)
defineProperty("height", 100)
function draw(self) 
    drawTexture(get(image), get(position_x), get(position_y), get(width), get(height)) 
end

