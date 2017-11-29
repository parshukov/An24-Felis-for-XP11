size = {710, 990}

defineProperty("payload_subpanel", globalPropertyi("sim/custom/xap/An24_panels/payload_subpanel"))

-- sim load
defineProperty("payload", globalPropertyf("sim/flightmodel/weight/m_fixed"))  -- payload weight, kg
defineProperty("CG_load", globalPropertyf("sim/flightmodel/misc/cgz_ref_to_default")) -- Center of Gravity reference to default, m
defineProperty("fuel_q_1", globalPropertyf("sim/flightmodel/weight/m_fuel[0]")) -- fuel quantity for tank 1
defineProperty("fuel_q_2", globalPropertyf("sim/flightmodel/weight/m_fuel[1]")) -- fuel quantity for tank 2
defineProperty("fuel_q_3", globalPropertyf("sim/flightmodel/weight/m_fuel[2]")) -- fuel quantity for tank 3
defineProperty("fuel_q_4", globalPropertyf("sim/flightmodel/weight/m_fuel[3]")) -- fuel quantity for tank 4

-- images
defineProperty("background", loadImage("payload_panel.dds", 5, 3, size[1], size[2]))
defineProperty("vert_plank", loadImage("payload_panel.dds", 719, 5, 2, 100))
defineProperty("hor_plank_green", loadImage("payload_panel.dds", 730, 2, 100, 2))
defineProperty("hor_plank_orange", loadImage("payload_panel.dds", 730, 8, 100, 2))
defineProperty("red_flag", loadImage("payload_panel.dds", 734, 22, 70, 25))
-- digits images
defineProperty("digitsImage", loadImage("black_digit_strip.png", 1, 0, 14, 196))


-- interpolate values using table as reference
local function interpolate(tbl, value)
    local lastActual = 0
    local lastReference = 0
    for _k, v in pairs(tbl) do
        if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end

-- interpolate distance to fuel quantity
local distance_tbl = {{ 0.00, 0 },
                  {  400, 1000 },
                  {  2600, 5000 },  
                  {  5000, 11000 }}    

local gear_tbl = {{ 14000, 3.35 },
                  { 16000, 2.95 },
                  { 18000, 2.6  },  
                  { 20000, 2.35 },
				  { 21500, 2.2  },
				  { 30000, 1.8 }}  
				  

-- define variables
local empty_plane_weight = 14150 -- kg
local rutkit_weight = 139 -- kg
local prepared_plane_weight = empty_plane_weight + rutkit_weight
--local empty_CG = 22 -- %MAC
local max_plane_weight = 21800 -- kg

local flight_distance = 300 -- km
local reserv_distance = 100 -- km
local taxi_time = 20 -- min
local fuel_stock = 100 -- kg

local crew_weight = 160 -- kg
local stuard_weight = 120 -- kg
local used_fuel = interpolate(distance_tbl, flight_distance + reserv_distance) 
local fuel_weight = 50 + fuel_stock + used_fuel + taxi_time * 10 -- kg
local loaded_plane_weight = prepared_plane_weight + crew_weight + stuard_weight + fuel_weight 
local max_payload = max_plane_weight - loaded_plane_weight

local row_1_mass = 150
local row_2_mass = 150
local row_3_mass = 150
local row_4_mass = 150
local row_5_mass = 150
local row_6_mass = 150

local all_pax_mass = row_1_mass + row_2_mass + row_3_mass + row_4_mass + row_5_mass + row_6_mass

local cargo_1 = 500
local cargo_2 = 100
local cargo_3 = 90

local airplane_weight = loaded_plane_weight + all_pax_mass + cargo_1 + cargo_2 + cargo_3
local comercial_payload = all_pax_mass + cargo_1 + cargo_2 + cargo_3
local landing_weight = airplane_weight - used_fuel

local pos1 = 237  -- initial position in pixels
local pos2 = 237 + pos1
local pos3 = 237 + pos2
local pos4 = 237 + pos3
local pos5 = 237 + pos4
local pos6 = 237 + pos5
local pos7 = 237 + pos6
local pos8 = 237 + pos7
local pos9 = 237 + pos8
local pos10 = 237 + pos9
local pos11 = 237 + pos10

