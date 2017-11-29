-- this is failures logic 
-- define property table

-- landing gears
defineProperty("retract1_fail", globalPropertyi("sim/operation/failures/rel_lagear1")) -- fail of retract gear
defineProperty("retract2_fail", globalPropertyi("sim/operation/failures/rel_lagear2")) -- fail of retract gear
defineProperty("retract3_fail", globalPropertyi("sim/operation/failures/rel_lagear3")) -- fail of retract gear

defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  --deploy of front gear
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear

defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  -- vertical deflection of left gear
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
defineProperty("gear3_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of left gear

defineProperty("tyre2_fail", globalPropertyf("sim/operation/failures/rel_tire2"))  -- tyre blow right
defineProperty("tyre3_fail", globalPropertyf("sim/operation/failures/rel_tire3"))  -- tyre blow left

-- fire
defineProperty("sim_engine_fire1", globalPropertyi("sim/cockpit2/annunciators/engine_fires[0]"))  -- left engine fire indicator
defineProperty("sim_engine_fire2", globalPropertyi("sim/cockpit2/annunciators/engine_fires[1]"))  -- right engine fire indicator
defineProperty("cockpit_smoke", globalPropertyi("sim/operation/failures/rel_smoke_cpit"))  -- Smoke in cockpit
-- skv
defineProperty("bleed1_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed1_sw")) 
defineProperty("bleed2_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed2_sw")) 

-- brakes
defineProperty("brake1_fail", globalPropertyi("sim/operation/failures/rel_lbrakes"))  -- left brakes
defineProperty("brake2_fail", globalPropertyi("sim/operation/failures/rel_rbrakes"))  -- right brakes
defineProperty("brake1", globalPropertyf("sim/flightmodel/controls/l_brake_add")) -- gear brake ratio. 0 = min, 1 = max
defineProperty("brake2", globalPropertyf("sim/flightmodel/controls/r_brake_add")) -- gear brake ratio. 0 = min, 1 = max
defineProperty("block_brake", globalPropertyf("sim/flightmodel/controls/parkbrake"))  -- blocks brakes
defineProperty("gear_speed_1", globalPropertyf("sim/flightmodel2/gear/tire_rotation_speed_rad_sec[1]")) -- radians/second	Rotational speed of this tire, radians per second.
defineProperty("gear_speed_2", globalPropertyf("sim/flightmodel2/gear/tire_rotation_speed_rad_sec[2]")) -- radians/second	Rotational speed of this tire, radians per second.

-- separation
defineProperty("rel_wing1L", globalPropertyi("sim/operation/failures/rel_wing1L"))  -- Wing separations
defineProperty("rel_wing2L", globalPropertyi("sim/operation/failures/rel_wing2L"))  -- Wing separations
defineProperty("rel_wing3L", globalPropertyi("sim/operation/failures/rel_wing3L"))  -- Wing separations
defineProperty("rel_wing4L", globalPropertyi("sim/operation/failures/rel_wing4L"))  -- Wing separations
defineProperty("rel_wing1R", globalPropertyi("sim/operation/failures/rel_wing1R"))  -- Wing separations
defineProperty("rel_wing2R", globalPropertyi("sim/operation/failures/rel_wing2R"))  -- Wing separations
defineProperty("rel_wing3R", globalPropertyi("sim/operation/failures/rel_wing3R"))  -- Wing separations
defineProperty("rel_wing4R", globalPropertyi("sim/operation/failures/rel_wing4R"))  -- Wing separations

defineProperty("elevator_R", globalPropertyi("sim/operation/failures/rel_mwing1"))  -- right elevator
defineProperty("elevator_L", globalPropertyi("sim/operation/failures/rel_mwing2"))  -- left elevator

defineProperty("aileron_R", globalPropertyi("sim/operation/failures/rel_mwing6"))  -- right aileron
defineProperty("aileron_L", globalPropertyi("sim/operation/failures/rel_mwing7"))  -- left aileron
defineProperty("rudder", globalPropertyi("sim/operation/failures/rel_mwing8"))  -- rudder

