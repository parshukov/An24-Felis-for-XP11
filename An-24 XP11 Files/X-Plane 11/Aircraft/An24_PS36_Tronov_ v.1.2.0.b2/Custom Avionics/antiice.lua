-- this is simple anti-ice system logic
size = {2048, 2048}
-- define property table
-- sim datarefs
defineProperty("pitot_1", globalPropertyi("sim/cockpit/switches/pitot_heat_on"))   -- pitot heat 1
defineProperty("pitot_2", globalPropertyi("sim/cockpit/switches/pitot_heat_on2"))   -- pitot heat 2
defineProperty("prop_ht", globalPropertyi("sim/cockpit/switches/anti_ice_prop_heat"))   -- propeller heat
defineProperty("wind_ht", globalPropertyi("sim/cockpit/switches/anti_ice_window_heat"))   -- window heat
defineProperty("wing_ht", globalPropertyi("sim/cockpit/switches/anti_ice_surf_heat"))  -- on/off wing heat
defineProperty("engine_ht", globalPropertyi("sim/cockpit/switches/anti_ice_inlet_heat"))  -- on/off engine heat. this heats only first engine :(
defineProperty("ice_detect", globalPropertyi("sim/cockpit2/ice/ice_detect_on"))  -- on/off ice detection
defineProperty("aoa_ht", globalPropertyi("sim/cockpit/switches/anti_ice_AOA_heat"))  -- on/off AOA heat

defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature

defineProperty("tas", globalPropertyf("sim/flightmodel/position/true_airspeed"))  -- true auspeed in meters per sec

defineProperty("ice_on_plane", globalPropertyi("sim/cockpit2/annunciators/ice"))  -- ice detected

defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

defineProperty("ice_all_on", globalPropertyi("sim/cockpit2/ice/ice_all_on")) -- all systems ON. this heats other engines too

-- ice on parts
defineProperty("frm_ice", globalPropertyf("sim/flightmodel/failures/frm_ice")) -- Ratio of icing on wings/airframe
defineProperty("pitot_ice", globalPropertyf("sim/flightmodel/failures/pitot_ice")) -- Ratio of icing on pitot tube
defineProperty("pitot_ice2", globalPropertyf("sim/flightmodel/failures/pitot_ice2")) -- Ratio of icing on pitot tube2
defineProperty("prop_ice", globalPropertyf("sim/flightmodel/failures/prop_ice")) -- Ratio of icing on the prop
defineProperty("inlet_ice", globalPropertyf("sim/flightmodel/failures/inlet_ice")) -- Ratio of icing on the air inlets?
defineProperty("window_ice", globalPropertyf("sim/flightmodel/failures/window_ice")) -- Ratio of icing on the windshield
defineProperty("aoa_ice", globalPropertyf("sim/flightmodel/failures/aoa_ice")) -- Ratio of icing on alpha vane




-- filures
defineProperty("engine_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat"))  -- engine heat fail
defineProperty("prop_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_prop_heat"))  -- prop heat fail
defineProperty("pitot1_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))  -- pitot 1 heat fail
defineProperty("pitot2_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))  -- pitot 2 heat fail
defineProperty("aoa_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_AOA_heat"))  -- AOA heat fail
defineProperty("wing_ht_fail", globalPropertyi("sim/operation/failures/rel_ice_surf_heat"))  -- AOA heat fail
defineProperty("detector_fail", globalPropertyi("sim/operation/failures/rel_ice_detect"))  -- ice detector fail

-- custom switchers
defineProperty("pitot_1_sw", globalPropertyi("sim/custom/xap/An24_ice/pitot1_sw"))   -- pitot heat 1
defineProperty("pitot_2_sw", globalPropertyi("sim/custom/xap/An24_ice/pitot2_sw"))   -- pitot heat 2
defineProperty("prop_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/prop_ht_sw"))   -- propeller heat
defineProperty("wind_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/window_ht_sw"))   -- window heat
defineProperty("wing_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/wing_ht_sw"))  -- on/off wing heat
defineProperty("engine_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/engine_ht_sw"))  -- on/off engine heat
defineProperty("ice_detect_sw", globalPropertyi("sim/custom/xap/An24_ice/rio_sw"))  -- on/off ice detection
defineProperty("aoa_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/aoa_ht_sw"))  -- on/off AOA heat

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("aa_main_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_main_cc")) 
defineProperty("aa_emerg_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_emerg_cc"))
defineProperty("aa_115_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_115_cc")) 


