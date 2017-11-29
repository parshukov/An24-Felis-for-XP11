-- torque indicator
size = {200, 200}

-- define property table
defineProperty("torq", globalPropertyf("sim/cockpit2/engine/indicators/torque_n_mtr[0]"))
defineProperty("ikm") -- flight time

-- images
defineProperty("needleImage", loadImage("needles.dds", 1, 0, 16, 88)) 
defineProperty("black_cap", loadImage("covers.dds", 344, 0, 56, 92)) -- black cap image
-- power
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time


-- take-off pressure must be 92, it's equals 1312 NM

local angle = -120

local last_angle = -120
local actual_angle = -120

function update()
	local v = get(torq) * (92 / 1300)
	if v < 20 and v > 8 then v = v + math.random(-10, 10)
	elseif v < 8 then v = 0 end
	

	
	if get(bus_AC_115_volt) > 110 then
		angle = v * 240 / 100 - 120
		set(ikm, v)
	else
		angle = -120
		set(ikm, 0)
	end
	-- set limits
	if angle < -130 then angle = -130
	elseif angle > 130 then angle = 130 end

	local delta = angle - last_angle
	local passed = get(frame_time)
	
    actual_angle = actual_angle + 1.5 * delta * passed	
	last_angle = actual_angle
	
end

components = {
	-- torque needle
	needle {
        position = { 10, 10, 180 , 180 },
        image = get(needleImage),
        angle = function()
			return actual_angle
        end   
    },
	
	-- black cap
	texture{
	    position = { 62, 4, 83, 135 },
        image = get(black_cap),
	},
	
}