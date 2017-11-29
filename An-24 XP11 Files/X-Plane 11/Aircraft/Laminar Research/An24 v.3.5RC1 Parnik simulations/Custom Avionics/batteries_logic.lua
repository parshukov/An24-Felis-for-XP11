-- this is simple logic of batteries. calculations for each bat are here.

-- initialize component property table
defineProperty("bat1_volt", globalPropertyf("sim/custom/xap/An24_power/bat1_volt")) -- battery voltage, initial 27V - full charge.
defineProperty("bat2_volt", globalPropertyf("sim/custom/xap/An24_power/bat2_volt")) 
defineProperty("bat3_volt", globalPropertyf("sim/custom/xap/An24_power/bat3_volt")) 

defineProperty("bat1_amp", globalPropertyf("sim/custom/xap/An24_power/bat1_amp"))  -- battery current, initial 0A. positive - battery load, negative - battery recharge.
defineProperty("bat2_amp", globalPropertyf("sim/custom/xap/An24_power/bat2_amp")) 
defineProperty("bat3_amp", globalPropertyf("sim/custom/xap/An24_power/bat3_amp")) 

defineProperty("bat_all_amp", globalPropertyf("sim/custom/xap/An24_power/bat_all_amp"))  -- overall load of batteries
defineProperty("bat_all_volt", globalPropertyf("sim/custom/xap/An24_power/bat_all_volt"))  -- overall voltage of batteries

defineProperty("bat1_on", globalPropertyi("sim/custom/xap/An24_power/bat1_on"))  -- battery switch. 0 = OFF, 1 = ON
defineProperty("bat2_on", globalPropertyi("sim/custom/xap/An24_power/bat2_on"))
defineProperty("bat3_on", globalPropertyi("sim/custom/xap/An24_power/bat3_on"))

defineProperty("stg1_is_gen", globalPropertyi("sim/custom/xap/An24_power/stg1_is_gen"))  -- generator can work as starter for his engine, if this variable = 0.
defineProperty("stg2_is_gen", globalPropertyi("sim/custom/xap/An24_power/stg2_is_gen")) 
defineProperty("gs24_is_gen", globalPropertyi("sim/custom/xap/An24_power/gs24_is_gen")) 
defineProperty("stg1_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg1_on_bus"))  -- generator connected if 1 and dissconnected if 0
defineProperty("stg2_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg2_on_bus"))
defineProperty("gs24_on_bus", globalPropertyi("sim/custom/xap/An24_power/gs24_on_bus"))

defineProperty("ground_available", globalPropertyi("sim/custom/xap/An24_power/ground_available"))
-- logic
defineProperty("bat_amp_cc", globalPropertyf("sim/custom/xap/An24_power/bat_amp_cc"))  -- if batteries are charging, they take current instead of give it. = 0 when bat is source
defineProperty("power_mode", globalPropertyi("sim/custom/xap/An24_power/power_mode"))  -- power mode: 0 = Ground, 1 = off, 2 = airplane
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("emerg_mode", globalPropertyi("sim/custom/xap/An24_power/emerg_mode"))  -- switcher for emergency power. 0 = auto, 1 = on main bus, 2 = emergency bus only

-- define local variables
local bat1_capacity = 20 -- A*H. initial capacity. will use for volt calculations
local bat2_capacity = 20 
local bat3_capacity = 20 


function update()  -- every frame calculations

	-- get some variables
	local bat_on1 = get(bat1_on)
	local bat_on2 = get(bat2_on)
	local bat_on3 = get(bat3_on)

local passed = get(frame_time)

