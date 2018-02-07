-- this is simple logic of generators. calculations for each bat are here.

-- initialize component property table
defineProperty("stg1_volt", globalPropertyf("sim/custom/xap/An24_power/stg1_volt")) -- generator STG18 voltage. initial 28.5V
defineProperty("stg2_volt", globalPropertyf("sim/custom/xap/An24_power/stg2_volt"))
defineProperty("gs24_volt", globalPropertyf("sim/custom/xap/An24_power/gs24_volt"))
defineProperty("go1_volt", globalPropertyf("sim/custom/xap/An24_power/go1_volt"))
defineProperty("go2_volt", globalPropertyf("sim/custom/xap/An24_power/go2_volt"))

defineProperty("stg1_amp", globalPropertyf("sim/custom/xap/An24_power/stg1_amp")) -- generator current, initial 0A
defineProperty("stg2_amp", globalPropertyf("sim/custom/xap/An24_power/stg2_amp")) 
defineProperty("gs24_amp", globalPropertyf("sim/custom/xap/An24_power/gs24_amp"))
defineProperty("go1_amp", globalPropertyf("sim/custom/xap/An24_power/go1_amp"))
defineProperty("go2_amp", globalPropertyf("sim/custom/xap/An24_power/go2_amp")) 

defineProperty("stg1_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg1_amp_cc"))  -- generator current consumption as starter, initial 0A
defineProperty("stg2_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg2_amp_cc")) 
defineProperty("gs24_amp_cc", globalPropertyf("sim/custom/xap/An24_power/gs24_amp_cc")) 

defineProperty("stg1_is_gen", globalPropertyi("sim/custom/xap/An24_power/stg1_is_gen"))  -- generator can work as starter for his engine, if this variable = 0.
defineProperty("stg2_is_gen", globalPropertyi("sim/custom/xap/An24_power/stg2_is_gen")) 
defineProperty("gs24_is_gen", globalPropertyi("sim/custom/xap/An24_power/gs24_is_gen")) 

defineProperty("stg1_starter", globalPropertyi("sim/custom/xap/An24_power/stg1_starter"))  -- generator worknig as starter
defineProperty("stg2_starter", globalPropertyi("sim/custom/xap/An24_power/stg2_starter")) 
defineProperty("gs24_starter", globalPropertyi("sim/custom/xap/An24_power/gs24_starter")) 

-- all generators work from their engines

defineProperty("eng1_N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]")) -- engine 1 rpm
defineProperty("eng2_N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]")) -- engine 2 rpm
defineProperty("ru19_N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[2]")) -- engine 3 rpm

defineProperty("eng1_start", globalPropertyf("sim/cockpit/engine/starter_duration[0]")) -- starter duration in time
defineProperty("eng2_start", globalPropertyf("sim/cockpit/engine/starter_duration[1]")) 
defineProperty("eng3_start", globalPropertyf("sim/cockpit/engine/starter_duration[2]"))

defineProperty("stg1_on", globalPropertyi("sim/custom/xap/An24_power/stg1_on"))  -- generator connected to engine if 1 and dissconnected if 0
defineProperty("stg2_on", globalPropertyi("sim/custom/xap/An24_power/stg2_on")) 

-- default sim variables
defineProperty("sim_gen1_on", globalPropertyi("sim/cockpit/electrical/generator_on[0]"))
defineProperty("sim_gen2_on", globalPropertyi("sim/cockpit/electrical/generator_on[1]"))
defineProperty("sim_gen3_on", globalPropertyi("sim/cockpit/electrical/generator_on[2]"))

-- from start system
defineProperty("starter_amp", globalPropertyf("sim/custom/xap/An24_start/starter_amp")) -- starter amperage for engines start

-- failures
defineProperty("set_real_generators", globalPropertyi("sim/custom/xap/An24_set/real_generators")) -- generators can fail if overload

defineProperty("sim_gen1_fail", globalPropertyi("sim/operation/failures/rel_genera0"))
defineProperty("sim_gen2_fail", globalPropertyi("sim/operation/failures/rel_genera1"))
defineProperty("sim_gen3_fail", globalPropertyi("sim/operation/failures/rel_genera2"))

defineProperty("starter1_fail", globalPropertyi("sim/operation/failures/rel_startr0"))
defineProperty("starter2_fail", globalPropertyi("sim/operation/failures/rel_startr1"))
defineProperty("starter3_fail", globalPropertyi("sim/operation/failures/rel_startr2"))


