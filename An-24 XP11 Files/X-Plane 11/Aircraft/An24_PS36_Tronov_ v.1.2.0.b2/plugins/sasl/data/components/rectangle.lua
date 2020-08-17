
defineProperty("color", { 0.15, 0.15, 0.15, 1.0 })

function draw(self)
    local c = get(color)
    drawRectangle(0, 0, 100, 100, c[1], c[2], c[3], c[4])
end

