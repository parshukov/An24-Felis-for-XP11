size = {2048, 2048}

-- define properties
-- switchers and buttons
defineProperty("ap_power", globalPropertyi("sim/custom/xap/An24_ap/ap_power"))  -- power of AP
defineProperty("ap_trim", globalPropertyi("sim/custom/xap/An24_ap/ap_trim"))  -- use trimmer of AP
defineProperty("ap_ON", globalPropertyi("sim/custom/xap/An24_ap/ap_ON"))  -- main button for engage AP
defineProperty("ap_kv", globalPropertyi("sim/custom/xap/An24_ap/ap_kv"))  -- button for altitude hold
defineProperty("ap_horizont", globalPropertyi("sim/custom/xap/An24_ap/ap_horizont"))  -- button to set horizontal position of plane
defineProperty("ap_curse_stab", globalPropertyi("sim/custom/xap/An24_ap/ap_curse_stab"))  -- switcher for curse stab. turn/GPK/GIK
defineProperty("ap_pitch", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch"))  -- pitch control
defineProperty("ap_pitch_sw", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch_sw"))  -- engage pitch control
defineProperty("ap_roll", globalPropertyf("sim/custom/xap/An24_ap/ap_roll"))   -- roll knob
defineProperty("ap_mech_off", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off"))  -- ap mechanic off. o = mechanics works, 1 = mech off
defineProperty("ap_mech_off_cap", globalPropertyi("sim/custom/xap/An24_ap/ap_mech_off_cap"))  -- ap mechanic off cap
-- lights
defineProperty("ap_ready_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_ready_lit"))  -- ready light
defineProperty("ap_on_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_on_lit"))  -- AP engaged light
defineProperty("ap_kv_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_kv_lit"))  -- alt stab engaged
defineProperty("ap_up_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_up_lit"))  -- AP feels UP force on stab
defineProperty("ap_down_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_down_lit"))  -- AP feels DOWN force on stab
defineProperty("ap_ail_fail_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_ail_fail_lit"))  -- aileron trim failed lamp
defineProperty("ap_elev_fail_lit", globalPropertyi("sim/custom/xap/An24_ap/ap_elev_fail_lit"))  -- elevator trim failed lamp
--images
defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("elev_force_led", loadImage("lamps.dds", 0, 60, 50, 30)) 
defineProperty("elev_fail_led", loadImage("lamps.dds", 150, 30, 50, 30))
defineProperty("ail_fail_led", loadImage("lamps.dds", 200, 30, 50, 30))
--defineProperty("autopilot_statePF", globalPropertyf("parshukovedition/autopilot_state_PF"))
--defineProperty("autopilot_stateFO", globalPropertyf("parshukovedition/autopilot_state_FO"))

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

local ap_up_light = get(ap_up_lit) == 1
local ap_down_light = get(ap_down_lit) == 1
local ap_ready_light = get(ap_ready_lit) == 1
local ap_on_light = get(ap_on_lit) == 1
local ap_kv_light = get(ap_kv_lit) == 1
local ap_elev_fail_light = get(ap_elev_fail_lit) == 1
local ap_ail_fail_light = get(ap_ail_fail_lit) == 1

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')

local cup_open_sound = loadSample('Custom Sounds/cup_open.wav')
local cup_close_sound = loadSample('Custom Sounds/cup_close.wav')

local switcher_pushed = false

function update()
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(ap_power, 0)
		set(ap_trim, 0)
		set(ap_pitch_sw, 0)
		not_loaded = false
	end

	ap_up_light = get(ap_up_lit) == 1
	ap_down_light = get(ap_down_lit) == 1
	ap_ready_light = get(ap_ready_lit) == 1
	ap_on_light = get(ap_on_lit) == 1
	ap_kv_light = get(ap_kv_lit) == 1
	ap_elev_fail_light = get(ap_elev_fail_lit) == 1
	ap_ail_fail_light = get(ap_ail_fail_lit) == 1
	
end


