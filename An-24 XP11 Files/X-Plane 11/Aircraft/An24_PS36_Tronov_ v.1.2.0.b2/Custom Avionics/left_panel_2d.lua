-- this is 3D panel for start engines
size = {983, 512}

-- define property table
-- custom datarefs

defineProperty("eng_start_btn", globalPropertyi("sim/custom/xap/An24_start/eng_start_btn")) -- start selected engine
defineProperty("start_at_ground_cap", globalPropertyi("sim/custom/xap/An24_start/start_at_ground_cap")) -- select start mode cap
defineProperty("start_at_ground", globalPropertyi("sim/custom/xap/An24_start/start_at_ground")) -- select start mode
defineProperty("sel_left_right", globalPropertyi("sim/custom/xap/An24_start/sel_left_right")) -- select engine to start. -1 - left, 0 - none, +1 - right
defineProperty("eng_start_mode", globalPropertyi("sim/custom/xap/An24_start/eng_start_mode")) -- select start mode. start or fail start
defineProperty("eng_start_stop", globalPropertyi("sim/custom/xap/An24_start/eng_start_stop")) -- button for stop start process
defineProperty("left_temp_check", globalPropertyi("sim/custom/xap/An24_start/left_temp_check")) -- select temp check mode
defineProperty("left_prt24_on", globalPropertyi("sim/custom/xap/An24_start/left_prt24_on")) -- PRT24 on
defineProperty("right_temp_check", globalPropertyi("sim/custom/xap/An24_start/right_temp_check")) -- select temp check mode
defineProperty("right_prt24_on", globalPropertyi("sim/custom/xap/An24_start/right_prt24_on")) -- PRT24 on

defineProperty("ru19_air_start_btn", globalPropertyi("sim/custom/xap/An24_start/ru19_air_start_btn")) -- start at flight button
defineProperty("ru19_ground_start_btn", globalPropertyi("sim/custom/xap/An24_start/ru19_ground_start_btn")) -- start on ground button
defineProperty("ru19_ground_start_cap", globalPropertyi("sim/custom/xap/An24_start/ru19_ground_start_cap")) -- start on ground button cap
defineProperty("ru19_start_mode", globalPropertyi("sim/custom/xap/An24_start/ru19_start_mode")) -- select start mode. start or fail start
defineProperty("ru19_start_stop", globalPropertyi("sim/custom/xap/An24_start/ru19_start_stop")) -- stop button for ru19
defineProperty("ru19_start_main_sw", globalPropertyi("sim/custom/xap/An24_start/ru19_start_main_sw")) --   -- main switcher for ru19
defineProperty("ru19_start_main_sw_cap", globalPropertyi("sim/custom/xap/An24_start/ru19_start_main_sw_cap")) -- main switcher for ru19
defineProperty("fire_valve3_sw", globalPropertyi("sim/custom/xap/An24_fuel/fire_valve3_sw")) -- fire valve switch for engine 3
defineProperty("ru19_pk_open_lit", globalPropertyi("sim/custom/xap/An24_fuel/ru19_pk_open_lit")) -- 
defineProperty("ru19_pk_close_lit", globalPropertyi("sim/custom/xap/An24_fuel/ru19_pk_close_lit")) -- 

defineProperty("starter_volt", globalPropertyf("sim/custom/xap/An24_start/starter_volt")) -- starter voltage for engines start
defineProperty("starter_amp", globalPropertyf("sim/custom/xap/An24_start/starter_amp")) -- starter amperage for engines start
defineProperty("apd_work_lit", globalPropertyi("sim/custom/xap/An24_start/apd_work_lit")) -- lamp for apd

