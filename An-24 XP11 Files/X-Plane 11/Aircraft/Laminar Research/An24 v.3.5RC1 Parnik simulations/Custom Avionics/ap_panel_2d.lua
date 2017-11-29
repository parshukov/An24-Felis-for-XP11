size = {512, 380}

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

defineProperty("gear_valve", globalPropertyi("sim/custom/xap/An24_hydro/gear_valve")) -- position of gear valve for gydraulic calculations and animations maximum 160.
defineProperty("flaps_valve", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve")) -- position of flaps valve for gydraulic calculations and animations.

defineProperty("ap_panel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/ap_panel_subpanel"))

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
defineProperty("background", loadImage("ap_panel_2d.dds", 0, 0, size[1], size[2]))
defineProperty("knob_img", loadImage("ap_panel_2d.dds", 6, 410, 95, 95))
defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))

defineProperty("small_btn_dn", loadImage("ap_panel_2d.dds", 122, 439, 36, 36))
defineProperty("small_btn_up", loadImage("ap_panel_2d.dds", 164, 439, 36, 36))

defineProperty("flap_up_img", loadImage("right_panel_2d.dds", 831, 117, 66, 66))
defineProperty("flap_ctr_img", loadImage("right_panel_2d.dds", 831, 330, 66, 66))
defineProperty("flap_dn_img", loadImage("right_panel_2d.dds", 831, 259, 66, 66))

defineProperty("gear_up_img", loadImage("right_panel_2d.dds", 906, 117, 66, 66))
defineProperty("gear_ctr_img", loadImage("right_panel_2d.dds", 906, 187, 66, 66))
defineProperty("gear_dn_img", loadImage("right_panel_2d.dds", 906, 259, 66, 66))

-- commands
flaps_command_up = findCommand("sim/flight_controls/flaps_up")
flaps_command_down = findCommand("sim/flight_controls/flaps_down")
gear_command_up = findCommand("sim/flight_controls/landing_gear_up")
gear_command_down = findCommand("sim/flight_controls/landing_gear_down")

local flap_up_clicked = false
local flap_down_clicked = false

local ap_up_light = get(ap_up_lit) == 1
local ap_down_light = get(ap_down_lit) == 1
local ap_ready_light = get(ap_ready_lit) == 1
local ap_on_light = get(ap_on_lit) == 1
local ap_kv_light = get(ap_kv_lit) == 1
local roll_angle = get(ap_roll) * 3
local ap_on_img = get(small_btn_up)
local pitch_img = get(tmb_ctr)
local stab_img = get(tmb_up)
local hor_btn_img = get(small_btn_up)
local kv_btn_img = get(small_btn_up)
local flap_img = get(flap_ctr_img)
local gear_img = get(gear_ctr_img)

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')

local switcher_pushed = false



function update()
	ap_up_light = get(ap_up_lit) == 1
	ap_down_light = get(ap_down_lit) == 1
	ap_ready_light = get(ap_ready_lit) == 1
	ap_on_light = get(ap_on_lit) == 1
	ap_kv_light = get(ap_kv_lit) == 1
	roll_angle = get(ap_roll) * 3
	
	if get(ap_ON) == 1 then ap_on_img = get(small_btn_dn) else ap_on_img = get(small_btn_up) end
	
	local a = get(ap_pitch)
	if a == 1 then pitch_img = get(tmb_dn)
	elseif a == -1 then pitch_img = get(tmb_up)
	else pitch_img = get(tmb_ctr) end
	
	local b = get(ap_curse_stab)
	if b == 0 then stab_img = get(tmb_dn)
	elseif b == 2 then stab_img = get(tmb_up)
	else stab_img = get(tmb_ctr) end
	
	if get(ap_horizont) == 1 then hor_btn_img = get(small_btn_dn) else hor_btn_img = get(small_btn_up) end
	
	if get(ap_kv) == 1 then kv_btn_img = get(small_btn_dn) else kv_btn_img = get(small_btn_up) end
	
	local c = get(flaps_valve)
	if c == 1 then flap_img = get(flap_dn_img)
	elseif c == -1 then flap_img = get(flap_up_img)
	else flap_img = get(flap_ctr_img) end
	
	local d = get(gear_valve)
	if d == 1 then gear_img = get(gear_dn_img)
	elseif d == -1 then gear_img = get(gear_up_img)
	else gear_img = get(gear_ctr_img) end
	
