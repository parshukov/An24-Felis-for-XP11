-- draws texture independed of cockpit lighting system

-- no default texture
defineProperty("image")
defineProperty("brt2")

local img = get(image)
local clr = get(brt2)
local x,y=getTextureSize(img)
function draw(self)
    sasl.gl.drawTexture(img, 0, 0, x, y, {clr ,clr ,clr})
--      drawTexture(get(image), 0, 0, 100, 100, 1, 1, 1)
end


