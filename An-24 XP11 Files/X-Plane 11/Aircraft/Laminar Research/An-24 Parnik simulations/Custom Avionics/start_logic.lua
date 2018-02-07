-- this is simple logic of start engines
-- define property table
-- default datarefs and commands
defineProperty("sim_igniter1", globalPropertyi("sim/cockpit2/engine/actuators/igniter_on[0]")) -- igniters on/off
defineProperty("sim_igniter2", globalPropertyi("sim/cockpit2/engine/actuators/igniter_on[1]")) -- igniters on/off
defineProperty("sim_igniter3", globalPropertyi("sim/cockpit2/engine/actuators/igniter_on[2]")) -- igniters on/off

defineProperty("sim_ignition1", globalPropertyi("sim/cockpit2/engine/actuators/ignition_on[0]")) -- ignition on/off
defineProperty("sim_ignition2", globalPropertyi("sim/cockpit2/engine/actuators/ignition_on[1]")) -- ignition on/off
defineProperty("sim_ignition3", globalPropertyi("sim/cockpit2/engine/actuators/ignition_on[2]")) -- ignition on/off

defineProperty("ru19_N1", globalPropertyf("sim/custom/xap/An24_start/ru19_N1"))  

starter_1 = findCommand("sim/starters/engage_starter_1")  -- simulator command for starter 1
starter_2 = findCommand("sim/starters/engage_starter_2")  -- simulator command for starter 2
starter_3 = findCommand("sim/starters/engage_starter_3")  -- simulator command for starter 3

-- custom datarefs
defineProperty("fuel_start1", globalPropertyi("sim/custom/xap/An24_start/fuel_start1")) -- fuel valves
defineProperty("fuel_start2", globalPropertyi("sim/custom/xap/An24_start/fuel_start2")) -- fuel valves
defineProperty("fuel_start3", globalPropertyi("sim/custom/xap/An24_start/fuel_start3")) -- fuel valves

defineProperty("stg1_starter", globalPropertyi("sim/custom/xap/An24_power/stg1_starter"))  -- generator worknig as starter
defineProperty("stg2_starter", globalPropertyi("sim/custom/xap/An24_power/stg2_starter")) 
defineProperty("gs24_starter", globalPropertyi("sim/custom/xap/An24_power/gs24_starter")) 

defineProperty("eng_start_btn", globalPropertyi("sim/custom/xap/An24_start/eng_start_btn")) -- start selected engine
defineProperty("start_at_ground_cap", globalPropertyi("sim/custom/xap/An24_start/start_at_ground_cap")) -- select start mode cap
defineProperty("start_at_ground", globalPropertyi("sim/custom/xap/An24_start/start_at_ground")) -- select start mode
defineProperty("sel_left_right", globalPropertyi("sim/custom/xap/An24_start/sel_left_right")) -- select engine to start. -1 - left, 0 - none, +1 - right
defineProperty("eng_start_mode", globalPropertyi("sim/custom/xap/An24_start/eng_start_mode")) -- select start mode. start or fail start
defineProperty("eng_start_stop", globalPropertyi("sim/custom/xap/An24_start/eng_start_stop")) -- button for stop start process
defineProperty("left_temp_check", globalPropertyi("sim/custom/xap/An24_start/left_temp_check")) -- select temp check mode
defineProperty("left_prt24_on", globalPropertyi("sim/custom/xap/An24_start/left_prt24_on")) -- PRT24 on
defineProperty("right_temp_check", globalPropertyi("sim/custom/xap/An24_start/right_temp_check")) -- select temp check mode
defineProperty("right_prt24_on", globalPropertyi("sim/custom/xap/An24_start/right_prt24_on")) -- PRT24 on

defineProperty("ru19_air_start_btn", globalPropertyi("sim/custom/xap/An24_start/ru19_air_start_btn")) -- start at flight button
defineProperty("ru19_ground_start_btn", globalPropertyi("sim/custom/xap/An24_start/ru19_ground_start_btn")) -- start on ground button
defineProperty("ru19_ground_start_cap", globalPropertyi("sim/custom/xap/An24_start/ru19_ground_start_btn")) -- start on ground button cap
defineProperty("ru19_start_mode", globalPropertyi("sim/custom/xap/An24_start/ru19_start_mode")) -- select start mode. start or fail start
defineProperty("ru19_start_stop", globalPropertyi("sim/custom/xap/An24_start/ru19_start_stop")) -- stop button for ru19

