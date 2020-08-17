
-- default angle
defineProperty("angle", 0)

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
        (100 - rw) / 2, (100 - rh) / 2, rw, rh)
end

