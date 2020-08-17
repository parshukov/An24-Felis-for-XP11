size = { 200, 200 }

-- initialize component property table
defineProperty("vvi", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_vvi_fpm"))


-- meters needle image
defineProperty("needleImage", loadImage("needles.dds", 86, 73, 18, 173))

local vvi_angle = -90
function update()
	local v = get(vvi) * 0.00508
	if 10 < v then
		v = 10
	elseif -10 > v then
		v = -10
	end
	vvi_angle = v * 18 - 90

end



components = {
--[[	rectangle {
		position = {99, 99, 2, 2},
		color = {1,0,0,1},
	},--]]

 -- vvi needle
	needle {
        position = { 10, 10, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return vvi_angle
        end
    }, 
}