components = {
	
	---------------
	-- lights --
	---------------

	-- AP force light
	textureLit {
		image = get(elev_force_led),
		position = {1229, 517, 50, 30},
		visible = function()
			return ap_up_light or ap_down_light
		end,
	},

	-- Elevator trim fail light
	textureLit {
		image = get(elev_fail_led),
		position = {1284, 517, 50, 30},
		visible = function()
			return ap_elev_fail_light
		end,
	},
	-------------------------------------------------------------------------------------------------
	
	-------------------------------------------------------------------------------------------------
	-- Elevator trim fail light
	textureLit {
		image = get(ail_fail_led),
		position = {1340, 517, 50, 30},
		visible = function()
			return ap_ail_fail_light
		end,
	},
	
	-- AP up light
	textureLit {
		image = get(yellow_led),
		position = {751, 290, 17, 17},
		visible = function()
			return ap_up_light
		end,
	},	
	
	-- AP down light
	textureLit {
		image = get(yellow_led),
		position = {767, 290, 17, 17},
		visible = function()
			return ap_down_light
		end,
	},
	
	-- AP ready light
	textureLit {
		image = get(yellow_led),
		position = {720, 290, 17, 17},
		visible = function()
			return ap_ready_light
		end,
	},	
	
	-- AP ON light
	textureLit {
		image = get(green_led),
		position = {736, 289, 17, 17},
		visible = function()
			return ap_on_light
		end,
	},		
	
	-- KV mode
	textureLit {
		image = get(green_led),
		position = {783, 289, 17, 17},
		visible = function()
			return ap_kv_light
		end,
	},	
	
	
	----------------
	-- clickables --
	----------------
	
	-- manual pitch
	-- pitch UP
    clickable {
        position = {1175, 373, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       onMouseClick = function() 
			if not switcher_pushed then playSample(switch_sound, 0) end
			switcher_pushed = true
			set(ap_pitch, 1)
			return true
		end,
		onMouseUp = function()
			set(ap_pitch, 0)
			switcher_pushed = false
			playSample(switch_sound, 0)
			return true
		end,
		
    },

	-- pitch DOWN
    clickable {
        position = {1175, 380, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then playSample(switch_sound, 0) end
			switcher_pushed = true
			set(ap_pitch, -1)
			return true
		end,
		onMouseUp = function()
			set(ap_pitch, 0)
			switcher_pushed = false
			playSample(switch_sound, 0)
			return true
		end,
		
    },


	-- autotrim switch
    switch {
        position = { 1004, 356, 15, 15},
        state = function()
            return get(ap_trim) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ap_trim) ~= 0 then
                set(ap_trim, 0)
            else
                set(ap_trim, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- power switch
    switch {
        position = { 1022, 356, 15, 15},
        state = function()
            return get(ap_power) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ap_power) ~= 0 then
                set(ap_power, 0)
            else
                set(ap_power, 1)
            end
            return true;
			end
		end,
        onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 


	-- pitch switcher
    switch {
        position = { 1059, 356, 15, 15},
        state = function()
            return get(ap_pitch_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ap_pitch_sw) ~= 0 then
                set(ap_pitch_sw, 0)
            else
                set(ap_pitch_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- stab selector
	-- switch down
    clickable {
        position = { 1041, 364, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ap_curse_stab)
			if a > 0 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(ap_curse_stab, a)
			return true
		end,
		
    },

	-- switch up
    clickable {
        position = { 1041, 355, 15, 7},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ap_curse_stab)
			if a < 2 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(ap_curse_stab, a)
			return true
		end,
		
    }, 
	
	-- roll knob
	-- roll left
    clickable {
        position = { 145, 10, 20, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ap_roll)
			if a > -25 then
				playSample(rot_click, 0)
				a = a - 5
			end
			set(ap_roll, a)
			return true
		end,
    },

 	-- roll right
    clickable {
        position = { 175, 10, 20, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ap_roll)
			if a < 25 then
				playSample(rot_click, 0)
				a = a + 5
			end
			set(ap_roll, a)
			return true
		end,
    },
	
 	-- roll center
    clickable {
        position = { 155, 40, 30, 20},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			if not switcher_pushed then playSample(rot_click, 0) end
			switcher_pushed = true
			set(ap_roll, 0)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- engage AP
    clickable {
        position = {803, 426, 20, 20},  -- search and set right
        
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
			set(ap_ON, 1)
			return true
		end,
		onMouseUp = function()
			playSample(btn_click, 0)
			switcher_pushed = false
			set(ap_ON, 0)
			return true
		end,
    },
	
	
	-- engage horizont mode
    clickable {
        position = {827, 427, 20, 20},  -- search and set right
        
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
			set(ap_horizont, 1)
			return true
		end,
		onMouseUp = function()
			playSample(btn_click, 0)
			switcher_pushed = false
			set(ap_horizont, 0)
			return true
		end,
    },
	
	-- engage alt hold mode
    clickable {
        position = {850, 427, 20, 20},  -- search and set right
        
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
			set(ap_kv, 1)
			return true
		end,
		onMouseUp = function()
			playSample(btn_click, 0)
			switcher_pushed = false
			set(ap_kv, 0)
			return true
		end,
    },	

	-- mechanic off cap
    switch {
        position = {167, 490, 35, 44},
        state = function()
            return get(ap_mech_off_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
				playSample(cup_open_sound, 0)
				if get(ap_mech_off_cap) ~= 0 then
					set(ap_mech_off_cap, 0)
				else
					set(ap_mech_off_cap, 1)
				end
				switcher_pushed = true
			end
			return true;
        end,
		onMouseUp = function()
		    playSample(switch_sound, 0)
		    playSample(cup_close_sound, 0)
			switcher_pushed = false
		end,
    },
	
	-- mechanic off
    switch {
        position = {917, 345, 18, 18},
        state = function()
            return get(ap_mech_off) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(ap_mech_off_cap) == 1 and not switcher_pushed then
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
    },
	

}
