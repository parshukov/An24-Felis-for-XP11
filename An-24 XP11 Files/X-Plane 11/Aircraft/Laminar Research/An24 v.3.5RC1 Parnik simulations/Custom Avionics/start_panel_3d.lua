-- this is 3D panel for start engines
size = {2048, 2048}

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

defineProperty("panel_cap", globalPropertyi("sim/cockpit2/switches/custom_slider_on[13]")) -- cap operation

defineProperty("apd_work_lit", globalPropertyi("sim/custom/xap/An24_start/apd_work_lit")) -- lamp for apd
defineProperty("pt29_work_lit", globalPropertyi("sim/custom/xap/An24_start/pt29_work_lit")) -- lamp for ru19 starter
defineProperty("strip_lit", globalPropertyi("sim/custom/xap/An24_start/strip_lit")) -- lamp for ru19 starter


defineProperty("starter_volt", globalPropertyf("sim/custom/xap/An24_start/starter_volt")) -- starter voltage for engines start
defineProperty("starter_amp", globalPropertyf("sim/custom/xap/An24_start/starter_amp")) -- starter amperage for engines start


defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec")) -- flight time

-- images
defineProperty("white_led", loadImage("leds.dds", 0, 0, 20, 20))
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 

defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("needles_thin", loadImage("needles.dds", 336, 103, 1, 110)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

local amp_angle = -110
local volt_angle = -45
local pt_work_light = get(pt29_work_lit) == 1
local apd_work_light = get(apd_work_lit) == 1
local strip_light = true

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

function update()
	
	amp_angle = get(starter_amp) * 217 / 1000 - 100
	volt_angle = get(starter_volt) * 90 / 75 - 45
	pt_work_light = get(pt29_work_lit) == 1
	apd_work_light = get(apd_work_lit) == 1
	strip_light = get(strip_lit) == 1
	
end


components = {

	-------------------
	-- needle gauges --
	-------------------
	
	-- ampermeter
	needle { 
		image = get(needles_1),
		position = {1305, 1150, 90, 90},
		angle = function()
			return amp_angle
		end,	
	},

	-- black cap
	texture{
	    position = {1330, 1175, 42, 42},
        image = get(black_cap),
	},
	
	-- start voltmeter
	needle { 
		image = get(needles_thin),
		position = {196, 916, 110, 110},
		angle = function()
			return volt_angle
		end,	
	},

	-- prt24 voltmeter
	needle { 
		image = get(needles_thin),
		position = {196, 817, 110, 110},
		angle = function()
			return -45
		end,
	},

	-- prt24 voltmeter
	needle { 
		image = get(needles_thin),
		position = {296, 817, 110, 110},
		angle = function()
			return -45
		end,
	},	

	
	---------------
	-- lights --
	---------------
	-- pt29 work
	textureLit {
		image = get(green_led),
		position = {740, 407, 20, 20},
		visible = function()
			return pt_work_light
		end,
	},

	-- strip open work
	textureLit {
		image = get(green_led),
		position = {760, 407, 20, 20},
		visible = function()
			return strip_light
		end,
	},

	-- apd work
	textureLit {
		image = get(white_led),
		position = {660, 428, 20, 20},
		visible = function()
			return apd_work_light
		end,
	},
	
	-------------------
	-- engines start --
	-------------------
	
	-- big cap
    switch {
        position = { 869, 201, 20, 44},
        state = function()
            return get(panel_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(panel_cap) ~= 0 then
                set(panel_cap, 0)
				set(start_at_ground_cap, 0)
            else
                set(panel_cap, 1)
            end
            return true;
        end
    }, 


	-- engine start button
	clickable {
        position = {689, 523, 20, 20},  -- search and set right
        
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
    switch {
        position = { 34, 491, 32, 40},
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
        position = { 880, 364, 18, 18},
        state = function()
            return get(start_at_ground) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
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
	-- select left
	clickable {
        position = { 908, 364, 8, 18},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(sel_left_right)
			if not switcher_pushed and a > -1 and get(panel_cap) ~= 0 then 
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
        position = { 900, 364, 8, 18},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(sel_left_right)
			if not switcher_pushed and a < 1 and get(panel_cap) ~= 0 then 
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
        position = {918, 364, 18, 18},
        state = function()
            return get(eng_start_mode) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(panel_cap) ~= 0 then
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
        position = {876, 511, 30, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(eng_start_stop, 1)
			if not switcher_pushed and get(panel_cap) ~= 0 then
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
        position = {956, 364, 18, 18},
        state = function()
            return get(left_prt24_on) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(panel_cap) ~= 0 then
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
        position = {975, 364, 18, 18},
        state = function()
            return get(right_prt24_on) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(panel_cap) ~= 0 then
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
	-- select up
	clickable {
        position = { 936, 373, 18, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(left_temp_check)
			if not switcher_pushed and a > -1 and get(panel_cap) ~= 0 then 
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
        position = { 936, 365, 18, 8},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
       	local a = get(left_temp_check)
			if not switcher_pushed and a < 1 and get(panel_cap) ~= 0 then 
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
	-- select up
	clickable {
        position = { 813, 345, 8, 18},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(right_temp_check) 
			if not switcher_pushed and a > -1 and get(panel_cap) ~= 0 then 
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
        position = { 805, 345, 8, 18},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(right_temp_check)
			if not switcher_pushed and a < 1 and get(panel_cap) ~= 0 then 
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
	
	-- start button cap
    switch {
        position = {802, 506, 22, 39},
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
	
	-- start button
	clickable {
        position = {709, 523, 20, 20},  -- search and set right
        
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
	
	-- mode selector
    switch {
        position = {822, 345, 18, 18},
        state = function()
            return get(ru19_start_mode) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
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

	-- stop button
	clickable {
        position = {913, 511, 30, 30},  -- search and set right
        
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
    switch {
        position = {94, 491, 32, 40},
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
        position = {879, 345, 18, 18},
        state = function()
            return get(ru19_start_main_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
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
		end,
    },

}

