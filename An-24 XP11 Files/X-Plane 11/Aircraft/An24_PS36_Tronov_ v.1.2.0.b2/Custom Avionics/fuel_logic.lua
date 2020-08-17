-- this is the logic of fuel system

-- define propery table
defineProperty("fire_valve1", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve1")) -- fire valve for engine 1
defineProperty("fire_valve2", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve2")) -- fire valve for engine 2
defineProperty("fire_valve3", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve3")) -- fire valve for engine 3
defineProperty("fire_valve1_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve1_sw")) -- fire valve switch for engine 1
defineProperty("fire_valve2_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve2_sw")) -- fire valve switch for engine 2
defineProperty("fire_valve3_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve3_sw")) -- fire valve switch for engine 3
defineProperty("fuel_circle_valve_sw", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_valve_sw")) -- valve for fuel circulation between left and right tanks
defineProperty("fuel_circle_valve", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_valve")) -- valve for fuel circulation between left and right tanks
defineProperty("mixt_valve1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access1")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access2")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve3", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access3")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("auto_ff", globalPropertyi("sim/custom/xap/An24_fuel/auto_ff")) -- automatic fuel flow
defineProperty("fuel_q_meter1", globalPropertyi("sim/custom/xap/An24_fuel/q_meter1_switch")) -- switcher for fuel meter 1
defineProperty("fuel_q_meter2", globalPropertyi("sim/custom/xap/An24_fuel/q_meter2_switch")) -- switcher for fuel meter 2
defineProperty("ff_meter", globalPropertyi("sim/custom/xap/An24_fuel/ff_meter_switch")) -- switcher for fuel flow meter 1
defineProperty("tank1_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank1_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank2_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank2_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank3_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank3_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank4_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank4_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich

-- quantity in fuel tanks in numbers of aircraft's tanks
defineProperty("fuel_q_1", globalPropertyf("sim/flightmodel/weight/m_fuel[0]")) -- fuel quantity for tank 1
defineProperty("fuel_q_2", globalPropertyf("sim/flightmodel/weight/m_fuel[1]")) -- fuel quantity for tank 2
defineProperty("fuel_q_3", globalPropertyf("sim/flightmodel/weight/m_fuel[2]")) -- fuel quantity for tank 3
defineProperty("fuel_q_4", globalPropertyf("sim/flightmodel/weight/m_fuel[3]")) -- fuel quantity for tank 4
defineProperty("fuel_q_all", globalPropertyf("sim/flightmodel/weight/m_fuel_total")) -- fuel quantity for all tanks

-- failures
defineProperty("fuel_block_1", globalPropertyi("sim/operation/failures/rel_fuel_block0"))  -- fuel filter block
defineProperty("fuel_block_2", globalPropertyi("sim/operation/failures/rel_fuel_block1"))
defineProperty("fuel_block_3", globalPropertyi("sim/operation/failures/rel_fuel_block2"))
defineProperty("fuel_block_4", globalPropertyi("sim/operation/failures/rel_fuel_block3"))

defineProperty("fuel_fluct1", globalPropertyi("sim/operation/failures/rel_fuelfl0"))  -- fuel fluctuation engine 1
defineProperty("fuel_fluct2", globalPropertyi("sim/operation/failures/rel_fuelfl1"))  -- fuel fluctuation engine 1
defineProperty("fuel_fluct3", globalPropertyi("sim/operation/failures/rel_fuelfl2"))  -- fuel fluctuation engine 2

-- pumps
defineProperty("fuel_pump_1", globalPropertyi("sim/custom/xap/An24_fuel/tank1_pump"))  -- fuel pump for tank 1
defineProperty("fuel_pump_2", globalPropertyi("sim/custom/xap/An24_fuel/tank2_pump"))  -- fuel pump for tank 2
defineProperty("fuel_pump_3", globalPropertyi("sim/custom/xap/An24_fuel/tank3_pump"))  -- fuel pump for tank 3
defineProperty("fuel_pump_4", globalPropertyi("sim/custom/xap/An24_fuel/tank4_pump"))  -- fuel pump for tank 4
defineProperty("pump1_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump1_switch"))  -- fuel pump switch tank 1
defineProperty("pump2_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump2_switch"))  -- fuel pump switch tank 2
defineProperty("pump3_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump3_switch"))  -- fuel pump switch tank 3
defineProperty("pump4_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump4_switch"))  -- fuel pump switch tank 4

