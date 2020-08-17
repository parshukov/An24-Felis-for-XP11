-- this is the simple logic of gyro-inductive compas
size = {2048, 2048}
-- define property table
-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("GIK_sw", globalPropertyi("sim/custom/xap/An24_gauges/GIK_sw")) 

-- control
defineProperty("GIK_button", globalPropertyi("sim/custom/xap/An24_gauges/GIK_button")) 
defineProperty("GIK_curse", globalPropertyf("sim/custom/xap/An24_gauges/GIK_curse"))
defineProperty("ap_GIK_curse", globalPropertyf("sim/custom/xap/An24_ap/curse_gik"))

-- sources
defineProperty("gyro", globalPropertyf("sim/custom/xap/An24_gauges/gyro_curse"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("real_mag_curse", globalPropertyf("sim/flightmodel/position/magpsi"))
defineProperty("turn", globalPropertyf("sim/flightmodel/misc/turnrate_roll")) -- turn rate deg/sec. must be used with some coef.

defineProperty("SC_master", globalPropertyi("scp/api/ismaster")) -- status of SmartCopilot
defineProperty("sc_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_angle")) -- SmartCopilot
defineProperty("sc_ap_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_ap_angle")) -- SmartCopilot

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

-- GIK button
button_command = findCommand("sim/autopilot/heading")
function button_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(GIK_button, 1)
    else set(GIK_button, 0)
    end
return 0
end
registerCommandHandler(button_command, 0, button_handler)


local time_counter = 0
local not_loaded = true



-- local variables
local gyro_angle = 0 -- angle taken from gyro
local angle_correct = 0 -- correction for angle to make it closer to real mag curse
local angle = get(gyro) -- result angle
local ap_angle_correct = get(real_mag_curse) - get(gyro)
-- post-frame calculations

function update()
	local passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	
	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(GIK_sw, 0)
		not_loaded = false
	end

	-- check power
	local power = get(bus_DC_27_volt) > 21 and get(bus_AC_115_volt) > 110 and get(GIK_sw) == 1
	-- set new gyro angle from gyro
	if power then gyro_angle = get(gyro) end
	-- sync compas
	local mag_curse = get(real_mag_curse)
	if mag_curse > 180 then mag_curse = mag_curse - 360 
	elseif mag_curse < -180 then mag_curse = mag_curse + 360 end
	--local button = get(GIK_button)
	if power and math.abs(angle - mag_curse) > 1 then
			if mag_curse - angle > 180 then
				angle_correct = angle_correct - 9 * passed * (get(GIK_button) + 0.007)
			elseif mag_curse - angle > 0.01 then
				angle_correct = angle_correct + 9 * passed * (get(GIK_button) + 0.007)
			elseif mag_curse - angle < -180 then
				angle_correct = angle_correct + 9 * passed * (get(GIK_button) + 0.007)
			elseif mag_curse - angle < -0.01 then
				angle_correct = angle_correct - 9 * passed * (get(GIK_button) + 0.007)
			end
		
		if angle_correct > 180 then angle_correct = angle_correct - 360
		elseif angle_correct < -180 then angle_correct = angle_correct + 360 end
	end

	-- set new angle according to drift
	if get(SC_master) == 1 then
		angle = get(sc_angle)
	else
		local v = gyro_angle + angle_correct     
		local delta = v - angle
		if delta > 180 then delta = delta - 360
		elseif delta < -180 then delta = delta + 360 end
		angle = angle + 20 * delta * passed
		if angle > 180 then angle = angle - 360
		elseif angle < -180 then angle = angle + 360 end
		set(sc_angle,angle)
	end
    

    
    -- angle correct for autopilot
	local ap_angle = get(gyro) + ap_angle_correct
	if get(SC_master) == 1 then
		ap_angle = get(sc_ap_angle)
	else
		if power and math.abs(ap_angle - mag_curse) > 1 then
			if mag_curse - ap_angle > 180 then
				ap_angle_correct = ap_angle_correct - 9 * passed * 0.007
			elseif mag_curse - ap_angle > 0.01 then
				ap_angle_correct = ap_angle_correct + 9 * passed * 0.007
			elseif mag_curse - ap_angle < -180 then
				ap_angle_correct = ap_angle_correct + 9 * passed * 0.007
			elseif mag_curse - ap_angle < -0.01 then
				ap_angle_correct = ap_angle_correct - 9 * passed * 0.007
			end
		
			if ap_angle_correct > 180 then ap_angle_correct = ap_angle_correct - 360
			elseif ap_angle_correct < -180 then ap_angle_correct = ap_angle_correct + 360 end
		end	
		set(sc_ap_angle,ap_angle)
	end
	
	


	-- set result
	set(GIK_curse, angle)
	set(ap_GIK_curse, ap_angle)

end	


end

