-- this is simple logic of pressurisation equipment
size = {2048, 2048}

-- sim DataRefs
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt. maybe in feet, maybe in meters.
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  -- pressire at sea level in.Hg
defineProperty("acf_has_press_contr", globalPropertyf("sim/aircraft/view/acf_has_press_controls")) 

defineProperty("eng_rpm1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("eng_rpm2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

defineProperty("mode", globalPropertyi("sim/cockpit2/pressurization/actuators/bleed_air_mode")) 
defineProperty("dump", globalPropertyi("sim/cockpit2/pressurization/actuators/dump_to_altitude_on")) 

defineProperty("sim_cab_alt", globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_altitude_ft"))   
defineProperty("sim_cab_vvi", globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm"))

defineProperty("actual_cabin_alt", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft"))

-- custom
defineProperty("bleed1_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed1_sw")) 
defineProperty("bleed2_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed2_sw")) 
defineProperty("dump_cap", globalPropertyi("sim/custom/xap/An24_skv/dump_cap")) 
defineProperty("dump_sw", globalPropertyi("sim/custom/xap/An24_skv/dump_sw")) 
defineProperty("skv_siren", globalPropertyi("sim/custom/xap/An24_skv/skv_siren")) 
defineProperty("skv_siren_alarm", globalPropertyi("sim/custom/xap/An24_skv/skv_siren_alarm")) 

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

-- power
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

-- failures
defineProperty("rapid_depress", globalPropertyi("sim/operation/failures/rel_depres_fast")) 

-- doors and windows may depressurise the plane
defineProperty("hole1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[2]"))  
defineProperty("hole2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[3]"))  
defineProperty("hole3", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[4]"))  
defineProperty("hole4", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[5]"))  
defineProperty("hole5", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[6]"))  
defineProperty("hole6", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[8]"))  
defineProperty("hole7", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[9]"))  
defineProperty("hole8", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[14]"))  

-- images
defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20))
defineProperty("blue_led", loadImage("leds.dds", 80, 0, 20, 20))
defineProperty("needleImage", loadImage("needles.dds", 86, 73, 18, 173))

-- initial switchers values
if get(eng_rpm1) < 70 and get(eng_rpm2) < 70 then
	set(bleed1_sw, 0)
	set(bleed2_sw, 0)
	
end

set(mode, 0)

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local cup_open_sound = loadSample('Custom Sounds/cup_open.wav')
local cup_close_sound = loadSample('Custom Sounds/cup_close.wav')

local switcher_pushed = false
set(acf_has_press_contr, 1)

-- altitude table
-- tables for needed cabin alt
local alt_table = {{ -50000, -50000},    -- bugs workaround
				  { 0, 0 },    -- on standard pressure zero level
            	  {  2000, 0 },     -- 2000 ft
           		  {  11000, 0 },    -- 11000 ft
          		  {  23000, 9000 },   -- 23000 ft
          		  {  1000000, 979500 }}   -- linear above 23000 ft

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

local use_oxy_lit = false
local door_lit = false
local angle1 = 0
local angle2 = 0
local siren_alarm = false
local counter = 0

local left_urvk_counter = 0
local right_urvk_counter = 0

function update()
	local passed = get(frame_time)

	local rpm1 = 0
	local rpm2 = 0
	if get(eng_rpm1) > 80 then rpm1 = 1 end
	if get(eng_rpm2) > 80 then rpm2 = 1 end
	
	local sys_on1 = rpm1 * get(bleed1_sw)
	local sys_on2 = rpm2 * get(bleed2_sw)
	
	-- gauges
	local left_coef = 0
	local right_coef = 0
	if sys_on1 == 1 then left_urvk_counter = left_urvk_counter + passed 
	else left_urvk_counter = 0 end
	if sys_on2 == 1 then right_urvk_counter = right_urvk_counter + passed
	else right_urvk_counter = 0 end
	
	if (sys_on1 == 1 and left_urvk_counter > 3) or sys_on1 == 0 then left_coef = 1 else left_coef = 0 end
	if (sys_on2 == 1 and right_urvk_counter > 3) or sys_on2 == 0 then right_coef = 1 else right_coef = 0 end
	angle1 = angle1 + (120 * sys_on1 * left_coef - angle1) * 0.6 * passed 
	angle2 = angle2 + (120 * sys_on2 * right_coef - angle2) * 0.6 * passed
	
	-- calculate real airplane altitude above standard pressure isoline
	local real_alt = get(msl_alt) * 3.28083 + (29.92 - get(baro_press)) * 1000
	-- calculate needed cabin altitude, which system can reach when work normally
	local needed_cabin_alt = real_alt	
	if real_alt < 100000 then needed_cabin_alt = interpolate(alt_table, real_alt) end
	
	local actual_alt = get(actual_cabin_alt)
	
	-- calculate speed of change cabin VVI and cabin altitude that system can really reach
	local cabin_alt = real_alt
	local vvi = 300 -- ft/min
	
	if angle1 + angle2 > 180 then
		cabin_alt = needed_cabin_alt
		vvi = 1500 * math.min(1, math.abs(actual_alt - cabin_alt) * 0.001)
	elseif angle1 + angle2 > 90 then
		cabin_alt = needed_cabin_alt
		if actual_alt > cabin_alt + 50 then vvi = 100 * math.min(1, math.abs(actual_alt - cabin_alt) * 0.001) 
		elseif actual_alt < cabin_alt - 50 then vvi = 750 * math.min(1, math.abs(actual_alt - cabin_alt) * 0.001) 
		else vvi = 0 * math.min(1, math.abs(actual_alt - cabin_alt) * 0.001) 
		end
	else
		cabin_alt = real_alt
		vvi = 300 
	end

	-- dump logic
	if get(dump_sw) == 1 then
		vvi = 2000
		cabin_alt = real_alt
	end
	

	
	--print(cabin_alt, vvi, real_alt)
	
	-- rapid decompression if some door or window is opened in flight
	local doors_open = get(hole3) > 0.1 or get(hole4) > 0.1 or get(hole5) > 0.1 or get(hole6) > 0.1 or get(hole7) > 0.1 or get(hole8) > 0.1
	if get(hole1) > 0.1 or get(hole2) > 0.1 or doors_open then
		set(rapid_depress, 6)
		set(mode, 0)
		vvi = 5000
	else 
		set(rapid_depress, 0) 
		set(mode, 2)
	end
	
	local power = get(bus_DC_27_volt_emerg) > 21
	
	-- lamps
	use_oxy_lit = actual_alt * 0.0003048009 > 3.5 and power
	door_lit = doors_open and power

	-- suren
	if use_oxy_lit then 
		set(skv_siren, 1) 
		counter = counter + passed
		if counter > 0.3 then
			counter = 0
			siren_alarm = not siren_alarm
		end
		if siren_alarm then set(skv_siren_alarm, 1) else set(skv_siren_alarm, 0) end
	else 
		set(skv_siren, 0) 
		counter = 0
		siren_alarm = false
		set(skv_siren_alarm, 0)
	end
	
	-- set result
	set(mode, 2)
	set(dump, 0)
	set(sim_cab_alt, cabin_alt)
	set(sim_cab_vvi, vvi)
	
	
end

components = {
	
    -- dump cap switch
    switch {
        position = {134, 448, 30, 40 },
        state = function()
            return get(dump_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cup_open_sound, 0)
			switcher_pushed = true
			if get(dump_cap) ~= 0 then
                set(dump_cap, 0)
				set(dump_sw, 0)
            else
                set(dump_cap, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
		    playSample(switch_sound, 0)
		    playSample(cup_close_sound, 0)
			switcher_pushed = false
			return true
		end,
    },

    -- dump cap switch
    switch {
        position = {955, 307, 17, 17 },
        state = function()
            return get(dump_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(dump_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(dump_sw) ~= 0 then
                set(dump_sw, 0)
            else
                set(dump_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- system1 switch
    switch {
        position = {1022, 429, 18, 18 },
        state = function()
            return get(bleed1_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(bleed1_sw) ~= 0 then
                set(bleed1_sw, 0)
            else
                set(bleed1_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- system2 switch
    switch {
        position = {1041, 429, 18, 18 },
        state = function()
            return get(bleed2_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(bleed2_sw) ~= 0 then
                set(bleed2_sw, 0)
            else
                set(bleed2_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- use oxigen light
	textureLit {
		image = get(blue_led),
		position = {641, 388, 19, 19},
		visible = function()
			return use_oxy_lit
		end,
	},

	-- close doors light
	textureLit {
		image = get(yellow_led),
		position = {621, 388, 19, 19},
		visible = function()
			return door_lit
		end,
	},
	
	-- system1 needle
	needle {
        position = { 1212, 1258, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return angle1
        end
    }, 

	-- system2 needle
	needle {
        position = { 1412, 1258, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return angle2
        end
    }, 


}