defineProperty("sim_elevator_R", globalPropertyi("sim/operation/failures/rel_hstbR"))  -- right elevator
defineProperty("sim_elevator_L", globalPropertyi("sim/operation/failures/rel_hstbL"))  -- left elevator
defineProperty("sim_rudder1", globalPropertyi("sim/operation/failures/rel_vstb1"))  -- rudder
defineProperty("sim_rudder2", globalPropertyi("sim/operation/failures/rel_vstb2"))  -- rudder


defineProperty("eng_sep1", globalPropertyi("sim/operation/failures/rel_engsep0"))  -- engine separations
defineProperty("eng_sep2", globalPropertyi("sim/operation/failures/rel_engsep1"))  -- engine separations
defineProperty("eng_sep3", globalPropertyi("sim/operation/failures/rel_engsep2"))  -- engine separations

-- pitots
defineProperty("pitot_1", globalPropertyi("sim/custom/xap/An24_covers/pitot_1"))  -- pitot 1
defineProperty("pitot_2", globalPropertyi("sim/custom/xap/An24_covers/pitot_2"))  -- pitot 2
defineProperty("pitot_3", globalPropertyi("sim/custom/xap/An24_covers/pitot_3"))  -- pitot 3

defineProperty("pitot_1_fail", globalPropertyi("sim/operation/failures/rel_pitot"))  -- pitot 1 fail
defineProperty("pitot_2_fail", globalPropertyi("sim/operation/failures/rel_pitot2"))  -- pitot 1 fail

-- generators
defineProperty("sim_gen1_fail", globalPropertyi("sim/operation/failures/rel_genera0"))
defineProperty("sim_gen2_fail", globalPropertyi("sim/operation/failures/rel_genera1"))
defineProperty("sim_gen3_fail", globalPropertyi("sim/operation/failures/rel_genera2"))