-- hydro
defineProperty("main_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/main_press_angle"))
defineProperty("emerg_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press_angle"))
defineProperty("store_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/store_press_angle"))
defineProperty("left_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/left_press_angle"))
defineProperty("right_press_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/right_press_angle"))
defineProperty("hydro_quantity_angle_2d", globalPropertyf("sim/custom/xap/An24_hydro/hydro_quantity_angle"))
defineProperty("hydro_circle", globalPropertyi("sim/custom/xap/An24_hydro/hydro_circle"))  -- connect main and emergency feeds
-- ssos
defineProperty("ssos_test", globalPropertyi("sim/custom/xap/An24_gauges/ssos_test_sw")) 
defineProperty("ssos_sw", globalPropertyi("sim/custom/xap/An24_gauges/ssos_sw")) 
defineProperty("ssos_sw_cap", globalPropertyi("sim/custom/xap/An24_gauges/ssos_sw_cap")) 
defineProperty("ssos_power_lit", globalPropertyi("sim/custom/xap/An24_gauges/ssos_power_lit"))  -- ssos power lamp
-- ap
defineProperty("ap_mech_off", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off"))  -- ap mechanic off. o = mechanics works, 1 = mech off
defineProperty("ap_mech_off_cap", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off_cap"))  -- ap mechanic off cap
-- wiper
defineProperty("wiper_sw", globalPropertyi("sim/cockpit2/switches/wiper_speed"))  -- 0=off,1=25%speed,2=50%speed,3=100%speed.

defineProperty("left_subpanel", globalPropertyi("sim/custom/xap/An24_panels/left_subpanel"))
-- images
defineProperty("background", loadImage("left_panel_2d.dds", 0, 0, 983, 512))
defineProperty("white_led", loadImage("leds.dds", 0, 0, 20, 20))
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("needles_2", loadImage("needles.dds", 18, 0, 13, 98)) 
defineProperty("needles_3", loadImage("needles.dds", 34, 0, 13, 98)) 
defineProperty("needles_4", loadImage("needles.dds", 0, 88, 15, 142)) 
defineProperty("needles_5", loadImage("needles.dds", 16, 111, 16, 98)) 

defineProperty("needles_thin", loadImage("needles.dds", 336, 103, 1, 110)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

defineProperty("small_btn_dn", loadImage("fuel_panel_2d.dds", 181, 817, 34, 36))
defineProperty("small_btn_up", loadImage("fuel_panel_2d.dds", 224, 817, 34, 36))

defineProperty("yellow_cap_close", loadImage("fuel_panel_2d.dds", 369, 726, 44, 163))
defineProperty("yellow_cap_open", loadImage("fuel_panel_2d.dds", 416, 726, 44, 163))

defineProperty("red_cap_close", loadImage("fuel_panel_2d.dds", 272, 726, 44, 163))
defineProperty("red_cap_open", loadImage("fuel_panel_2d.dds", 319, 726, 44, 163))

defineProperty("red_sidecap_close", loadImage("fuel_panel_2d.dds", 43, 890, 162, 42))
defineProperty("red_sidecap_open", loadImage("fuel_panel_2d.dds", 43, 936, 162, 42))

defineProperty("ru_cap_close", loadImage("fuel_panel_2d.dds", 47, 729, 117, 71))
defineProperty("ru_cap_open", loadImage("fuel_panel_2d.dds", 47, 805, 117, 71))

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))
defineProperty("tmb_left", loadImage("tumbler_left.dds"))
defineProperty("tmb_right", loadImage("tumbler_right.dds"))

defineProperty("red_vent_img", loadImage("fuel_panel_2d.dds", 180, 726, 80, 80))

defineProperty("grey_cap", loadImage("covers.dds", 406, 0, 56, 56)) 

defineProperty("black_cap1", loadImage("covers.dds", 264, 67, 77, 59)) 
defineProperty("black_cap2", loadImage("covers.dds", 138, 59, 57, 60)) 
defineProperty("black_cap3", loadImage("covers.dds", 202, 60, 57, 60)) 

local amp_angle = -110
local volt_angle = -45

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

local ssos_tmb_pos = 0

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local cup_open_sound = loadSample('Custom Sounds/cup_open.wav')
local cup_close_sound = loadSample('Custom Sounds/cup_close.wav')

local switcher_pushed = false

function update()
	
	amp_angle = get(starter_amp) * 217 / 1000 - 100
	volt_angle = get(starter_volt) * 90 / 75 - 45

	-- calculate emergency pressure indicator
	emerg_press_angle = get(emerg_press_angle_2d)
	
	-- calculate main pressure indicator
	main_press_angle = get(main_press_angle_2d)

	-- calculate hydro storage pressure
	store_press_angle = get(store_press_angle_2d)

	-- calculate hydraulic quantity
	quantity_angle = get(hydro_quantity_angle_2d) 

	
	-- calculate left brake pressure indicator
	brake_1_angle = get(left_press_angle_2d)
	
	-- calculate right brake pressure indicator
	brake_2_angle = get(right_press_angle_2d)
	
	-- ssos tumbler
	ssos_tmb_pos = get(ssos_test)
	
end


components = {

	-- background
	texture {
		position = {0, 0, 983, 512},
		image = get(background),
	},

	-------------------
	-- needle gauges --
	-------------------
	
	-- ampermeter
	needle { 
		image = get(needles_1),
		position = {717, 339, 60, 60},
		angle = function()
			return amp_angle
		end,	
	},

	-- black cap
	texture{
	    position = {733, 353, 30, 30},
        image = get(black_cap),
	},
	
	-- start voltmeter
	needle { 
		image = get(needles_thin),
		position = {795, 266, 200, 200},
		angle = function()
			return volt_angle
		end,	
	},

	-- emergency pressure indicator
	needle { 
		image = get(needles_1),
		position = {14, 392, 60, 60},
		angle = function()
		return emerg_press_angle
		end,	
	},
	
	-- main pressure indicator
	needle { 
		image = get(needles_1),
		position = {85, 428, 60, 60},
		angle = function()
		return main_press_angle
		end,	
	},
	
	-- storage pressure indicator
	needle { 
		image = get(needles_1),
		position = {135, 378, 60, 60},
		angle = function()
		return store_press_angle
		end,	
	},

	-- left brake indicator
	needle { 
		image = get(needles_1),
		position = {188, 428, 60, 60},
		angle = function()
		return brake_1_angle
		end,	
	},

	-- right brake indicator
	needle { 
		image = get(needles_1),
		position = {238, 378, 60, 60},
		angle = function()
		return brake_2_angle
		end,	
	},	

	-- hydraulic quantity indicator
	needle { 
		image = get(needles_4),
		position = {400, 350, 105, 105},
		angle = function()
		return quantity_angle
		end,	
	},
	
	-- caps
	-- cap for emergency pressure indicator
	texture {
		image = get(black_cap1),
		position = {26, 400, 40, 30},
	},

	-- cap for main pressure indicator
	texture {
		image = get(black_cap2),
		position = {96, 439, 32, 32},
	},	
	
	-- cap for storage pressure indicator
	texture {
		image = get(black_cap3),
		position = {150, 390, 32, 32},
	},
	
	-- cap for left pressure indicator
	texture {
		image = get(black_cap2),
		position = {200, 439, 32, 32},
	},	
	
	-- cap for right pressure indicator
	texture {
		image = get(black_cap3),
		position = {250, 390, 32, 32},
	},
	
	-- cap for hydraulic quantity indicator
	texture {
		image = get(grey_cap),
		position = {433, 380, 40, 40},
	},
	
	---------------
	-- lights --
	---------------
	-- apd work
	textureLit {
		image = get(white_led),
		position = {172, 225, 17, 17},
		visible = function()
			return get(apd_work_lit) == 1
		end,
	},
	
	-- Ru19 PK open
	textureLit {
		image = get(green_led),
		position = {346, 464, 18, 18},
		visible = function()
			return get(ru19_pk_open_lit) == 1
		end,
	},

	-- Ru19 PK open
	textureLit {
		image = get(red_led),
		position = {347, 352, 18, 18},
		visible = function()
			return get(ru19_pk_close_lit) == 1
		end,
	},

	-- SSOS work
	textureLit {
		image = get(green_led),
		position = {643, 254, 18, 18},
		visible = function()
			return get(ssos_power_lit) == 1
		end,
	},

	-------------------
	-- SSOS system --
	-------------------

	-- image
	texture {
		position = {550, 248, 120, 30},
		image = function()
			--print(get(eng_start_btn))
			if get(ssos_sw_cap) == 1 then return get(red_sidecap_open) else return get(red_sidecap_close) end
		end,
	},		

	-- ssos switch 
	switch {
        position = { 540, 249, 80, 25},
        state = function()
            return get(ssos_sw) ~= 0
        end,
        btnOn = get(tmb_left),
        btnOff = get(tmb_right),
		visible = function()
			return get(ssos_sw_cap) == 1
		end,
        onMouseClick = function()
            if not switcher_pushed and get(ssos_sw_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ssos_sw) ~= 0 then
                set(ssos_sw, 0)
            else
                set(ssos_sw, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },		
	
	-- ssos switch cap
	switch {
        position = { 570, 280, 40, 30},
        state = function()
            return get(ssos_sw_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cup_open_sound, 0)
			switcher_pushed = true
			if get(ssos_sw_cap) ~= 0 then
                set(ssos_sw_cap, 0)
				set(ssos_sw, 1)
            else
                set(ssos_sw_cap, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
		    playSample(cup_close_sound, 0)
			switcher_pushed = false
			return true
		end,
    },



	-- test switcher
	-- images
	texture {
		position = {735, 405, 20, 80},
		image = get(tmb_up),
		visible = function()
			return ssos_tmb_pos == 1
		end,
	},
	texture {
		position = {735, 405, 20, 80},
		image = get(tmb_ctr),
		visible = function()
			return ssos_tmb_pos == 0
		end,
	},
	texture {
		position = {705, 435, 80, 20},
		image = get(tmb_left),
		visible = function()
			return ssos_tmb_pos == 2
		end,
	},
	texture {
		position = {705, 435, 80, 20},
		image = get(tmb_right),
		visible = function()
			return ssos_tmb_pos == 3
		end,
	},	

	-- switch up
    clickable {
        position = {725, 470, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(ssos_test, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(ssos_test, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
		
    },

	-- switch left
    clickable {
        position = {705, 430, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(ssos_test, 2)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(ssos_test, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
		
    },
	
	-- switch right
    clickable {
        position = {745, 430, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(ssos_test, 3)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(ssos_test, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
		
    },
	
	-------------------
	-- engines start --
	-------------------
	-- image
	texture {
		position = {137, 263, 30, 30},
		image = function()
			--print(get(eng_start_btn))
			if get(eng_start_btn) == 1 then return get(small_btn_dn) else return get(small_btn_up) end
		end,
	},
	-- engine start button
	clickable {
        position = {135, 260, 30, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(eng_start_btn, 1)
			if not switcher_pushed then
			playSample(btn_click, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(eng_start_btn, 0)
			playSample(btn_click, 0)
			switcher_pushed = false
			return true
		end
		
    }, 

	-- cap for ground/air start selector
	texture {
		position = {215, 225, 30, 120},
		image = function()
			--print(get(eng_start_btn))
			if get(start_at_ground_cap) == 1 then return get(yellow_cap_open) else return get(yellow_cap_close) end
		end,
	},	

	switch {
        position = { 180, 240, 30, 40},
        state = function()
            return get(start_at_ground_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(start_at_ground_cap) ~= 0 then
                set(start_at_ground_cap, 0)
				set(start_at_ground, 0)
            else
                set(start_at_ground_cap, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	
	-- ground/air start selector
    switch {
        position = { 217, 230, 25, 80},
        state = function()
            return get(start_at_ground) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
		visible = function()
			return get(start_at_ground_cap) == 1
		end,
        onMouseClick = function()
            if not switcher_pushed and get(start_at_ground_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(start_at_ground) ~= 0 then
                set(start_at_ground, 0)
            else
                set(start_at_ground, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- engine selector
	
	-- image
	texture {
		position = {290, 215, 25, 80},
		image = function()
			--print(get(eng_start_btn))
			local a = get(sel_left_right)
			if a == 1 then return get(tmb_dn) 
			elseif a == -1 then return get(tmb_up) 
			else return get(tmb_ctr)
			end
		end,
	},

	-- select left
	clickable {
        position = { 285, 255, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(sel_left_right)
			if not switcher_pushed and a > -1 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			set(sel_left_right, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
		
    }, 

	-- select right
	clickable {
        position = { 285, 215, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(sel_left_right)
			if not switcher_pushed and a < 1 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
				set(sel_left_right, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- engine start mode - cold rotate/start
    switch {
        position = {355, 215, 25, 80},
        state = function()
            return get(eng_start_mode) ~= 0
        end,
        btnOn = get(tmb_dn),
        btnOff = get(tmb_up),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(eng_start_mode) ~= 0 then
                set(eng_start_mode, 0)
            else
                set(eng_start_mode, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	
	
	-- stop button
	clickable {
        position = {417, 250, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(eng_start_stop, 1)
			if not switcher_pushed then
			playSample(btn_click, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(eng_start_stop, 0)
			playSample(btn_click, 0)
			switcher_pushed = false
			return true
		end
		
    }, 	
	
	-- left PRT24
    switch {
        position = {210, 135, 25, 80},
        state = function()
            return get(left_prt24_on) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(left_prt24_on) ~= 0 then
                set(left_prt24_on, 0)
            else
                set(left_prt24_on, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	
		
	-- right PRT24
    switch {
        position = {375, 135, 25, 80},
        state = function()
            return get(right_prt24_on) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
		onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(right_prt24_on) ~= 0 then
                set(right_prt24_on, 0)
            else
                set(right_prt24_on, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	
	
	
	-- left engine temp check
	-- image
	texture {
		position = {149, 135, 25, 80},
		image = function()
			--print(get(eng_start_btn))
			local a = get(left_temp_check)
			if a == 1 then return get(tmb_dn) 
			elseif a == -1 then return get(tmb_up) 
			else return get(tmb_ctr)
			end
		end,
	},

	-- select up
	clickable {
        position = { 149, 175, 25, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(left_temp_check)
			if not switcher_pushed and a > -1 then 
				playSample(switch_sound, 0) 
				switcher_pushed = true
				a = a - 1
			end
				set(left_temp_check, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- select down
	clickable {
        position = { 149, 135, 25, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        onMouseClick = function() 
       	local a = get(left_temp_check)
			if not switcher_pushed and a < 1 then 
				playSample(switch_sound, 0)
				switcher_pushed = true				
				a = a + 1
			end
				set(left_temp_check, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
		
    }, 
	
	
	-- right engine temp check
	-- image
	texture {
		position = {437, 135, 25, 80},
		image = function()
			--print(get(eng_start_btn))
			local a = get(right_temp_check)
			if a == 1 then return get(tmb_dn) 
			elseif a == -1 then return get(tmb_up) 
			else return get(tmb_ctr)
			end
		end,
	},
	-- select up
	clickable {
        position = { 437, 175, 25, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(right_temp_check) 
			if not switcher_pushed and a > -1 then 
				playSample(switch_sound, 0) 
				switcher_pushed = true
				a = a - 1
			end
			set(right_temp_check, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- select down
	clickable {
        position = { 437, 135, 25, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(right_temp_check)
			if not switcher_pushed and a < 1 then 
				playSample(switch_sound, 0) 
				switcher_pushed = true
				a = a + 1
			end
				set(right_temp_check, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	---------------------
	-- RU-19 start --
	---------------------	
	-- image
	texture {
		position = {145, 70, 30, 30},
		image = function()
			--print(get(eng_start_btn))
			if get(ru19_ground_start_btn) == 1 then return get(small_btn_dn) else return get(small_btn_up) end
		end,
	},

	-- start button
	clickable {
        position = {145, 70, 30, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed and get(ru19_ground_start_cap) == 1 then
				set(ru19_ground_start_btn, 1)
				playSample(btn_click, 0)
				switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(ru19_ground_start_btn, 0)
			playSample(btn_click, 0)
			switcher_pushed = false
			return true
		end
		
    },

	-- start button cap
	texture {
		position = {85, 47, 100, 65},
		image = function()
			if get(ru19_ground_start_cap) == 1 then return get(ru_cap_open) else return get(ru_cap_close) end
		end
	},
    switch {
        position = {90, 60, 40, 40},
        state = function()
            return get(ru19_ground_start_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(ru19_ground_start_cap) ~= 0 then
                set(ru19_ground_start_cap, 0)
            else
                set(ru19_ground_start_cap, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	
	-- mode selector
    switch {
        position = {195, 37, 25, 80},
        state = function()
            return get(ru19_start_mode) ~= 0
        end,
        btnOn = get(tmb_dn),
        btnOff = get(tmb_up),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ru19_start_mode) ~= 0 then
                set(ru19_start_mode, 0)
            else
                set(ru19_start_mode, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	
	
	-- fiction
	texture {
		position = {300, 37, 25, 80},
		image = get(tmb_dn),
	},

	-- stop button
	clickable {
        position = {417, 60, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then
				playSample(btn_click, 0)
				switcher_pushed = true
			end
			set(ru19_start_stop, 1)
			return true
		end,
		onMouseUp = function()
			set(ru19_start_stop, 0)
			playSample(btn_click, 0)
			switcher_pushed = false
			return true
		end
		
    }, 	

	-- main switcher cap
 	texture {
		position = {352, 20, 35, 140},
		image = function()
			--print(get(eng_start_btn))
			if get(ru19_start_main_sw_cap) == 1 then return get(red_cap_open) else return get(red_cap_close) end
		end,
	},	
	switch {
        position = {320, 50, 30, 40},
        state = function()
            return get(ru19_start_main_sw_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(ru19_start_main_sw_cap) ~= 0 then
                set(ru19_start_main_sw_cap, 0)
				set(ru19_start_main_sw, 0)
            else
                set(ru19_start_main_sw_cap, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- main switcher 
    switch {
        position = {357, 37, 25, 80},
        state = function()
            return get(ru19_start_main_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(ru19_start_main_sw_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ru19_start_main_sw) ~= 0 then
                set(ru19_start_main_sw, 0)
            else
                set(ru19_start_main_sw, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
		visible = function()
			return get(ru19_start_main_sw_cap) == 1
		end
    },
	
	-- fire valve 3
    switch {
        position = {340, 380, 25, 80},
        state = function()
            return get(fire_valve3_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fire_valve3_sw) ~= 0 then
                set(fire_valve3_sw, 0)
            else
                set(fire_valve3_sw, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	

	-- hydro valve
	needle { 
		image = get(red_vent_img),
		position = {742, 202, 80, 80},
		angle = function()
			return 45 * get(hydro_circle)
		end,	
	},

	-- hydro circle valve
	switch {
		position = { 742, 202, 80, 80},
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
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- image
	texture {
		position = {740, 98, 120, 30},
		image = function()
			--print(get(eng_start_btn))
			if get(ap_mech_off_cap) == 1 then return get(red_sidecap_open) else return get(red_sidecap_close) end
		end,
	},	
	
	-- AP mechanic off cap
    switch {
        position = {770, 140, 40, 30},
        state = function()
            return get(ap_mech_off_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(ap_mech_off_cap) ~= 0 then
                set(ap_mech_off_cap, 0)
				set(ap_mech_off, 0)
            else
                set(ap_mech_off_cap, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- AP mechanic off
    switch {
        position = {740, 100, 80, 25},
        state = function()
            return get(ap_mech_off) ~= 0
        end,
        btnOn = get(tmb_right),
        btnOff = get(tmb_left),
        onMouseClick = function()
            if not switcher_pushed and get(ap_mech_off_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ap_mech_off) ~= 0 then
                set(ap_mech_off, 0)
            else
                set(ap_mech_off, 1)
            end
			end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
		visible = function()
			return get(ap_mech_off_cap) ~= 0
		end
    },
	
	
	-- wiper
    switch {
        position = {540, 70, 100, 100},
        state = function()
            return get(wiper_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(wiper_sw) ~= 0 then
                set(wiper_sw, 0)
            else
                set(wiper_sw, 2)
            end
            return true;
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
        set(left_subpanel, 0 )
        return true
        end
    },	
	
}