-- other pumps
--[[defineProperty("pump_1", globalPropertyi("sim/cockpit/engine/fuel_pump_on[0]"))  -- fuel pump for eng 1
defineProperty("pump_2", globalPropertyi("sim/cockpit/engine/fuel_pump_on[1]"))  -- fuel pump for eng 2
defineProperty("pump_3", globalPropertyi("sim/cockpit/engine/fuel_pump_on[2]"))  -- fuel pump for eng 3

defineProperty("pump_eng_1", globalPropertyi("sim/cockpit2/engine/actuators/fuel_pump_on[0]"))  -- fuel pump for eng 1
defineProperty("pump_eng_2", globalPropertyi("sim/cockpit2/engine/actuators/fuel_pump_on[2]"))  -- fuel pump for eng 2
defineProperty("pump_eng_3", globalPropertyi("sim/cockpit2/engine/actuators/fuel_pump_on[3]"))  -- fuel pump for eng 3
--]]
defineProperty("real_fuel_pump_1", globalPropertyi("sim/cockpit2/fuel/fuel_tank_pump_on[0]"))  -- real fuel pump for tank 1
defineProperty("real_fuel_pump_4", globalPropertyi("sim/cockpit2/fuel/fuel_tank_pump_on[3]"))  -- real fuel pump for tank 4

-- engines
defineProperty("FF1", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[0]")) -- fuel flow for engine 1
defineProperty("FF2", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[1]")) -- fuel flow for engine 2
defineProperty("FF3", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[2]")) -- fuel flow for engine 3

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("real_fuel", globalPropertyi("sim/custom/xap/An24_set/real_fuel")) -- switch for real fuel system or FSE compability


-- electric
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

defineProperty("fuel_pumps_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_pumps_cc")) -- fuel pumps current consumption
defineProperty("fuel_valves_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_valves_cc")) -- fuel valves current consumption
defineProperty("fuel_circle_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_circle_cc")) -- fuel valves current consumption
defineProperty("fuel_meter_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_meter_cc")) -- fuel meters current consumption


-- local variables
local passed = 0
local sync_timer = 10

local tank1_q = get(fuel_q_1) -- virtual quantity for tank 1
local tank2_q = get(fuel_q_2) -- virtual quantity for tank 2
local tank3_q = get(fuel_q_3) -- virtual quantity for tank 3
local tank4_q = get(fuel_q_4) -- virtual quantity for tank 4

local eng1_use = 1  -- by default engine use tank 1
local eng2_use = 4
local tank1_work = 1
local tank2_work = 1
local tank3_work = 1
local tank4_work = 1

-- post frame calculations
function update()
	passed = get(frame_time)
	local power_27_main = 1 -- variable for system work only when power_27_main exist. will calculate it later
	local power_27_emerg = 1 -- variable for system work only when power_27_emerg exist. will calculate it later
	local power_36 = 1
	local power_115 = 1
	-- print(get(bus_DC_27_volt))
-- all calculations produced only during sim work
	local real = get(real_fuel) == 1
