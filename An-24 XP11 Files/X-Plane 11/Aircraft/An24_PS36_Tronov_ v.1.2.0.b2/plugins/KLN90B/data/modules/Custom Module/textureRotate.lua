-- no default texture
defineProperty("image")
defineProperty("angle")
defineProperty("brt2")
local clr = get(brt2)

function draw(self)
    sasl.gl.drawRotatedTexture(get(image), get(angle), 0, 0, size[1], size[2], {clr ,clr ,clr})
end
