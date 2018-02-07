-- this is a main power logic, connecting all generator, batteries and panels and calculating power load on busses

-- define property table
-- connect sources to bus
defineProperty("stg1_on", globalPropertyi("sim/custom/xap/An24_power/stg1_on")) -- generator connected if 1 and dissconnected if 0
defineProperty("stg2_on", globalPropertyi("sim/custom/xap/An24_power/stg2_on"))

defineProperty("bat1_on", globalPropertyi("sim/custom/xap/An24_power/bat1_on"))  -- battery switch. 0 = OFF, 1 = ON
defineProperty("bat2_on", globalPropertyi("sim/custom/xap/An24_power/bat2_on"))
defineProperty("bat3_on", globalPropertyi("sim/custom/xap/An24_power/bat3_on"))

defineProperty("stg1_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg1_on_bus"))  -- generator connected if 1 and dissconnected if 0
defineProperty("stg2_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg2_on_bus"))
defineProperty("gs24_on_bus", globalPropertyi("sim/custom/xap/An24_power/gs24_on_bus"))
defineProperty("go1_on_bus", globalPropertyi("sim/custom/xap/An24_power/go1_on_bus"))
defineProperty("go2_on_bus", globalPropertyi("sim/custom/xap/An24_power/go2_on_bus"))

defineProperty("inv_PT1000_1", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_1"))  -- inverters
defineProperty("inv_PT1000_2", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_2"))
defineProperty("inv_PT750", globalPropertyi("sim/custom/xap/An24_power/inv_PT750"))

defineProperty("main_on_emerg", globalPropertyi("sim/custom/xap/An24_power/main_on_emerg"))  -- main bus connected to emergency bus
defineProperty("DC_source", globalPropertyi("sim/custom/xap/An24_power/DC_source"))  -- source for DC27v bus. 0 = none, 1 = STG1, 2 = STG2, 3 = GS24, 4 = bat. left gen by default
defineProperty("AC_source", globalPropertyi("sim/custom/xap/An24_power/AC_source"))  -- source for AC115 bus. 1 when generators, 2 when inverter
defineProperty("PO750_mode", globalPropertyi("sim/custom/xap/An24_power/PO750_mode"))  -- switcher for PO750. 0 = ground, 1 = off, 2 = on
defineProperty("GS24_mode", globalPropertyi("sim/custom/xap/An24_power/GS24_mode"))  -- start from: 0 = ground power, 1 = off, 2 = GS24
defineProperty("power_mode", globalPropertyi("sim/custom/xap/An24_power/power_mode"))  -- power mode: 0 = Ground, 1 = off, 2 = airplane
defineProperty("ground_available", globalPropertyi("sim/custom/xap/An24_power/ground_available"))
-- logic

-- generators and bat voltage
defineProperty("stg1_volt", globalPropertyf("sim/custom/xap/An24_power/stg1_volt")) -- generators voltage.
defineProperty("stg2_volt", globalPropertyf("sim/custom/xap/An24_power/stg2_volt"))
defineProperty("gs24_volt", globalPropertyf("sim/custom/xap/An24_power/gs24_volt"))
defineProperty("go1_volt", globalPropertyf("sim/custom/xap/An24_power/go1_volt"))
defineProperty("go2_volt", globalPropertyf("sim/custom/xap/An24_power/go2_volt"))

defineProperty("stg1_amp", globalPropertyf("sim/custom/xap/An24_power/stg1_amp")) -- generators current, initial 0A
defineProperty("stg2_amp", globalPropertyf("sim/custom/xap/An24_power/stg2_amp")) 
defineProperty("gs24_amp", globalPropertyf("sim/custom/xap/An24_power/gs24_amp"))
defineProperty("go1_amp", globalPropertyf("sim/custom/xap/An24_power/go1_amp"))
defineProperty("go2_amp", globalPropertyf("sim/custom/xap/An24_power/go2_amp")) 

defineProperty("bat_all_amp", globalPropertyf("sim/custom/xap/An24_power/bat_all_amp"))  -- overall load of batteries
defineProperty("bat_all_volt", globalPropertyf("sim/custom/xap/An24_power/bat_all_volt"))  -- overall voltage of batteries
defineProperty("bat_amp_cc", globalPropertyf("sim/custom/xap/An24_power/bat_amp_cc"))  -- if batteries are charging, they take current instead of give it. = 0 when bat is source

-- buses currents and voltage
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_amp", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_amp")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_DC_27_amp_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_amp_emerg")) 
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt")) 
defineProperty("bus_AC_36_amp", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_amp")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("bus_AC_115_amp", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_amp")) 

