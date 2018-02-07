-- this skript contains components for fuel system manipulation and indication
size = {2048, 2048}

-- define property table
-- switchers
defineProperty("fire_valve1_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve1_sw")) -- fire valve switch for engine 1
defineProperty("fire_valve2_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve2_sw")) -- fire valve switch for engine 2
defineProperty("fire_valve3_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve3_sw")) -- fire valve switch for engine 3
defineProperty("fuel_circle_valve_sw", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_valve_sw")) -- valve for fuel circulation between left and right tanks
defineProperty("pump1_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump1_switch"))  -- fuel pump switch tank 1
defineProperty("pump2_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump2_switch"))  -- fuel pump switch tank 2
defineProperty("pump3_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump3_switch"))  -- fuel pump switch tank 3
defineProperty("pump4_switch", globalPropertyi("sim/custom/xap/An24_fuel/pump4_switch"))  -- fuel pump switch tank 4
defineProperty("q_meter1_switch", globalPropertyi("sim/custom/xap/An24_fuel/q_meter1_switch"))  -- switcher for quantity meter left
defineProperty("q_meter2_switch", globalPropertyi("sim/custom/xap/An24_fuel/q_meter2_switch"))  -- switcher for quantity meter right
defineProperty("ff_meter_switch", globalPropertyi("sim/custom/xap/An24_fuel/ff_meter_switch"))  -- switcher for fuel flow meter
defineProperty("auto_ff_switch", globalPropertyi("sim/custom/xap/An24_fuel/auto_ff_switch"))  -- switcher for fuel flow automat
defineProperty("quantity_mode", globalPropertyi("sim/custom/xap/An24_fuel/quantity_mode"))  -- mode of quantity meter

