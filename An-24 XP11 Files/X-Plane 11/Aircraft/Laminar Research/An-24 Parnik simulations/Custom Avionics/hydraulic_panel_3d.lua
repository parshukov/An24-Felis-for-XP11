-- this is indication of hydraulic system 

size = {2048, 2048} -- panel will contain a several gauges in different plases of panel texture

-- define properties
defineProperty("main_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.
defineProperty("emerg_press", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press")) -- pressure in emergency system. initial 120 kg per square sm. maximum 160.
defineProperty("hydro_quantity", globalPropertyf("sim/custom/xap/An24_hydro/hydro_quantity")) -- quantity of hydraulic liquid. initially 28 liters. in work downs to 21 liters. also can flow out in come case of failure.
defineProperty("hydro_store", globalPropertyf("sim/custom/xap/An24_hydro/hydro_store")) -- pressure in main hydro storage
defineProperty("hydro_circle", globalPropertyi("sim/custom/xap/An24_hydro/hydro_circle"))  -- connect main and emergency feeds
defineProperty("brake1", globalPropertyf("sim/flightmodel/controls/l_brake_add")) -- gear brake ratio. 0 = min, 1 = max
defineProperty("brake2", globalPropertyf("sim/flightmodel/controls/r_brake_add")) -- gear brake ratio. 0 = min, 1 = max
defineProperty("block_brake", globalPropertyf("sim/flightmodel/controls/parkbrake"))  -- blocks brakes
defineProperty("flap_deg1", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]"))  -- left flap deg
defineProperty("flap_deg2", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]"))  -- right flap deg


defineProperty("gear_valve", globalPropertyi("sim/custom/xap/An24_hydro/gear_valve")) -- position of gear valve for gydraulic calculations and animations.
defineProperty("gear_rotary", globalPropertyi("sim/custom/xap/An24_hydro/gear_rotary")) -- position of gear valve for gydraulic calculations and animations.
defineProperty("gear_unblock", globalPropertyi("sim/custom/xap/An24_hydro/gear_unblock")) -- remove block from gear retraction on ground
defineProperty("gear_unblock_cap", globalPropertyi("sim/custom/xap/An24_hydro/gear_unblock_cap")) -- remove block from gear retraction on ground
defineProperty("flaps_valve", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve")) -- position of flaps valve for gydraulic calculations and animations.
defineProperty("flaps_rotary", globalPropertyi("sim/custom/xap/An24_hydro/flaps_rotary")) -- position of flaps valve for gydraulic calculations and animations.
defineProperty("flaps_valve_emerg", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve_emerg")) -- position of emergency flaps valve for gydraulic calculations and animations.
defineProperty("flaps_valve_emerg_cap", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve_emerg_cap")) -- position of emergency flaps valve for gydraulic calculations and animations.
defineProperty("emerg_pump_sw", globalPropertyi("sim/custom/xap/An24_hydro/emerg_pump_sw")) -- emergency hydro pump switcher. if its ON and power exist - emergency bus will gain pressure

defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt"))
-- for 2D
defineProperty("main_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/main_press_angle"))
defineProperty("emerg_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press_angle"))
defineProperty("store_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/store_press_angle"))
defineProperty("left_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/left_press_angle"))
defineProperty("right_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/right_press_angle"))
defineProperty("hydro_quantity_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/hydro_quantity_angle"))


-- define images
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("needles_2", loadImage("needles.dds", 18, 0, 13, 98)) 
defineProperty("needles_3", loadImage("needles.dds", 34, 0, 13, 98)) 
defineProperty("needles_4", loadImage("needles.dds", 0, 88, 15, 142)) 
defineProperty("needles_5", loadImage("needles.dds", 16, 111, 16, 98)) 

defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("grey_cap", loadImage("covers.dds", 406, 0, 56, 56)) 

defineProperty("black_cap1", loadImage("covers.dds", 264, 67, 77, 59)) 
defineProperty("black_cap2", loadImage("covers.dds", 138, 59, 57, 60)) 
defineProperty("black_cap3", loadImage("covers.dds", 202, 60, 57, 60)) 

-- commands
flaps_command_up = findCommand("sim/flight_controls/flaps_up")
flaps_command_down = findCommand("sim/flight_controls/flaps_down")
gear_command_up = findCommand("sim/flight_controls/landing_gear_up")
gear_command_down = findCommand("sim/flight_controls/landing_gear_down")


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