local pos8_show = pos8
local pos9_show = pos9
local pos10_show = pos10
local pos11_show = pos11

local show_all_pax = false

local takeoff_weight_plank = 245
local landing_weight_plank = 245

local to_CG = 33
local lan_CG = 33

local to_gear_CG = 33
local lan_gear_CG = 33

local tank1_load = 125
local tank2_load = 550
local tank3_load = 550
local tank4_load = 125

local acf_CG_meters = 0.102722

-- set initial load
set(fuel_q_1, tank1_load)
set(fuel_q_2, tank2_load)
set(fuel_q_3, tank3_load)
set(fuel_q_4, tank4_load)
set(payload, comercial_payload + crew_weight + stuard_weight + rutkit_weight)
set(CG_load, acf_CG_meters)

local to_weight_flag = false
local fuel_flag = false
local to_cg_flag = false
local lan_cg_flag = false
local to_gear_cg_flag = false
local lan_gear_cg_flag = false

function set_flags()
	-- red falgs logic
	to_weight_flag = airplane_weight > max_plane_weight
	fuel_flag = fuel_weight > 3950
	to_cg_flag = to_CG < 15 or to_CG > 33
	lan_cg_flag = lan_CG < 15 or lan_CG > 33
	to_gear_cg_flag = to_gear_CG < 15 or to_gear_CG > 33
	lan_gear_cg_flag = lan_gear_CG < 15 or lan_gear_CG > 33	
end

function update()
	-- recalculate masses
	prepared_plane_weight = empty_plane_weight + rutkit_weight
	used_fuel = interpolate(distance_tbl, flight_distance + reserv_distance) 
	fuel_weight = 50 + fuel_stock + used_fuel + taxi_time * 10 -- kg
	loaded_plane_weight = prepared_plane_weight + crew_weight + stuard_weight + fuel_weight
	max_payload = max_plane_weight - loaded_plane_weight
	
	all_pax_mass = row_1_mass + row_2_mass + row_3_mass + row_4_mass + row_5_mass + row_6_mass
	airplane_weight = loaded_plane_weight + all_pax_mass + cargo_1 + cargo_2 + cargo_3
	comercial_payload = all_pax_mass + cargo_1 + cargo_2 + cargo_3
	landing_weight = airplane_weight - used_fuel
	
	-- calculate CG position
	pos1 = 237 - crew_weight * 0.145625
	pos2 = pos1 + stuard_weight * 0.125
	pos3 = pos2 - row_1_mass * 0.06
	pos4 = pos3 - row_2_mass * 0.02675
	pos5 = pos4 + row_3_mass * 0.0055
	pos6 = pos5 + row_4_mass * 0.039
	pos7 = pos6 + row_5_mass * 0.07233
	pos8 = pos7 + row_6_mass * 0.105333
	pos9 = pos8 - cargo_1 * 0.1
	pos10 = pos9 + cargo_2 * 0.173
	pos11 = pos10 + cargo_3 * 0.203
	
	-- limit shown planks into diagramm area
	pos8_show = pos8
	if pos8_show > 367 then pos8_show = 367 end
	
	pos9_show = pos9
	if pos9_show > 367 then pos9_show = 367
	elseif pos9_show < 0 then pos9_show = 0 end
	
	pos10_show = pos10
	if pos10_show > 367 then pos10_show = 367
	elseif pos10_show < 0 then pos10_show = 0 end
	
	pos11_show = pos11
	if pos11_show > 367 then pos11_show = 367
	elseif pos11_show < 0 then pos11_show = 0 end
	
	-- calculate horisontal planks
	takeoff_weight_plank = 245 + (airplane_weight - 14000) * 0.008125
	if takeoff_weight_plank > 310 then takeoff_weight_plank = 310 end
	
	landing_weight_plank = 245 + (landing_weight - 14000) * 0.008125
	if landing_weight_plank > 310 then landing_weight_plank = 310 end
	
	-- calculate new CG in % of MAC
	-- calculate pixel coordinates for final planks
	local to_coef = 1.5918 * (airplane_weight - 14000) * 0.008125 / 65
	local to_CG_low = 33 - (332 - pos11) * 0.1235
	to_CG = to_CG_low + to_coef * (33 - to_CG_low) * 0.29
	
	local lan_coef = 1.5918 * (landing_weight - 14000) * 0.008125 / 65
	local lan_CG_low = 33 - (332 - pos11) * 0.1235
	lan_CG = lan_CG_low + lan_coef * (33 - lan_CG_low) * 0.29
	
	to_gear_CG = to_CG - interpolate(gear_tbl, airplane_weight)
	lan_gear_CG = lan_CG - interpolate(gear_tbl, landing_weight)
	
	-- variables for load aircraft
	-- max fuel load 3950 kg. tank 1,4 = 1425 kg, tank 2,3 = 550 kg
	if fuel_weight <= 1100 then
		tank1_load = 12.5
		tank2_load = (fuel_weight - 25) / 2
		tank3_load = (fuel_weight - 25) / 2
		tank4_load = 12.5
	elseif fuel_weight <= 3950 then
		tank1_load = (fuel_weight - 1100) / 2
		tank2_load = 550
		tank3_load = 550
		tank4_load = (fuel_weight - 1100) / 2
	else
		tank1_load = 1425
		tank2_load = 550
		tank3_load = 550
		tank4_load = 1425
	end
	
	-- calculate new CG offset from model's default
	local set_coef = 1.5918 * (landing_weight - fuel_weight - 14000) * 0.008125 / 65
	local set_CG_low = 33 - (332 - pos11) * 0.1235
	set_CG = set_CG_low + set_coef * (33 - set_CG_low) * 0.29	

	acf_CG_meters = (set_CG - 18) * 0.02686
	
	set_flags()
	
