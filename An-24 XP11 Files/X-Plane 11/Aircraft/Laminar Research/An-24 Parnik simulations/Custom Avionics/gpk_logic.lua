size = {400, 400}

-- define property table
-- source
defineProperty("gyro", globalPropertyf("sim/custom/xap/An24_gauges/gyro2_curse")) -- source gyro
defineProperty("correct", globalPropertyf("sim/custom/xap/An24_gauges/GPK_corr")) -- correction on GPK panel
defineProperty("correct_ap", globalPropertyf("sim/custom/xap/An24_gauges/ap_GPK_corr")) -- correction on GPK panel
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

defineProperty("SC_master", globalPropertyi("scp/api/ismaster")) -- status of SmartCopilot
defineProperty("sc_curse_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_curse_angle")) -- SmartCopilot
defineProperty("sc_ap_curse_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_ap_curse_angle")) -- SmartCopilot

-- result
defineProperty("GPK_curse", globalPropertyf("sim/custom/xap/An24_gauges/GPK_curse"))  -- gyro curse from GPK
defineProperty("ap_GPK_curse", globalPropertyf("sim/custom/xap/An24_ap/curse_gpk"))  -- gyro curse from GPK for autopilot
-- images
defineProperty("scale", loadImage("scales_1.png", 1, 1, 341, 341))
defineProperty("scale_triangle", loadImage("kppm.dds", 30, 223, 13, 23))


-- local variables
local angle = get(gyro) -- result angle
local curse_angle = 0
local ap_curse_angle = 0
-- postframe calculaions
function update()
	-- time calculations
	local passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	
	-- calculate new angle with smooth move
	
	if get(SC_master) == 1 then
		curse_angle = get(sc_curse_angle)
	else
		local v = get(gyro) + get(correct)
		local delta = v - curse_angle
		if delta > 180 then delta = delta - 360
		elseif delta < -180 then delta = delta + 360 end
		curse_angle = curse_angle + 10 * delta * passed
		if curse_angle > 180 then curse_angle = curse_angle - 360
		elseif curse_angle < -180 then curse_angle = curse_angle + 360 end
		
		set(sc_curse_angle,curse_angle)
	end
	
	-- calculate new angle with smooth move for autopilot
	if get(SC_master) == 1 then
		ap_curse_angle = get(sc_ap_curse_angle)
	else
		local w = get(gyro) + get(correct_ap)
		local ap_delta = w - ap_curse_angle
		if ap_delta > 180 then ap_delta = ap_delta - 360
		elseif ap_delta < -180 then ap_delta = ap_delta + 360 end
		ap_curse_angle = ap_curse_angle + 10 * ap_delta * passed
		if ap_curse_angle > 180 then ap_curse_angle = ap_curse_angle - 360
		elseif ap_curse_angle < -180 then ap_curse_angle = ap_curse_angle + 360 end
		
		set(sc_ap_curse_angle,ap_curse_angle)
	end
	-- set result for other gauges and AP
	set(GPK_curse, curse_angle)
	set(ap_GPK_curse, ap_curse_angle)
	
	--print(get(correct), get(gyro), curse_angle)
	
end	


end

components = {


	-- scale
	needle {
		position = {34, 35, 340, 340},
		image = get(scale),
		angle = function()
			return -curse_angle
		end,
	
	},

	-- position triangle
	texture {
		position = {196, 368, 16, 18},
		image = get(scale_triangle),
	
	},


}
