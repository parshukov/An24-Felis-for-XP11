size = { 200, 200 }

-- needle image
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("longNeedleImage", loadImage("needles.dds", 86, 73, 18, 173))

-- caps
defineProperty("yellow_cap", loadImage("covers.dds", 140, 0, 56, 56)) -- black cap image
defineProperty("kg_cap", loadImage("covers.dds", 66, 0, 56, 56)) -- black cap image
defineProperty("term_cap", loadImage("covers.dds", 0, 0, 56, 56)) -- black cap image

-- fuel pressure
defineProperty("fuel_p", globalPropertyf("sim/cockpit2/engine/indicators/fuel_pressure_psi[0]"))

-- oil pressure
defineProperty("oil_p", globalPropertyf("sim/cockpit2/engine/indicators/oil_pressure_psi[0]"))

-- oil temperature
defineProperty("oil_t", globalPropertyf("sim/cockpit2/engine/indicators/oil_temperature_deg_C[0]"))

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

-- 1 pound/square inch = 0.07031 kilogram/square centimeter

-- local variables
local fuel_p_angle = -65
local oil_p_angle = 155
--local oil_t_angle = -155

function update()
	-- check power
	local power27 = 0
	local power115 = 0
	if get(bus_DC_27_volt) > 21 then power27 = 1 else power27 = 0 end
	if get(bus_AC_115_volt) > 110 then power115 = 1 else power115 = 0 end
	
	-- fuel and oil pressure angle
    if power27 * power115 > 0 then
		fuel_p_angle = get(fuel_p) * 0.07031 * 120 * 1.12 / 100 - 60
        oil_p_angle = -get(oil_p) * 0.07031 * 120 / 8 + 150
		-- set limit
		if fuel_p_angle > 120 then fuel_p_angle = 120 end  
		if oil_p_angle < 30 then oil_p_angle = 30 end
	else 
		fuel_p_angle = -65
		oil_p_angle = 155
	end
--[[	
	if power27 > 0 then
		oil_t_angle = get(oil_t) * 120 / 200 - 120
		-- set limits 
		if oil_t_angle > -30 then oil_t_angle = -30
		elseif oil_t_angle < -150 then oil_t_angle = -150
		end
	else
		oil_t_angle = -155
	end
--]]
	
end

-- emi3 consists of several components
components = {

   
    -- fuel pressure needle
    needle {
        position = { 24, 39, 150 , 150 },
        image = get(longNeedleImage),
        angle = function()
			return fuel_p_angle
        end   
    },

 
    -- oil pressure needle
    needle {
        position = { -13, 10, 106, 106 },
        image = get(needles_1),
        angle = function()
			return oil_p_angle
        end   
    }, 
--[[
    -- oil temperature needle
    needle {
        position = { 107, 10, 106, 106 },
        image = get(needles_1),
        angle = function()
			return oil_t_angle
        end   
    },   
--]]
	-- yellowk cap
	texture{
	    position = { 74, 90, 52, 52 },
        image = get(yellow_cap),
	}, 
	
	-- kg cap
	texture{
	    position = { 14, 36, 52, 52 },
        image = get(kg_cap),
	}, 
	
	-- term cap
	texture{
	    position = { 133, 36, 52, 52 },
        image = get(term_cap),
	}, 

}