-- enviroment
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("ground_speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature
defineProperty("runway", globalPropertyf("sim/weather/runway_friction")) -- runway friction. 0 = dry, 1 = wet, 2 = icy

-- reality
defineProperty("set_real_gears", globalPropertyi("sim/custom/xap/An24_set/real_gears")) --  gears can fail in overspeed
defineProperty("set_real_brakes", globalPropertyi("sim/custom/xap/An24_set/real_brakes")) -- brakes can overheat and fail
defineProperty("set_real_tyres", globalPropertyi("sim/custom/xap/An24_set/real_tyres")) -- tyres can blow if too much brakes




local passed = 0

local last_gear_deploy1 = get(gear1_deploy)
local last_gear_deploy2 = get(gear2_deploy)
local last_gear_deploy3 = get(gear3_deploy)

local brake_counter1 = 0
local brake_counter2 = 0

local tyre_counter1 = math.random(0, 10)
local tyre_counter2 = math.random(0, 10)

local counter = 0

function update()
	
	-- time
	passed = get(frame_time)

if passed > 0 then
	
	-- landing gear deploy failure
	local gear_real = get(set_real_gears) == 1
	local airspeed = get(ias) * 1.852
	if airspeed > 400 and gear_real then
		if get(gear1_deploy) > last_gear_deploy1 and last_gear_deploy1 > 0.7 then set(retract1_fail, 6) end
		if get(gear2_deploy) > last_gear_deploy2 and last_gear_deploy2 > 0.7 then set(retract2_fail, 6) end
		if get(gear3_deploy) > last_gear_deploy3 and last_gear_deploy3 > 0.7 then set(retract3_fail, 6) end
	end
	last_gear_deploy1 = get(gear1_deploy)
	last_gear_deploy2 = get(gear2_deploy)
	last_gear_deploy3 = get(gear3_deploy)	
	---------------------
	
	-- fire logic
	if (get(sim_engine_fire1) == 6 and get(bleed1_sw) == 1) or (get(sim_engine_fire2) == 6 and get(bleed2_sw) == 1) then
		set(cockpit_smoke, 6)
	else
		set(cockpit_smoke, 0)
	end
	---------------------
 
	-- brake failures
	local brake_real = get(set_real_brakes) == 1
	local g_spd = get(ground_speed)
	if g_spd > 10 then g_spd = 10 end
	local out_temp = get(thermo) + 5 / 30
	local park_brake = get(block_brake)
	local gear_spd1 = get(gear_speed_1)
	local gear_spd2 = get(gear_speed_2)
	
	local on_ground = get(gear1_deflect) > 0.05 or get(gear2_deflect) > 0.05 or get(gear3_deflect) > 0.05
	
	if g_spd > 5 and on_ground and brake_real then
		brake_counter1 = brake_counter1 + g_spd * (math.max(get(brake1), park_brake) - 0.1) * passed * out_temp * gear_spd1 * 0.00005
		brake_counter2 = brake_counter2 + g_spd * (math.max(get(brake2), park_brake) - 0.1) * passed * out_temp * gear_spd2 * 0.00005
	else
		brake_counter1 = brake_counter1 - passed * 0.1
		brake_counter2 = brake_counter2 - passed * 0.1
	end

	
	
	if brake_counter1 < 0 then
		brake_counter1 = 0
	elseif brake_counter1 > 10 then
		set(brake1_fail, 6)
		brake_counter1 = 0
	end
	if brake_counter2 < 0 then
		brake_counter2 = 0
	elseif brake_counter2 > 10 then
		set(brake2_fail, 6)
		brake_counter2 = 0
	end	
	----------------------
	
	-- tyre blow
	local tyre_real = get(set_real_tyres) == 1
	local runway_fr = -(get(runway) - 2)
	if g_spd > 5 and on_ground and tyre_real then
		if gear_spd1 < 1 then 
			tyre_counter1 = tyre_counter1 + passed * runway_fr end
		if gear_spd2 < 1 then tyre_counter2 = tyre_counter2 + passed * runway_fr end
	end
	
	
	if tyre_counter1 > 50 then 
		tyre_counter1 = 0
		set(tyre2_fail, 6)
	end

	if tyre_counter2 > 50 then 
		tyre_counter2 = 0
		set(tyre3_fail, 6)
	end	
	----------------------
	
	-- separations
	if get(rel_wing1L) == 6 then 
		set(rel_wing2L, 6) 
		set(eng_sep1, 6)
	end
	if get(rel_wing2L) == 6 then set(rel_wing3L, 6) end
	if get(rel_wing3L) == 6 then
		set(rel_wing4L, 6) 
		set(aileron_L, 6)	
	end

	if get(rel_wing1R) == 6 then 
		set(rel_wing2R, 6) 
		set(eng_sep2, 6)
		set(eng_sep3, 6)
	end
	if get(rel_wing2R) == 6 then set(rel_wing3R, 6) end
	if get(rel_wing3R) == 6 then 
		set(rel_wing4R, 6) 
		set(aileron_R, 6)	
	end	
	
	if get(eng_sep1) == 6 then set(sim_gen1_fail, 6) end
	if get(eng_sep2) == 6 then set(sim_gen2_fail, 6) end
	if get(eng_sep3) == 6 then set(sim_gen3_fail, 6) end
	
	if get(sim_elevator_R) == 6 then set(elevator_R, 6) end
	if get(sim_elevator_L) == 6 then set(elevator_L, 6) end
	
	if get(sim_rudder1) == 6 or get(sim_rudder2) == 6 then set(rudder, 6) end
	
	
	
	----------------------
	
	-- pitot blockage
	if get(pitot_1) == 0 or get(pitot_2) == 0 then set(pitot_1_fail, 6) else set(pitot_1_fail, 0) end
	if get(pitot_3) == 0 then set(pitot_2_fail, 6) else set(pitot_2_fail, 0) end	
	

end

end



