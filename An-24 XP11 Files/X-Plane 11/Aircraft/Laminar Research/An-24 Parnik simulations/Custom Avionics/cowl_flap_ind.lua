-- indicator for cowl flaps position
size = {200, 200}

-- define property table
-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))

-- source
defineProperty("flap1", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[0]"))
defineProperty("flap2", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[1]"))

-- images
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 

local left_angle = -45
local right_angle = -45

function update()

	if get(bus_DC_27_volt) > 21 then
		left_angle = get(flap1) * 90 - 45
		right_angle = get(flap2) * 90 - 45
	end

end





components = {

	-- left flap indicator
	needle { 
		image = get(needles_1),
		position = {16, 18, 65, 65},
		angle = function()
			return left_angle
		end,	
	},

	-- right flap indicator
	needle { 
		image = get(needles_1),
		position = {113, 18, 65, 65},
		angle = function()
			return right_angle
		end,	
	},



}