if passed > 0 then
	
	local bat_volt1 = 20 -- bat volt depends on current capacity and load or charge
	local bat_volt2 = 20 
	local bat_volt3 = 20  

	local bat_volt_all = (bat_volt1 + bat_volt2 + bat_volt3) / 3  -- mean ariphmetic of all connected batteries
	local ground_power = 0
	if get(ground_available) == 1 and get(power_mode) == 0 then ground_power = 1 end

	if bat_on1 == 1 or bat_on2 == 1 or bat_on3 == 1 then   -- all of calculations can be skipped if batteries are off

		-- calculate if batteries are source. depending if generators work and connected to bus
		local bat_source = false
		if get(stg1_is_gen) * get(stg1_on_bus) == 0 and get(stg2_is_gen) * get(stg2_on_bus) == 0 and get(gs24_is_gen) * get(gs24_on_bus) == 0 and ground_power == 0 then 
		set(bat_amp_cc, 0)	
		bat_source = true
		else
		set(bat_amp_cc, (28 * (bat_on1 + bat_on2 + bat_on3) - bat1_capacity * bat_on1 - bat2_capacity * bat_on2 - bat3_capacity * bat_on3))   -- bat current depends on their charge
		bat_source = false
		end

		-- calculate each bat current
		local bat_amp_all = get(bat_all_amp) - get(bat_amp_cc)
		local bat_amp1 = bat_amp_all * bat_on1 / (bat_on1 + bat_on2 + bat_on3) -- current on each bat depends on how many bats are connected
		local bat_amp2 = bat_amp_all * bat_on2 / (bat_on1 + bat_on2 + bat_on3)
		local bat_amp3 = bat_amp_all * bat_on3 / (bat_on1 + bat_on2 + bat_on3)

		-- calculate curent bat capacity
		bat1_capacity = bat1_capacity - bat_amp1 * passed / 3600
		if bat1_capacity < 0 then 
			bat1_capacity = 0 
			bat_amp1 = 0
		end
		if bat1_capacity > 28 then 
			bat1_capacity = 28
			bat_amp1 = 0
		end

		bat2_capacity = bat2_capacity - bat_amp2 * passed / 3600
		if bat2_capacity < 0 then 
			bat2_capacity = 0 
			bat_amp2 = 0
		end
		if bat2_capacity > 28 then 
			bat2_capacity = 28
			bat_amp2 = 0
		end
	
		bat3_capacity = bat3_capacity - bat_amp3 * passed / 3600
		if bat3_capacity < 0 then 
			bat3_capacity = 0 
			bat_amp3 = 0
		end
		if bat3_capacity > 28 then 
			bat3_capacity = 28
			bat_amp3 = 0
		end

		-- calculate bat volts
		bat_volt1 = 20 + bat1_capacity * 4 * bat_on1 / 28 - bat_amp1 / 110  -- bat volt depends on current capacity and load or charge
		bat_volt2 = 20 + bat2_capacity * 4 * bat_on2 / 28 - bat_amp2 / 110
		bat_volt3 = 20 + bat3_capacity * 4 * bat_on3 / 28 - bat_amp3 / 110  
		
		bat_volt_all = (bat_volt1 + bat_volt2 + bat_volt3) / 3  -- mean ariphmetic of all connected batteries
		
		if bat_volt_all < 21 and bat_source then
			bat1_capacity = bat1_capacity / 2
			bat2_capacity = bat2_capacity / 2
			bat3_capacity = bat3_capacity / 2
			bat_volt1 = 18.5
			bat_volt2 = 18.5
			bat_volt3 = 18.5
		end
		
		-- set current for ampermeters	
		set(bat1_amp, bat_amp1) 
		set(bat2_amp, bat_amp2) 
		set(bat3_amp, bat_amp3) 

		-- set volts
		set(bat1_volt, bat_volt1)
		set(bat2_volt, bat_volt2)
		set(bat3_volt, bat_volt3)
	
		-- set result of all calculations
		set(bat_all_volt, bat_volt_all)
  	else 
		set(bat_all_volt, 0)
 		-- set current for ampermeters	
		set(bat1_amp, 0) 
		set(bat2_amp, 0) 
		set(bat3_amp, 0) 
		-- set volts
		set(bat1_volt, 0)
		set(bat2_volt, 0)
		set(bat3_volt, 0)
  	end
end

end