function update() -- every frame calculations are here
	-- pre calculation defifnitions

	local eng_rpm1 = get(eng1_N2)
	local eng_rpm2 = get(eng2_N2)
	local eng_rpm3 = get(ru19_N2)
	local eng1_work = 0
	local eng2_work = 0
	local starter = get(starter_amp)
	
	local eng1_start = get(stg1_starter)
	local eng2_start = get(stg2_starter)
	local eng3_start = get(gs24_starter)
	
	local gen1_amp = get(stg1_amp)
	local gen2_amp = get(stg2_amp)
	local gen3_amp = get(gs24_amp)
	
	-- generators failures
	local real = get(set_real_generators) == 1
	local gen1_fail = get(sim_gen1_fail) == 6
	local gen2_fail = get(sim_gen2_fail) == 6
	local gen3_fail = get(sim_gen3_fail) == 6
	
	-- set overload fails
	if real then
		if gen1_amp > 650 then set(sim_gen1_fail, 6) end
		if gen2_amp > 650 then set(sim_gen2_fail, 6) end
		if gen3_amp > 1000 then set(sim_gen3_fail, 6) end
		
		if gen1_fail then set(starter1_fail, 6) end
		if gen2_fail then set(starter2_fail, 6) end
		if gen3_fail then set(starter3_fail, 6) end
	end
	
	-- check engine work
	if eng_rpm1 > 40 then eng1_work = 1 else eng1_work = 0 end
	if eng_rpm2 > 40 then eng2_work = 1 else eng2_work = 0 end
	
	-- check if gens work as generator
	if eng1_start == 0 and eng1_work * get(stg1_on) > 0 then 
		set(stg1_is_gen, 1) 
		--eng1_work = 1
		set(sim_gen1_on, 1)
	else 
		set(stg1_is_gen, 0) 
		set(sim_gen1_on, 0)
	end
	if eng2_start == 0 and eng2_work * get(stg2_on) > 0 then 
		set(stg2_is_gen, 1) 
		--eng2_work = 1
		set(sim_gen2_on, 1)
	else 
		set(stg2_is_gen, 0) 
		set(sim_gen2_on, 0)
	end	
	if eng3_start == 0 and eng_rpm3 > 40 then 
		set(gs24_is_gen, 1) 
		set(sim_gen3_on, 1)
	else 
		set(gs24_is_gen, 0) 
		set(sim_gen3_on, 0)
	end

	-- calculations for left generator STG
	local stg_volt1 = (29 - gen1_amp / 300) * get(stg1_is_gen) * get(stg1_on)  -- calculate voltage of generator depending on it's load
	if get(stg1_is_gen) == 0 and eng1_start == 1 and eng2_start == 0 and starter > 0 then  -- calculate starter consumption
		stg_volt1 = 0
		set(stg1_amp_cc, starter)
	elseif stg_volt1 > 21 then set(stg1_amp_cc, 20) -- generator use current for produce power
	else set(stg1_amp_cc, 0)
	end
	if gen1_fail then stg_volt1 = 0 end
	set(stg1_volt, stg_volt1)
	--print(get(stg1_amp_cc))
	-- calculations for right generator STG
	local stg_volt2 = (29 - gen2_amp / 300) * get(stg2_is_gen) * get(stg2_on)  -- calculate voltage of generator depending on it's load
	if get(stg2_is_gen) == 0 and eng1_start == 0 and eng2_start == 1 and starter > 0 then  -- calculate starter consumption
		stg_volt2 = 0
		set(stg2_amp_cc, starter)
	elseif stg_volt2 > 21 then set(stg2_amp_cc, 20) -- generator use current for produce power
	else set(stg2_amp_cc, 0)
	end
	if gen2_fail then stg_volt2 = 0 end
	set(stg2_volt, stg_volt2)
	--print(get(stg1_amp_cc),get(stg2_amp_cc))
	-- calculations for RU19 generator
	local gs24_volts = (29 - gen3_amp / 700) * get(gs24_is_gen)
	--if eng1_start_last ~= eng1_start_now or eng2_start_last ~= eng2_start_now then gs24_volts = (60 - get(gs24_amp) * 30 / 600) * get(gs24_is_gen) end  -- GS24 produse more power when it used as source for engines starters
	if get(gs24_is_gen) == 0 and eng3_start == 1 then  -- calculate starter consumption
		gs24_volts = 0
		set(gs24_amp_cc, 400 - eng_rpm3 * 5)
	else set(gs24_amp_cc, 0)		
	end
	if gen3_fail then gs24_volts = 0 end
	set(gs24_volt, gs24_volts)

	-- calculations for left generator GO
	local go_volt1 = (120 - get(go1_amp) * 5 / 133) * eng1_work -- calculate voltage of generator depending on it's load and work of engine
	set(go1_volt, go_volt1)

	-- calculations for right generator GO
	local go_volt2 = (120 - get(go2_amp) * 5 / 133) * eng2_work -- calculate voltage of generator depending on it's load and work of engine
	set(go2_volt, go_volt2)
	

	
end
