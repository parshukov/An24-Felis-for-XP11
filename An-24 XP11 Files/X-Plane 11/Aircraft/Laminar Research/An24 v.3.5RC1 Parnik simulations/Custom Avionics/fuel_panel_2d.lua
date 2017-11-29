-- this skript contains components for fuel system manipulation and indication
size = {600, 850}

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

defineProperty("fuel_pump_1", globalPropertyi("sim/custom/xap/An24_fuel/tank1_pump"))  -- fuel pump for tank 1
defineProperty("fuel_pump_2", globalPropertyi("sim/custom/xap/An24_fuel/tank2_pump"))  -- fuel pump for tank 2
defineProperty("fuel_pump_3", globalPropertyi("sim/custom/xap/An24_fuel/tank3_pump"))  -- fuel pump for tank 3
defineProperty("fuel_pump_4", globalPropertyi("sim/custom/xap/An24_fuel/tank4_pump"))  -- fuel pump for tank 4
defineProperty("fuel_circle_valve", globalPropertyi("sim/custom/xap/An24_fuel/fuel_circle_valve")) -- valve for fuel circulation between left and right tanks
defineProperty("mixt_valve1", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access1")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve2", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access2")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich
defineProperty("mixt_valve3", globalPropertyf("sim/custom/xap/An24_fuel/fuel_access3")) -- Mixture Control (per engine), 0 = cutoff, 1 = full rich

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

defineProperty("fuel_subpanel", globalPropertyi("sim/custom/xap/An24_panels/fuel_subpanel"))

-- images
defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20)) 
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

defineProperty("needle_q_left", loadImage("needles.dds", 32, 95, 17, 141)) 
defineProperty("needle_q_right", loadImage("needles.dds", 48, 95, 17, 141)) 
defineProperty("needle_long", loadImage("needles.dds", 67, 70, 16, 179)) 

defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))

defineProperty("yellow_cap", loadImage("covers.dds", 204, 0, 56, 56)) -- yellow cap image
defineProperty("background", loadImage("fuel_panel_2d.dds", 0, 0, 512, 725)) -- yellow cap image
defineProperty("mode_ndl_img", loadImage("fuel_panel_2d.dds", 6, 779, 30, 142)) -- mode switcher needle

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))


local function bool2int(var)
	if var then return 1 else return 0 end
end

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

local mode_angle = 0
local left_filter_lit = false
local right_filter_lit = false
-- post frame calculations
function update()
	q_left_angle = get(fuel_quant1_angle)
	q_right_angle = get(fuel_quant2_angle)
	
	
	fuel_show_left = get(fuel_flow_left_count)
	ff1_actual_angle = get(fuel_flow_left_angle)
	fuel_show_right = get(fuel_flow_right_count)
	ff2_actual_angle = get(fuel_flow_right_angle)
	
	mode_angle = -50 + get(quantity_mode) * 33
	fuel_1000_lit = get(quant_1000_lit) == 1
	left_filter_lit = get(left_filter_block_lit) == 1
	right_filter_lit = get(right_filter_block_lit) == 1
	
	fuel_circle_led = get(fuel_circle_lit) == 1
	fuel_press_left_led = get(left_fuel_press_lit) == 1
	fuel_press_right_led = get(right_fuel_press_lit) == 1
	
	pump1_led = get(fuel_lump1_lit) == 1
	pump2_led = get(fuel_lump2_lit) == 1
	pump3_led = get(fuel_lump3_lit) == 1
	pump4_led = get(fuel_lump4_lit) == 1
	
	fire_v1_led = get(left_pk_open_lit) == 1
	fire_v2_led = get(right_pk_open_lit) == 1
	chip_left = get(left_chip_lit) == 1
	chip_right = get(right_chip_lit) == 1
	
end