end

-- plank limits: 0 - 367


components = {


	-- background
	textureLit {
		image = get(background),
		position = {0, 0, size[1], size[2]},

	},

	-----------------
	-- red flags --
	----------------
	-- acf weight flag
	textureLit {
		image = get(red_flag),
		position = {619, 304, 75, 18},
		visible = function()
			return to_weight_flag
		end

	},
	-- fuel flag
	textureLit {
		image = get(red_flag),
		position = {619, 344, 75, 20},
		visible = function()
			return fuel_flag
		end

	},
	-- to_cg_flag
	textureLit {
		image = get(red_flag),
		position = {335, 115, 50, 15},
		visible = function()
			return to_cg_flag
		end

	},
	-- lan_cg_flag
	textureLit {
		image = get(red_flag),
		position = { 335, 87, 50, 15},
		visible = function()
			return lan_cg_flag
		end

	},
	-- to_gear_cg_flag
	textureLit {
		image = get(red_flag),
		position = {  430, 115, 50, 15},
		visible = function()
			return to_gear_cg_flag
		end

	},
	-- lan_gear_cg_flag
	textureLit {
		image = get(red_flag),
		position = {430, 87, 50, 15},
		visible = function()
			return lan_gear_cg_flag
		end

	},	
	------------------------
	-- diagramm planks --
	------------------------
    -- crew_weight plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos1
        end,
        position_y = 635,
        width = 3,
        height = 25 
    },

    -- stuard_weight plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos2
        end,
        position_y = 612,
        width = 3,
        height = 25 
    },	

    -- row_1_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos3
        end,
        position_y = 543,
        width = 3,
        height = 70,
		visible = function()
			return not show_all_pax
		end,
    },		
    -- row_2_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos4
        end,
        position_y = 519,
        width = 3,
        height = 25,
		visible = function()
			return not show_all_pax
		end,
    },		
    -- row_3_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos5
        end,
        position_y = 497,
        width = 3,
        height = 23,
		visible = function()
			return not show_all_pax
		end,
    },			
    -- row_4_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos6
        end,
        position_y = 475,
        width = 3,
        height = 23,
		visible = function()
			return not show_all_pax
		end,
    },	
    -- row_5_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos7
        end,
        position_y = 453,
        width = 3,
        height = 23,
		visible = function()
			return not show_all_pax
		end,		
    },
    -- row_6_mass plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos8_show
        end,
        position_y = 430,
        width = 3,
        height = 23,
		visible = function()
			return not show_all_pax
		end,
    },
    -- cargo_1 plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos9_show
        end,
        position_y = 405,
        width = 3,
        height = 25, 
    },
    -- cargo_2 plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos10_show
        end,
        position_y = 380,
        width = 3,
        height = 25,
    },
    -- cargo_3 plank - final
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos11_show
        end,
        position_y = 245,
        width = 3,
        height = 137, 
    },
    -- all pax plank
    free_texture {
        image = get(vert_plank),
        position_x = function() 
             return 245 + pos8_show
        end,
        position_y = 430,
        width = 3,
        height = 180,
		visible = function()
			return show_all_pax
		end
    },

	-------------------
	-- weight planks --
	-------------------
    -- aircraft weight
    free_texture {
        image = get(hor_plank_green),
        position_x = 240, 
        position_y = function()
			return takeoff_weight_plank
        end,
        width = 340,
        height = 3, 
    }, 

    -- aircraft weight at landing
    free_texture {
        image = get(hor_plank_orange),
        position_x = 240, 
        position_y = function()
			return landing_weight_plank
        end,
        width = 340,
        height = 3, 
    }, 
	
	
	-----------------------
	-- digits --
	---------------------
	-- empty airplane_CG
   digitstape {
        position = { 595, 846, 40, 15};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
        value = 22;
    };
	-- empty plane weight
   digitstape {
        position = { 283, 831, 67, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return empty_plane_weight
        end;
    }; 

	-- rutkit weight
   digitstape {
        position = { 283, 817, 67, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return rutkit_weight
        end;
    }; 

	-- prepared_plane_weightt
   digitstape {
        position = { 283, 803, 67, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return prepared_plane_weight
        end;
    };
	-- prepared_plane_weightt
   digitstape {
        position = { 400, 803, 72, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return prepared_plane_weight
        end;
    };

	-- crew_weight
   digitstape {
        position = { 400, 789, 72, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return crew_weight
        end;
    };
	
	-- stuard_weight
   digitstape {
        position = { 400, 776, 72, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return stuard_weight
        end;
    };	
	
	-- fuel_weight
   digitstape {
        position = { 400, 762, 72, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return fuel_weight
        end;
    };		
	
	-- loaded_plane_weight
   digitstape {
        position = { 400, 748, 72, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return loaded_plane_weight
        end;
    };		
   digitstape {
        position = { 619, 748, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return loaded_plane_weight
        end;
    };		
	
	-- max_plane_weight
   digitstape {
        position = { 619, 762, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return max_plane_weight
        end;
    };	
	
	-- max_payload
   digitstape {
        position = { 619, 733, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return max_payload
        end;
    };	

	-- prepared_plane_weightt
   digitstape {
        position = { 619, 668, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return prepared_plane_weight
        end;
    };

	-- crew_weight
   digitstape {
        position = { 619, 643, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return crew_weight
        end;
    };

	-- stuard_weight
   digitstape {
        position = { 619, 620, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return stuard_weight
        end;
    };

	-- all_pax_mass
   digitstape {
        position = { 619, 575, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return all_pax_mass
        end;
    };
	
	-- row_1_mass
   digitstape {
        position = { 619, 551, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_1_mass
        end;
    };

	-- row_2_mass
   digitstape {
        position = { 619, 528, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_2_mass
        end;
    };	
	
	-- row_3_mass
   digitstape {
        position = { 619, 505, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_3_mass
        end;
    };

	-- row_4_mass
   digitstape {
        position = { 619, 483, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_4_mass
        end;
    };

	-- row_5_mass
   digitstape {
        position = { 619, 461, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_5_mass
        end;
    };

	-- row_6_mass
   digitstape {
        position = { 619, 438, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return row_6_mass
        end;
    };

	-- cargo_1
   digitstape {
        position = { 619, 415, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return cargo_1
        end;
    };

	-- cargo_2
   digitstape {
        position = { 619, 392, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return cargo_2
        end;
    };

	-- cargo_3
   digitstape {
        position = { 619, 368, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return cargo_3
        end;
    };

	-- fuel_weight
   digitstape {
        position = { 619, 345, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return fuel_weight
        end;
    };

	-- airplane_weight
   digitstape {
        position = { 619, 305, 75, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return airplane_weight
        end;
    };	
	
	





	-- crew_weight
   digitstape {
        position = { 200, 643, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
		showLeadingZeros = false;
        value = function() 
            return crew_weight / 80
        end;
    };

	-- stuard_weight
   digitstape {
        position = { 195, 620, 35, 18};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
        value = function() 
            return stuard_weight
        end;
    };

	-- all_pax_mass
   digitstape {
        position = { 197, 575, 25, 18};
        image = digitsImage;
        digits = 2;
        allowNonRound = true;
        value = function() 
            return all_pax_mass / 75
        end;
    };
	
	-- row_1_mass
   digitstape {
        position = { 200, 551, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_1_mass / 75
        end;
    };

	-- row_2_mass
   digitstape {
        position = { 200, 528, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_2_mass / 75
        end;
    };	
	
	-- row_3_mass
   digitstape {
        position = { 200, 505, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_3_mass / 75
        end;
    };

	-- row_4_mass
   digitstape {
        position = { 200, 483, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_4_mass / 75
        end;
    };

	-- row_5_mass
   digitstape {
        position = { 200, 461, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_5_mass / 75
        end;
    };

	-- row_6_mass
   digitstape {
        position = { 200, 438, 15, 18};
        image = digitsImage;
        digits = 1;
        allowNonRound = true;
        value = function() 
            return row_6_mass / 75
        end;
    };
	
	-- cargo_1
   digitstape {
        position = { 195, 415, 35, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
        value = function() 
            return cargo_1
        end;
    };

	-- cargo_2
   digitstape {
        position = { 195, 392, 30, 18};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
        value = function() 
            return cargo_2
        end;
    };

	-- cargo_3
   digitstape {
        position = { 195, 368, 30, 18};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
        value = function() 
            return cargo_3
        end;
    };

	
	
	-- loaded_plane_weight
   digitstape {
        position = { 249, 142, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return loaded_plane_weight
        end;
    };	
	
	-- comercial_payload
   digitstape {
        position = { 249, 129, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return comercial_payload
        end;
    };

	-- airplane_weight
   digitstape {
        position = { 249, 115, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return airplane_weight
        end;
    };	
	
	-- airplane_CG
   digitstape {
        position = { 335, 115, 50, 15};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function() 
            return to_CG
        end;
    };

	-- airplane_CG with gears retracted
   digitstape {
        position = { 430, 115, 50, 15};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function() 
            return to_gear_CG
        end;
    };

	
	-- used_fuel
   digitstape {
        position = { 249, 101, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return used_fuel
        end;
    };	
	
	-- landing_weight
   digitstape {
        position = { 249, 87, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return landing_weight
        end;
    };		

	-- airplane_CG
   digitstape {
        position = { 335, 87, 50, 15};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function() 
            return lan_CG
        end;
    };
	
	-- airplane_CG
   digitstape {
        position = { 430, 87, 50, 15};
        image = digitsImage;
        digits = 3;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function() 
            return lan_gear_CG
        end;
    };
	
	-- flight_distance
   digitstape {
        position = { 249, 61, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return flight_distance
        end;
    };		
	
	-- reserv_distance
   digitstape {
        position = { 249, 47, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return reserv_distance
        end;
    };		
	
	-- taxi_time
   digitstape {
        position = { 249, 33, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return taxi_time
        end;
    };	
	
	-- fuel_stock
   digitstape {
        position = { 249, 19, 75, 15};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
        value = function() 
            return fuel_stock
        end;
    };	

	-----------------
	-- clickables --
	-----------------
	
   -- clickable area for decrement crew_weight
    clickable {
       position = { 180, 643, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			crew_weight = crew_weight - 80
			if crew_weight < 80 then crew_weight = 80 end
			
        return true
        end
    },	
	
   -- clickable area for increment crew_weight
    clickable {
       position = { 240, 643, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			crew_weight = crew_weight + 80
			if crew_weight > 400 then crew_weight = 400 end
        return true
        end
    },	
	----------------------
   -- clickable area for decrement stuard_weight
    clickable {
       position = { 180, 619, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			stuard_weight = stuard_weight - 20
			if stuard_weight < 80 then stuard_weight = 80 end
        return true
        end
    },	
	
   -- clickable area for increment stuard_weight
    clickable {
       position = { 240, 619, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			stuard_weight = stuard_weight + 20
			if stuard_weight > 200 then stuard_weight = 200 end
        return true
        end
    },	
	----------------------
   -- clickable area for decrement all pax mass
    clickable {
       position = { 180, 572, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_1_mass = 0
			row_2_mass = 0
			row_3_mass = 0
			row_4_mass = 0
			row_5_mass = 0
			row_6_mass = 0
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment all pax mass
    clickable {
       position = { 240, 572, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_1_mass = 600
			row_2_mass = 600
			row_3_mass = 600
			row_4_mass = 600
			row_5_mass = 600
			row_6_mass = 600
			show_all_pax = true
        return true
        end
    },
	----------------------
   -- clickable area for decrement row_1_mass
    clickable {
       position = { 180, 550, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_1_mass = row_1_mass - 75
			if row_1_mass < 0 then row_1_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_1_mass
    clickable {
       position = { 240, 550, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_1_mass = row_1_mass + 75
			if row_1_mass > 600 then row_1_mass = 600 end
			show_all_pax = false
        return true
        end
    },	
	----------------------
   -- clickable area for decrement row_2_mass
    clickable {
       position = { 180, 527, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_2_mass = row_2_mass - 75
			if row_2_mass < 0 then row_2_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_2_mass
    clickable {
       position = { 240, 527, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_2_mass = row_2_mass + 75
			if row_2_mass > 600 then row_2_mass = 600 end
			show_all_pax = false
        return true
        end
    },		
	----------------------
   -- clickable area for decrement row_3_mass
    clickable {
       position = { 180, 504, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_3_mass = row_3_mass - 75
			if row_3_mass < 0 then row_3_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_3_mass
    clickable {
       position = { 240, 504, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_3_mass = row_3_mass + 75
			if row_3_mass > 600 then row_3_mass = 600 end
			show_all_pax = false
        return true
        end
    },		
	----------------------
   -- clickable area for decrement row_4_mass
    clickable {
       position = { 180, 482, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_4_mass = row_4_mass - 75
			if row_4_mass < 0 then row_4_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_4_mass
    clickable {
       position = { 240, 482, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_4_mass = row_4_mass + 75
			if row_4_mass > 600 then row_4_mass = 600 end
			show_all_pax = false
        return true
        end
    },	
	-------------------------------
	-- clickable area for decrement row_5_mass
    clickable {
       position = { 180, 460, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_5_mass = row_5_mass - 75
			if row_5_mass < 0 then row_5_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_5_mass
    clickable {
       position = { 240, 460, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_5_mass = row_5_mass + 75
			if row_5_mass > 600 then row_5_mass = 600 end
			show_all_pax = false
        return true
        end
    },	
	----------------------------
   -- clickable area for decrement row_6_mass
    clickable {
       position = { 180, 437, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_6_mass = row_6_mass - 75
			if row_6_mass < 0 then row_6_mass = 0 end
			show_all_pax = false
        return true
        end
    },	
	
   -- clickable area for increment row_6_mass
    clickable {
       position = { 240, 437, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			row_6_mass = row_6_mass + 75
			if row_6_mass > 600 then row_6_mass = 600 end
			show_all_pax = false
        return true
        end
    },	
	----------------------------
   -- clickable area for decrement cargo_1
    clickable {
       position = { 180, 414, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_1 = cargo_1 - 100
			if cargo_1 < 0 then cargo_1 = 0 end
        return true
        end
    },	
	
   -- clickable area for increment cargo_1
    clickable {
       position = { 240, 414, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_1 = cargo_1 + 100
			if cargo_1 > 1500 then cargo_1 = 1500 end
        return true
        end
    },
	----------------------------
   -- clickable area for decrement cargo_2
    clickable {
       position = { 180, 390, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_2 = cargo_2 - 50
			if cargo_2 < 0 then cargo_2 = 0 end
        return true
        end
    },	
	
   -- clickable area for increment cargo_1
    clickable {
       position = { 240, 390, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_2 = cargo_2 + 50
			if cargo_2 > 600 then cargo_2 = 600 end
        return true
        end
    },
	----------------------------
   -- clickable area for decrement cargo_3
    clickable {
       position = { 180, 367, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_3 = cargo_3 - 30
			if cargo_3 < 0 then cargo_3 = 0 end
        return true
        end
    },	
	
   -- clickable area for increment cargo_3
    clickable {
       position = { 240, 367, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			cargo_3 = cargo_3 + 30
			if cargo_3 > 570 then cargo_3 = 570 end
        return true
        end
    },
	---------------------------- 
	-- clickable area for decrement flight_distance
    clickable {
       position = { 325, 61, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			flight_distance = flight_distance - 100
			if flight_distance < 0 then flight_distance = 0 end
        return true
        end
    },	
	-- clickable area for decrement flight_distance
    clickable {
       position = { 367, 61, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			flight_distance = flight_distance + 100
			if flight_distance > 2000 then flight_distance = 2000 end
        return true
        end
    },
	---------------------------- 
	-- clickable area for decrement reserv_distance
    clickable {
       position = { 325, 47, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			reserv_distance = reserv_distance - 100
			if reserv_distance < 0 then reserv_distance = 0 end
        return true
        end
    },	
	-- clickable area for decrement reserv_distance
    clickable {
       position = { 367, 47, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			reserv_distance = reserv_distance + 100
			if reserv_distance > 1000 then reserv_distance = 1000 end
        return true
        end
    },
	---------------------------- 
	-- clickable area for decrement taxi_time
    clickable {
       position = { 325, 33, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			taxi_time = taxi_time - 10
			if taxi_time < 0 then taxi_time = 0 end
        return true
        end
    },	
	-- clickable area for decrement taxi_time
    clickable {
       position = { 367, 33, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			taxi_time = taxi_time + 10
			if taxi_time > 60 then taxi_time = 60 end
        return true
        end
    },
	---------------------------- 
	-- clickable area for decrement fuel_stock
    clickable {
       position = { 325, 19, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			fuel_stock = fuel_stock - 50
			if fuel_stock < 0 then fuel_stock = 0 end
        return true
        end
    },	
	-- clickable area for decrement fuel_stock
    clickable {
       position = { 367, 19, 20, 15 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			fuel_stock = fuel_stock + 50
			if fuel_stock > 500 then fuel_stock = 500 end
        return true
        end
    },

	
	-- clickable area for LOAD button
    clickable {
       position = { 530, 90, 150, 60 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			-- set new fuel load
			set(fuel_q_1, tank1_load)
			set(fuel_q_2, tank2_load)
			set(fuel_q_3, tank3_load)
			set(fuel_q_4, tank4_load)
			
			-- set payload and CG
			set(payload, comercial_payload + crew_weight + stuard_weight + rutkit_weight)
			set(CG_load, acf_CG_meters)
			-- close panel
			set(payload_subpanel, 0)
		return true
        end
    },	
	
	
	
	
	
	
	
	
	
   -- clickable area for closing main menu
    clickable {
       position = { size[1]-20, size[2]-20, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
        set(payload_subpanel, 0 )
        return true
        end
    },	
}



