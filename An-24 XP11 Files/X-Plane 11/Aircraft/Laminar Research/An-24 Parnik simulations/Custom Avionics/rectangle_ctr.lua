
defineProperty("R", 0.5)
defineProperty("G", 0.5)
defineProperty("B", 0.5)
defineProperty("A", 0.5)
defineProperty("position_x", 0)
defineProperty("position_y", 0)
defineProperty("width", 100)
defineProperty("height", 100)
function draw(self)
    drawRectangle(get(position_x), get(position_y), get(width), get(height), get(R), get(G), get(B), get(A))
end

