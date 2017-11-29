size = {100, 100}

defineProperty("signal", globalPropertyf("sim/custom/xap/An24_ark/ark1_signal"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time


defineProperty("needleImg", loadImage("needles.dds", 226, 0, 118, 4))

local ndl_angle = -48
local last_angle = -48


-- postframe calculaions
function update()
local passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	
	local delta = (get(signal) * 70 - 48) - last_angle

    ndl_angle = ndl_angle + 3 * delta * passed

	last_angle = ndl_angle
end

end

components = {

	needle {
		position = {-9, -36, 118, 118},
		image = get(needleImg),
		angle = function()
			return ndl_angle + 90
		end
	},
--[[
	rectangle {
		position = {0, 49, 100, 2},
		color = {1,0,0,1},
	},
	
	rectangle {
		position = {49, 0, 2, 100},
		color = {1,0,0,1},
	},
--]]
}

