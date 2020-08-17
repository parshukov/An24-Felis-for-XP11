size = {200, 200}

-- define property table
defineProperty("adf1", globalPropertyf("sim/custom/xap/An24_ark/ark1_angle")) -- bearing to NDB
defineProperty("adf2", globalPropertyf("sim/custom/xap/An24_ark/ark2_angle"))

--defineProperty("vor1", globalPropertyf("sim/custom/xap/An24_gauges/vor_1")) -- bearing to VOR
--defineProperty("vor2", globalPropertyf("sim/custom/xap/An24_gauges/vor_2")) -- bearing to VOR

--defineProperty("ark_vor", globalPropertyf("sim/custom/xap/An24_gauges/ark_vor")) -- switcher ARK/VOR

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- images
defineProperty("needle1", loadImage("needles.dds", 403, 71, 28, 177))
defineProperty("needle2", loadImage("needles.dds", 433, 71, 28, 177))

--defineProperty("adf1_test", globalPropertyf("sim/cockpit2/radios/indicators/adf1_relative_bearing_deg"))

local angle1 = 0
local angle2 = 0
local last_angle1 = 0
local last_angle2 = 0

function update()
	-- time calculations
passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	
	--local switch = get(ark_vor)
	
	-- needle 1 smooth
	local v1 = get(adf1)
	--if switch == 0 then v1 = get(adf1) else v1 = get(vor1) end
   	
   	local delta1 = v1 - last_angle1
    if delta1 > 180 then delta1 = delta1 - 360
    elseif delta1 < -180 then delta1 = delta1 + 360 end
    angle1 = angle1 + 2 * delta1 * passed
    if angle1 > 180 then angle1 = angle1 - 360
    elseif angle1 < -180 then angle1 = angle1 + 360 end
	
	-- needle 2 smooth
	local v2 = get(adf2)
	--if switch == 0 then v2 = get(adf2) else v2 = get(vor2) end
    
	local delta2 = v2 - last_angle2
    if delta2 > 180 then delta2 = delta2 - 360
    elseif delta2 < -180 then delta2 = delta2 + 360 end
    angle2 = angle2 + 2 * delta2 * passed
    if angle2 > 180 then angle2 = angle2 - 360
    elseif angle2 < -180 then angle2 = angle2 + 360 end	

end
	last_angle1 = angle1
	last_angle2 = angle2
end



components = {



	-- needle 1
	needle {
		position = {5, 5, 190, 190},
		image = get(needle1),
		angle = function()
			return angle1 
		end
	},
	
	-- needle 2
	needle {
		position = {5, 5, 190, 190},
		image = get(needle2),
		angle = function()
			return angle2 
		end
	},

--[[	rectangle {
		position = {99, 99, 2, 2},
		color = {1,0,0,1},
	}, --]]


}


