-- this is the logic for manipulate gears movements and its failures

-- define property table
-- landing gears
defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  -- vertical deflection of front gear
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
defineProperty("gear3_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of right gear

defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  --deploy of front gear
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear

-- hydraulic system 
defineProperty("hydro_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.
defineProperty("gear_valve", globalPropertyi("sim/custom/xap/An24_hydro/gear_valve")) -- position of gear valve for gydraulic calculations and animations.
defineProperty("gear_unblock", globalPropertyi("sim/custom/xap/An24_hydro/gear_unblock")) -- remove block from gear retraction on ground
defineProperty("gear_rotary", globalPropertyi("sim/custom/xap/An24_hydro/gear_rotary")) -- position of gear valve for gydraulic calculations and animations.
defineProperty("direction", globalPropertyi("sim/custom/xap/An24_hydro/direction")) -- gear request ( used for SmartCopilot )

-- enviroment
defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))  -- knots indicated air speed
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("G", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload

-- failures
defineProperty("retract1_fail", globalPropertyi("sim/operation/failures/rel_lagear1")) -- fail of retract gear
defineProperty("retract2_fail", globalPropertyi("sim/operation/failures/rel_lagear2")) -- fail of retract gear
defineProperty("retract3_fail", globalPropertyi("sim/operation/failures/rel_lagear3")) -- fail of retract gear
defineProperty("actuator_fail", globalPropertyi("sim/operation/failures/rel_gear_act")) -- actuator fail. bugs workaround

defineProperty("rel_wing1L", globalPropertyi("sim/operation/failures/rel_wing1L"))  -- Wing separations
defineProperty("rel_wing1R", globalPropertyi("sim/operation/failures/rel_wing1R"))  -- Wing separations

defineProperty("set_real_gears", globalPropertyi("sim/custom/xap/An24_set/real_gears")) --  gears can fail in overspeed
defineProperty("cam_in_cockpit", globalPropertyi("sim/graphics/view/view_is_external"))




-- test
defineProperty("gear_steer", globalPropertyf("sim/aircraft/gear/acf_nw_steerdeg1")) 
-- commands
--local gear_command_up = createCommand("xap/an24/gear_up", "retract landing gear landing gear")
--local gear_command_down = createCommand("xap/an24/gear_down", "extend landing gear landing gear")
gear_command_up = findCommand("sim/flight_controls/landing_gear_up")
gear_command_down = findCommand("sim/flight_controls/landing_gear_down")
gear_toggle = findCommand("sim/flight_controls/landing_gear_toggle")


local gear_move1 = loadSample('Custom Sounds/gear_move.wav')
local gear_move2 = loadSample('Custom Sounds/gear_move.wav')
local gear_move3 = loadSample('Custom Sounds/gear_move.wav')
local gear_close1 = loadSample('Custom Sounds/gear_lock.wav')
local gear_close2 = loadSample('Custom Sounds/gear_lock.wav')
local gear_close3 = loadSample('Custom Sounds/gear_lock.wav')

setSampleGain(gear_close1, 400)
setSampleGain(gear_close2, 400)
setSampleGain(gear_close3, 400)


-- local variables
local passed = 0
local lock1 = true  -- locks for gears 
local lock2 = true
local lock3 = true

local fake_command = false -- this is for fixing X-Plane gear bug. (X-Plane does't have 3 position gear handler)

local power = 1

function gear_up_handler(phase)
	if 0 == phase then
		if not fake_command then
			local a = get(direction) - 1
			if a < -1 then a = -1 end
			set(gear_valve, a)
			set(gear_rotary, a)
			set(direction, a * power)
		else
			fake_command = false
		end			
	end
	return 0
end

function gear_down_handler(phase)
	if 0 == phase then
		if not fake_command then
			local a = get(direction) + 1
			if a > 1 then a = 1 end
			set(gear_valve, a)
			set(gear_rotary, a)
			set(direction, a * power)
		else
			fake_command = false
		end
	end
	return 0
end

function gear_toggle_handler(phase)
	if 0 == phase then
		local a = get(direction)
		if a ~= 0 then
			a = 0
		else
			if get(gear1_deploy) > 0.7 then
				a = -1
			elseif get(gear1_deploy) < 0.3 then
				a =  1
			end
		end
		
		set(gear_valve, a)
		set(gear_rotary, a)
		set(direction, a * power)
				
		--logDebug( "Direction - " .. get(direction))
		--logDebug( "Deploy - " .. get(gear1_deploy) )
		--logDebug( "Lock 1 - " .. lock1)
		--logDebug( "Lock 2 - " .. lock2)
		--logDebug( "Lock 3 - " .. lock3)
		--logDebug( "Retract - ".. retract )
		-- direction = a * power
	
	end
	return 0
end

registerCommandHandler(gear_command_up, 0, gear_up_handler)
registerCommandHandler(gear_command_down, 0, gear_down_handler)
registerCommandHandler(gear_toggle, 0, gear_toggle_handler)

local lock1_last = lock1
local lock2_last = lock2
local lock3_last = lock3

local pos1_last = get(gear1_deploy)
local pos2_last = get(gear2_deploy)
local pos3_last = get(gear3_deploy)

local gear1_crash = false   -- variables for gear crash calculations
local gear2_crash = false
local gear3_crash = false

-- constants (Update for xplane 11 23042017)
 
local GEAR_SPEED = 1.7 / 4.5 -- per second
 
local HYDRO = 0.006
 
local pos1 = 1 --get(gear1_deploy)  -- initial positions of gears
 
local pos2 = 1 --get(gear2_deploy)
 
local pos3 = 1 --get(gear3_deploy) 

-- end update


if pos1 > 0 then pos1 = 1 end
if pos2 > 0 then pos2 = 1 end
if pos3 > 0 then pos3 = 1 end

--print(pos1, pos2, pos3)

-- every frame calculations
function update()
	
	local view_ext = get(cam_in_cockpit)
	
	--local pos1 = get(gear1_deploy)  -- update positions of gears
	--local pos2 = get(gear2_deploy)
	--local pos3 = get(gear3_deploy)
	
	--print("inside update func" ,pos1, pos2, pos3)
	
	passed = get(frame_time)

	power = 1 -- variable for manipulate gears only when power exist. will calculate it later

	local real = get(set_real_gears) == 1
	-- all calculations produced only during sim work
	if passed > 0 then

		local G_coef = 0.4 - get(hydro_press) * 0.002
		local A_coef = (0.2 - get(hydro_press) * 0.001) / 80
		local main_hydro = get(hydro_press)
	
		-- direction = get(gear_valve) * power 
	
		-- calculate locks
		--[[if direction ~= 0 then
		lock1 = false  -- locks for gears 
		lock2 = false
		lock3 = false		
		end --]]

		-- calculate if gears can retract depending on autoblock
		local retract = false
		if get(gear2_deflect) < 0.01 or get(gear_unblock) > 0 then retract = true else retract = false end
		-- test
		--[[retract = true
		lock1 = false  -- locks for gears 
		lock2 = false
		lock3 = false--]]
	
		-- gears crash
		if get(gear1_deflect) > 0.6 then gear1_crash = true end
		if get(gear2_deflect) > 0.55 then gear2_crash = true end
		if get(gear3_deflect) > 0.55 then gear3_crash = true end
	
	-- calculations for gear 1 (Update for xplane 11 23042017)
            if not lock1 and not gear1_crash and retract and get(retract1_fail) < 6 then
            -- calculate position        
            pos1 = pos1_last + 1.2 * GEAR_SPEED * (get(direction) * get(hydro_press) * HYDRO + get(G) * math.cos(math.pi * pos1_last / 2) * G_coef + get(airspeed) * math.sin(math.pi * pos1_last / 2) * A_coef + math.random() * 0.1) * passed
            if not isSamplePlaying(gear_move1) and pos1 > 0 and pos1 < 1 then playSample(gear_move1, 1) end
            setSampleGain(gear_move1, (main_hydro * 2 + view_ext * 200) * 0.3)
            setSamplePitch(gear_move1, power * main_hydro * 7)
            if pos1 < 0 then  -- limit positions and close lock when reached
                pos1 = 0
                lock1 = true
                --logDebug( "Lock True 0")
            elseif pos1 > 1 then
                --logDebug( "Lock True 1")
                pos1 = 1
                lock1 = true
              end
            end
-- cancel update 

		-- calculate crash position
		if gear1_crash and real then
			if pos1 > 0.2 then pos1 = pos1 - passed / 2 end
			if pos1 < 0.2 then
				pos1 = 0.2
				gear1_crash = false
			end
		end
		
		--print("point 3", pos1)

		-- calculations for gear 2
		if not lock2 and not gear2_crash and retract and get(retract2_fail) < 6 then
			-- calculate position		
			pos2 = pos2_last + GEAR_SPEED * (get(direction) * get(hydro_press) * HYDRO + get(G) * math.cos(math.pi * pos1_last / 2) * G_coef + get(airspeed) * math.sin(math.pi * pos1_last / 2) * A_coef + math.random() * 0.1) * passed
			if not isSamplePlaying(gear_move2) and pos2 > 0 and pos2 < 1 then playSample(gear_move2, 1) end
			setSampleGain(gear_move2, (main_hydro * 2 + view_ext * 200) * 0.3)
			setSamplePitch(gear_move2, power * main_hydro * 7)
			if pos2 < 0 then  -- limit positions and close lock when reached
				pos2 = 0
				lock2 = true
			elseif pos2 > 1 then
				pos2 = 1
				lock2 = true
			end
		end

		-- calculate crash position
		if gear2_crash and real then
			if pos2 > 0.3 then pos2 = pos2 - passed / 2 end
			if pos2 < 0.3 then 
				pos2 = 0.3 
				gear2_crash = false
			end
		end
	
		-- calculations for gear 3
		if not lock3 and not gear3_crash and retract and get(retract3_fail) < 6 then
			-- calculate position		
			pos3 = pos3_last + GEAR_SPEED * (get(direction) * get(hydro_press) * HYDRO + get(G) * math.cos(math.pi * pos1_last / 2) * G_coef + get(airspeed) * math.sin(math.pi * pos1_last / 2) * A_coef + math.random() * 0.1) * passed
			if not isSamplePlaying(gear_move3) and pos3 > 0 and pos3 < 1 then playSample(gear_move3, 1) end
			setSampleGain(gear_move3, (main_hydro * 2 + view_ext * 200) * 0.3)
			setSamplePitch(gear_move3, power * main_hydro * 7)
			if pos3 < 0 then  -- limit positions and close lock when reached
				pos3 = 0
				lock3 = true
			elseif pos3 > 1 then
				pos3 = 1
				lock3 = true
			end
		end

		-- calculate crash position
		if gear3_crash and real then
			if pos3 > 0.3 then pos3 = pos3 - passed / 2 end
			if pos3 < 0.3 then 
				pos3 = 0.3 
				gear3_crash = false
			end
		end
	
		-- limit gear positions
		if pos1 > 1 then pos1 = 1 end
		if pos1 < 0 then pos1 = 0 end
		if pos2 > 1 then pos2 = 1 end
		if pos2 < 0 then pos2 = 0 end
		if pos3 > 1 then pos3 = 1 end
		if pos3 < 0 then pos3 = 0 end
	
		-- calculate locks
		lock1 = get(direction) < 1 and pos1 < 0.001 or get(direction) > -1 and pos1 > 0.999
		lock2 = get(direction) < 1 and pos2 < 0.001 or get(direction) > -1 and pos2 > 0.999
		lock3 = get(direction) < 1 and pos3 < 0.001 or get(direction) > -1 and pos3 > 0.999
	
		--logDebug( "lock1 - " ..tostring(lock1 ))
		--logDebug( "Dir".. get(direction) )
		--logDebug( "Pos" .. pos1)

		-- play lock sounds
		if lock1_last ~= lock1 then playSample(gear_close1, 0) end
		if lock2_last ~= lock2 then playSample(gear_close2, 0) end
		if lock3_last ~= lock3 then playSample(gear_close3, 0) end

		-- stop playing sounds
		if lock1 or get(direction) == 0 then stopSample(gear_move1) end
		if lock2 or get(direction) == 0 then stopSample(gear_move2) end
		if lock3 or get(direction) == 0 then stopSample(gear_move3) end

		-- bugs workaround
		local sim_pos1 = get(gear1_deploy)
		if lock1 and sim_pos1 > 0 and sim_pos1 < 0.1 then
			fake_command = true
			commandOnce(gear_command_up)
		elseif lock1 and sim_pos1 < 1 and sim_pos1 > 0.9 then
			fake_command = true	
			commandOnce(gear_command_down) 
		end
	
		-- wing separations
		if get(rel_wing1L) == 6 then pos3 = 0 end
		if get(rel_wing1R) == 6 then pos2 = 0 end
	
		-- set results
		set(gear1_deploy, pos1)
		set(gear2_deploy, pos2)	
		set(gear3_deploy, pos3)

		pos1_last = pos1
		pos2_last = pos2
		pos3_last = pos3
	
		lock1_last = lock1
		lock2_last = lock2
		lock3_last = lock3
	
	end

end