-- for 2D
defineProperty("wing_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/wing_heat_lit"))  -- for 2D panel
defineProperty("engine_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/engine_heat_lit"))  -- for 2D panel
defineProperty("prop_left_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/prop_left_lit"))  -- for 2D panel
defineProperty("prop_right_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/prop_right_lit"))  -- for 2D panel
defineProperty("pitot1_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot1_lit"))  -- for 2D panel
defineProperty("pitot2_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot2_lit"))  -- for 2D panel
defineProperty("aoa_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/aoa_heat_lit"))  -- for 2D panel

defineProperty("pitot1_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot1_test_lit"))  -- for 2D panel
defineProperty("pitot2_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot2_test_lit"))  -- for 2D panel
defineProperty("aoa_heat_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/aoa_heat_test_lit"))  -- for 2D panel
defineProperty("rio_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/rio_heat_lit"))  -- for 2D panel

defineProperty("ice_left_eng_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/ice_left_eng_lit"))  -- for 2D panel
defineProperty("ice_right_eng_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/ice_right_eng_lit"))  -- for 2D panel

defineProperty("thermo_angle_2d", globalPropertyf("sim/custom/xap/An24_ice/thermo_angle"))  -- for 2D panel

defineProperty("test_btn", globalPropertyi("sim/custom/xap/An24_ice/test_btn"))  -- for 2D panel


-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time

-- images
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

defineProperty("pos_not_work_img", loadImage("lamps.dds", 50, 60, 50, 30)) 
defineProperty("ice_on_plane_img", loadImage("lamps.dds", 100, 60, 50, 30)) 

local function bool2int(var)
	if var then return 1 else return 0 end
end

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

-- table for termo gauge
local termo_table = {{ -500, -180},    
				  { -60, -100 },    
            	  {  -50, -90 },    
           		  {  0, -45 },   
          		  {  50, 8 },   
          		  {  100, 55 },
				  {  150, 97 },
				  {  1000, 180 }}   

-- lamps
local wing_heat_lit = false
local engine_heat_lit = false
local prop_heat_lit = false
local prop_right_lit = false
local prop_left_lit = true
local pitot1_lit = false
local pitot2_lit = false
local aoa_heat_lit = false

local pitot1_test_lit = false
local pitot2_test_lit = false
local aoa_heat_test_lit = false
local rio_heat_lit = false

local ice_on_plane_lit = false
local pos_not_work_lit = false
local ice_left_eng_lit = false
local ice_right_eng_lit = false
local pitot_left_fail_lit = false
local pitot_right_fail_lit = false


local plane_must_heat = false


local test_button = false
local test_pressed = false
local termo_angle = -90

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')

-- temporal variables
local window_heat_timer = 0
local eng_heat_timer = 0
local prop_heat_counter = 0
local pos_lamp_counter = 0

-- post frame calculations
function update()
	
	
	
	local passed = get(frame_time)