local emerg_press_angle = -60
local store_press_angle = -105
local main_press_angle = 195
local quantity_angle = -110
local brake_1_angle = 195
local brake_2_angle = -105
local power = 0
local power115 = 0
local flap_ind_angle = 0
local emerg_pump_led = false

local flap_up_clicked = false
local flap_down_clicked = false

-- every frame calculations.
function update()

	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(emerg_pump_sw, 0)
		not_loaded = false
	end

	-- calculate power
	if get(bus_DC_27_volt_emerg) > 21 then power = 1 else power = 0 end
	if get(bus_AC_115_volt) > 110 then power115 = 1 else power115 = 0 end
	
	-- calculate emergency pump led shine
	if get(emerg_pump_sw) * power * power115 > 0 then emerg_pump_led = true else emerg_pump_led = false end
	-- calculate emergency pressure indicator
	emerg_press_angle = get(emerg_press) * power115 * 120 / 240 - 60
	
	-- calculate main pressure indicator
	main_press_angle = -get(main_press) * power115 * 120 / 240 + 195

	-- calculate hydro storage pressure
	store_press_angle = get(hydro_store) * power115 * 120 / 240 - 105

	-- calculate hydraulic quantity
	if power == 1 then quantity_angle = get(hydro_quantity) * 180 / 30 - 90
	else quantity_angle = -110 end
	
	-- calculate left brake pressure indicator
	brake_1_angle = -math.max(get(brake1), get(block_brake)) * power115 * 120 / 1.5 + 195
	
	-- calculate right brake pressure indicator
	brake_2_angle = math.max(get(brake2), get(block_brake)) * power115 * 120 / 1.5 - 105
	
	-- calculate flaps indicator
	if power > 0 then
		flap_ind_angle = math.max(get(flap_deg1), get(flap_deg2)) * 180 / 45
	end
	
	-- set vars for 2D panel
	set(main_press_angle_2d, main_press_angle)
	set(emerg_press_angle_2d, emerg_press_angle)
	set(store_press_angle_2d, store_press_angle)
	set(left_press_angle_2d, brake_1_angle)
	set(right_press_angle_2d, brake_2_angle)
	set(hydro_quantity_angle_2d, quantity_angle)
	
end