components = {
	
	-- background
	texture {
		position = {0, 0, size[1], size[2]},
		image = get(background),
	},


	---------------------
	-- needle gauges --
	---------------------
	-- quantity meter. left needle
	needle { 
		image = get(needle_q_left),
		position = {442, 418, 130, 130},
		angle = function()
		return q_left_angle
		end,	
	},

	-- quantity meter. right needle
	needle { 
		image = get(needle_q_right),
		position = {442, 418, 130, 130},
		angle = function()
		return q_right_angle
		end,	
	},
	
	-- yellow cap
	texture{
	    position = { 482, 458, 50, 50},
        image = get(yellow_cap),
	},
	
	-- quantity mode
	needle { 
		image = get(mode_ndl_img),
		position = {422, 200, 166, 166},
		angle = function()
		return mode_angle
		end,	
	},
	
	-- control button
	clickable {
        position = { 483, 390, 50, 50},  -- search and set right
        
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
        position = { 470, 240, 35, 70},  -- search and set right
        
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
        position = { 505, 240, 35, 70},  -- search and set right
        
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
        position = { 75, 167, 65, 20};
        image = digitsImage;
        digits = 3;
		allowNonRound = false;
		showLeadingZeros = true;
        value = function() 
            return fuel_show_left; 
        end;
    }; 
	needle { 
		image = get(needle_long),
		position = {21, 132, 170, 170},
		angle = function()
		return ff1_actual_angle
		end,	
	},

    -- counter rotary
    rotary {
        -- image = rotaryImage;
        value = fuel_flow_left_count_rot;
        step = 10;
        position = {  75, 100, 70, 50 };

        -- round counter
        adjuster = function(v)
			playSample(rot_click, 0) 
            return math.ceil(v/10) * 10
        end;
    };
	
	-- right counter
	digitstape {
        position = {280, 167, 65, 20};
        image = digitsImage;
        digits = 3;
		allowNonRound = false;
		showLeadingZeros = true;
        value = function() 
            return fuel_show_right; 
        end;
    }; 
	needle { 
		image = get(needle_long),
		position = {227, 132, 170, 170},
		angle = function()
		return ff2_actual_angle
		end,	
	},
    -- counter rotary
    rotary {
        -- image = rotaryImage;
        value = fuel_flow_right_count_rot;
        step = 10;
        position = {  280, 100, 70, 50 };

        -- round counter
        adjuster = function(v)
            playSample(rot_click, 0) 
			return math.ceil(v/10) * 10
        end;
    };

	---------------------
	-- panel lights --
	---------------------
	-- fuel quantity less then 1000kg
	textureLit {
		image = get(red_led),
		position = {484, 726, 38, 38},
		visible = function()
			return fuel_1000_lit
		end,
	},

	-- left filter block
	textureLit {
		image = get(yellow_led),
		position = {442, 634, 38, 38},
		visible = function()
			return left_filter_lit
		end,
	},
	
	-- right filter block
	textureLit {
		image = get(yellow_led),
		position = {529, 634, 38, 38},
		visible = function()
			return right_filter_lit
		end,
	},
	
	-- fuel circle
	textureLit {
		image = get(yellow_led),
		position = {189, 782, 32, 32},
		visible = function()
			return fuel_circle_led
		end,
	},
	
	-- fuel pressure left
	textureLit {
		image = get(green_led),
		position = {22, 755, 32, 32},
		visible = function()
			return fuel_press_left_led
		end,
	},
	
	-- fuel pressure right
	textureLit {
		image = get(green_led),
		position = {357, 755, 32, 32},
		visible = function()
			return fuel_press_right_led
		end,
	},
	
	-- fuel pump 1
	textureLit {
		image = get(green_led),
		position = {75, 660, 32, 32},
		visible = function()
			return pump1_led
		end,
	},
	
	-- fuel pump 2
	textureLit {
		image = get(green_led),
		position = {139, 660, 32, 32},
		visible = function()
			return pump2_led
		end,
	},
	
	-- fuel pump 3
	textureLit {
		image = get(green_led),
		position = {240, 560, 32, 32},
		visible = function()
			return pump3_led
		end,
	},

	-- fuel pump 2
	textureLit {
		image = get(green_led),
		position = {139, 560, 32, 32},
		visible = function()
			return pump2_led
		end,
	},
	
	-- fuel pump 3
	textureLit {
		image = get(green_led),
		position = {240, 660, 32, 32},
		visible = function()
			return pump3_led
		end,
	},
	
	-- fuel pump 4
	textureLit {
		image = get(green_led),
		position = {304, 660, 32, 32},
		visible = function()
			return pump4_led
		end,
	},
	
	-- fire valve 1 ON
	textureLit {
		image = get(green_led),
		position = {22, 560, 32, 32},
		visible = function()
			return fire_v1_led
		end,
	},

	-- fire valve 2 ON
	textureLit {
		image = get(green_led),
		position = {357, 560, 32, 32},
		visible = function()
			return fire_v2_led
		end,
	},	
	
	-- chip left
	textureLit {
		image = get(red_led),
		position = {20, 348, 35, 35},
		visible = function()
			return chip_left
		end,
	},	
	
	-- chip right
	textureLit {
		image = get(red_led),
		position = {357, 350, 35, 35},
		visible = function()
			return chip_right
		end,
	},	

	---------------------
	-- panel switchers --
	---------------------
    -- fire valve 1
    switch {
        position = { 25, 420, 30, 100},
        state = function()
            return get(fire_valve1_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = { 360, 420, 30, 100},
        state = function()
            return get(fire_valve2_sw) ~= 0
        end,
        btnOn = get(tmb_up),
		btnOff = get(tmb_dn),
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
	
	-- fuel pump 1
	texture {
		position = {85, 420, 30, 100},
		image = function()
			local a = get(pump1_switch)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end
	},
	-- switcher up
	clickable {
        position = { 85, 470, 30, 50},  -- search and set right
        
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
        position = { 85, 420, 30, 50},  -- search and set right
        
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
 	texture {
		position = {301, 420, 30, 100},
		image = function()
			local a = get(pump4_switch)
			local pic
			if a == 0 then pic = get(tmb_dn)
			elseif a == 1 then pic = get(tmb_ctr)
			else pic = get(tmb_up) end
			return pic
		end
	},

	-- switcher up
	clickable {
        position = { 301, 470, 30, 50},  -- search and set right
        
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
        position = { 301, 420, 30, 50},  -- search and set right
        
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
        position = {140, 420, 30, 100},
        state = function()
            return get(pump2_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {247, 420, 30, 100},
        state = function()
            return get(pump3_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {195, 420, 30, 100},
        state = function()
            return get(fuel_circle_valve_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {32, -15, 30, 100},
        state = function()
            return get(q_meter1_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {135, -15, 30, 100},
        state = function()
            return get(q_meter2_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {232, -15, 30, 100},
        state = function()
            return get(ff_meter_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        position = {467, -15, 30, 100},
        state = function()
            return get(auto_ff_switch) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
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
        set(fuel_subpanel, 0 )
        return true
        end
    },	
	
}