if  passed > 0 then
	-- power calculations
	local power27 = get(bus_DC_27_volt) > 21
	local power27_em = get(bus_DC_27_volt_emerg) > 21
	local power115 = get(bus_AC_115_volt) > 110
	
	local bus27_cc = 0
	local bus27_em_cc = 0
	local bus115_cc = 0
	
	local eng1 = get(N1)
	local eng2 = get(N2)
	
	test_button = test_pressed or get(test_btn) == 1
	------------------
	if power27_em then 
		
		-- wing heat
		if ((get(wing_ht_sw) < 0 and plane_must_heat) or get(wing_ht_sw) > 0) and window_heat_timer < 1 then 
			window_heat_timer = window_heat_timer + passed / 40
			bus27_em_cc = bus27_em_cc + 5
		elseif get(wing_ht_sw) == 0 and window_heat_timer > 0 then 
			window_heat_timer = window_heat_timer - passed / 40 
			bus27_em_cc = bus27_em_cc + 5
		end
		
		if window_heat_timer > 0.75 and (eng1 > 50 or eng2 > 50) and get(wing_ht_fail) < 6 then set(wing_ht, 1)
		else set(wing_ht, 0) end
		
		if get(wing_ht) == 1 then wing_heat_lit = true
		else wing_heat_lit = false end
		---
		
		
		-- left PVD
		if get(pitot_1_sw) == 1 then 
			set(pitot_1, 1)
			bus27_em_cc = bus27_em_cc + 10
			pitot1_lit = true
			pitot1_test_lit = false
		elseif get(pitot_1_sw) == -1 then
			set(pitot_1, 0)
			pitot1_test_lit = true
			pitot1_lit = false
		else
			set(pitot_1, 0)
			pitot1_lit = false
			pitot1_test_lit = false
		end
		
		pitot_left_fail_lit = get(pitot1_ht_fail) == 6
		pitot1_lit = pitot1_lit and not pitot_left_fail_lit
		pitot1_test_lit = pitot1_test_lit and not pitot_left_fail_lit
		
		-- right PVD
		if get(pitot_2_sw) == 1 then 
			set(pitot_2, 1)
			bus27_em_cc = bus27_em_cc + 10
			pitot2_lit = true
			pitot2_test_lit = false
		elseif get(pitot_2_sw) == -1 then
			set(pitot_2, 0)
			pitot2_test_lit = true
			pitot2_lit = false
		else
			set(pitot_2, 0)
			pitot2_lit = false
			pitot2_test_lit = false
		end
		
		pitot_right_fail_lit = get(pitot1_ht_fail) == 6
		pitot1_lit = pitot1_lit and not pitot_right_fail_lit
		pitot1_test_lit = pitot1_test_lit and not pitot_right_fail_lit
		
		-- angle of atack sensor heat
		if get(aoa_ht_sw) == 1 then 
			set(aoa_ht, 1)
			bus27_em_cc = bus27_em_cc + 10
			aoa_heat_lit = true
			aoa_heat_test_lit = false
		elseif get(aoa_ht_sw) == -1 then
			set(aoa_ht, 0)
			aoa_heat_lit = false
			aoa_heat_test_lit = true
		else
			set(aoa_ht, 0)
			aoa_heat_lit = false
			aoa_heat_test_lit = false
		end
		
		local aoa_fail = get(aoa_ht_fail) == 6
		aoa_heat_lit = aoa_heat_lit and not aoa_fail
		aoa_heat_test_lit = aoa_heat_test_lit and not aoa_fail
		
		-- lamps logic
		local speed = get(tas) * 0.25
		-- left engine heat lamp
		if (eng1 + speed > 5 and eng1 + speed < 50) or (plane_must_heat and get(engine_ht) == 0) then
			ice_left_eng_lit = true
		else ice_left_eng_lit = false end

		-- right engine heat lamp
		if (eng2 + speed > 5 and eng2 + speed < 50) or (plane_must_heat and get(engine_ht) == 0) then
			ice_right_eng_lit = true
		else ice_right_eng_lit = false end
		
		-- plane in ice lamp
		ice_on_plane_lit = plane_must_heat
		
		-- POS not work lamp
		if plane_must_heat and not wing_heat_lit or (ice_left_eng_lit or ice_right_eng_lit) then
			pos_lamp_counter = pos_lamp_counter + passed
			if pos_lamp_counter > 0.5 then
				pos_lamp_counter = 0
				pos_not_work_lit = not pos_not_work_lit
			end
		else
			pos_not_work_lit = false
			pos_lamp_counter = 0
		end
		
	
	else
		set(ice_detect, 0)
		set(pitot_1, 0)
		set(pitot_2, 0)
		set(aoa_ht, 0)
		wing_heat_lit = false
		pitot1_lit = false
		pitot2_lit = false
		aoa_heat_lit = false
		if eng1 < 50 and eng2 < 50 then set(wing_ht, 0) end
		pitot1_test_lit = false
		pitot2_test_lit = false
		aoa_heat_test_lit = false
		ice_left_eng_lit = false
		ice_right_eng_lit = false
		ice_on_plane_lit = false
		pos_not_work_lit = false
		pitot_right_fail_lit = false
		pitot_left_fail_lit = false
	end
	
	---------------- 
	if power27 then
	
		-- engines heat. can be changed only if power
		if get(engine_ht_sw) == 1 and eng_heat_timer < 1 then 
			eng_heat_timer = eng_heat_timer + passed / 6
			bus27_cc = bus27_cc + 10
		elseif get(engine_ht_sw) == 0 and eng_heat_timer > 0 then
			eng_heat_timer = eng_heat_timer - passed / 6
			bus27_cc = bus27_cc + 10		
		end
		
		if eng_heat_timer > 0.8 and (eng1 > 50 or eng2 > 50) and get(engine_ht_fail) < 6 then
			set(engine_ht, 1)
			set(ice_all_on, 1) -- temporal solution for heating all engines
		else 
			set(engine_ht, 0) 
			set(ice_all_on, 0) 
		end
		
		if get(engine_ht) == 1 then engine_heat_lit = true
		else engine_heat_lit = false end
		-------
		
		-- RIO-3 logic
		local rio_switcher = get(ice_detect_sw)
		local ice_detected = get(frm_ice) + get(pitot_ice) + get(pitot_ice2) + get(prop_ice) + get(inlet_ice) + get(window_ice) + get(aoa_ice) > 0.01
		
		-- RIO mode
		if rio_switcher == 1 then 
			set(ice_detect, 1) 		
		else 
			set(ice_detect, 0) 
		end		
		
		-- RIO lamps
		if (rio_switcher == -1 or (rio_switcher == 1 and ice_detected)) and get(detector_fail) < 6 then 
			rio_heat_lit = true
		else rio_heat_lit = false end
		
		-- RIO signal
		if ice_detected then
			plane_must_heat = true
		else 
			plane_must_heat = false
		end 
	
		--plane_must_heat = true  -- test
		
	else
		set(ice_detect, 0)
		engine_heat_lit = false
		rio_heat_lit = false
		plane_must_heat = false
	end
	
	----------------
	if power115 then
		
		-- prop heat
		if ((get(prop_ht_sw) == 1 and plane_must_heat) or get(prop_ht_sw) == -1) and get(prop_ht_fail) < 6 then  
			set(prop_ht, 1)
			bus115_cc = bus115_cc + 30
			prop_heat_lit = true
		elseif get(prop_ht_sw) == 0 or get(prop_ht_fail) == 6 then
			set(prop_ht, 0)
			prop_heat_lit = false
		end
		
		if get(wind_ht_sw) == 1 then -- window heat
			set(wind_ht, 1)
			bus115_cc = bus115_cc + 4
		else
			set(wind_ht, 0)
		end
		
		-- prop heat lamps
		prop_heat_counter = prop_heat_counter + passed
		-- switch lamps 
		if prop_heat_counter > 25 then
			prop_heat_counter = 0
			prop_left_lit = not prop_left_lit
		end

	else
		set(prop_ht, 0)
		set(wind_ht, 0)
		prop_heat_lit = false
	end
	

	-- set currents
	set(aa_main_cc, bus27_cc)
	set(aa_emerg_cc, bus27_em_cc)
	set(aa_115_cc, bus115_cc)


	-- test lamp button
	if test_button and power27_em then
		wing_heat_lit = true
		engine_heat_lit = true
		--pitot1_lit = true
		--pitot2_lit = true
		--aoa_heat_lit = true
		--pitot1_test_lit = true
		--pitot2_test_lit = true
		--aoa_heat_test_lit = true
		--rio_heat_lit = true --контроль обогрева датчиков РИО
		--prop_left_lit = true
		prop_heat_lit = true
		prop_right_lit= true
		--ice_left_eng_lit = true
		--ice_right_eng_lit = true
		--ice_on_plane_lit = true
		pos_not_work_lit = true
	else
	prop_right_lit = false
	end
	
	-- thermometer gauge
	termo_angle = interpolate(termo_table, get(thermo))

