
defineProperty("color", { 0.15, 0.15, 0.15})
defineProperty("brt2")

function draw(self)
    local c = get(color)
    sasl.gl.drawRectangle(0, 0, size[1], size[2], c[1], c[2], c[3], get(brt2))
end

