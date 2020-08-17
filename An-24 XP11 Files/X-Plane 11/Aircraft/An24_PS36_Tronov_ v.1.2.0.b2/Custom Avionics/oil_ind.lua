-- oil quantity indicator
size = {100, 200}

-- define property table
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) -- power on 27 volt bus
defineProperty("sim_oil_q1", globalPropertyf("sim/cockpit2/engine/indicators/oil_quantity_ratio[0]")) -- quantity ratio
defineProperty("sim_oil_q2", globalPropertyf("sim/cockpit2/engine/indicators/oil_quantity_ratio[1]")) -- quantity ratio

defineProperty("oil_lamp1", globalPropertyf("sim/custom/xap/An24_gauges/oil_lamp1")) -- low quantity lamp
defineProperty("oil_lamp2", globalPropertyf("sim/custom/xap/An24_gauges/oil_lamp2")) -- low quantity lamp

-- images
defineProperty("needles_2", loadImage("needles.dds", 18, 0, 13, 98)) 
defineProperty("needles_3", loadImage("needles.dds", 34, 0, 13, 98))

local left_angle = 150
local right_angle = -150


function update()
	
	if get(bus_DC_27_volt) > 21 then
		left_angle = -(get(sim_oil_q1) * 40 - 15) * 120 / 25 + 150
		right_angle = (get(sim_oil_q2) * 40 - 15) * 120 / 25 - 150
		if left_angle > 126 then set(oil_lamp1, 1) end
		if right_angle < -126 then set(oil_lamp2, 1) end
	else
		left_angle = 150
		right_angle = -150
		set(oil_lamp1, 0)
		set(oil_lamp2, 0)
	end
	
	if left_angle > 150 then left_angle = 150 end
	if right_angle < -150 then right_angle = -150 end

end


components = {

	-- left oil
	needle { 
		image = get(needles_2),
		position = {-70, 40, 120, 120},
		angle = function()
			return left_angle
		end,	
	},
	
	-- right oil
	needle { 
		image = get(needles_2),
		position = {50, 40, 120, 120},
		angle = function()
			return right_angle
		end,	
	},

}