defineProperty("ru19_start_main_sw", globalPropertyi("sim/custom/xap/An24_start/ru19_start_main_sw")) --   -- main switcher for ru19
defineProperty("ru19_start_main_sw_cap", globalPropertyi("sim/custom/xap/An24_start/ru19_start_main_sw_cap")) -- main switcher for ru19


defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))

defineProperty("eng_rpm1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("eng_rpm2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("eng_rpm3", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[2]"))

defineProperty("virt_rud1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))
defineProperty("virt_rud2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))
defineProperty("virt_rud3", globalPropertyf("sim/custom/xap/An24_misc/virt_rud3"))

defineProperty("apd_work_lit", globalPropertyi("sim/custom/xap/An24_start/apd_work_lit")) -- lamp for apd
defineProperty("pt29_work_lit", globalPropertyi("sim/custom/xap/An24_start/pt29_work_lit")) -- lamp for ru19 starter
defineProperty("strip_lit", globalPropertyi("sim/custom/xap/An24_start/strip_lit")) -- lamp for ru19 starter

defineProperty("starter_volt", globalPropertyf("sim/custom/xap/An24_start/starter_volt")) -- starter voltage for engines start
defineProperty("starter_amp", globalPropertyf("sim/custom/xap/An24_start/starter_amp")) -- starter amperage for engines start

defineProperty("set_real_startup", globalPropertyi("sim/custom/xap/An24_set/real_startup")) -- when start the engines a lot of thing must to be done

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

defineProperty("tro_comm_1", globalPropertyf("sim/flightmodel/engine/ENGN_thro[0]"))
defineProperty("tro_comm_2", globalPropertyf("sim/flightmodel/engine/ENGN_thro[1]"))
defineProperty("tro_comm_3", globalPropertyf("sim/flightmodel/engine/ENGN_thro[2]"))

defineProperty("tro_need_1", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[0]"))
defineProperty("tro_need_2", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[1]"))
defineProperty("tro_need_3", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[2]"))


local time_last = get(sim_run_time)  -- time for previous frame
set(tro_comm_1, 0)
local left_eng_start_time = time_last - 100
local right_eng_start_time = time_last - 100
local ru19_start_time = time_last - 100

local eng1_starting = false
local eng2_starting = false
local eng3_starting = false

local left_rpm_check = false
local right_rpm_check = false

commandEnd(starter_1)
commandEnd(starter_2)
commandEnd(starter_3)

local start_volt = 0
local start_amp = 0
local start_button_pressed = false
local ru19_start_button_pressed = false

-- postframe calculaions
function update()
--set(tro_comm_1, 20)
	-- time calculations
	local time_now = get(sim_run_time)
	local passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	start_volt = 0
	start_amp = 0	
	local real = get(set_real_startup) == 1
	-- power calculations
	local power = get(bus_DC_27_volt) > 16
	local power_em = get(bus_DC_27_volt_emerg) > 16
	
	local rpm1 = get(eng_rpm1)
	local rpm2 = get(eng_rpm2)
	local rpm3 = get(eng_rpm3)
	local ru_rpm = get(ru19_N1)
	-- automatic fuel cutoff
	if time_now - left_eng_start_time > 70 and rpm1 < 50 then set(fuel_start1, 0) end
	--else set(fuel_start1, 1) end
	
	if time_now - right_eng_start_time > 70 and rpm2 < 50 then set(fuel_start2, 0) end
	--else set(fuel_start2, 1) end
	
	if time_now - ru19_start_time > 30 and rpm3 < 40 then set(fuel_start3, 0) end
	--else set(fuel_start3, 1) end
	
	--[[
	if not real then
		set(fuel_start1, 1)
		set(fuel_start2, 1)
		set(fuel_start3, 1)
	end
	--]]
	
	-- start engines logic
	local selected_eng = get(sel_left_right)
	local eng_start = get(eng_start_btn) == 1
	local ground_start = get(start_at_ground) == 1
	local stop_button = get(eng_start_stop) == 1
	local cold_rotate = get(eng_start_mode) == 0

	if power then
		if selected_eng == -1 and eng_start and ((get(virt_rud1) < 0.06 and get(left_prt24_on) == 1 and not eng2_starting) or not real) and not start_button_pressed then -- left eng can be started
			eng1_starting = true
			left_eng_start_time = time_now
			start_button_pressed = true
		elseif selected_eng == 1 and eng_start and ((get(virt_rud2) < 0.06 and get(right_prt24_on) == 1 and not eng1_starting) or not real) and not start_button_pressed then -- right eng can be started
			eng2_starting = true
			right_eng_start_time = time_now	
			start_button_pressed = true
		end
		
		-- release start button
		start_button_pressed = eng_start
		
		-- left engine --
		-- start process on ground for left engine	
		if eng1_starting and ground_start and (not cold_rotate or not real) then
			
			-- rpm check
			if not left_rpm_check and rpm1 > 20 and real then
					start_volt = 0
					start_amp = 0				
					eng1_starting = false
					left_eng_start_time = left_eng_start_time - 70
			else left_rpm_check = true
			end
			
			-- turn on the starter
			if time_now - left_eng_start_time > 1 and time_now - left_eng_start_time < 28 then
				commandBegin(starter_1)
				set(stg1_starter, 1)
			end
			
			-- turn on the fuel
			if (time_now - left_eng_start_time > 25 and time_now - left_eng_start_time < 45) or rpm1 > 30 then
				set(fuel_start1, 1)
			end
			
			-- start volt and amp calculations
			if time_now - left_eng_start_time > 3 and time_now - left_eng_start_time < 9 then 
				start_volt = 20 + rpm1
				start_amp = 600 - rpm1 * 50
			elseif time_now - left_eng_start_time > 9 and time_now - left_eng_start_time < 15 then 
				start_volt = 29 + (rpm1 - 8.3)
				start_amp = 600 - (rpm1 - 8.3) * 40
			elseif time_now - left_eng_start_time > 15 and time_now - left_eng_start_time < 20 then 
				start_volt = 39 + (rpm1 - 14.9) * 2
				start_amp = 600 - (rpm1 - 14.9) * 40
			elseif time_now - left_eng_start_time > 20 and time_now - left_eng_start_time < 26 then 
				start_volt = 43 + (rpm1 - 18.8) * 0.13
				start_amp = 600 - (rpm1 - 18.8) * 10
			elseif time_now - left_eng_start_time > 26 and rpm1 < 45 then 
				start_volt = 51 + (rpm1 - 43) * 2
				start_amp = 600 - (rpm1 - 43) * 5
				
			
				
			else 
				start_volt = 0
				start_amp = 0
			end
			
			-- finish startup process
			if time_now - left_eng_start_time > 50 or rpm1 > 45 then 
				eng1_starting = false 
				commandEnd(starter_1)
				set(stg1_starter, 0)
				left_rpm_check = false
				start_volt = 0
				start_amp = 0
			end 
			
			-- emergency stop startup process
			if stop_button then  
				eng1_starting = false
				left_eng_start_time = left_eng_start_time - 70
				set(fuel_start1, 0)
				commandEnd(starter_1)
				set(stg1_starter, 0)
				start_volt = 0
				start_amp = 0
				left_rpm_check = false
			end	
			
					
		end
		----------------------Tunning startup extended throttle for left engine here------------------------------------------------------------------------
			if time_now - left_eng_start_time < 60 and rpm1 > 10 and rpm1 < 45 then 
				set(tro_need_1, 0.001)
			
			elseif time_now - left_eng_start_time < 60 and rpm1 > 45 and rpm1 < 92 then 
				set(tro_need_1, 0.075)
		    end
			

		-- start process on air for left engine	
		if eng1_starting and not ground_start and not cold_rotate then
			-- turn on the starter
			if time_now - left_eng_start_time < 20 and rpm1 > 50 then
				commandBegin(starter_1)
				set(stg1_starter, 1)
			else 
				commandEnd(starter_1)
				set(stg1_starter, 0)
			end
			-- turn on the fuel
			if time_now - left_eng_start_time > 2 and time_now - left_eng_start_time < 40 then
				set(fuel_start1, 1)
			end
			
			if time_now - left_eng_start_time > 40 then eng1_starting = false end -- finish startup process
			
			if stop_button then  -- emergency stop startup process
				eng1_starting = false
				left_eng_start_time = left_eng_start_time - 70
				set(fuel_start1, 0)
				commandEnd(starter_1)
				set(stg1_starter, 0)
			end				
		end

		-- cold rotate for left engine
		if eng1_starting and cold_rotate and real then
			-- turn on the starter
			if time_now - left_eng_start_time < 20 then
				commandBegin(starter_1)
				set(stg1_starter, 1)
			else 
				commandEnd(starter_1)
				set(stg1_starter, 0)
				eng1_starting = false
			end
			
			-- start volt and amp calculations
			if time_now - left_eng_start_time > 3 and time_now - left_eng_start_time < 9 then 
				start_volt = 20 + rpm1
				start_amp = 600 - rpm1 * 50
			elseif time_now - left_eng_start_time > 9 and time_now - left_eng_start_time < 15 then 
				start_volt = 29 + (rpm1 - 8.3)
				start_amp = 600 - (rpm1 - 8.3) * 40
			elseif time_now - left_eng_start_time > 15 and time_now - left_eng_start_time < 20 then 
				start_volt = 39 + (rpm1 - 14.9) * 2
				start_amp = 600 - (rpm1 - 14.9) * 40
			elseif time_now - left_eng_start_time > 20 and time_now - left_eng_start_time < 26 then 
				start_volt = 43 + (rpm1 - 18.8) * 0.13
				start_amp = 600 - (rpm1 - 18.8) * 10
			elseif time_now - left_eng_start_time > 26 and rpm1 < 45 then 
				start_volt = 51 + (rpm1 - 43) * 2
				start_amp = 600 - (rpm1 - 43) * 5
			else 
				start_volt = 0
				start_amp = 0
			end
			
			if stop_button then  -- emergency stop startup process
				eng1_starting = false
				left_eng_start_time = left_eng_start_time - 70
				--set(fuel_start1, 0)
				commandEnd(starter_1)
				set(stg1_starter, 0)
			end
		end

		-- right engine --
		-- start process on ground for right engine	
		if eng2_starting and ground_start and (not cold_rotate or not real) then
			-- rpm check
			if not right_rpm_check and rpm2 > 20 and real then
					start_volt = 0
					start_amp = 0				
					eng2_starting = false
					right_eng_start_time = right_eng_start_time - 70
			else right_rpm_check = true
			end
			
			-- turn on the starter
			if time_now - right_eng_start_time > 1 and time_now - right_eng_start_time < 28 then
				commandBegin(starter_2)
				set(stg2_starter, 1)
			end

			-- turn on the fuel
			if (time_now - right_eng_start_time > 25 and time_now - right_eng_start_time < 45) or rpm2 > 30 then
				set(fuel_start2, 1)
			end
			
			-- start volt and amp calculations
			if time_now - right_eng_start_time > 3 and time_now - right_eng_start_time < 9 then 
				start_volt = 20 + rpm2
				start_amp = 700 - rpm2 * 50
			elseif time_now - right_eng_start_time > 9 and time_now - right_eng_start_time < 15 then 
				start_volt = 29 + (rpm2 - 8.3)
				start_amp = 700 - (rpm2 - 8.3) * 40
			elseif time_now - right_eng_start_time > 15 and time_now - right_eng_start_time < 20 then 
				start_volt = 39 + (rpm2 - 14.9) * 2
				start_amp = 700 - (rpm2 - 14.9) * 40
			elseif time_now - right_eng_start_time > 20 and time_now - right_eng_start_time < 26 then 
				start_volt = 43 + (rpm2 - 18.8) * 0.13
				start_amp = 700 - (rpm2 - 18.8) * 10
			elseif time_now - right_eng_start_time > 26 and rpm2 < 45 then 
				start_volt = 51 + (rpm2 - 43) * 2
				start_amp = 700 - (rpm2 - 43) * 5
			else 
				start_volt = 0
				start_amp = 0
			end

			-- finish startup process
			if time_now - right_eng_start_time > 50 or rpm2 > 45 then 
				eng2_starting = false 
				commandEnd(starter_2)
				set(stg2_starter, 0)
				right_rpm_check = false
				start_volt = 0
				start_amp = 0
			end 
			
			-- emergency stop startup process
			if stop_button then 
				eng2_starting = false
				right_eng_start_time = right_eng_start_time - 70
				set(fuel_start2, 0)
				commandEnd(starter_2)
				set(stg2_starter, 0)
				start_volt = 0
				start_amp = 0
				right_rpm_check = false
			end				
		end
----------------------Tunning startup extended throttle for right engine here---

			if time_now - right_eng_start_time < 60 and rpm2 > 10 and rpm2 < 45 then 
				set(tro_need_2, 0.001)
			
			elseif time_now - right_eng_start_time < 60 and rpm2 > 45 and rpm2 < 92 then 
				set(tro_need_2, 0.075)
		    end
			
		-- start process on air for right engine	
		if eng2_starting and not ground_start and not cold_rotate then
			-- turn on the starter
			if time_now - right_eng_start_time < 20 and rpm2 > 50 then
				commandBegin(starter_2)
				set(stg2_starter, 1)
			else 
				commandEnd(starter_2) 
				set(stg2_starter, 0)
			end
			-- turn on the fuel
			if time_now - right_eng_start_time > 2 and time_now - right_eng_start_time < 40 then
				set(fuel_start2, 1)
			end
			
			if time_now - right_eng_start_time > 40 then eng2_starting = false end -- finish startup process
			
			if stop_button then  -- emergency stop startup process
				eng2_starting = false
				right_eng_start_time = right_eng_start_time - 70
				set(fuel_start2, 0)
				commandEnd(starter_2)
				set(stg2_starter, 0)
			end			
		end
		
		-- cold rotate for right engine
		if eng2_starting and cold_rotate and real then
			-- turn on the starter
			if time_now - right_eng_start_time < 20 then
				commandBegin(starter_2)
				set(stg2_starter, 1)
			else 
				commandEnd(starter_2)
				set(stg2_starter, 0)
				eng2_starting = false
			end
			
			-- start volt and amp calculations
			if time_now - right_eng_start_time > 3 and time_now - right_eng_start_time < 9 then 
				start_volt = 20 + rpm2
				start_amp = 700 - rpm2 * 50
			elseif time_now - right_eng_start_time > 9 and time_now - right_eng_start_time < 15 then 
				start_volt = 29 + (rpm2 - 8.3)
				start_amp = 700 - (rpm2 - 8.3) * 40
			elseif time_now - right_eng_start_time > 15 and time_now - right_eng_start_time < 20 then 
				start_volt = 39 + (rpm2 - 14.9) * 2
				start_amp = 700 - (rpm2 - 14.9) * 40
			elseif time_now - right_eng_start_time > 20 and time_now - right_eng_start_time < 26 then 
				start_volt = 43 + (rpm2 - 18.8) * 0.13
				start_amp = 700 - (rpm2 - 18.8) * 10
			elseif time_now - right_eng_start_time > 26 and rpm2 < 45 then 
				start_volt = 51 + (rpm2 - 43) * 2
				start_amp = 700 - (rpm2 - 43) * 5
				elseif time_now - right_eng_start_time > 26 and rpm2 < 90 then 
				start_volt = 51 + (rpm2 - 43) * 2
				start_amp = 700 - (rpm2 - 43) * 5
			else 
				start_volt = 0
				start_amp = 0
			end
			
			if stop_button then  -- emergency stop startup process
				eng2_starting = false
				right_eng_start_time = right_eng_start_time - 70
				--set(fuel_start2, 0)
				commandEnd(starter_2)
				set(stg2_starter, 0)
			end				

		end
	else
		eng1_starting = false
		left_eng_start_time = left_eng_start_time - 70
		commandEnd(starter_1)
		set(stg1_starter, 0)
		left_rpm_check = false
		
		eng2_starting = false
		right_eng_start_time = right_eng_start_time - 70
		commandEnd(starter_2)
		set(stg2_starter, 0)
		right_rpm_check = false
		
		start_volt = 0
		start_amp = 0
		start_button_pressed = false
	end
	
	
	
	-- RU-19 start logic
	local ru19_cold_rotate = get(ru19_start_mode) == 0
	local ru19_stop_button = get(ru19_start_stop) == 1
	local ru19_main = get(ru19_start_main_sw) == 1
	local start_button = get(ru19_ground_start_btn) == 1 or get(ru19_air_start_btn) == 1
	-- determine start process
	if start_button and ((power_em and ru19_main) or not real) and not ru19_start_button_pressed then
		eng3_starting = true
		ru19_start_time = time_now
		ru19_start_button_pressed = true
	end
	
	ru19_start_button_pressed = start_button
	
	-- start the engine
	if eng3_starting and (not ru19_cold_rotate or not real) then
		if time_now - ru19_start_time < 28 and ru_rpm < 31 then
			commandBegin(starter_3)
			set(gs24_starter, 1)
			set(fuel_start3, 1)
		else 
			commandEnd(starter_3)
			set(gs24_starter, 0)
			eng3_starting = false
		end
		-- stop starting process
		if ru19_stop_button or (not ru19_main and real) then
			set(fuel_start3, 0)
			commandEnd(starter_3)
			set(gs24_starter, 0)
			eng3_starting = false
			ru19_start_time = ru19_start_time - 30
		end
		
	elseif eng3_starting and real then
		if time_now - ru19_start_time < 20 then
			commandBegin(starter_3)
			set(gs24_starter, 1)
		else 
			commandEnd(starter_3)
			set(gs24_starter, 0)
			eng3_starting = false
		end	
		
		-- stop starting process
		if ru19_stop_button or not ru19_main then
			commandEnd(starter_3)
			set(gs24_starter, 0)
			eng3_starting = false
			ru19_start_time = ru19_start_time - 30
		end
		
	end
		

	if power or power_em then
			-- turn on the igniters			
			set(sim_igniter1, 1)
			set(sim_ignition1, 1)
			set(sim_igniter2, 1)
			set(sim_ignition2, 1)
			set(sim_igniter3, 1)
			set(sim_ignition3, 1)
			-- set lamp indicators
			if eng1_starting or eng2_starting then set(apd_work_lit, 1) else set(apd_work_lit, 0) end
			if eng3_starting then set(pt29_work_lit, 1) else set(pt29_work_lit, 0) end
			if ru_rpm < 63 then set(strip_lit, 1) else set(strip_lit, 0) end
	else
			-- turn off the igniters			
			set(sim_igniter1, 0)
			set(sim_ignition1, 0)
			set(sim_igniter2, 0)
			set(sim_ignition2, 0)
			set(sim_igniter3, 0)
			set(sim_ignition3, 0)
			-- set lamp indication
			set(apd_work_lit, 0)
			set(pt29_work_lit, 0)
			set(strip_lit, 0)
	end
	
	if not real then start_volt = 0 start_amp = 0 end
	
	if start_volt > 70 then start_volt = 70 end
	if start_amp > 600 then start_amp = 600 end
	
	set(starter_volt, start_volt)
	set(starter_amp, start_amp)
	
	-- stop starter (bugs workariond)
	if not eng1_starting then 
		commandEnd(starter_1) 
		set(stg1_starter, 0)	
	end
	if not eng2_starting then 
		commandEnd(starter_2) 
		set(stg2_starter, 0)
	end
	if not eng3_starting then 
		commandEnd(starter_3) 
		set(gs24_starter, 0)
	end
	

	
end
	-- last variables

end