defineProperty("fuel_stop1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop1")) -- stops on center panel
defineProperty("fuel_stop2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop2")) -- stops on center panel
defineProperty("fuel_stop1_cap", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop1_cap")) -- stops on center panel
defineProperty("fuel_stop2_cap", globalPropertyf("sim/custom/xap/An24_fuel/fuel_stop2_cap")) -- stops on center panel

defineProperty("fuel_pump_1", globalPropertyi("sim/custom/xap/An24_fuel/tank1_pump"))  -- fuel pump for tank 1
defineProperty("fuel_pump_2", globalPropertyi("sim/custom/xap/An24_fuel/tank2_pump"))  -- fuel pump for tank 2
defineProperty("fuel_pump_3", globalPropertyi("sim/custom/xap/An24_fuel/tank3_pump"))  -- fuel pump for tank 3
defineProperty("fuel_pump_4", globalPropertyi("sim/custom/xap/An24_fuel/tank4_pump"))  -- fuel pump for tank 4
defineProperty("fuel_circle_valve", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_valve")) -- valve for fuel circulation between left and right tanks
--defineProperty("mixt_valve1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access1")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
--defineProperty("mixt_valve2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access2")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
--defineProperty("mixt_valve3", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access3")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve1", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve1")) -- fire valve for engine 1
defineProperty("mixt_valve2", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve2")) -- fire valve for engine 2
defineProperty("mixt_valve3", globalPropertyf("sim/custom/xap/An24_fuel/fire_valve3")) -- fire valve for engine 3

-- defineProperty("SC_master", globalPropertyi("scp/api/ismaster")) -- status of SmartCopilot
-- defineProperty("sc_fuel_show_left", globalPropertyf("sim/custom/xap/An24_fuel/sc_fuel_show_left")) -- SmartCopilot
-- defineProperty("sc_fuel_show_right", globalPropertyf("sim/custom/xap/An24_fuel/sc_fuel_show_right")) -- SmartCopilot


defineProperty("chip_detect1", globalPropertyf("sim/cockpit/warnings/annunciators/chip_detected[0]")) -- chip in engine1
defineProperty("chip_detect2", globalPropertyf("sim/cockpit/warnings/annunciators/chip_detected[1]")) -- chip in engine1

-- fuel in tanks for indication
defineProperty("tank1_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank1_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank2_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank2_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank3_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank3_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("tank4_q_ind", globalPropertyf("sim/custom/xap/An24_fuel/tank4_q_ind")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich

-- real fuel flow on two engines
defineProperty("FF1", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[0]")) -- fuel flow for engine 1
defineProperty("FF2", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[1]")) -- fuel flow for engine 2
defineProperty("FF3", globalPropertyf("sim/flightmodel/engine/ENGN_FF_[2]")) -- fuel flow for engine 3

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- electric
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("fuel_flow_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_cc")) 

-- failures
defineProperty("tank1_block_fail", globalPropertyf("sim/operation/failures/rel_fuel_block0")) -- fuel filter blocked
defineProperty("tank2_block_fail", globalPropertyf("sim/operation/failures/rel_fuel_block1")) -- fuel filter blocked
defineProperty("tank3_block_fail", globalPropertyf("sim/operation/failures/rel_fuel_block2")) -- fuel filter blocked
defineProperty("tank4_block_fail", globalPropertyf("sim/operation/failures/rel_fuel_block3")) -- fuel filter blocked

-- results
defineProperty("quant_1000_lit", globalPropertyi("sim/custom/xap/An24_fuel/quant_1000_lit")) -- 
defineProperty("left_filter_block_lit", globalPropertyi("sim/custom/xap/An24_fuel/left_filter_block_lit")) -- 
defineProperty("right_filter_block_lit", globalPropertyi("sim/custom/xap/An24_fuel/right_filter_block_lit")) -- 
defineProperty("fuel_circle_lit", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_lit")) -- 
defineProperty("left_fuel_press_lit", globalPropertyi("sim/custom/xap/An24_fuel/left_fuel_press_lit")) -- 
defineProperty("right_fuel_press_lit", globalPropertyi("sim/custom/xap/An24_fuel/right_fuel_press_lit")) -- 
defineProperty("left_pk_open_lit", globalPropertyi("sim/custom/xap/An24_fuel/left_pk_open_lit")) -- 
defineProperty("right_pk_open_lit", globalPropertyi("sim/custom/xap/An24_fuel/right_pk_open_lit")) -- 
defineProperty("left_chip_lit", globalPropertyi("sim/custom/xap/An24_fuel/left_chip_lit")) -- 
defineProperty("right_chip_lit", globalPropertyi("sim/custom/xap/An24_fuel/right_chip_lit")) -- 
defineProperty("fuel_lump1_lit", globalPropertyi("sim/custom/xap/An24_fuel/fuel_lump1_lit")) -- 
defineProperty("fuel_lump2_lit", globalPropertyi("sim/custom/xap/An24_fuel/fuel_lump2_lit")) -- 
defineProperty("fuel_lump3_lit", globalPropertyi("sim/custom/xap/An24_fuel/fuel_lump3_lit")) -- 
defineProperty("fuel_lump4_lit", globalPropertyi("sim/custom/xap/An24_fuel/fuel_lump4_lit")) -- 
defineProperty("fuel_flow_left_angle", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_left_angle")) -- 
defineProperty("fuel_flow_right_angle", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_right_angle")) -- 
defineProperty("fuel_flow_left_count", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_left_count")) -- 
defineProperty("fuel_flow_right_count", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_right_count")) -- 
defineProperty("fuel_flow_left_count_rot", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_left_count_rot")) -- 
defineProperty("fuel_flow_right_count_rot", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_right_count_rot")) -- 
defineProperty("fuel_quant1_angle", globalPropertyf("sim/custom/xap/An24_fuel/fuel_quant1_angle")) -- 
defineProperty("fuel_quant2_angle", globalPropertyf("sim/custom/xap/An24_fuel/fuel_quant2_angle")) -- 
defineProperty("fuel_quant_button", globalPropertyi("sim/custom/xap/An24_fuel/fuel_quant_button")) -- 
defineProperty("ru19_pk_open_lit", globalPropertyi("sim/custom/xap/An24_fuel/ru19_pk_open_lit")) -- 
defineProperty("ru19_pk_close_lit", globalPropertyi("sim/custom/xap/An24_fuel/ru19_pk_close_lit")) -- 

-- reality
defineProperty("set_real_fuel_meter", globalPropertyi("sim/custom/xap/An24_set/real_fuel_meter")) -- real fuel meter will show less fuel amount, then it's really is

-- images
defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

defineProperty("needle_q_left", loadImage("needles.dds", 32, 95, 17, 141)) 
defineProperty("needle_q_right", loadImage("needles.dds", 48, 95, 17, 141)) 
defineProperty("needle_long", loadImage("needles.dds", 67, 70, 16, 179)) 

defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))

defineProperty("yellow_cap", loadImage("covers.dds", 204, 0, 56, 56)) -- yellow cap image


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

local function bool2int(var)
	if var then return 1 else return 0 end
end

local function int2bool(var)
	if var == 0 then return false else return true end
end



local power_27 = 0
local power_emerg = 0
local power_36 = 0
local power_115 = 0


-- leds variables
local fire_v1_led = false
local fire_v2_led = false
local fire_v3_led = false
local fire_v3_off_led = false
local pump1_led = false
local pump2_led = false
local pump3_led = false
local pump4_led = false
local fuel_circle_led = false
local fuel_press_left_led = false
local fuel_press_right_led = false
local chip_left = false
local chip_right = false
local fuel_1000_lit = false
local left_filter_lit = false
local right_filter_lit = false

-- local variables
local q_left_last_angle = -150  -- previous position of needle for smooth movement
local q_right_last_angle = -150
local q_left_angle = -150
local q_right_angle = -150

local fuel_counter_left = 1000
local fuel_counter_right = 1000
local counter_rotary_left = get(fuel_flow_left_count_rot)
local counter_rotary_right = get(fuel_flow_right_count_rot)
local fuel_show_left = fuel_counter_left + counter_rotary_left
local fuel_show_right = fuel_counter_right + counter_rotary_right
local fuel_flow1_angle = -135
local fuel_flow2_angle = -135
local ff1_actual_angle = math.random() * 40 - 130
local ff1_last_angle = ff1_actual_angle
local ff2_actual_angle = math.random() * 40 - 130
local ff2_last_angle = ff2_actual_angle

local q_left_needed = -150
local q_right_needed = -150

local passed = 0

local fuel_corr_table = { 
{  -20, 0 },    
{  0, 0 },    
{  100, 100 },    
{  260, 200 },
{  450, 300 },    
{  650, 400 },    
{  850, 500 },
{  1030, 600 },    
{  1130, 700 },    
{  1230, 800 },
{  1350, 900 },    
{  1430, 1000 },    
{  1520, 1100 },
{  1620, 1200 },
{  1720, 1300 },
{  1820, 1400 },
{  1920, 1500 },
{  2020, 1600 },
{  2120, 1700 },
{  2220, 1800 },
{  2320, 1900 },
{  2430, 2000 },
{  2530, 2100 },
} 

local function interpolate(tbl, value) -- interpolate values using tables
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

-- post frame calculations
function update()

	local sim_time = get(flight_time)
	passed = get(frame_time)
if passed > 0 then
	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(fire_valve1_sw, 0)
		set(fire_valve2_sw, 0)
		set(pump1_switch, 1)
		set(pump2_switch, 0)
		set(pump3_switch, 0)
		set(pump4_switch, 1)
		set(q_meter1_switch, 0)
		set(q_meter2_switch, 0)
		set(ff_meter_switch, 0)
		set(auto_ff_switch, 0)
		not_loaded = false
	end
	
	-- power calculations
	if get(bus_DC_27_volt) > 21 then power_27 = 1 else power_27 = 0 end
	if get(bus_DC_27_volt_emerg) > 21 then power_emerg = 1 else power_emerg = 0 end
	if get(bus_AC_36_volt) > 34 then power_36 = 1 else power_36 = 0 end
	if get(bus_AC_115_volt) > 112 then power_115 = 1 else power_115 = 0 end
	
	-- fire valve leds calculations
	fire_v1_led = power_emerg * get(mixt_valve1) > 0.7
	fire_v2_led = power_emerg * get(mixt_valve2) > 0.7
	fire_v3_led = power_emerg * get(mixt_valve3) > 0.7
	fire_v3_off_led = power_emerg > 0 and get(mixt_valve3) < 0.3
		
	-- fuel pump leds
	pump1_led = power_27 * get(fuel_pump_1) > 0
	pump2_led = power_27 * get(fuel_pump_2) > 0
	pump3_led = power_27 * get(fuel_pump_3) > 0
	pump4_led = power_27 * get(fuel_pump_4) > 0
	
	-- fuel circle led
	fuel_circle_led = power_27 * get(fuel_circle_valve) > 0
	
	-- fuel pressure leds
	if fuel_circle_led and power_36 * power_115 > 0 then
		if pump1_led or pump2_led or pump3_led or pump4_led then
			fuel_press_left_led = true
			fuel_press_right_led = true
		else 
			fuel_press_left_led = false
			fuel_press_right_led = false
		end
	elseif not fuel_circle_led and power_36 * power_115 > 0 then
		if pump1_led or pump2_led then fuel_press_left_led = true
		else fuel_press_left_led = false end
		if pump3_led or pump4_led then fuel_press_right_led = true
		else fuel_press_right_led = false end
	else 
		fuel_press_left_led = false
		fuel_press_right_led = false
	end
		fuel_press_left_led = fuel_press_left_led and fire_v1_led
		fuel_press_right_led = fuel_press_right_led and fire_v2_led
	
	-- chip detect led
	chip_left = power_27 * get(chip_detect1) > 0 or (get(mixt_valve1) < 0.3 and power_emerg == 1)
	chip_right = power_27 * get(chip_detect2) > 0 or (get(mixt_valve2) < 0.3 and power_emerg == 1)
	
	-- fuel quantity indicators
	local real = get(set_real_fuel_meter) == 1
	local q_mode = get(quantity_mode)
	local tank1q = get(tank1_q_ind)
	local tank2q = get(tank2_q_ind)
	local tank3q = get(tank3_q_ind)
	local tank4q = get(tank4_q_ind)
	if real then
		tank1q = interpolate(fuel_corr_table, tank1q)
		tank2q = interpolate(fuel_corr_table, tank2q)
		tank3q = interpolate(fuel_corr_table, tank3q)
		tank4q = interpolate(fuel_corr_table, tank4q)
	end
	
	
	local power_mode = 0
	
	-- determine needed angles
	if get(fuel_quant_button) == 1 then
		q_left_needed = -150
		q_right_needed = -150
		if q_mode == 0 then power_mode = 0 else power_mode = 1 end
	else
		if q_mode == 0 then 
			power_mode = 0
		elseif q_mode == 1 then
			q_left_needed = (tank1q + tank2q) * 300 / 2400 - 150
			q_right_needed = (tank3q + tank4q) * 300 / 2400 - 150
			power_mode = 1
		elseif q_mode == 2 then
			q_left_needed = tank1q * 300 / 2400 - 150
			q_right_needed = tank4q * 300 / 2400 - 150
			power_mode = 1
		elseif q_mode == 3 then
			q_left_needed = tank2q * 300 / 1600 - 150
			q_right_needed = tank3q * 300 / 1600 - 150
			power_mode = 1
		end
	end
	

	-- smooth movement of q-meter needles
	q_left_angle = q_left_last_angle + (q_left_needed - q_left_last_angle) * passed * 1 * power_115 * math.random() * get(q_meter1_switch) * power_mode
	q_right_angle = q_right_last_angle + (q_right_needed - q_right_last_angle) * passed * 1 * power_115 * math.random() * get(q_meter2_switch) * power_mode
	
	-- fuel quantity less then 1000kg lamp
	fuel_1000_lit = power_115 == 1 and tank1q + tank2q + tank3q + tank4q < 750 and power_27 == 1
	
	-- fuel filters lamps
	left_filter_lit = power_27 == 1 and (get(tank1_block_fail) == 6 or get(tank2_block_fail) == 6)
	right_filter_lit = power_27 == 1 and (get(tank3_block_fail) == 6 or get(tank4_block_fail) == 6)

	-- fuel flow meters and fuel counters
	if get(ff_meter_switch) * power_115 > 0 then
		--fuel_counter_left = fuel_counter_left - get(FF1) * passed 
		set(fuel_flow_left_count_rot, get(fuel_flow_left_count_rot) - get(FF1) * passed)
		--fuel_counter_right = fuel_counter_right - get(FF2) * passed 
		set(fuel_flow_right_count_rot, get(fuel_flow_right_count_rot) - get(FF2) * passed)
		fuel_flow1_angle = (get(FF1) * 3600 - 200) * 240 / 600 - 120
		fuel_flow2_angle = (get(FF2) * 3600 - 200) * 240 / 600 - 120
		set(fuel_flow_cc, 4)
	else
		set(fuel_flow_cc, 0)

	end
	fuel_show_left = get(fuel_flow_left_count_rot)
	if fuel_show_left < 0 then 
		set(fuel_flow_left_count_rot, get(fuel_flow_left_count_rot) + 1) 
	end
	if fuel_show_left > 9990 then 
		set(fuel_flow_left_count_rot, get(fuel_flow_left_count_rot) - 5)
	end
	
	fuel_show_right = get(fuel_flow_right_count_rot)
	if fuel_show_right < 0 then 
		set(fuel_flow_right_count_rot, get(fuel_flow_right_count_rot) + 1) 
	end
	if fuel_show_right > 9990 then 
		set(fuel_flow_right_count_rot, get(fuel_flow_right_count_rot) - 5)
	end
	
	if fuel_flow1_angle < -135 then fuel_flow1_angle = -135 end
	if fuel_flow2_angle < -135	then fuel_flow2_angle = -135 end
	
	-- smooth moves of angles
	ff1_actual_angle = ff1_last_angle + (fuel_flow1_angle - ff1_last_angle) * passed * 1
	ff2_actual_angle = ff2_last_angle + (fuel_flow2_angle - ff2_last_angle) * passed * 1
	
	-- set results for 2D panel
	set(quant_1000_lit, bool2int(fuel_1000_lit))  
	set(left_filter_block_lit, bool2int(left_filter_lit))
	set(right_filter_block_lit, bool2int(right_filter_lit))
	set(fuel_circle_lit, bool2int(fuel_circle_led))
	set(left_fuel_press_lit, bool2int(fuel_press_left_led))
	set(right_fuel_press_lit, bool2int(fuel_press_right_led))
	set(left_pk_open_lit, bool2int(fire_v1_led))
	set(right_pk_open_lit, bool2int(fire_v2_led))	
	set(left_chip_lit, bool2int(chip_left))
	set(right_chip_lit, bool2int(chip_right))
	set(fuel_lump1_lit, bool2int(pump1_led))
	set(fuel_lump2_lit, bool2int(pump2_led))
	set(fuel_lump3_lit, bool2int(pump3_led))
	set(fuel_lump4_lit, bool2int(pump4_led))
	set(fuel_flow_left_angle, ff1_actual_angle)
	set(fuel_flow_right_angle, ff2_actual_angle)
	
	--if get(SC_master) == 1 then
		--fuel_show_left = get(sc_fuel_show_left)
		--fuel_show_right = get(sc_fuel_show_right)
	--else
		--set(sc_fuel_show_left, fuel_show_left)
		--set(sc_fuel_show_right, fuel_show_right)
	--end
	
	set(fuel_flow_left_count, fuel_show_left/10)
	set(fuel_flow_right_count, fuel_show_right/10)	
	set(fuel_quant1_angle, q_left_angle)
	set(fuel_quant2_angle, q_right_angle)
	set(ru19_pk_open_lit, bool2int(fire_v3_led))
	set(ru19_pk_close_lit, bool2int(fire_v3_off_led))
	
	-- last variables
	q_left_last_angle = q_left_angle
	q_right_last_angle = q_right_angle
	ff1_last_angle = ff1_actual_angle
	ff2_last_angle = ff2_actual_angle
end

end


components = {
	---------------------
	-- needle gauges --
	---------------------
	-- quantity meter. left needle
	needle { 
		image = get(needle_q_left),
		position = {230, 1275, 141, 141},
		angle = function()
		return q_left_angle
		end,	
	},
	
	-- quantity meter. right needle
	needle { 
		image = get(needle_q_right),
		position = {230, 1275, 141, 141},
		angle = function()
		return q_right_angle
		end,	
	},
	
	-- yellow cap
	texture{
	    position = { 272, 1317, 56, 56 },
        image = get(yellow_cap),
	},
	
	-- control button
	clickable {
        position = { 275, 1250, 50, 50},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fuel_quant_button, 1)
			if not switcher_pushed then
			playSample(btn_click, 0)
			switcher_pushed = true
			end
			return true
		end,
		
		onMouseUp = function()
			set(fuel_quant_button, 0)
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end,
    },
	
	-- mode changer
	clickable {
        position = { 1518, 559, 35, 70},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(quantity_mode)
			if not switcher_pushed and a > 0 then 
				playSample(plastic_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(quantity_mode, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	clickable {
        position = { 1550, 559, 35, 70},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(quantity_mode)
			if not switcher_pushed and a < 3 then 
				playSample(plastic_sound, 0) 
				a = a + 1
			end
			set(quantity_mode, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- fuel flow meters
	-- left counter
	digitstape {
        position = { 1068, 1490, 71, 25};
        image = digitsImage;
        digits = 3;
		allowNonRound = false;
		showLeadingZeros = true;
        value = function() 
            return fuel_show_left / 10; 
        end;
    }; 
	needle { 
		image = get(needle_long),
		position = {1012, 1457, 179, 179},
		angle = function()
		return ff1_actual_angle
		end,	
	},

    -- counter rotary
    rotary {
        -- image = rotaryImage;
        value = fuel_flow_left_count_rot;
        step = 10;
        position = {  1068, 1450, 70, 50 };

        -- round counter
        adjuster = function(v)
			playSample(rot_click, 0) 
            return math.ceil(v/10) * 10
        end;
    };
	
	--[[
	clickable {
        position = { 1103, 1450, 35, 50},  -- search and set right
        
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			counter_rotary_left = counter_rotary_left + 10
			fuel_counter_left = math.ceil(fuel_counter_left / 10 - 0.5) * 10
			return true
		end,
    },
	clickable {
        position = { 1068, 1450, 35, 50},  -- search and set right
        
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			counter_rotary_left = counter_rotary_left - 10
			fuel_counter_left = math.floor(fuel_counter_left / 10 + 0.5) * 10
			return true
		end,
    },
--]]
	-- right counter
	digitstape {
        position = { 1268, 1490, 71, 25};
        image = digitsImage;
        digits = 3;
		allowNonRound = false;
		showLeadingZeros = true;
        value = function() 
            return fuel_show_right / 10; 
        end;
    }; 
	needle { 
		image = get(needle_long),
		position = {1212, 1457, 179, 179},
		angle = function()
		return ff2_actual_angle
		end,	
	},
    -- counter rotary
    rotary {
        -- image = rotaryImage;
        value = fuel_flow_right_count_rot;
        step = 10;
        position = {  1268, 1450, 70, 50 };

        -- round counter
        adjuster = function(v)
            playSample(rot_click, 0) 
			return math.ceil(v/10) * 10
        end;
    };

--[[
	clickable {
        position = { 1303, 1450, 35, 50},  -- search and set right
        
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			counter_rotary_right = counter_rotary_right + 10
			fuel_counter_right = math.ceil(fuel_counter_right / 10 - 0.5) * 10
			return true
		end,
    },
	clickable {
        position = { 1268, 1450, 35, 50},  -- search and set right
        
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			counter_rotary_right = counter_rotary_right - 10
			fuel_counter_right = math.floor(fuel_counter_right / 10 + 0.5) * 10
			return true
		end,
    },
--]]
	---------------------
	-- panel lights --
	---------------------
	-- fuel quantity less then 1000kg
	textureLit {
		image = get(red_led),
		position = {600, 368, 20, 20},
		visible = function()
			return fuel_1000_lit
		end,
	},

	-- left filter block
	textureLit {
		image = get(yellow_led),
		position = {620, 368, 20, 20},
		visible = function()
			return left_filter_lit
		end,
	},
	
	-- right filter block
	textureLit {
		image = get(yellow_led),
		position = {640, 368, 20, 20},
		visible = function()
			return right_filter_lit
		end,
	},
	
	
	-- fire valve 3 ON
	textureLit {
		image = get(green_led),
		position = {621, 428, 20, 20},
		visible = function()
			return fire_v3_led
		end,
	},

	-- fire valve 3 OFF
	textureLit {
		image = get(red_led),
		position = {641, 428, 20, 20},
		visible = function()
			return fire_v3_off_led
		end,
	},
	
	-- fuel circle
	textureLit {
		image = get(yellow_led),
		position = {680, 367, 20, 20},
		visible = function()
			return fuel_circle_led
		end,
	},
	
	-- fuel pressure left
	textureLit {
		image = get(green_led),
		position = {660, 367, 20, 20},
		visible = function()
			return fuel_press_left_led
		end,
	},
	
	-- fuel pressure right
	textureLit {
		image = get(green_led),
		position = {700, 367, 20, 20},
		visible = function()
			return fuel_press_right_led
		end,
	},
	
	-- fuel pump 1
	textureLit {
		image = get(green_led),
		position = {720, 367, 20, 20},
		visible = function()
			return pump1_led
		end,
	},
	
	-- fuel pump 2
	textureLit {
		image = get(green_led),
		position = {739.5, 367, 20, 20},
		visible = function()
			return pump2_led
		end,
	},
	
		-- fuel pump 3
	textureLit {
		image = get(green_led),
		position = {760, 367, 20, 20},
		visible = function()
			return pump3_led
		end,
	},
	
		-- fuel pump 4
	textureLit {
		image = get(green_led),
		position = {780.5, 367, 20, 20},
		visible = function()
			return pump4_led
		end,
	},
	
	-- fire valve 1 ON
	textureLit {
		image = get(green_led),
		position = {600.5, 347, 20, 20},
		visible = function()
			return fire_v1_led
		end,
	},

	-- fire valve 2 ON
	textureLit {
		image = get(green_led),
		position = {660, 347, 20, 20},
		visible = function()
			return fire_v2_led
		end,
	},	
	
	-- chip left
	textureLit {
		image = get(red_led),
		position = {680, 347, 20, 20},
		visible = function()
			return chip_left
		end,
	},	
	
	-- chip right
	textureLit {
		image = get(red_led),
		position = {700, 347, 20, 20},
		visible = function()
			return chip_right
		end,
	},	

	---------------------
	-- panel switchers --
	---------------------
    -- fire valve 1
    switch {
        position = { 805, 288, 17, 17},
        state = function()
            return get(fire_valve1_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fire_valve1_sw) ~= 0 then
                set(fire_valve1_sw, 0)
            else
                set(fire_valve1_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

    -- fire valve 2
    switch {
        position = { 918, 288, 17, 17},
        state = function()
            return get(fire_valve2_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fire_valve2_sw) ~= 0 then
                set(fire_valve2_sw, 0)
            else
                set(fire_valve2_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- fire valve 3
    switch {
        position = {823, 364, 17, 17},
        state = function()
            return get(fire_valve3_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fire_valve3_sw) ~= 0 then
                set(fire_valve3_sw, 0)
            else
                set(fire_valve3_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- fuel pump 1
    -- switcher up
	clickable {
        position = { 823, 288, 17, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pump1_switch)
			if not switcher_pushed and a < 2 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			set(pump1_switch, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- switcher down
	clickable {
        position = { 823, 297, 17, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pump1_switch)
			if not switcher_pushed and a > 0 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			set(pump1_switch, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- fuel pump 4
    -- switcher up
	clickable {
        position = { 897, 288, 17, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pump4_switch)
			if not switcher_pushed and a < 2 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			set(pump4_switch, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- switcher down
	clickable {
        position = { 897, 297, 17, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       onMouseClick = function() 
			local a = get(pump4_switch)
			if not switcher_pushed and a > 0 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			set(pump4_switch, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- fuel pump 2
    switch {
        position = {842, 288, 17, 17},
        state = function()
            return get(pump2_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(pump2_switch) ~= 0 then
                set(pump2_switch, 0)
            else
                set(pump2_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- fuel pump 3
    switch {
        position = {879, 288, 17, 17},
        state = function()
            return get(pump3_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(pump3_switch) ~= 0 then
                set(pump3_switch, 0)
            else
                set(pump3_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	
	
	-- fuel circle
    switch {
        position = {861, 288, 17, 17},
        state = function()
            return get(fuel_circle_valve_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fuel_circle_valve_sw) ~= 0 then
                set(fuel_circle_valve_sw, 0)
            else
                set(fuel_circle_valve_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- fuel q-meter left
    switch {
        position = {879, 307, 17, 17},
        state = function()
            return get(q_meter1_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(q_meter1_switch) ~= 0 then
                set(q_meter1_switch, 0)
            else
                set(q_meter1_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- fuel q-meter right
    switch {
        position = {898, 307, 17, 17},
        state = function()
            return get(q_meter2_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(q_meter2_switch) ~= 0 then
                set(q_meter2_switch, 0)
            else
                set(q_meter2_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- fuel flow meter 
    switch {
        position = {917, 307, 17, 17},
        state = function()
            return get(ff_meter_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ff_meter_switch) ~= 0 then
                set(ff_meter_switch, 0)
            else
                set(ff_meter_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- fuel flow automat
    switch {
        position = {936, 307, 17, 17},
        state = function()
            return get(auto_ff_switch) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(auto_ff_switch) ~= 0 then
                set(auto_ff_switch, 0)
            else
                set(auto_ff_switch, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- fuel stop cap left
    switch {
        position = {34, 450, 34, 40},
        state = function()
            return get(fuel_stop1_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(fuel_stop1_cap) ~= 0 then
                set(fuel_stop1_cap, 0)
            else
                set(fuel_stop1_cap, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- fuel stop cap right
    switch {
        position = {68, 450, 34, 40},
        state = function()
            return get(fuel_stop2_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(fuel_stop2_cap) ~= 0 then
                set(fuel_stop2_cap, 0)
            else
                set(fuel_stop2_cap, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	

	-- fuel stop left	
    switch {
        position = {1002, 372, 18, 18},
        state = function()
            return get(fuel_stop1) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(fuel_stop1_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fuel_stop1) ~= 0 then
                set(fuel_stop1, 0)
            else
                set(fuel_stop1, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	

	-- fuel stop right	
    switch {
        position = {1020, 372, 18, 18},
        state = function()
            return get(fuel_stop2) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(fuel_stop2_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fuel_stop2) ~= 0 then
                set(fuel_stop2, 0)
            else
                set(fuel_stop2, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	
	
	
}