-- this is logic of whole autopilot AP28 for An24.

-- property table
-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt. maybe in feet, maybe in meters.
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  -- pressire at sea level in.Hg

-- sources
defineProperty("trim", globalPropertyf("sim/cockpit2/controls/elevator_trim"))
defineProperty("indicated_roll", globalPropertyf("sim/custom/xap/An24_ap/indicated_roll"))  -- roll from AHZ
defineProperty("indicated_pitch", globalPropertyf("sim/custom/xap/An24_ap/indicated_pitch"))  -- pitch from AHZ
defineProperty("curse_gik", globalPropertyf("sim/custom/xap/An24_ap/curse_gik"))  -- curse diff from GIK gauge
defineProperty("curse_gpk", globalPropertyf("sim/custom/xap/An24_ap/curse_gpk"))  -- curse diff from GPK gauge
defineProperty("curse_zk", globalPropertyf("sim/custom/xap/An24_ap/curse_zk"))  -- curse diff from ZK2 gauge
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt"))
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt"))
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))
defineProperty("vvi", globalPropertyf("sim/flightmodel/position/vh_ind_fpm"))
defineProperty("slip", globalPropertyf("sim/cockpit2/gauges/indicators/slip_deg"))
-- defineProperty("pitch_force", globalPropertyf("sim/joystick/yoke_pitch_ratio"))
defineProperty("pitch_force", globalPropertyf("sim/custom/xap/An24_ap/ap_pitch_comm"))
defineProperty("ap_power_cc", globalPropertyf("sim/custom/xap/An24_ap/ap_power_cc"))
defineProperty("sim_ap_mode", globalPropertyi("sim/cockpit/autopilot/autopilot_mode"))
-- switchers
defineProperty("ap_power", globalPropertyi("sim/custom/xap/An24_ap/ap_power"))  -- power of AP
defineProperty("ap_trim", globalPropertyi("sim/custom/xap/An24_ap/ap_trim"))  -- use trimmer of AP
defineProperty("ap_ON", globalPropertyi("sim/custom/xap/An24_ap/ap_ON"))  -- main button for engage AP
defineProperty("ap_kv", globalPropertyi("sim/custom/xap/An24_ap/ap_kv"))  -- button for altitude hold
defineProperty("ap_horizont", globalPropertyi("sim/custom/xap/An24_ap/ap_horizont"))  -- button to set horizontal position of plane
defineProperty("ap_curse_stab", globalPropertyi("sim/custom/xap/An24_ap/ap_curse_stab"))  -- switcher for curse stab. turn/GPK/GIK
defineProperty("ap_pitch", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch"))  -- pitch control UP and DOWN
defineProperty("ap_pitch_sw", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch_sw"))  -- engage pitch control
defineProperty("ap_roll", globalPropertyf("sim/custom/xap/An24_ap/ap_roll"))   -- roll knob
-- lights
defineProperty("ap_ready_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_ready_lit"))  -- ready light
defineProperty("ap_on_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_on_lit"))  -- AP engaged light
defineProperty("ap_kv_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_kv_lit"))  -- alt stab engaged
defineProperty("ap_up_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_up_lit"))  -- AP feels UP force on stab
defineProperty("ap_down_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_down_lit"))  -- AP feels DOWN force on stab
defineProperty("ap_ail_fail_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_ail_fail_lit"))  -- aileron trim failed lamp
defineProperty("ap_elev_fail_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_elev_fail_lit"))  -- elevator trim failed lamp

