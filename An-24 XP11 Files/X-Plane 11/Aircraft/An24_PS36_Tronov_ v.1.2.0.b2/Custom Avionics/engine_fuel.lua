size = {2048, 2048}


-- sources
-- from fuel system
defineProperty("fuel_access1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access1")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("fuel_access2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access2")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("fuel_access3", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access3")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich

-- from center panel
defineProperty("fuel_stop1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop1")) -- stops on center panel
defineProperty("fuel_stop2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop2")) -- stops on center panel
defineProperty("fuel_stop1_cap", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop1_cap")) -- stops on center panel
defineProperty("fuel_stop2_cap", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop2_cap")) -- stops on center panel

-- from startup panel and automatic cut-off
defineProperty("fuel_start1", globalPropertyf("sim/custom/xap/An24_start/fuel_start1")) -- fuel start from startup panel
defineProperty("fuel_start2", globalPropertyf("sim/custom/xap/An24_start/fuel_start2")) -- fuel start from startup panel
defineProperty("fuel_start3", globalPropertyf("sim/custom/xap/An24_start/fuel_start3")) -- fuel start from startup panel

-- from outside service
defineProperty("left_eng_main", globalPropertyi("sim/custom/xap/An24_covers/left_eng_main"))  -- left engine main cover
defineProperty("left_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/left_eng_ext"))  -- left engine exhaust cover
defineProperty("right_eng_main", globalPropertyi("sim/custom/xap/An24_covers/right_eng_main"))  -- right engine main cover
defineProperty("right_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/right_eng_ext"))  -- right engine exhaust cover
defineProperty("ru19_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/ru19_eng_ext"))  -- ru19 engine exhaust cover

-- fire extinguishers
defineProperty("sim_engine_ext1", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[0]"))  -- left engine fire extinguiher
defineProperty("sim_engine_ext2", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[1]"))  -- right engine fire extinguiher
defineProperty("sim_engine_ext3", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[2]"))  -- RU19 engine fire extinguiher


-- result
defineProperty("mixt_valve1", globalPropertyf("sim/flightmodel/engine/ENGN_mixt[0]")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve2", globalPropertyf("sim/flightmodel/engine/ENGN_mixt[1]")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve3", globalPropertyf("sim/flightmodel/engine/ENGN_mixt[2]")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich


function update()
	-- left engine fuel access
	set(mixt_valve1, get(fuel_access1) * get(fuel_stop1) * get(fuel_start1) * get(left_eng_main) *  get(left_eng_ext) * (1 - get(sim_engine_ext1)))
	
	-- right engine fuel access
	set(mixt_valve2, get(fuel_access2) * get(fuel_stop2) * get(fuel_start2)* get(right_eng_main) * get(right_eng_ext) * (1 - get(sim_engine_ext2)))

	-- RU19 engine fuel access
	set(mixt_valve3, get(fuel_access3) * get(fuel_start3) * get(ru19_eng_ext) * (1 - get(sim_engine_ext3)))
	
	
	
end