defineProperty("stg1_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg1_amp_cc"))  -- generator current consumption as starter, initial 0A
defineProperty("stg2_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg2_amp_cc")) 
defineProperty("gs24_amp_cc", globalPropertyf("sim/custom/xap/An24_power/gs24_amp_cc")) 

-- default sim variables
defineProperty("sim_bat_on", globalPropertyi("sim/cockpit/electrical/battery_on"))
defineProperty("sim_avionics_on", globalPropertyi("sim/cockpit/electrical/avionics_on"))

defineProperty("sim_inv1_on", globalPropertyi("sim/cockpit2/electrical/inverter_on[0]"))
defineProperty("sim_inv2_on", globalPropertyi("sim/cockpit2/electrical/inverter_on[1]"))

-- current consumption
--[[defineProperty("stg1_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg1_amp_cc"))  -- generator current consumption as starter, initial 0A
defineProperty("stg2_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg2_amp_cc")) 
defineProperty("gs24_amp_cc", globalPropertyf("sim/custom/xap/An24_power/gs24_amp_cc"))

defineProperty("bat_amp_cc", globalPropertyf("sim/custom/xap/An24_power/bat_amp_cc")) --]]


-- calculate buses every frame
function update()
	set(sim_bat_on, 1) -- test
	
	-- caclulations for DC 27v bus
	local DC27_volt = 0
	local DC27_source = get(DC_source)  -- 1 = STG1, 2 = STG2, 3 = GS24, 4 = bat. 0 = ground
	-- select work source and set voltage for bus
	local bats_on = 0
	local ground = get(ground_available)
	
	local stg1 = get(stg1_volt) * get(stg1_on_bus)
	local stg2 = get(stg2_volt) * get(stg2_on_bus)
	local gs24 = get(gs24_volt) * get(gs24_on_bus)
	local bats = get(bat_all_volt)
	
	local stg1_work = 0
	if stg1 > 19 then stg1_work = 1 end
	
	local stg2_work = 0
	if stg2 > 19 then stg2_work = 1 end
	
	local gs24_work = 0
	if gs24 > 19 then gs24_work = 1 end
	
	if get(power_mode) == 2 then
		if get(bat1_on)	== 1 or get(bat2_on) == 1 or get(bat3_on) == 1 then bats_on = 1 else bats_on = 0 end  -- define if batteries are ON
	
		if stg1_work + stg2_work + gs24_work > 0 then 
			DC27_volt = (stg1 + stg2 + gs24) / (stg1_work + stg2_work + gs24_work)
			DC27_source = 6
	--[[	elseif stg1 > 19 and stg2 > 19 then -- both generators are on and work
			DC27_volt = (stg1 + stg2) / 2
			DC27_source = 5
		elseif stg1 > 19 then -- STG left will work if its on and not overload
			DC27_volt = stg1
			DC27_source = 1
		elseif stg2 > 19 then -- STG right will work when STG left is not and STG right not overloaded
			DC27_volt = get(stg2_volt)
			DC27_source = 2
		elseif gs24 > 19 then -- GS24 will work when both gens are OFF and it's not overloaded
			DC27_volt = get(gs24_volt)
			DC27_source = 3 --]]
		elseif bats > 21 then -- of none of gens are not work - power will be taken from batteries in case if emergensy bus is connected to main
			DC27_volt = bats * get(main_on_emerg) * bats_on  -- bus will work if it's connected to emergency bus
			DC27_source = 4
		else DC27_volt = 0
		end
		-- default battery and avionics ON
		--set(sim_bat_on, bats_on)
		set(sim_avionics_on, bats_on)
	elseif get(power_mode) == 0 then
		DC27_source = 0
		if ground == 1 then DC27_volt = 27 end
		--set(sim_bat_on, ground)
		set(sim_avionics_on, 1)
	else	
		DC27_source = 0
		DC27_volt = 0
		--set(sim_bat_on, 0)
		set(sim_avionics_on, 0)
	end
	
	set(DC_source, DC27_source)  -- set selected source for other logics			
	set(bus_DC_27_volt, DC27_volt) -- set voltage on DC bus 27v
	-- print(get(bus_DC_27_volt))
	-- calculations for emergency bus
	local emerg_volt = get(bat_all_volt) * bats_on
	if DC27_source == 4 then emerg_volt = get(bat_all_volt) * bats_on else emerg_volt = DC27_volt  end -- emergency bus works as long as batteries are connected
	set(bus_DC_27_volt_emerg, emerg_volt)

	-- set default inverters
	if DC27_volt > 20 or emerg_volt > 20 then 
		set(sim_inv1_on, 1)
		set(sim_inv2_on, 1)
	else
		set(sim_inv1_on, 0)
		set(sim_inv2_on, 0)
	end

	-- calculations for AC 36v bus
	local AC36_volt = 0	
	
	if get(inv_PT1000_1) == 1 and (DC27_volt > 21 or emerg_volt > 21) then AC36_volt = 36
	elseif get(inv_PT1000_2) == 1 and emerg_volt > 21 then AC36_volt = 36
	else AC36_volt = 0
	end

	set(bus_AC_36_volt, AC36_volt) -- set voltage on DC bus 36v 
	
	-- calculations for AC 115v bus
	local AC115_volt = 0
	local AC115_source = 0 -- 1, 2 when generators, 3 when inverter, 0 = ground	
	if get(PO750_mode) == 0 then
		if get(ground_available) == 1 then AC115_volt = 115 end
		AC115_source = 0
	elseif get(go1_volt) * get(go1_on_bus) > 0 and get(go1_amp) < 133 then 
		AC115_volt = get(go1_volt)
		AC115_source = 1
	elseif get(go2_volt) * get(go2_on_bus) > 0 and get(go2_amp) < 133 then 
		AC115_volt = get(go2_volt)
		AC115_source = 2
	elseif get(inv_PT750) == 1 and DC27_volt > 21 and emerg_volt > 21 and get(PO750_mode) == 2 then 
		AC115_volt = 115
		AC115_source = 3
	else AC115_source = 0
	end
	set(AC_source, AC115_source) -- set selected source for other logics
	set(bus_AC_115_volt, AC115_volt) 

	-- try to relocate currents from buses to sources
	-- local PT750_amp = 0
	if AC115_source == 1 then set(go1_amp, get(bus_AC_115_amp)) else set(go1_amp, 0) end  -- current on GO-left
	if AC115_source == 2 then set(go2_amp, get(bus_AC_115_amp)) else set(go2_amp, 0) end
	-- if AC115_source == 3 then PT750_amp = get(bus_AC_115_amp) end -- calculate current on PT750
		
	local bus27_amp = get(bus_DC_27_amp) -- + get(bus_DC_27_amp_emerg)   -- current on main bus will be calculated in other logic

	--if DC27_source == 1 then set(stg1_amp, bus27_amp) else set(stg1_amp, 0) end  -- current on STG-left
	--if DC27_source == 2 then set(stg2_amp, bus27_amp) else set(stg2_amp, 0) end -- current on STG-right
	--if DC27_source == 3 then set(gs24_amp, bus27_amp) else set(gs24_amp, 0) end -- current on GS24
	if DC27_source == 4 then set(bat_all_amp, bus27_amp) else set(bat_all_amp, 0 - get(bat_amp_cc)) end
	if DC27_source == 6 then -- all generators are on bus and work parralel
		set(stg1_amp, bus27_amp * stg1_work / (stg1_work + stg2_work + gs24_work))
		set(stg2_amp, bus27_amp * stg2_work / (stg1_work + stg2_work + gs24_work))		
		set(gs24_amp, bus27_amp * gs24_work / (stg1_work + stg2_work + gs24_work))
	else 
		set(stg1_amp, 0)
		set(stg2_amp, 0)		
		set(gs24_amp, 0)
	end
	--[[
	-- relocating curents on engines start
	if get(GS24_mode) == 2 and DC27_volt > 0 then
		if (get(stg1_amp_cc) > 35 or get(stg2_amp_cc) > 35) and get(gs24_volt) > 19 and get(gs24_on_bus) == 1 then  -- relocate current to GS24
			set(stg1_amp, 0)
			set(stg2_amp, 0)
			set(gs24_amp, bus27_amp)
		elseif (get(stg1_amp_cc) > 35 or get(stg2_amp_cc) > 35) then -- relocate to batteries
			set(stg1_amp, 0)
			set(stg2_amp, 0)
			set(gs24_amp, 0)
			set(bat_all_amp, bus27_amp)
			--set(DC_source, 4)
		end
	end	--]]		
	
			
end







