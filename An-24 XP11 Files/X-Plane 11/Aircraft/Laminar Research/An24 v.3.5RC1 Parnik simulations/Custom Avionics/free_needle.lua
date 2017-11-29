
-- property table
defineProperty("angle", 0)
defineProperty("position_x")
defineProperty("position_y")
defineProperty("width")
defineProperty("height")

-- no image
defineProperty("image")

function draw(self)
    local w, h = getTextureSize(get(image))
    
    local max = w
    if h > max then
        max = h
    end

    local rw = (w / max) * 100
    local rh = (h / max) * 100
    drawRotatedTexture(get(image), get(angle), 
        get(position_x), get(position_y), get(width), get(height))
end

