-- scrollable tape

-- tape image
defineProperty("image")

-- size of visible area
defineProperty("window", { 1.0, 1.0 } )

-- amount to scroll horizontal
defineProperty("scrollX", 0)

-- amount to scroll vertically
defineProperty("scrollY", 0)

-- draw tape
function draw(self)
    local sz = get(window)
    drawTexturePart(get(image), 0, 0, 100, 100, 
        get(scrollX), get(scrollY), sz[1], sz[2]) 
end