end

components = {

	-- background
	texture {
		image = get(background),
		position = {0, 0, size[1], size[2]},

	},	

	
	---------------
	-- lights --
	---------------

	
	-- AP up light
	textureLit {
		image = get(yellow_led),
		position = {127, 29, 20, 20},
		visible = function()
			return ap_up_light
		end,
	},	
	
	-- AP down light
	textureLit {
		image = get(yellow_led),
		position = {185, 29, 20, 20},
		visible = function()
			return ap_down_light
		end,
	},
	
	-- AP ready light
	textureLit {
		image = get(yellow_led),
		position = {182, 345, 20, 20},
		visible = function()
			return ap_ready_light
		end,
	},	
	
	-- AP ON light
	textureLit {
		image = get(green_led),
		position = {297, 345, 20, 20},
		visible = function()
			return ap_on_light
		end,
	},		
	
	-- KV mode
	textureLit {
		image = get(green_led),
		position = {299, 29, 20, 20},
		visible = function()
			return ap_kv_light
		end,
	},	
	
	
	----------------
	-- clickables --
	----------------
	
	-- manual pitch
	-- image
	texture{
		position = {125, 255, 25, 80},
		image = function()
			return pitch_img
		end,
	},
	texture{
		position = {350, 255, 25, 80},
		image = function()
			return pitch_img
		end,
	},	
	-- pitch UP
    clickable {
        position = {115, 250, 40, 40},  -- search and set right
        
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
    clickable {
        position = {345, 250, 40, 40},  -- search and set right
        
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
        position = {115, 300, 40, 40},  -- search and set right
        
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
    clickable {
        position = {345, 300, 40, 40},  -- search and set right
        
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
        position = { 120, 90, 25, 80},
        state = function()
            return get(ap_trim) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = { 180, 90, 25, 80},
        state = function()
            return get(ap_power) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = { 355, 90, 25, 80},
        state = function()
            return get(ap_pitch_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
	texture{
		position = {298, 90, 25, 80},
		image = function()
			return stab_img
		end,
	},	

	-- switch down
    clickable {
        position = { 295, 90, 30, 40},  -- search and set right
        
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
        position = { 295, 130, 30, 40},  -- search and set right
        
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
	-- image
	needle {
		position = {202, 245, 95, 95},
		image = get(knob_img),
		angle = function()
			return roll_angle
		end,
	},
	
	-- roll left
    clickable {
        position = { 190, 250, 50, 60},  -- search and set right
        
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
        position = { 260, 250, 50, 60},  -- search and set right
        
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
        position = { 225, 320, 50, 40},  -- search and set right
        
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

	-- button images
	texture {
		position = {233, 115, 36, 36},
		image = function()
			return ap_on_img
		end
	},
	
	-- engage AP
    clickable {
        position = {230, 110, 40, 40},  -- search and set right
        
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
	
	-- button images
	texture {
		position = {233, 20, 36, 36},
		image = function()
			return hor_btn_img
		end
	},
	
	-- button images
	texture {
		position = {349, 20, 36, 36},
		image = function()
			return kv_btn_img
		end
	},
	
	-- engage horizont mode
    clickable {
        position = {230, 15, 40, 40},  -- search and set right
        
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
        position = {345, 15, 40, 40},  -- search and set right
        
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

	-- flap images
	texture{
		position = {20, 200, 80, 80},
		image = function()
			return flap_img
		end,
	},	
	
	-- turn flaps UP
    clickable {
        position = {20, 250, 60, 60},  -- search and set right
        
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
        position = {20, 180, 60, 60},  -- search and set right
        
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

	-- gear images
	texture{
		position = {410, 200, 80, 80},
		image = function()
			return gear_img
		end,
	},	
	-- turn gears UP
    clickable {
        position = {420, 250, 60, 60},  -- search and set right
        
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

	-- turn gears DOWN
    clickable {
        position = {420, 180, 60, 60},  -- search and set right
        
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
        set(ap_panel_subpanel, 0 )
        return true
        end
    },	

}