end


-- set 2D lamps
set(wing_heat_lit_2d, bool2int(wing_heat_lit))
set(engine_heat_lit_2d, bool2int(engine_heat_lit))
set(prop_left_lit_2d, bool2int(prop_left_lit and prop_heat_lit))
set(prop_right_lit_2d, bool2int(not prop_left_lit and prop_heat_lit))
set(aoa_heat_lit_2d, bool2int(aoa_heat_lit))
set(pitot1_lit_2d, bool2int(pitot1_lit))
set(pitot2_lit_2d, bool2int(pitot2_lit))
set(pitot1_test_lit_2d, bool2int(pitot1_test_lit))
set(pitot2_test_lit_2d, bool2int(pitot2_test_lit))
set(aoa_heat_test_lit_2d, bool2int(aoa_heat_test_lit))
set(rio_heat_lit_2d, bool2int(rio_heat_lit))
set(ice_left_eng_lit_2d, bool2int(ice_left_eng_lit))
set(ice_right_eng_lit_2d, bool2int(ice_right_eng_lit))
set(thermo_angle_2d, termo_angle)


end


local switcher_pushed = false


--------------
components = {
	
	-- gauges --
	-- thermoneter
	needle { 
		image = get(needles_1),
		position = {610, 1055, 180, 180},
		angle = function()
			return termo_angle
		end,	
	},

	-- black cap
	texture{
	    position = {675, 1115, 60, 60 },
        image = get(black_cap),
	},	
	-----------------
	-- lights --
	-----------------
	
	-- wing heat
	textureLit {
		image = get(green_led),
		position = {661, 328, 19, 19},
		visible = function()
			return wing_heat_lit
		end,
	},	
	

	-- engine heat
	textureLit {
		image = get(green_led),
		position = {681, 328, 19, 19},
		visible = function()
			return engine_heat_lit
		end,
	},	

	-- prop left
	textureLit {
		image = get(green_led),
		position = {700, 328, 19, 19},
		visible = function()
			return not prop_left_lit and prop_heat_lit
		end,
	},
textureLit {
		image = get(green_led),
		position = {700, 328, 19, 19},
		visible = function()
			return prop_right_lit
		end,
	},	

	-- prop right
	textureLit {
		image = get(green_led),
		position = {721, 328, 19, 19},
		visible = function()
			return prop_left_lit and prop_heat_lit
		end,
	},
	
	-- pitot left light
	textureLit {
		image = get(green_led),
		position = {761, 308, 19, 19},
		visible = function()
			return pitot1_lit
		end,
	},		

	-- pitot left test light
	textureLit {
		image = get(green_led),
		position = {622, 289, 19, 19},
		visible = function()
			return pitot1_test_lit
		end,
	},		
	
	-- pitot right light
	textureLit {
		image = get(green_led),
		position = {602, 289, 19, 19},
		visible = function()
			return pitot2_lit
		end,
	},		

	-- pitot right test light
	textureLit {
		image = get(green_led),
		position = {661, 289, 19, 19},
		visible = function()
			return pitot2_test_lit
		end,
	},		

	-- AOA light
	textureLit {
		image = get(green_led),
		position = {781, 308, 19, 19},
		visible = function()
			return aoa_heat_lit
		end,
	},	

	-- AOA test light
	textureLit {
		image = get(green_led),
		position = {641, 289, 19, 19},
		visible = function()
			return aoa_heat_test_lit
		end,
	},

	-- RIO heat light
	textureLit {
		image = get(green_led),
		position = {781, 348, 19, 19},
		visible = function()
			return rio_heat_lit
		end,
	},

	-- left engine in ice light
	textureLit {
		image = get(red_led),
		position = {621, 328, 19, 19},
		visible = function()
			return ice_left_eng_lit
		end,
	},
	
	-- right engine in ice light
	textureLit {
		image = get(red_led),
		position = {641, 328, 19, 19},
		visible = function()
			return ice_right_eng_lit
		end,
	},


	-- pos not work light
	textureLit {
		image = get(pos_not_work_img),
		position = {1004, 516, 50, 30},
		visible = function()
			return pos_not_work_lit
		end,
	},	
	
	-- ice on plane light
	textureLit {
		image = get(ice_on_plane_img),
		position = {1060, 516, 50, 30},
		visible = function()
			return ice_on_plane_lit
		end,
	},	
	
	--------------------
	-- clickables --
	--------------------

	-- test button
    clickable {
        position = {781, 522, 19, 19},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then playSample(btn_click, 0) end
			switcher_pushed = true
			set(test_btn, 1)
			return true
		end,
		onMouseUp = function()
			playSample(btn_click, 0)
			set(test_btn, 0)
			switcher_pushed = false
			return true
		end,
		
		
    },

	
	-- windows heat switch
    switch {
        position = { 880, 272, 35, 15},
        state = function()
            return get(wind_ht_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(wind_ht_sw) ~= 0 then
                set(wind_ht_sw, 0)
            else
                set(wind_ht_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- engines heat switch
    switch {
        position = { 918, 272, 35, 15},
        state = function()
            return get(engine_ht_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			if get(engine_ht_sw) ~= 0 then
                set(engine_ht_sw, 0)
            else
                set(engine_ht_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- wing heat up
    clickable {
        position = {954, 272, 35, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(wing_ht_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(wing_ht_sw, a)
			return true
		end,
		
    },

	-- wing heat down
    clickable {
        position = {954, 280, 35, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(wing_ht_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			
			set(wing_ht_sw, a)
			return true
		end,
		
    },


	-- ice detect down
    clickable {
        position = {937, 299, 35, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ice_detect_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(ice_detect_sw, a)
			return true
		end,
		
    },

	-- ice detect up
    clickable {
        position = {937, 290, 35, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ice_detect_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(ice_detect_sw, a)
			return true
		end,
		
    },


	-- pitot heat down
    clickable {
        position = {1136, 439, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_1_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(pitot_1_sw, a)
			return true
		end,
		
    },

	-- pitot heat up
    clickable {
        position = {1136, 430, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_1_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(pitot_1_sw, a)
			return true
		end,
		
    },	
	
	-- aoa sensor heat down
    clickable {
        position = {1154, 439, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(aoa_ht_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(aoa_ht_sw, a)
			return true
		end,
		
    },

	-- aoa sensor hean up
    clickable {
        position = {1154, 430, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(aoa_ht_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(aoa_ht_sw, a)
			return true
		end,
		
    },	


	-- pitot heat down
    clickable {
        position = {1173, 439, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_2_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(pitot_2_sw, a)
			return true
		end,
		
    },

	-- pitot heat up
    clickable {
        position = {1173, 430, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_2_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(pitot_2_sw, a)
			return true
		end,
		
    },
	
	-- prop heat down
    clickable {
        position = {805, 261, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(prop_ht_sw)
			if a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(prop_ht_sw, a)
			return true
		end,
		
    },

	-- prop heat up
    clickable {
        position = {805, 252, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(prop_ht_sw)
			if a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(prop_ht_sw, a)
			return true
		end,
		
    },	


}