-- components
components = {
	
	-----------------------
	-- needle indicators --
	-----------------------
	-- emergency pressure indicator
	needle { 
		image = get(needles_1),
		position = {1206, 1136, 88, 88},
		angle = function()
		return emerg_press_angle
		end,	
	},

	-- cap for emergency pressure indicator
	texture {
		image = get(black_cap1),
		position = {1210, 1138, 77, 59},
	},
	
	-- main pressure indicator
	needle { 
		image = get(needles_1),
		position = {979, 1180, 88, 88},
		angle = function()
		return main_press_angle
		end,	
	},
	
	-- cap for main pressure indicator
	texture {
		image = get(black_cap2),
		position = {1001, 1199, 40, 45},
	},
	
	-- storage pressure indicator
	needle { 
		image = get(needles_1),
		position = {1050, 1108, 88, 88},
		angle = function()
		return store_press_angle
		end,	
	},

	-- cap for storage pressure indicator
	texture {
		image = get(black_cap3),
		position = {1073, 1128, 40, 45},
	},
		
	
	-- hydraulic quantity indicator
	needle { 
		image = get(needles_4),
		position = {1428, 1050, 142, 142},
		angle = function()
		return quantity_angle
		end,	
	},

	-- cap for hydraulic quantity indicator
	texture {
		image = get(grey_cap),
		position = {1472, 1093, 56, 56},
	},
	
	-- left brake indicator
	needle { 
		image = get(needles_1),
		position = {1062, 1097, 88, 88},
		angle = function()
		return brake_1_angle
		end,	
	},

	-- cap for left brake indicator
	texture {
		image = get(black_cap2),
		position = {1087, 1117, 40, 45},
	},
	
	-- right brake indicator
	needle { 
		image = get(needles_1),
		position = {1133, 1024, 88, 88},
		angle = function()
		return brake_2_angle
		end,	
	},	
	
	-- cap for right brake indicator
	texture {
		image = get(black_cap3),
		position = {1155, 1045, 40, 45},
	},
	
	-- flap position indicator
	needle { 
		image = get(needles_5),
		position = {1250, 1055, 98, 98},
		angle = function()
		return flap_ind_angle
		end,	
	},
	------------------------
	-- leds --
	------------------------
	
	textureLit {
		image = get(yellow_led),
		position = {600, 387, 20, 20},
		visible = function()
			return emerg_pump_led
		end,
	},
	
	------------------------
	-- panel clickables --
	------------------------
	
	-- hydro circle valve
	switch {
    position = { 880, 449, 38, 49},
    state = function()
        return get(hydro_circle) ~= 0
    end,
    --btnOn = get(tmb_up),
    --btnOff = get(tmb_dn),
    onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(hydro_circle) ~= 0 then
                set(hydro_circle, 0)
            else
                set(hydro_circle, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- emergency hydraulic pump switcher
	switch {
		position = { 955, 325, 17, 17},
		state = function()
			return get(emerg_pump_sw) ~= 0
		end,
    --btnOn = get(tmb_up),
    --btnOff = get(tmb_dn),
		onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(emerg_pump_sw) ~= 0 then
                set(emerg_pump_sw, 0)
            else
                set(emerg_pump_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	

	-- emergency flap valve cap
    clickable {
        position = {102, 449, 33, 39},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then
				playSample(cap_sound, 0)
				switcher_pushed = true
				if get(flaps_valve_emerg_cap) == 0 then 
					set(flaps_valve_emerg_cap, 1)
				else
					set(flaps_valve_emerg_cap, 0)
					set(flaps_valve_emerg, 0)
				end
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- emergency flap valve pump switcher
	switch {
		position = { 1116, 371, 18, 18},
		state = function()
			return get(flaps_valve_emerg) ~= 0
		end,
    --btnOn = get(tmb_up),
    --btnOff = get(tmb_dn),
		onMouseClick = function()
            if not switcher_pushed and get(flaps_valve_emerg_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(flaps_valve_emerg) ~= 0 then
                set(flaps_valve_emerg, 0)
            else
                set(flaps_valve_emerg, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- turn OFF gear retract block cap
    clickable {
        position = {655, 457, 31, 45},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then
				playSample(cap_sound, 0)
				switcher_pushed = true
				if get(gear_unblock_cap) == 0 then 
					set(gear_unblock_cap, 1)
				else
					set(gear_unblock_cap, 0)
					set(gear_unblock, 0)
				end
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	
	
	-- turn OFF gear retract block
	switch {
		position = {1134, 371, 18, 18},
		state = function()
			return get(gear_unblock) ~= 0
		end,
    --btnOn = get(tmb_up),
    --btnOff = get(tmb_dn),
		onMouseClick = function()
            if not switcher_pushed and get(gear_unblock_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(gear_unblock) ~= 0 then
                set(gear_unblock, 0)
            else
                set(gear_unblock, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- turn flaps UP
    clickable {
        position = {1135, 410, 30, 15},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
		onMouseClick = function() 
			if not flap_up_clicked then
				playSample(switch_sound, 0)
				commandBegin(flaps_command_up)
				flap_up_clicked = true
			end
			return true
		end,
		onMouseUp = function()
			playSample(switch_sound, 0)
			commandEnd(flaps_command_up)
			flap_up_clicked = false
			return true
		end,
	
    },

	-- turn flaps DOWN
    clickable {
        position = {1135, 395, 30, 15},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not flap_down_clicked then
				playSample(switch_sound, 0)
				commandBegin(flaps_command_down)
				flap_down_clicked = true
			end
			return true
		end,
		onMouseUp = function()
			playSample(switch_sound, 0)
			commandEnd(flaps_command_down)
			flap_down_clicked = false
			return true
		end,
    },
	rectangle {
		position = { 1168, 410, 30, 15},
		color = {0, 1, 0, 1},
	},
	-- turn gears UP
    clickable {
        position = {1168, 410, 30, 15},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			commandOnce(gear_command_up)
			if not switcher_pushed then playSample(switch_sound, 0) end
			switcher_pushed = true
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end
    },

	rectangle {
		position = { 1168, 395, 30, 15},
		color = {1, 0, 0, 1},
	},
	-- turn gears DOWN
    clickable {
        position = {1168, 395, 30, 15},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
		onMouseClick = function() 
			commandOnce(gear_command_down)
			if not switcher_pushed then playSample(switch_sound, 0) end
			switcher_pushed = true
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end
    },

	
}