-- controls
defineProperty("ap_roll_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_roll_diff"))  -- difference between needed and current roll (bank)
defineProperty("ap_pitch_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_pitch_diff"))  -- difference between needed and current pitch
defineProperty("ap_hdg_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_hdg_diff"))  -- difference between needed and current heading
defineProperty("ap_roll_power", globalPropertyi("sim/custom/xap/An24_ap/ap_roll_power"))  -- power for aileron mechanic
defineProperty("ap_pitch_power", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch_power"))  -- power for elevator mechanic
defineProperty("ap_hdg_power", globalPropertyi("sim/custom/xap/An24_ap/ap_hdg_power"))  -- power for rudder mechanic
defineProperty("yaw_spd", globalPropertyf("sim/custom/xap/An24_ap/ap_yaw_spd")) -- current yaw speed deg/sec

defineProperty("ap_mech_off", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off"))  -- ap mechanic off. o = mechanics works, 1 = mech off
defineProperty("ap_mech_off_cap", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off_cap"))  -- ap mechanic off cap

-- failures
--defineProperty("rudd_fail", globalPropertyi("sim/operation/failures/rel_trim_rud"))  -- rudder trim fail
defineProperty("ail_fail", globalPropertyi("sim/operation/failures/rel_trim_ail"))  -- aileron trim fail
defineProperty("elev_fail", globalPropertyi("sim/operation/failures/rel_trim_elv"))  -- elevator trim fail

defineProperty("ail_servo", globalPropertyi("sim/operation/failures/rel_servo_ailn"))  -- aileron trim fail
defineProperty("elev_servo", globalPropertyi("sim/operation/failures/rel_servo_elev"))  -- elevator trim fail
defineProperty("rudd_serv", globalPropertyi("sim/operation/failures/rel_servo_rudd"))  -- rudder trim fail
defineProperty("thro_serv", globalPropertyi("sim/operation/failures/rel_servo_thro"))  -- throttle fail
defineProperty("PF_ApbuttonState", globalPropertyf("parshukovedition/autopilot_state_PF_ApbuttonState"))
defineProperty("FO_ApbuttonState", globalPropertyf("parshukovedition/autopilot_state_FO_ApbuttonState"))
local autopilot_off_onn_Sound = loadSample('Sounds/alert/autopilot_disco.wav')
defineProperty("isalerton", globalPropertyi("parshukovedition/isalerton"))
-- global variables



local passed = 0
local pitch_vvi = 0 -- global variable for stabilise plane in horisontal flight
local ap_state = 1 -- autopilot status. 0 - off, 1 - ready, 2 - work
local last_ap_state = 0
local ap_last_state = 0
local ap_timer_start = get(flight_time)
local ap_alt_mode = 0
local ap_roll_mode = 0
	-- alt modes are:
	-- 0 - using manual pitch, manual bank and curse stab depending on selected source
	-- 1 - horizont
	-- 2 - KV - altitude hold

	-- roll modes are
	-- 0 - turns from knob or compas
	-- 1 - horizont
	-- 2 - turns from ZK
local auto_kv = false -- kv mode auto switched after horizont mode
local curse = 0
-- logic of AP channels
local autopilot_pitch = get(indicated_pitch)
local autopilot_roll = get(indicated_roll)
local msl = get(msl_alt) * 3.28083 -- MSL alt in feet
local real_alt = msl + (29.92 - get(baro_press)) * 1000  -- calculate barometric altitude in feet
local baro_alt = real_alt * 0.3048 -- altitude in meters
local hold_alt = baro_alt

local ap_pitch_need = autopilot_pitch
local ap_roll_need = autopilot_roll
local ap_hdg_need = 0

local last_stab = get(ap_curse_stab)
local hdg_diff = 0
local hdg_diff_need = 0
local pitch_diff = 0
--local pitch_diff_need = 0
local roll_diff = 0
--local roll_diff_need = 0

local last_pitch_mode = ap_alt_mode
local last_roll_mode = ap_roll_mode
local curse_sat = false
local gpk_curse_last = 0
local gik_curse_last = 0




-- commands

-- turn off AP
ap_off_command = findCommand("sim/autopilot/fdir_servos_down_one")
function ap_off_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase and ap_state == 2 then
		ap_state = 1
		set(PF_ApbuttonState,0)
		set(FO_ApbuttonState,0)
		set(isalerton,1)
		playSample(autopilot_off_onn_Sound, 0)
    end
return 0
end
registerCommandHandler(ap_off_command, 0, ap_off_handler)


-- turn ON AP
ap_on_command = findCommand("sim/autopilot/fdir_servos_up_one")
function ap_on_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(ap_ON, 1)
	else
		set(ap_ON, 0)
	end
return 0
end
registerCommandHandler(ap_on_command, 0, ap_on_handler)


-- hold AP
ap_hold_command = findCommand("sim/autopilot/servos_on")
local ap_hold = false
function ap_hold_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase and (ap_state == 2 or ap_hold) then
		ap_state = 1
		ap_hold = true
	elseif ap_hold then
		ap_state = 2
		ap_hold = false
    else ap_hold = false
    end
return 0
end
registerCommandHandler(ap_hold_command, 0, ap_hold_handler)


-- left bank
ap_left_command = findCommand("sim/autopilot/override_left")
function ap_left_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(ap_roll) - 5
		if a < -25 then a = -25 end
		set(ap_roll, a)
    end
return 0
end
registerCommandHandler(ap_left_command, 0, ap_left_handler)

-- right bank
ap_right_command = findCommand("sim/autopilot/override_right")
function ap_right_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(ap_roll) + 5
		if a > 25 then a = 25 end
		set(ap_roll, a)
    end
return 0
end
registerCommandHandler(ap_right_command, 0, ap_right_handler)


-- pitch UP
ap_UP_command = findCommand("sim/autopilot/override_up")
function ap_UP_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(ap_pitch, 1)
    else set(ap_pitch, 0)
    end
return 0
end
registerCommandHandler(ap_UP_command, 0, ap_UP_handler)


-- pitch DOWN
ap_DOWN_command = findCommand("sim/autopilot/override_down")
function ap_DOWN_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(ap_pitch, -1)
    else set(ap_pitch, 0)
    end
return 0
end
registerCommandHandler(ap_DOWN_command, 0, ap_DOWN_handler)

-- KV mode
ap_KV_command = findCommand("sim/autopilot/altitude_hold")
function ap_KV_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(ap_kv, 1)
  	else set(ap_kv, 0)
   	end
return 0
end
registerCommandHandler(ap_KV_command, 0, ap_KV_handler)

-- horison mode
ap_HOR_command = findCommand("sim/autopilot/wing_leveler")
function ap_HOR_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(ap_horizont, 1)
  	else set(ap_horizont, 0)
   	end
return 0
end
registerCommandHandler(ap_HOR_command, 0, ap_HOR_handler)

-- AP power switcher
ap_power_command = findCommand("sim/autopilot/fdir_on")
function ap_power_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		set(ap_power, math.abs(get(ap_power) - 1))
	end
return 0
end
registerCommandHandler(ap_power_command, 0, ap_power_handler)

-- AP trim switcher
ap_trim_command = findCommand("sim/autopilot/servos_toggle")
function ap_trim_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		set(ap_trim, math.abs(get(ap_trim) - 1))
	end
return 0
end
registerCommandHandler(ap_trim_command, 0, ap_trim_handler)

-- AP pitch switcher
ap_pitch_command = findCommand("sim/autopilot/pitch_sync")
function ap_pitch_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		set(ap_pitch_sw, math.abs(get(ap_pitch_sw) - 1))
	end
return 0
end
registerCommandHandler(ap_pitch_command, 0, ap_pitch_handler)

-- AP course select UP
ap_course_UP_command = findCommand("sim/autopilot/airspeed_up")
function ap_course_UP_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(ap_curse_stab) + 1
		if a > 2 then a = 2 end
		set(ap_curse_stab, a)
	end
return 0
end
registerCommandHandler(ap_course_UP_command, 0, ap_course_UP_handler)


-- AP course select DOWN
ap_course_DOWN_command = findCommand("sim/autopilot/airspeed_down")
function ap_course_DOWN_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(ap_curse_stab) - 1
		if a < 0 then a = 0 end
		set(ap_curse_stab, a)
	end
return 0
end
registerCommandHandler(ap_course_DOWN_command, 0, ap_course_DOWN_handler)

-----------------

-- function for calculating roll, depending on curse difference between needed and actual curse
function calc_roll(curse_delta, norm_delta, max_roll)
	-- normalise delta. on delta bigger then norm_delta - bank will be maximal = max_roll
	local delta = curse_delta / norm_delta
	if delta > 1 then delta = 1
	elseif delta < -1 then delta = -1 end

	-- return result
	return max_roll * delta
end


local alt_diff_last = 0
local pitch_step = 0.2
local pitch_need = get(indicated_pitch)
-- function for calculate pitch for maintain altitude
function calc_pitch(alt_diff, pitch_limit)

		local spd_coef = math.min(1, math.abs(alt_diff / 100)) * 5
		-- calculate approach movement to given track
		if math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff > 25 then -- climbing from hold_alt. above
			pitch_need = pitch_need - pitch_step * 2 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff > 25 then -- descending to hold_alt. above
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed > -spd_coef then 
					pitch_need = pitch_need - pitch_step * 1 * passed
				elseif (alt_diff - alt_diff_last) / passed < -spd_coef then
					pitch_need = pitch_need + pitch_step * 1 * passed
				end
			end
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff < -25 then -- descending from hold_alt. below
			pitch_need = pitch_need + pitch_step * 2 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff < -25 then -- climbing to hold_alt. below
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed < spd_coef then 
					pitch_need = pitch_need + pitch_step * 1 * passed
				elseif (alt_diff - alt_diff_last) / passed > spd_coef then
					pitch_need = pitch_need - pitch_step * 1 * passed
				end
			end	
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff > 10 then -- climbing from hold_alt. above
			pitch_need = pitch_need - pitch_step * 1 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff > 10 then -- descending to hold_alt. above
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed > -spd_coef then 
					pitch_need = pitch_need - pitch_step * 0.5 * passed
				elseif (alt_diff - alt_diff_last) / passed < -spd_coef then
					pitch_need = pitch_need + pitch_step * 0.5 * passed
				end
			end
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff < -10 then -- descending from hold_alt. below
			pitch_need = pitch_need + pitch_step * 1 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff < -10 then -- climbing to hold_alt. below
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed < spd_coef then 
					pitch_need = pitch_need + pitch_step * 0.5 * passed
				elseif (alt_diff - alt_diff_last) / passed > spd_coef then
					pitch_need = pitch_need - pitch_step * 0.5 * passed
				end
			end	
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff > 0 then -- climbing from hold_alt. above
			pitch_need = pitch_need - pitch_step * 0.2 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff > 0 then -- descending to hold_alt. above
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed > -spd_coef then 
					pitch_need = pitch_need - pitch_step * 0.1 * passed
				elseif (alt_diff - alt_diff_last) / passed < -spd_coef then
					pitch_need = pitch_need + pitch_step * 0.1 * passed
				end
			end
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) > 0 and alt_diff < 0 then -- descending from hold_alt. below
			pitch_need = pitch_need + pitch_step * 0.2 * passed
		elseif math.abs(alt_diff) - math.abs(alt_diff_last) < 0 and alt_diff < 0 then -- climbing to hold_alt. below
			if passed > 0 then 
				if (alt_diff - alt_diff_last) / passed < spd_coef then 
					pitch_need = pitch_need + pitch_step * 0.1 * passed
				elseif (alt_diff - alt_diff_last) / passed > spd_coef then
					pitch_need = pitch_need - pitch_step * 0.1 * passed
				end
			end				
		else
			--pitch_need = (get(res_pitch_1) + get(res_pitch_2)) * 0.5 -- think about some fix for stable pitch
		end
		
		alt_diff_last = alt_diff

		return pitch_need

--[[	
	-- calculate needed vertical speed
	local delta_vv = alt_diff / norm_alt
	if delta_vv > 1 then delta_vv = 1
	elseif delta_vv < -1 then delta_vv = -1 end

	local needed_vv = delta_vv * max_vv

	-- calculate new pitch for maintain desired vv
	local vv_diff = needed_vv - get(vvi) * 0.00508
	if vv_diff > 0.1 then pitch_vv = pitch_vv + pitch_spd * passed
	elseif vv_diff < -0.1 then pitch_vv = pitch_vv - pitch_spd * passed
	end

	-- minimise pitch
	if pitch_vv > pitch_limit then pitch_vv = pitch_limit
	elseif pitch_vv < -pitch_limit then pitch_vv = -pitch_limit end
	--if ap_alt_mode == 2 then print("result", delta_vv, needed_vv, vv_diff, pitch_vv) end
	return pitch_vv

--]]

	-- normalie difference
--[[	local delta = alt_diff / norm_pitch
	if delta > 1 then delta = 1
	elseif delta < -1 then delta = -1 end

	--local new_pitch = autopilot_pitch + delta * max_pitch
	local new_pitch = delta * max_pitch  -- initial pitch for minimise delta

	-- minimise vertical speed
	if math.abs(alt_diff) < 30 then
		if vert_spd > 0.5 then pitch_vvi = pitch_vvi - frame_time * spd
		elseif vert_spd < -0.5 then pitch_vvi = pitch_vvi + frame_time * spd
		else
			--level_pitch = get(indicated_pitch)
			--pitch_vvi = 0
		end
	end

	-- calculate result and limit it
	local res_pitch = new_pitch + pitch_vvi
	if res_pitch > max_pitch then res_pitch = max_pitch
	elseif res_pitch < -max_pitch then res_pitch = -max_pitch end


	return res_pitch
--]]
end


-- function to select autopilot power status, depending on power, switchers and start time
function autopilot_state()
	-- set default AP fail
	set(ail_servo, 6)
	set(elev_servo, 6)
	set(rudd_serv, 6)
	set(thro_serv, 6)
	
	-- calculate power
	local autopilot_power = get(bus_AC_36_volt) > 30 and get(bus_AC_115_volt) > 110 and get(ap_power) == 1
	-- set timer for AP get ready
	local sim_time = get(flight_time)
	if autopilot_power then
		-- set ready status
		if ap_state == 0 and sim_time - ap_timer_start > 10 then -- AP is ready after 10 sec
			ap_state = 1
		elseif ap_state == 1 and get(ap_ON) == 1 then -- AP engaged
			ap_state = 2
		end
	else
		ap_state = 0
		ap_timer_start = sim_time
	end
	if ap_state > 0 then set(ap_power_cc, 5) else set(ap_power_cc, 0) end
	
	return true
end


-- function for automatic selection of modes
function autopilot_mode()

	if ap_state == 1 and get(ap_horizont) == 1 then  -- horizont mode when AP not connected
		ap_alt_mode = 1
		ap_roll_mode = 1
	elseif ap_state == 1 and math.abs(get(indicated_roll)) < 1 and math.abs(get(indicated_pitch)) < 5 and math.abs(get(vvi) * 0.00508) < 0.5  then  -- out of horizont mode
		ap_alt_mode = 0
		ap_roll_mode = 0
	elseif ap_state == 2 then
			-- logic of pitch mode
			if ap_alt_mode == 1 and math.abs(get(indicated_roll)) < 1 and math.abs(get(indicated_pitch)) < 5 and math.abs(get(vvi) * 0.00508) < 0.5 then  -- automatic turn to KV mode
				auto_kv = true
				ap_alt_mode = 2
			elseif ap_alt_mode ~= 2 and get(ap_kv) == 1 then -- manual turn to KV mode
				ap_alt_mode = 2
				auto_kv = false
			elseif ap_alt_mode ~= 1 and get(ap_horizont) == 1 then -- turn to horizont mode
				ap_alt_mode = 1
			elseif get(ap_ON) == 1 or get(ap_pitch_sw) == 0 or (not auto_kv and get(ap_pitch) ~= 0 and ap_alt_mode == 2) then -- turn to manual mode
				ap_alt_mode = 0
				auto_kv = false
			end

			-- logic of roll mode
			if get(ap_horizont) == 1 then
				ap_roll_mode = 1
			elseif get(ap_curse_stab) == 0 and ap_alt_mode ~= 1 and math.abs(get(curse_zk)) < 120 then
				ap_roll_mode = 2
			elseif get(ap_curse_stab) ~= 0 and ap_alt_mode ~= 1 then
				ap_roll_mode = 0
			end
	elseif ap_state == 0 then
		ap_alt_mode = 0
		ap_roll_mode = 0
	end

end

-- logic of mechanics power
function mech_power()
	if (ap_state == 1 and ap_alt_mode == 1) or ap_state == 2 then
		set(ap_roll_power, (1 - get(ap_ail_fail_lit)) * (1 - get(ap_mech_off)))
		set(ap_pitch_power, get(ap_pitch_sw) * (1 - get(ap_elev_fail_lit)) * (1 - get(ap_mech_off)))
		set(ap_hdg_power, (1 - get(ap_mech_off)))
	else
		set(ap_roll_power, 0)
		set(ap_pitch_power, 0)
		set(ap_hdg_power, 0)
	end
end


-- logic of mechanics
function mech_logic()
	-- calculate altitude to hold
	msl = get(msl_alt) * 3.28083 -- MSL alt in feet
	real_alt = msl + (29.92 - get(baro_press)) * 1000  -- calculate barometric altitude in feet
	
	baro_alt = real_alt * 0.3048 -- altitude in meters
	
	-- pitch logic
	if ap_state < 2 and ap_alt_mode ~= 1 then autopilot_pitch = get(indicated_pitch) end -- set new pitch for hold it
	if last_pitch_mode ~= ap_alt_mode or ap_state ~= ap_last_state then  
		last_pitch_mode = ap_alt_mode
		ap_last_state = ap_state
		if ap_alt_mode == 0 then 
			autopilot_pitch = get(indicated_pitch) -- set new pitch for hold it
		elseif ap_alt_mode == 1 then 
			autopilot_pitch = 0
		elseif ap_alt_mode == 2 then 
			hold_alt = baro_alt  -- set new alt for hold
		end
	end
	
	if ap_alt_mode ~= 2 then -- save some variables, while they not used as parameters
		pitch_need = get(indicated_pitch) 
		hold_alt = baro_alt
	end
	
	-- pitch modes
	local KV_pitch = calc_pitch(baro_alt - hold_alt, 10) -- inititalisation of function variables due to actual flight situation
	if get(ap_pitch_sw) == 1 then
		if ap_alt_mode == 0 then autopilot_pitch = autopilot_pitch + get(ap_pitch) * passed * 1
		elseif ap_alt_mode == 1 then autopilot_pitch = 0 
		elseif ap_alt_mode == 2 then autopilot_pitch = KV_pitch
		end
	end
	
	if autopilot_pitch > 20 then autopilot_pitch = 20
	elseif autopilot_pitch < -20 then autopilot_pitch = -20 end

	-- smooth move of needed pitch
	if autopilot_pitch > ap_pitch_need + 0.1 then ap_pitch_need = ap_pitch_need + 5 * passed
	elseif autopilot_pitch < ap_pitch_need - 0.1 then ap_pitch_need = ap_pitch_need - 5 * passed end

	-- calculate pitch difference for mechanic
	pitch_diff = ap_pitch_need - get(indicated_pitch)

	set(ap_pitch_diff, pitch_diff)

	
	
	
	-- roll logic
	if ap_roll_mode == 1 then autopilot_roll = 0  -- horizont mode
	elseif ap_roll_mode == 2 then autopilot_roll = calc_roll(-get(curse_zk), 15, 15)  -- turns mode
	else autopilot_roll = get(ap_roll)  -- manual roll mode
	end

	-- smooth move of roll
	if autopilot_roll > ap_roll_need + 0.1 then ap_roll_need = ap_roll_need + 5 * passed
	elseif autopilot_roll < ap_roll_need - 0.1 then ap_roll_need = ap_roll_need - 5 * passed end

	-- calculate roll difference for mechanic
	roll_diff = ap_roll_need - get(indicated_roll)

	set(ap_roll_diff, roll_diff)

	-- heading logic
	local stab = get(ap_curse_stab)
	-- set new curse after manuvers
	if math.abs(autopilot_roll) > 3 or stab ~= last_stab or ap_state ~= last_ap_state or get(ap_ON) == 1 then 
		curse_sat = false 
	end
	last_stab = stab
	last_ap_state = ap_state

	if math.abs(get(indicated_roll)) < 3 and not curse_sat then -- final course set
		if stab == 1 then curse = get(curse_gpk)
		elseif stab == 2 then curse = get(curse_gik) end
		curse_sat = true
	end

	-- set needed hdg

	local gpk_curse = get(curse_gpk) - curse
	if gpk_curse > 180 then gpk_curse = gpk_curse - 360
	elseif gpk_curse < -180 then gpk_curse = gpk_curse + 360 end

	local gik_curse = get(curse_gik) - curse
	if gik_curse > 180 then gik_curse = gik_curse - 360
	elseif gik_curse < -180 then gik_curse = gik_curse + 360 end

	if math.abs(autopilot_roll) > 1 or stab == 0 then hdg_diff = get(slip)
	elseif stab == 1 then hdg_diff = gpk_curse
	elseif stab == 2 then hdg_diff = gik_curse
	end

	-- smooth move of hdg diff
	if ap_state < 2 then hdg_diff_need = 0 end
	-- limit course
	if hdg_diff > 180 then hdg_diff = hdg_diff - 360
	elseif hdg_diff < -180 then hdg_diff = hdg_diff + 360 end
	
	if hdg_diff_need < hdg_diff - 0.01 then hdg_diff_need = hdg_diff_need + 5 * passed
	elseif hdg_diff_need > hdg_diff + 0.01 then hdg_diff_need = hdg_diff_need - 5 * passed
	else hdg_diff_need = hdg_diff end
	if ap_state < 2 then hdg_diff_need = 0 end
	
	set(ap_hdg_diff, hdg_diff_need)
	
	-- calculate current hdg speed
	local hdg_spd = 0
	if passed > 0 then
		if math.abs(autopilot_roll) > 1 or stab == 0 then hdg_spd = -get(slip)
		elseif stab == 1 then hdg_spd = -(get(curse_gpk) - gpk_curse_last) / passed
		elseif stab == 2 then hdg_spd = -(get(curse_gik) - gik_curse_last) / passed
		end
	end
	
	set(yaw_spd, hdg_spd)
	
	gpk_curse_last = get(curse_gpk)
	gik_curse_last = get(curse_gik)
	
	
end


-- function to set status lights
function set_lights()
	if ap_state == 1 then set(ap_ready_lit, 1) else set(ap_ready_lit, 0) end
	if ap_state == 2 then
		set(ap_on_lit, 1)
		if get(pitch_force) > 0.2 then
			set(ap_up_lit, 0)
			set(ap_down_lit, 1)
		elseif get(pitch_force) < -0.2 then
			set(ap_up_lit, 1)
			set(ap_down_lit, 0)
		else
			set(ap_up_lit, 0)
			set(ap_down_lit, 0)
		end
	else
		set(ap_on_lit, 0)
		set(ap_up_lit, 0)
		set(ap_down_lit, 0)
	end
	if ap_alt_mode == 2 and ap_state == 2 then set(ap_kv_lit, 1) else set(ap_kv_lit, 0) end

	if ap_state > 0 then
		if get(ail_fail) == 6 then set(ap_ail_fail_lit, 1) else set(ap_ail_fail_lit, 0) end
		if get(elev_fail) == 6 then set(ap_elev_fail_lit, 1) else set(ap_elev_fail_lit, 0) end
	else
		set(ap_ail_fail_lit, 0)
		set(ap_elev_fail_lit, 0)
	end

end


-- every frame calculations
function update()

	-- set default AP
	--if not ap_hold then set(sim_ap_mode, ap_state) end
	set(sim_ap_mode, 0)
	passed = get(frame_time)

if passed > 0 then

	-- check AP power state
	autopilot_state()

	-- select AP mode
	autopilot_mode()

	-- set mechanics power
	mech_power()

	-- set mechanic comands
	mech_logic()

	-- lights
	set_lights()

else
	passed = 0
end
end






