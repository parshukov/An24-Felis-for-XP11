-- this is the electrical panel logic, shown on 3D cockpit panels...

size = {2048, 2048} -- panel will contain a several gauges in different plases of panel texture

-- define property table
-- connect sources to bus
defineProperty("stg1_on", globalPropertyi("sim/custom/xap/An24_power/stg1_on")) -- generator connected if 1 and dissconnected if 0
defineProperty("stg2_on", globalPropertyi("sim/custom/xap/An24_power/stg2_on"))

defineProperty("stg1_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg1_on_bus"))  -- generator connected if 1 and dissconnected if 0
defineProperty("stg2_on_bus", globalPropertyi("sim/custom/xap/An24_power/stg2_on_bus"))
defineProperty("gs24_on_bus", globalPropertyi("sim/custom/xap/An24_power/gs24_on_bus"))
defineProperty("go1_on_bus", globalPropertyi("sim/custom/xap/An24_power/go1_on_bus"))
defineProperty("go2_on_bus", globalPropertyi("sim/custom/xap/An24_power/go2_on_bus"))

defineProperty("inv_PT1000_1", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_1"))  -- inverters
defineProperty("inv_PT1000_2", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_2"))
defineProperty("inv_PT750", globalPropertyi("sim/custom/xap/An24_power/inv_PT750"))

defineProperty("bat1_on", globalPropertyi("sim/custom/xap/An24_power/bat1_on"))  -- battery switch. 0 = OFF, 1 = ON
defineProperty("bat2_on", globalPropertyi("sim/custom/xap/An24_power/bat2_on"))
defineProperty("bat3_on", globalPropertyi("sim/custom/xap/An24_power/bat3_on"))

-- logic
defineProperty("main_on_emerg", globalPropertyi("sim/custom/xap/An24_power/main_on_emerg"))  -- main bus connected to emergency bus
defineProperty("DC_source", globalPropertyi("sim/custom/xap/An24_power/DC_source"))  -- source for DC27v bus. 0 = none, 1 = STG1, 2 = STG2, 3 = GS24, 4 = bat. left gen by default
defineProperty("AC_source", globalPropertyi("sim/custom/xap/An24_power/AC_source"))  -- source for AC115 bus. 1 when generators, 2 when inverter

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

defineProperty("bat1_volt", globalPropertyf("sim/custom/xap/An24_power/bat1_volt")) -- battery voltage, initial 27V - full charge.
defineProperty("bat2_volt", globalPropertyf("sim/custom/xap/An24_power/bat2_volt")) 
defineProperty("bat3_volt", globalPropertyf("sim/custom/xap/An24_power/bat3_volt")) 

defineProperty("bat1_amp", globalPropertyf("sim/custom/xap/An24_power/bat1_amp"))  -- battery current, initial 0A. positive - battery load, negative - battery recharge.
defineProperty("bat2_amp", globalPropertyf("sim/custom/xap/An24_power/bat2_amp")) 
defineProperty("bat3_amp", globalPropertyf("sim/custom/xap/An24_power/bat3_amp")) 

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

-- switchers
defineProperty("AC36_volt_mode", globalPropertyi("sim/custom/xap/An24_power/AC36_volt_mode"))  -- mode switcher for AC 36 voltmeter, 9 positions 0-8
defineProperty("AC115_volt_mode", globalPropertyi("sim/custom/xap/An24_power/AC115_volt_mode"))  -- mode switcher for AC 115 voltmeter, 7 positions 0-6
defineProperty("DC_volt_mode", globalPropertyi("sim/custom/xap/An24_power/DC_volt_mode"))  -- mode switcher for DC voltmeter, 11 positions 0-10
defineProperty("PT1000_mode", globalPropertyi("sim/custom/xap/An24_power/PT1000_mode"))   -- switcher for PT1000. 0 = emerg, 1 = off, 2 = on
defineProperty("PO750_mode", globalPropertyi("sim/custom/xap/An24_power/PO750_mode"))  -- switcher for PO750. 0 = ground, 1 = off, 2 = on
defineProperty("GS24_mode", globalPropertyi("sim/custom/xap/An24_power/GS24_mode"))  -- start from: 0 = ground power, 1 = off, 2 = GS24
defineProperty("power_mode", globalPropertyi("sim/custom/xap/An24_power/power_mode"))  -- power mode: 0 = Ground, 1 = off, 2 = airplane
defineProperty("emerg_mode", globalPropertyi("sim/custom/xap/An24_power/emerg_mode"))  -- switcher for emergency power. 0 = auto, 1 = on main bus, 2 = emergency bus only
defineProperty("STG_disconnect_cap1", globalPropertyi("sim/custom/xap/An24_power/STG_disconnect_cap1"))  -- red cap for STG disconnectiong button
defineProperty("STG_disconnect_cap2", globalPropertyi("sim/custom/xap/An24_power/STG_disconnect_cap2"))  -- red cap for STG disconnectiong button
defineProperty("emerg_cap", globalPropertyf("sim/custom/xap/An24_power/emerg_cap"))  -- red cap for emergency mode switcher

-- logic
defineProperty("ground_available", globalPropertyi("sim/custom/xap/An24_power/ground_available")) -- ground power available


-- define images
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("needles_2", loadImage("needles.dds", 18, 0, 13, 98)) 
defineProperty("needles_3", loadImage("needles.dds", 34, 0, 13, 98)) 

defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 
defineProperty("red_small_led", loadImage("leds.dds", 110, 0, 10, 10)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

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

local cup_open_sound = loadSample('Custom Sounds/cup_open.wav')
local cup_close_sound = loadSample('Custom Sounds/cup_close.wav')

local switcher_pushed = false

-- interpolating functions
-- interpolate values to degrees of needle

local GO_amps_table = { 
{  -100, -50 },
{  0, -45 },
{  60, -30 }, 
{  90, -10 },
{  120, 12 },
{  150, 44 },
{  1000, 50 }} 

local AC36_volt_table = { 
{  -100, -50 },    
{  0, -45 },    
{  20, -15 },    
{  40, 45 },
{  100, 50 }}   

local AC115_freq_table = { 
{  0, -50 },    
{  350, -45 },    
{  380, -20 },    
{  420, 20 },
{  450, 45 }}   



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

-- local variables
local GO_left_amp = 0
local GO_right_amp = 0
local STG_left_amp = 0
local STG_right_amp = 0
local GS_amp = 0
local BAT_amp = 0
local AC36_volt = 0
local AC115_volt = 0
local AC115_freq = 0
local DC_volt = 0

-- variables for lights
local STG_left_fail_led = false  -- red leds on forvard panel
local STG_right_fail_led = false
local emerg_bus_led = false
local GO_left_fail_led = false
local GO_right_fail_led = false
local GS24_on_bus_led = false  -- leds on overhead panel
local ground_led = false 
local emerg36_led = false
local emerg36_ON_led = false


-- pverall calculations per frame
function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(stg1_on_bus, 0)
		set(stg2_on_bus, 0)
		set(gs24_on_bus, 0)
		set(go1_on_bus, 0)
		set(go2_on_bus, 0)
		set(PT1000_mode, 1)
		set(inv_PT1000_1, 0)
		set(inv_PT1000_2, 0)
		set(PO750_mode, 1)
		set(inv_PT750, 0)
		set(power_mode, 1)
		set(GS24_mode, 1)
		set(emerg_mode, 0)
		set(bus_AC_36_volt,0)
		set(bus_AC_115_volt,0)
		not_loaded = false
	end	
				
	GO_left_amp = interpolate(GO_amps_table, get(go1_amp))  -- calculate angle for GO left ampermeter needle
	GO_right_amp = interpolate(GO_amps_table, get(go2_amp))  -- calculate angle for GO right ampermeter needle
	STG_left_amp = get(stg1_amp) * 220 / 1000 - 100  -- calculate angle for STG left ampermeter needle
	--print(STG_left_amp, get(get(stg1_amp)))
	
	STG_right_amp = get(stg2_amp) * 220 / 1000 - 100  -- calculate angle for STG right ampermeter needle
	if get(GS24_mode) == 0 then if get(ground_available) == 1 then GS_amp = get(bus_DC_27_amp) * 220 / 1000 - 100 end else GS_amp = get(gs24_amp) * 220 / 1000 - 100 end  -- calculate angle for GS24 ampermeter needle
	if get(DC_source) == 4 then BAT_amp = get(bat_all_amp) else BAT_amp = -get(bat_amp_cc) end  -- calculate angle for batteries ampermeter needle
	BAT_amp = BAT_amp * 220 / 1000 - 100	
	local AC36_mode = get(AC36_volt_mode)  -- calculate angle for AC36 voltmeter
	local AC36_volts = 0
	if AC36_mode == 0 then AC36_volts = get(bus_AC_36_volt) else AC36_volts = get(bus_AC_36_volt) end
	AC36_volt = interpolate(AC36_volt_table, AC36_volts)

	local AC115_mode = get(AC115_volt_mode)  -- calculate angle for AC115 voltmeter
	local AC115_volts = 0
	if AC115_mode == 0 then AC115_volts = get(bus_AC_115_volt) -- select source for voltmeter. add here variable to define emergency bus
	elseif AC115_mode == 1 then if get(ground_available) == 1 then AC115_volts =  115 end -- ground power
	elseif AC115_mode == 2 then AC115_volts = get(go1_volt)
	elseif AC115_mode == 3 then AC115_volts = get(go2_volt)
	elseif AC115_mode == 4 then AC115_volts = get(bus_AC_115_volt) * 1  -- add autopilot variable
	elseif AC115_mode == 5 then AC115_volts = get(bus_AC_115_volt) * 1  -- emergency bus here
	elseif AC115_mode == 6 then AC115_volts = get(bus_AC_115_volt) * 1  -- prop heat here
	end
	AC115_volt = interpolate(GO_amps_table, AC115_volts)  -- AC115 voltmeter scale similar to GO ampermeter
	local AC115_exist
	if get(AC115_volts) > 0 then AC115_exist = 400 else AC115_exist = 0 end	
	AC115_freq = interpolate(AC115_freq_table, AC115_exist)

	local DC_volts = 0  -- calculate angle for DC voltmeter
	local DC_mode = get(DC_volt_mode)
	--DC_mode = 0 -- test modes
	if DC_mode == 0 then if get(ground_available) == 1 then DC_volts = 27 end
	elseif DC_mode == 1 then if get(ground_available) == 1 then DC_volts = 27 end
	elseif DC_mode == 2 then DC_volts = get(bat1_volt)
	elseif DC_mode == 3 then DC_volts = get(bat2_volt)
	elseif DC_mode == 4 then DC_volts = get(bat3_volt)
	elseif DC_mode == 5 then DC_volts = get(gs24_volt)
	elseif DC_mode == 6 then DC_volts = get(stg1_volt)
	elseif DC_mode == 7 then DC_volts = get(stg2_volt)
	elseif DC_mode == 8 then DC_volts = get(bus_DC_27_volt)
	elseif DC_mode == 9 then DC_volts = get(bus_DC_27_volt)
	elseif DC_mode == 10 then DC_volts = get(bus_DC_27_volt_emerg)
	end
	DC_volt = DC_volts * 240 / 30 - 120
	
	-- leds logic
	if get(bus_DC_27_volt_emerg) > 21 then  -- all lamps will not work if even emergency bus down
		STG_left_fail_led = get(stg1_volt) < 20
		STG_right_fail_led = get(stg2_volt) < 20
		GO_left_fail_led = get(go1_volt) < 100 and get(go1_on_bus) > 0
		GO_right_fail_led = get(go2_volt) < 100 and get(go2_on_bus) > 0
		emerg_bus_led = get(DC_source) == 4
		GS24_on_bus_led = get(gs24_on_bus) > 0 and get(gs24_volt) > 21
		ground_led = get(ground_available) == 1 and get(power_mode) == 0
		emerg36_led = emerg_bus_led
		emerg36_ON_led = get(inv_PT1000_2) > 0
	else
		STG_left_fail_led = false  -- red leds on forvard panel
		STG_right_fail_led = false
		emerg_bus_led = false
		GO_left_fail_led = false
		GO_right_fail_led = false
		GS24_on_bus_led = false  -- leds on overhead panel
		ground_led = false 
		emerg36_led = false
		emerg36_ON_led = false
	end
	
	--print(get(GS24_mode))

end

-- components of electric panel
components = {
	-----------------------
	-- panel lights --
	-----------------------
--[[
	-- emergency feed on 36v bus
	textureLit {
		image = get(yellow_led),
		position = {698, 270, 17, 17},
		visible = function()
			return emerg36_ON_led
		end,
	},
	textureLit {
		image = get(yellow_led),
		position = {714, 270, 17, 17},
		visible = function()
			return emerg36_ON_led
		end,
	},
--]]	
	-- turn on emerg feed
	textureLit {
		image = get(yellow_led),
		position = {731, 270, 17, 17},
		visible = function()
			return emerg36_led
		end,
	},
	
	-- GS24 on bus
	textureLit {
		image = get(green_led),
		position = {747, 270, 17, 17},
		visible = function()
			return GS24_on_bus_led
		end,
	},	
	
	-- ground available
	textureLit {
		image = get(green_led),
		position = {763, 270, 17, 17},
		visible = function()
			return ground_led
		end,
	},
	textureLit {
		image = get(green_led),
		position = {780, 270, 17, 17},
		visible = function()
			return ground_led
		end,
	},

	-- STG left fail
	textureLit {
		image = get(red_small_led),
		position = {700, 388, 20, 20},
		visible = function()
			return STG_left_fail_led
		end,
	},
	-- STG right fail
	textureLit {
		image = get(red_small_led),
		position = {720, 388, 20, 20},
		visible = function()
			return STG_right_fail_led
		end,
	},
	-- emergency bus
	textureLit {
		image = get(red_small_led),
		position = {740, 388, 20, 20},
		visible = function()
			return emerg_bus_led
		end,
	},

	-- GO left fail
	textureLit {
		image = get(red_small_led),
		position = {760, 388, 20, 20},
		visible = function()
			return GO_left_fail_led
		end,
	},
	-- GO right fail
	textureLit {
		image = get(red_small_led),
		position = {780, 388, 20, 20},
		visible = function()
			return GO_right_fail_led
		end,
	},
	
	
	-----------------------
	-- switchers --	
	-----------------------

	-- PT1000 switcher
	-- switch up
    clickable {
        position = {1040, 325, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(PT1000_mode)
			
			if not switcher_pushed and a < 2 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(PT1000_mode, a)
			if a == 1 then 
				set(inv_PT1000_1, 0)
				set(inv_PT1000_2, 0)
			elseif a == 2 then
				set(inv_PT1000_1, 1)
				set(inv_PT1000_2, 0)
			else
				set(inv_PT1000_1, 0)
				set(inv_PT1000_2, 1)
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 


    -- switch down
        clickable {
        position = {1040, 318, 15, 7 },  -- search and set right
        
       cursor = { 
             x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(PT1000_mode)
			if not switcher_pushed and a > 0 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(PT1000_mode, a)
			if a == 1 then 
				set(inv_PT1000_1, 0)
				set(inv_PT1000_2, 0)
			elseif a == 2 then
				set(inv_PT1000_1, 1)
				set(inv_PT1000_2, 0)
			else
				set(inv_PT1000_1, 0)
				set(inv_PT1000_2, 1)
			end
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 


	-- PO750 switcher
	-- switcher up
	clickable {
        position = {1059, 325, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(PO750_mode)
			if not switcher_pushed and a < 2 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(PO750_mode, a)
			if a == 1 then 
				set(inv_PT750, 0)
				set(AC_source, 3)
			elseif a == 2 then
				set(inv_PT750, 1)
				set(AC_source, 3)
			else
				set(inv_PT750, 0)
				set(AC_source, 0)
			end
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

    -- switcher down
	clickable {
        position = {1059, 318, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(PO750_mode)
			if not switcher_pushed and a > 0 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(PO750_mode, a)
			if a == 1 then 
				set(inv_PT750, 0)
				set(AC_source, 3)
			elseif a == 2 then
				set(inv_PT750, 1)
				set(AC_source, 3)
			else
				set(inv_PT750, 0)
				set(AC_source, 0)
			end
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
  
    -- main emergency switcher
	-- switcher cap
	-- cap open
	clickable {
        position = {566, 366, 33, 41},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then playSample(cup_open_sound , 0) 
			switcher_pushed = true
			if get(emerg_cap) < 1 then set(emerg_cap, 1) 
			elseif get(emerg_cap) == 1 then
				if get(emerg_mode) == 2 then
					set(emerg_cap, 0.1)
				else
					set(emerg_cap, 0)
				end
			end
			end
			return true
		end,
		onMouseUp = function()
		    playSample(cup_close_sound , 0)
			switcher_pushed = false
			return true
		end,
    }, 	

	
    -- switcher up
	clickable {
        position = {1154, 325, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(emerg_mode)
			if not switcher_pushed and a < 1 and get(emerg_cap) < 0.2 then 
				a = a + 1
				switcher_pushed = true
				playSample(switch_sound, 0) 
			elseif not switcher_pushed and a < 2 and get(emerg_cap) > 0.2 then 
				a = a + 1
				switcher_pushed = true
				playSample(switch_sound, 0)
			end
			--if a > 1 and get(emerg_cap) < 0.2 then a = 1
			--elseif a > 1 then a = 2 end
			set(emerg_mode, a)
			if a == 1 then 
				set(main_on_emerg, 1)
			else
				set(main_on_emerg, 0)
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },   

    -- switcher down
	clickable {
        position = {1154, 318, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(emerg_mode)
			if not switcher_pushed and a < 2 and a > 0 and get(emerg_cap) < 0.2 then 
				a = a - 1
				switcher_pushed = true
				playSample(switch_sound, 0) 
			elseif not switcher_pushed and a > 0 and get(emerg_cap) > 0.2 then 
				a = a - 1
				switcher_pushed = true
				playSample(switch_sound, 0)
			end
			
			--if a == 2 and get(emerg_cap) < 0.2 then a = a
			--else a = a - 1 end
			--if a < 0 then a = 0 end
			set(emerg_mode, a)
			if a == 1 then 
				set(main_on_emerg, 1)
			else
				set(main_on_emerg, 0)
			end
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
    
    -- GO left switcher
    switch {
        position = { 1078, 318, 15, 14},
        state = function()
            return get(go1_on_bus) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(go1_on_bus) ~= 0 then
                set(go1_on_bus, 0)
            else
                set(go1_on_bus, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

    -- GO right switcher
    switch {
        position = {1097, 318, 15, 14 },
        state = function()
            return get(go2_on_bus) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(go2_on_bus) ~= 0 then
                set(go2_on_bus, 0)
            else
                set(go2_on_bus, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
   
    -- STG left switcher
    switch {
        position = {1003, 299, 15, 14 },
        state = function()
            return get(stg1_on_bus) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(stg1_on_bus) ~= 0 then
                set(stg1_on_bus, 0)
            else
                set(stg1_on_bus, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- STG right switcher
    switch {
        position = { 1021, 299, 15, 14 },
        state = function()
            return get(stg2_on_bus) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(stg2_on_bus) ~= 0 then
                set(stg2_on_bus, 0)
            else
                set(stg2_on_bus, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- GS24 switcher
    switch {
        position = { 1040, 299, 15, 14 },
        state = function()
            return get(gs24_on_bus) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(gs24_on_bus) ~= 0 then
                set(gs24_on_bus, 0)
            else
                set(gs24_on_bus, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- STG on engine cap left
    switch {
        position = {825, 507, 20, 35 },
        state = function()
            return get(STG_disconnect_cap1) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cup_open_sound , 0)
			switcher_pushed = true
			if get(STG_disconnect_cap1) ~= 0 then
                set(STG_disconnect_cap1, 0)
            else
                set(STG_disconnect_cap1, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
		    playSample(cup_close_sound , 0)
			switcher_pushed = false
			return true
		end,
    },	
	
    -- STG on engine left switcher
    switch {
        position = { 757, 498, 20, 20 },
        state = function()
            return get(stg1_on) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(STG_disconnect_cap1) > 0 then
			playSample(btn_click, 0)
			switcher_pushed = true
			if get(stg1_on) ~= 0 then
                set(stg1_on, 0)
            else
                set(stg1_on, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- STG on engine cap right
	switch {
        position = {849, 507, 20, 35 },
        state = function()
            return get(STG_disconnect_cap2) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cup_open_sound , 0)
			switcher_pushed = true
			if get(STG_disconnect_cap2) ~= 0 then
                set(STG_disconnect_cap2, 0)
            else
                set(STG_disconnect_cap2, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
		    playSample(cup_close_sound , 0)
			switcher_pushed = false
			return true
		end,
    },
	
    -- STG on engine right switcher
    switch {
        position = { 778, 498, 20, 20 },
        state = function()
            return get(stg2_on) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
		if not switcher_pushed and get(STG_disconnect_cap2) > 0 then
			playSample(btn_click, 0)
			switcher_pushed = true
			if get(stg2_on) ~= 0 then
                set(stg2_on, 0)
            else
                set(stg2_on, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- AC36_volt_mode voltmeter switcher
	-- switcher up
	clickable {
        position = {879, 240, 13, 26 },  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(AC36_volt_mode)
			if not switcher_pushed and a < 8 then 
				playSample(plastic_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(AC36_volt_mode, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- switcher down
	clickable {
        position = {866, 240, 13, 26 },  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(AC36_volt_mode)
			if not switcher_pushed and a > 0 then 
				playSample(plastic_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(AC36_volt_mode, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    
	-- AC115_volt_mode voltmeter switcher
	-- switcher up
	clickable {
        position = {972, 240, 13, 26 },  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(AC115_volt_mode)
			if not switcher_pushed then 
				playSample(plastic_sound, 0) 
				a = a + 1
				switcher_pushed = true
			end
			if a > 6 then a = 0 end
			set(AC115_volt_mode, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- switcher down
	clickable {
        position = {960, 240, 13, 26},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(AC115_volt_mode)
			if not switcher_pushed then 
				playSample(plastic_sound, 0) 
				a = a - 1
				switcher_pushed = true
			end
			if a < 0 then a = 6 end
			set(AC115_volt_mode, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- DC_volt_mode voltmeter switcher
	-- switcher up
	clickable {
        position = {1003, 240, 13, 26 },  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(DC_volt_mode)
			if not switcher_pushed and a < 10 then 
				playSample(plastic_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(DC_volt_mode, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- switcher down
	clickable {
        position = {990, 240, 13, 26},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(DC_volt_mode)
			if not switcher_pushed and a > 0 then 
				playSample(plastic_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(DC_volt_mode, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

 
	-- power mode
	-- switcher up
	clickable {
        position = {1061, 306, 30, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(GS24_mode)
			if not switcher_pushed and a < 2 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(GS24_mode, a)
			set(power_mode, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- switcher down
	clickable {
        position = {1061, 299, 30, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(GS24_mode)
			if not switcher_pushed and a > 0 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(GS24_mode, a)
			set(power_mode, a)
		return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end
    },


	-----------------------
	-- needle indicators --
	-----------------------

	-- GO left ampermeter
	needle { 
		image = get(needles_3),
		position = {1301, 920, 98, 98},
		angle = function()
			return GO_left_amp
		end,	
	},

	-- GO right ampermeter
	needle { 
		image = get(needles_3),
		position = {1202, 823, 98, 98},
		angle = function()
			return GO_right_amp
		end,	
	},
	
	-- STG left ampermeter
	needle { 
		image = get(needles_1),
		position = {1305, 853, 88, 88},
		angle = function()
			return STG_left_amp
		end,	
	},
	
	-- black cap
	texture{
	    position = {1332, 876, 42, 42 },
        image = get(black_cap),
	},
	
	-- STG right ampermeter
	needle { 
		image = get(needles_1),
		position = {1405, 952, 88, 88},
		angle = function()
			return STG_right_amp
		end,	
	},
	
	-- black cap
	texture{
	    position = {1432, 975, 42, 42 },
        image = get(black_cap),
	},
	
	-- GS24 ampermeter
	needle { 
		image = get(needles_1),
		position = {1505, 952, 88, 88},
		angle = function()
			return GS_amp
		end,	
	},
	
	-- black cap
	texture{
	    position = {1532, 975, 42, 42 },
        image = get(black_cap),
	},
	
	-- BAT ampermeter
	needle { 
		image = get(needles_1),
		position = {1405, 853, 88, 88},
		angle = function()
			return BAT_amp
		end,	
	},
	
	-- black cap
	texture{
	    position = {1432, 875, 42, 42 },
        image = get(black_cap),
	},
	
	-- AC36 voltmeter
	needle { 
		image = get(needles_3),
		position = {1002, 822, 98, 98},
		angle = function()
			return AC36_volt
		end,	
	},	
	-- AC115 voltmeter
	needle { 
		image = get(needles_3),
		position = {1202, 920, 98, 98},
		angle = function()
			return AC115_volt
		end,	
	},
	-- AC115 freq-meter
	needle { 
		image = get(needles_3),
		position = {1100, 822, 98, 98},
		angle = function()
			return AC115_freq
		end,	
	},
	-- DC27 voltmeter
	needle { 
		image = get(needles_1),
		position = {1507, 853, 88, 88},
		angle = function()
			return DC_volt
		end,	
	},

	-- black cap
	texture{
	    position = {1532, 875, 42, 42 },
        image = get(black_cap),
	},
	
}

