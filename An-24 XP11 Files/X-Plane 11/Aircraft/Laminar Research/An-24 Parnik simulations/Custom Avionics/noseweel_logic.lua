defineProperty("weel_switch", globalPropertyi("sim/custom/xap/An24_gauges/noseweel"))

defineProperty("weel_angle1", globalPropertyf("sim/aircraft/gear/acf_nw_steerdeg1"))
defineProperty("weel_angle2", globalPropertyf("sim/aircraft/gear/acf_nw_steerdeg2"))

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) -- power on 27 volt bus
defineProperty("nosewheel_mode_lamp", globalPropertyi("sim/custom/xap/An24_gauges/nosewheel_mode_lamp"))

defineProperty("nosewheel_mode_ready", globalPropertyi("sim/custom/xap/An24_gauges/nosewheel_mode_ready"))
defineProperty("nosewheel_mode_ready_delay", globalPropertyi("sim/custom/xap/An24_gauges/nosewheel_mode_ready_delay")) -- int18h
defineProperty("nosewheel_mode_time_to_ready", globalPropertyi("sim/custom/xap/An24_gauges/nosewheel_mode_time_to_ready")) -- int18h

defineProperty("main_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.
defineProperty("emerg_press", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press")) -- pressure in emergency system. initial 120 kg per square sm. maximum 160.
-- weel_switch -1 = taxi , 0 = off , 1 = take off/landing
-- lamp 1 = taxi, 2 = off, 3 = takeoff/landing, 0 = none
createProp("sim/custom/xap/An24_gauges/nosewheel_mode_lamp", "int", 0);  -- lamp of nosewheel mode

defineProperty("lock", globalPropertyi("sim/cockpit2/controls/nosewheel_steer_on"))

function update()
	
    set(nosewheel_mode_ready_delay, 2)
    
	set(lock, 1) -- do not let nosewheel become free castor
	
	local ws = get(weel_switch)
	local power = get(bus_DC_27_volt) > 21
	local press = math.max(get(main_press), get(emerg_press)) / 120

    if press > 1 then press = 1 end
	
	if ws == -1 and power then   
        set(weel_angle1, 45 * press) 
        set(weel_angle2, 45 * press) 
        set(nosewheel_mode_lamp, 1)
        set(nosewheel_mode_ready, 0)
        set(nosewheel_mode_time_to_ready, os.time())
	elseif (ws == 1 and power) then 
        if get(nosewheel_mode_ready) == 0 then
            set(weel_angle1, 1) 
            set(weel_angle2, 1)
            set(nosewheel_mode_lamp, 2)
            if os.time() > (get(nosewheel_mode_time_to_ready)+get(nosewheel_mode_ready_delay)) then --
                set(nosewheel_mode_ready, 1)                                                        --
            end                                                                                     --
        else    
            set(weel_angle1, 10 * press) 
            set(weel_angle2, 10 * press) 
            set(nosewheel_mode_lamp, 3)
        end    
	elseif ws == 0 and power then 
        set(weel_angle1, 1) 
        set(weel_angle2, 1)  
        set(nosewheel_mode_lamp, 0)
        set(nosewheel_mode_ready, 0)
        set(nosewheel_mode_time_to_ready, os.time())                                                --
	else 
		set(weel_angle1, 1) 
		set(weel_angle2, 1) 
		set(nosewheel_mode_lamp, 0) 
        --set(nosewheel_mode_ready, 0)                                                              --
        --set(nosewheel_mode_time_to_ready, os.time())                                              --
	end



end


--gear_togle_command = findCommand("sim/flight_controls/gyro_rotor_trim_up")

gear_togle_command = findCommand("sim/flight_controls/nwheel_steer_toggle")
function gear_toggle_handler(phase)
	if 0 == phase then
		if get(weel_switch) ~= 1 then set(weel_switch, 1)
		else set(weel_switch, -1) end
	end
return 0
end

registerCommandHandler(gear_togle_command, 0, gear_toggle_handler)
