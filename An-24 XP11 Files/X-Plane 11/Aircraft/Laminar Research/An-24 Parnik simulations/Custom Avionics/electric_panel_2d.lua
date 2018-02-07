-- this is the electrical panel logic, shown on 3D cockpit panels...

size = {600, 1024} -- panel will contain a several gauges in different plases of panel texture

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
defineProperty("electropanel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/electropanel_subpanel"))

-- define images
defineProperty("background", loadImage("electro_panel_2d.dds", 0, 0, 512, 870)) 
defineProperty("rot_switch", loadImage("rot_switch.dds"))

defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("needles_2", loadImage("needles.dds", 18, 0, 13, 98)) 
defineProperty("needles_3", loadImage("needles.dds", 34, 0, 13, 98)) 

defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 
defineProperty("red_small_led", loadImage("leds.dds", 110, 0, 10, 10)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))

defineProperty("btn_press", loadImage("electro_panel_2d.dds", 130, 895, 25, 25))
defineProperty("btn_up", loadImage("electro_panel_2d.dds", 171, 895, 25, 25))
defineProperty("stg_cap_close", loadImage("electro_panel_2d.dds", 4, 879, 50, 81))
defineProperty("stg_cap_open", loadImage("electro_panel_2d.dds", 55, 879, 50, 81))

defineProperty("main_cap_open", loadImage("electro_panel_2d.dds", 207, 873, 82, 104))
defineProperty("main_tmb_up", loadImage("electro_panel_2d.dds", 115, 967, 24, 43))
defineProperty("main_tmb_ctr", loadImage("electro_panel_2d.dds", 145, 967, 24, 43))
defineProperty("main_tmb_dn", loadImage("electro_panel_2d.dds", 180, 966, 24, 43))

defineProperty("main_tmb_up_close", loadImage("electro_panel_2d.dds", 412, 877, 50, 103))
defineProperty("main_tmb_ctr_close", loadImage("electro_panel_2d.dds", 359, 877, 50, 103))
defineProperty("main_tmb_dn_close", loadImage("electro_panel_2d.dds", 307, 877, 50, 103))

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

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

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

-- overall calculations per frame
function update()

	GO_left_amp = interpolate(GO_amps_table, get(go1_amp))  -- calculate angle for GO left ampermeter needle
	GO_right_amp = interpolate(GO_amps_table, get(go2_amp))  -- calculate angle for GO right ampermeter needle
	STG_left_amp = get(stg1_amp) * 220 / 1000 - 100  -- calculate angle for STG left ampermeter needle
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
	elseif AC115_mode == 1 then if get(ground_available)  == 1 then AC115_volts = 115 end -- ground power
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
	-- background
	texture {
		position = {0, 0, size[1], size[2]},
		image = get(background),
	},
	
	-----------------------
	-- panel lights --
	-----------------------