if passed > 0 then
	-- power calculations
	if get(bus_DC_27_volt) > 21 then power_27_main = 1 else power_27_main = 0 end
	if get(bus_DC_27_volt_emerg) > 21 then power_27_emerg = 1 else power_27_emerg = 0 end
	if get(bus_AC_36_volt) > 34 then power_36 = 1 else power_36 = 0 end
	if get(bus_AC_115_volt) > 112 then power_115 = 1 else power_115 = 0 end
	
	
	local pump1_cc = 0 -- pump counsumption
	local pump2_cc = 0
	local pump3_cc = 0
	local pump4_cc = 0
	local FV1_cc = 0  -- fire valve conumption
	local FV2_cc = 0
	local FV3_cc = 0
	-- fire valves logic
	local valve1 = get(fire_valve1)
	local valve2 = get(fire_valve2)
	local valve3 = get(fire_valve3)
	-- valve 1
	if get(fire_valve1_sw) == 1 and valve1 < 1 then 
		valve1 = valve1 + passed * power_27_emerg / 4  -- valve will full open in 4 sec
		FV1_cc = power_27_emerg * 3
	end  
	if get(fire_valve1_sw) == 0 and valve1 > 0 then 
		valve1 = valve1 - passed * power_27_emerg / 4 -- valve will full close in 4 sec
		FV1_cc = power_27_emerg * 3
	end  
	set(fire_valve1, valve1)  -- set results
	-- valve 2
	if get(fire_valve2_sw) == 1 and valve2 < 1 then 
		valve2 = valve2 + passed * power_27_emerg / 4  -- valve will full open in 4 sec
		FV2_cc = power_27_emerg * 3
	end  
	if get(fire_valve2_sw) == 0 and valve2 > 0 then 
		valve2 = valve2 - passed * power_27_emerg / 4 -- valve will full close in 4 sec
		FV2_cc = power_27_emerg * 3
	end  
	set(fire_valve2, valve2)  -- set results
	-- valve 3
	if get(fire_valve3_sw) == 1 and valve3 < 1 then 
		valve3 = valve3 + passed * power_27_emerg / 4  -- valve will full open in 4 sec
		FV3_cc = power_27_emerg * 3
	end  
	if get(fire_valve3_sw) == 0 and valve3 > 0 then 
		valve3 = valve3 - passed * power_27_emerg / 4 -- valve will full close in 4 sec
		FV3_cc = power_27_emerg * 3
	end  
	set(fire_valve3, valve3)  -- set results
	
	-- fire valve consumption
	set(fuel_valves_cc, FV1_cc + FV2_cc + FV2_cc)
	
	-- fuel pumps logic
	-- pump 1
	if get(pump1_switch) == 2 then
		if tank1_q > 12.5 then 
			set(fuel_pump_1, power_27_main)
			pump1_cc = power_27_main * 2
		else 
			set(fuel_pump_1, 0) 
			pump1_cc = 0 
		end
	elseif get(pump1_switch) == 0 then 
		set(fuel_pump_1, power_27_main)
		pump1_cc = power_27_main * 2
	else 
		set(fuel_pump_1, 0)
		pump1_cc = 0 
	end

	-- pump 2
	if get(pump2_switch) == 1 then 
		set(fuel_pump_2, power_27_main) 
		pump2_cc = power_27_main * 2
	else 
		set(fuel_pump_2, 0)
		pump2_cc = 0
	end
	
	-- pump 3
	if get(pump3_switch) == 1 then 
		set(fuel_pump_3, power_27_main) 
		pump3_cc = power_27_main * 2
	else 
		set(fuel_pump_3, 0)
		pump3_cc = 0
	end
	
	-- pump 4
	if get(pump4_switch) == 2 then
		if tank4_q > 12.5 then 
			set(fuel_pump_4, power_27_main)
			pump4_cc = power_27_main * 2
		else 
			set(fuel_pump_4, 0) 
			pump4_cc = 0 
		end
	elseif get(pump4_switch) == 0 then 
		set(fuel_pump_4, power_27_main)
		pump4_cc = power_27_main * 2
	else 
		set(fuel_pump_4, 0)
		pump4_cc = 0 
	end
	
	-- fuel pumps current counsumption
	set(fuel_pumps_cc, pump1_cc + pump2_cc + pump3_cc + pump4_cc)
	
	-- fuel tanks logic
	
	-- usage of fuel calculations
	if get(fuel_block_1) ~= 6 then tank1_work = 1 else tank1_work = 0 end
	if get(fuel_block_2) ~= 6 then tank2_work = 1 else tank2_work = 0 end
	if get(fuel_block_3) ~= 6 then tank3_work = 1 else tank3_work = 0 end
	if get(fuel_block_4) ~= 6 then tank4_work = 1 else tank4_work = 0 end

	-- fuel flow calculations
	local engine1_flow = get(FF1) * passed
	local engine2_flow = get(FF2) * passed
	local engine3_flow = get(FF3) * passed
	
	-- recalculate tanks
	local tank1 = tank1_q * tank1_work - 12.5  -- unused fuel level
	local tank2 = tank2_q * tank2_work - 12.5 - 240 * (1 - get(fuel_pump_2))
	local tank3 = tank3_q * tank3_work - 12.5 - 240 * (1 - get(fuel_pump_3))
	local tank4 = tank4_q * tank4_work - 12.5
	
	-- calculate circle valve work
	local fuel_circle = get(fuel_circle_valve_sw) * power_27_main
	set(fuel_circle_valve, fuel_circle)
	set(fuel_circle_cc, fuel_circle * power_27_main * 3)
	-- calculate new fuel levels depending on tanks work and circle valve
	if get(auto_ff) == 1 or fuel_circle * math.abs (tank1 + tank2 - tank3 - tank4) > 100 then			
		-- determine tank with max quantity
		local max_num = 0
		if tank1 > tank2 and tank1 > tank3 and tank1 > tank4 and tank1 > 0 then max_num = 1
		elseif tank2 > tank3  and tank2 > tank4 and tank2 > 0 then max_num = 2
		elseif tank3 > tank4 and tank3 > 0 then max_num = 3
		elseif tank4 > 0 then max_num = 4 
		else max_num = 0 end
		-- take fuel from selected tank
		if max_num == 1 then tank1_q = tank1_q - (engine1_flow + engine2_flow + engine3_flow)
		elseif max_num == 2 then tank2_q = tank2_q - (engine1_flow + engine2_flow + engine3_flow)
		elseif max_num == 3 then tank3_q = tank3_q - (engine1_flow + engine2_flow + engine3_flow)
		elseif max_num == 4 then tank4_q = tank4_q - (engine1_flow + engine2_flow + engine3_flow)
		end	
		eng1_use = max_num
		eng2_use = max_num
	else 
		-- left wing
		if tank1 > tank2 and tank1 > 0 then 
			tank1_q = tank1_q - engine1_flow
			eng1_use = 1
		elseif tank2 > 0 then 
			tank2_q = tank2_q - engine1_flow
			eng1_use = 2
		else eng1_use = 0 end
		-- right wing
		if tank4 > tank3 and tank4 > 0 then 
			tank4_q = tank4_q - engine2_flow - engine3_flow
			eng2_use = 4
		elseif tank3 > 0 then 
			tank3_q = tank3_q - engine2_flow - engine3_flow
			eng2_use = 3
		else eng2_use = 0 end
	end
	
	-- quantity synchronisation
	sync_timer = sync_timer + passed
	if sync_timer > 10 then
		sync_timer = 0 -- reset counter
		-- if there was refueling
		local refuel = (tank1_q + tank2_q + tank3_q + tank4_q - get(fuel_q_all))
		if math.abs(refuel) > 10 then -- if added or taken more then 10 kg of fuel
			tank1_q = get(fuel_q_1) -- virtual quantity for tank 1
			tank2_q = get(fuel_q_2) -- virtual quantity for tank 2
			tank3_q = get(fuel_q_3) -- virtual quantity for tank 3
			tank4_q = get(fuel_q_4) -- virtual quantity for tank 4
		end
		-- check overall quantity and set calculated values
		local diff = refuel / 4  -- calc difference between calculated quantity and simulated
		
		if diff <= 0 and real then -- if calculated less then simulated, then set it
			set(fuel_q_1, tank1_q)
			set(fuel_q_2, tank2_q)
			set(fuel_q_3, tank3_q)
			set(fuel_q_4, tank4_q)
		elseif math.abs(refuel) < 10 and real then
			set(fuel_q_1, tank1_q - diff)  -- else set not more then simulated
			set(fuel_q_2, tank2_q - diff)
			set(fuel_q_3, tank3_q - diff)
			set(fuel_q_4, tank4_q - diff)
			tank1_q = get(fuel_q_1) -- virtual quantity for tank 1
			tank2_q = get(fuel_q_2) -- virtual quantity for tank 2
			tank3_q = get(fuel_q_3) -- virtual quantity for tank 3
			tank4_q = get(fuel_q_4) -- virtual quantity for tank 4	
		end
	end
	
	-- set engine failures and fuel access
	-- engine 1
	if eng1_use == 0 then set(mixt_valve1, 0)
	else set(mixt_valve1, valve1) end
	
	-- engines 2 and 3
	if eng2_use == 0 then 
		set(mixt_valve2, 0)
		set(mixt_valve3, 0)
	else
		set(mixt_valve2, valve2)
		set(mixt_valve3, valve3)
	end
	
	-- indication of fuel quantity calculation
	local fuel_m_cc1 = 0
	local fuel_m_cc2 = 0
	-- left wing fuel meter
	if power_27_main * power_115 * get(fuel_q_meter1) > 0 then
		set(tank1_q_ind, tank1_q)
		set(tank2_q_ind, tank2_q)
		fuel_m_cc1 = 1
	else 
		set(tank1_q_ind, -10)
		set(tank2_q_ind, -10)
		fuel_m_cc1 = 0
	end
	-- right wing fuel meter
	if power_27_main * power_115 * get(fuel_q_meter2) > 0 then
		set(tank3_q_ind, tank3_q)
		set(tank4_q_ind, tank4_q)
		fuel_m_cc2 = 1
	else 
		set(tank3_q_ind, -10)
		set(tank4_q_ind, -10)
		fuel_m_cc2 = 0
	end
	set(fuel_meter_cc, fuel_m_cc1 + fuel_m_cc2)
	
	-- set other pumps to work
	--[[set(pump_1, 1)
	set(pump_2, 1)
	set(pump_3, 1)
	set(pump_eng_1, 1)
	set(pump_eng_2, 1)
	set(pump_eng_3, 1)--]]
	
	-- logic for real fuel pumps. this logic must be extended
	if engine1_flow == 0 or pump1_cc + pump2_cc == 0 then set(real_fuel_pump_1, 0) else set(real_fuel_pump_1, 1) end
	if engine2_flow + engine3_flow == 0 or pump3_cc + pump4_cc == 0 then set(real_fuel_pump_4, 0) else set(real_fuel_pump_4, 1) end


end

end
