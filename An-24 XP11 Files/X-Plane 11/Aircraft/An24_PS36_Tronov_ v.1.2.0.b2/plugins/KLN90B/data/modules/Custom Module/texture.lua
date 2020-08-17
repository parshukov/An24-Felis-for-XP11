-- no default texture
defineProperty("image")

function draw(self)
    sasl.gl.drawTexture(get(image), 0, 0, size[1], size[2])
end