--[[
	-- emergency feed on 36v bus
	textureLit {
		image = get(yellow_led),
		position = {181, 986, 24, 24},
		visible = function()
			return emerg36_ON_led
		end,
	},

	textureLit {
		image = get(yellow_led),
		position = {253, 986, 24, 24},
		visible = function()
			return emerg36_ON_led
		end,
	},	
--]]	
	-- turn on emerg feed
	textureLit {
		image = get(yellow_led),
		position = {515, 886, 24, 24},
		visible = function()
			return emerg36_led
		end,
	},
	
	-- GS24 on bus
	textureLit {
		image = get(green_led),
		position = {105, 518, 30, 30},
		visible = function()
			return GS24_on_bus_led
		end,
	},	
	
	-- ground available
	textureLit {
		image = get(green_led),
		position = {215, 518, 30, 30},
		visible = function()
			return ground_led
		end,
	},
	textureLit {
		image = get(green_led),
		position = {320, 518, 30, 30},
		visible = function()
			return ground_led
		end,
	},

	-----------------------
	-- switchers --	
	-----------------------

	-- PT1000 switcher
	texture {
		position = {515, 907, 25, 100},
		image = function()
			local a = get(PT1000_mode)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end,
	
	},

	-- switch up
    clickable {
        position = {500, 960, 50, 50},  -- search and set right
        
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
        position = {500, 910, 50, 50},  -- search and set right
        
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
	texture {
		position = {283, 735, 25, 100},
		image = function()
			local a = get(PO750_mode)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end,
	
	},

	-- switcher up
	clickable {
        position = {270, 790, 50, 50},  -- search and set right
        
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
        position = {270, 740, 50, 50},  -- search and set right
        
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
        position = {525, 130, 50, 60},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then playSample(cap_sound, 0) 
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
			switcher_pushed = false
			return true
		end,
    }, 	

	
    -- switcher up
	clickable {
        position = {475, 170, 50, 50},  -- search and set right
        
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
        position = {475, 120, 50, 50},  -- search and set right
        
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
        position = {371, 612, 25, 100},
        state = function()
            return get(go1_on_bus) ~= 0
        end,
		btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(go1_on_bus) ~= 0 then
                set(go1_on_bus, 0)
            else
                set(go1_on_bus, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

    -- GO right switcher
    switch {
        position = {423, 612, 25, 100},
        state = function()
            return get(go2_on_bus) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {39, 64, 25, 100},
        state = function()
            return get(stg1_on_bus) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = { 85, 64, 25, 100},
        state = function()
            return get(stg2_on_bus) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {132, 64, 25, 100},
        state = function()
            return get(gs24_on_bus) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {335, 160, 50, 30 },
        state = function()
            return get(STG_disconnect_cap1) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
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
			switcher_pushed = false
			return true
		end,
    },	

	-- button image
	texture {
		position = {400, 95, 29, 29},
		image = function()
			local a
			if get(stg2_on) == 1 then a = get(btn_up) else a = get(btn_press) end
			return a
		end
	},
	-- cap image
	texture {
		position = {388, 70, 60, 97},
		image = function()
			local a
			if get(STG_disconnect_cap2) == 1 then a = get(stg_cap_open) else a = get(stg_cap_close) end
			return a
		end
	},	
	-- button image
	texture {
		position = {350, 95, 29, 29},
		image = function()
			local a
			if get(stg1_on) == 1 then a = get(btn_up) else a = get(btn_press) end
			return a
		end
	},
	
	-- cap image
	texture {
		position = {338, 70, 60, 97},
		image = function()
			local a
			if get(STG_disconnect_cap1) == 1 then a = get(stg_cap_open) else a = get(stg_cap_close) end
			return a
		end
	},
	
    -- STG on engine left switcher
    switch {
        position = {335, 90, 50, 50 },
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
        position = {385, 160, 50, 30 },
        state = function()
            return get(STG_disconnect_cap2) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
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
			switcher_pushed = false
			return true
		end,
    },

	
    -- STG on engine right switcher
    switch {
        position = { 385, 90, 50, 50 },
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
	needle {
		position = {187, 867, 80, 80},
		image = get(rot_switch),
		angle = function()
			return -135  + get(AC36_volt_mode) * 270 / 8
		end
	},

	-- switcher up
	clickable {
        position = {230, 870, 40, 80 },  -- search and set right
        
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
        position = {185, 870, 40, 80 },  -- search and set right
        
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
 
	needle {
		position = {45, 620, 80, 80},
		image = get(rot_switch),
		angle = 0,
	},
 
 	needle {
		position = {142, 620, 80, 80},
		image = get(rot_switch),
		angle = 0,
	},
 
	-- AC115_volt_mode voltmeter switcher
	needle {
		position = {242, 620, 80, 80},
		image = get(rot_switch),
		angle = function()
			return -60 + get(AC115_volt_mode) * 320 / 7
		end
	},
	-- switcher up
	clickable {
        position = {290, 620, 40, 80},  -- search and set right
        
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
        position = {240, 620, 40, 80},  -- search and set right
        
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
	needle {
		position = {463, 281, 80, 80},
		image = get(rot_switch),
		angle = function()
			return -150 + get(DC_volt_mode) * 300 / 10
		end
	},
	-- switcher up
	clickable {
        position = {510, 280, 40, 80 },  -- search and set right
        
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
        position = {460, 280, 40, 80 },  -- search and set right
        
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
	texture {
		position = {193, 65, 25, 100},
		image = function()
			local a = get(GS24_mode)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end,
	},
	
	texture {
		position = {265, 65, 25, 100},
		image = function()
			local a = get(GS24_mode)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end,
	
	},
	-- switcher up
	clickable {
        position = {195, 120, 100, 50},  -- search and set right
        
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
        position = {195, 70, 100, 50},  -- search and set right
        
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
		position = {338, 719, 90, 90},
		angle = function()
			return GO_left_amp
		end,	
	},

	-- GO right ampermeter
	needle { 
		image = get(needles_3),
		position = {450, 719, 90, 90},
		angle = function()
			return GO_right_amp
		end,	
	},
	
	-- STG left ampermeter
	needle { 
		image = get(needles_1),
		position = {60, 412, 65, 65},
		angle = function()
			return STG_left_amp
		end,	
	},
	
	
	-- STG right ampermeter
	needle { 
		image = get(needles_1),
		position = {162, 412, 65, 65},
		angle = function()
			return STG_right_amp
		end,	
	},
	
	
	-- GS24 ampermeter
	needle { 
		image = get(needles_1),
		position = {265, 412, 65, 65},
		angle = function()
			return GS_amp
		end,	
	},
	
	-- BAT ampermeter
	needle { 
		image = get(needles_1),
		position = {367, 412, 65, 65},
		angle = function()
			return BAT_amp
		end,	
	},
	
	
	-- AC36 voltmeter
	needle { 
		image = get(needles_3),
		position = {310, 854, 90, 90},
		angle = function()
			return AC36_volt
		end,	
	},	
	-- AC115 voltmeter
	needle { 
		image = get(needles_3),
		position = {161, 719, 90, 90},
		angle = function()
			return AC115_volt
		end,	
	},
	-- AC115 freq-meter
	needle { 
		image = get(needles_3),
		position = {49, 719, 90, 90},
		angle = function()
			return AC115_freq
		end,	
	},
	-- DC27 voltmeter
	needle { 
		image = get(needles_1),
		position = {469, 412, 65, 65},
		angle = function()
			return DC_volt
		end,	
	},

	-- black cap
	texture{
	    position = {79, 428, 30, 30 },
        image = get(black_cap),
	},

	-- black cap
	texture{
	    position = {180, 428, 30, 30 },
        image = get(black_cap),
	},
	
	-- black cap
	texture{
	    position = {283, 428, 30, 30 },
        image = get(black_cap),
	},

	-- black cap
	texture{
	    position = {385, 428, 30, 30 },
        image = get(black_cap),
	},

	-- black cap
	texture{
	    position = {487, 428, 30, 30 },
        image = get(black_cap),
	},
	
	-- main cap open img
	texture{
		position = {471, 0, 102, 130},
		image = get(main_cap_open),
		visible = function()
			return get(emerg_cap) == 1
		end
	},
	
	-- main tmb img
	texture{
		position = {492, 135, 29, 53},
		image = function()
			local a = get(emerg_mode)
			local pic
			if a == 0 then pic = get(main_tmb_dn)
			elseif a == 1 then pic = get(main_tmb_ctr)
			else pic = get(main_tmb_up) end
			return pic
		end,
		visible = function()
			return get(emerg_cap) == 1
		end,
	},

	-- main tmb with cap close
	texture{
		position = {478, 88, 58, 116},
		image = function()
			local a = get(emerg_mode)
			local pic
			if a == 0 then pic = get(main_tmb_dn_close)
			elseif a == 1 then pic = get(main_tmb_ctr_close)
			else pic = get(main_tmb_up_close) end
			return pic
		end,
		visible = function()
			return get(emerg_cap) ~= 1
		end,
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
        set(electropanel_subpanel, 0 )
        return true
        end
    },
	
}

