size = { 200, 200 }

-- initialize component property table
defineProperty("N1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))   
defineProperty("N2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))

defineProperty("uprt_cc", globalPropertyf("sim/custom/xap/An24_gauges/uprt_cc"))

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec"))  -- local time since aircraft was loaded 

-- background image
-- defineProperty("background", loadImage("ite2.dds", 0, 0, 155, 155))
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

-- needle image
defineProperty("needle_N1", loadImage("needles.dds", 145, 78, 19, 163)) 
defineProperty("needle_N2", loadImage("needles.dds", 168, 78, 19, 163))



-- local variables
local left_angle = -150
local right_angle = -150
local left_angle_last = -150
local right_angle_last = -150
local left_angle_actual = -150
local right_angle_actual = -150


-- post frame calculations
function update()
	-- check power
	if get(bus_DC_27_volt) > 21 then
		left_angle = get(N1) * 257 - 150
		right_angle = get(N2) * 257 - 150
		set(uprt_cc, 8)
	else
		left_angle = -150
		right_angle = -150
		set(uprt_cc, 0)
	end
	

	local passed = get(frame_time)
if  passed > 0 then
	-- set smooth move
	left_angle_actual = left_angle_last + (left_angle - left_angle_last) * passed * 10
	right_angle_actual = right_angle_last + (right_angle - right_angle_last) * passed * 10
end
	-- last variables
	left_angle_last = left_angle_actual
	right_angle_last = right_angle_actual
	

	
end


components = {
 
 -- right needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_N2),
        angle = function() 
            return right_angle_actual
        end
    }, 

    -- left needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_N1),
        angle = function() 
            return left_angle_actual
        end
    },     

	-- black cap
	texture{
	    position = { 79, 78, 44, 44 },
        image = get(black_cap),
	},
	
   -- positioning gauge
  --[[ rectangle {
   		position = {99, 99, 2, 2},
   		color = {1,0,0,1},
   }, --]]

}

