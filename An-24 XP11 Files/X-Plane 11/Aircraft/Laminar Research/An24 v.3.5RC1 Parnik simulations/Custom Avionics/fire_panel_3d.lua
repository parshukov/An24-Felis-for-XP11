-- this is fire panel
size = {2048, 2048}

-- define property table
-- switchers and buttons
defineProperty("fire_main_switcher", globalPropertyi("sim/custom/xap/An24_fire/fire_main_switcher"))  -- main switcher for fire system.
defineProperty("fire_left_wing_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_left_wing_btn"))  -- fire in left wing button
defineProperty("fire_left_wing_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_wing_lit"))  -- fire in left wing light
defineProperty("fire_right_wing_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_right_wing_btn"))  -- fire in right wing button
defineProperty("fire_right_wing_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_wing_lit"))  -- fire in right wing light
defineProperty("fire_left_nacelle_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_left_nacelle_btn"))  -- fire in left nacelle button
defineProperty("fire_left_nacelle_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_nacelle_lit"))  -- fire in left nacelle light
defineProperty("fire_right_nacelle_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_right_nacelle_btn"))  -- fire in right nacelle button
defineProperty("fire_right_nacelle_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_nacelle_lit"))  -- fire in right nacelle light
defineProperty("fire_ru19_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_ru19_btn"))  -- fire in ru19 button
defineProperty("fire_ru19_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_ru19_lit"))  -- fire in ru19 light

-- engines lamps and buttons
defineProperty("fire_left_eng_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_lit"))  -- fire in left engine light
defineProperty("fire_right_eng_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_lit"))  -- fire in right engine light

defineProperty("ext_left_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_left_ready_lit"))  -- left engine extinguisher ready
defineProperty("ext_right_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_right_ready_lit"))  -- right engine extinguisher ready
defineProperty("ext_first_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_first_ready_lit"))  -- furst turn extinguisher ready
defineProperty("ext_second_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_second_ready_lit"))  -- second turn extinguisher ready

defineProperty("fire_left_eng_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_ext"))  -- button for left engine fire extinguisher
defineProperty("fire_left_eng_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_ext_cap"))  -- cap for button for left engine fire extinguisher

defineProperty("fire_right_eng_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_ext"))  -- button for right engine fire extinguisher
defineProperty("fire_right_eng_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_ext_cap"))  -- cap for button for right engine fire extinguisher

defineProperty("fire_second_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_second_ext"))  -- button for second turn fire extinguisher
defineProperty("fire_second_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_second_ext_cap"))  -- cap for button for second turn fire extinguisher

-- images
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 
defineProperty("yellow_small_led", loadImage("leds.dds", 100, 0, 10, 10)) 

defineProperty("left_wing_fire_led", loadImage("fire_lamps.dds", 0, 0, 80, 64)) 
defineProperty("left_nacelle_fire_led", loadImage("fire_lamps.dds", 103, 0, 80, 64)) 
defineProperty("right_nacelle_fire_led", loadImage("fire_lamps.dds", 202, 0, 80, 64)) 
defineProperty("ru19_eng_fire_led", loadImage("fire_lamps.dds", 301, 0, 80, 64)) 
defineProperty("right_wing_fire_led", loadImage("fire_lamps.dds", 400, 0, 80, 64)) 


local left_wing_fire_light = get(fire_left_wing_lit) == 1
local left_nacelle_fire_light = get(fire_left_nacelle_lit) == 1
local right_nacelle_fire_light = get(fire_right_nacelle_lit) == 1
local ru19_fire_light = get(fire_ru19_lit) == 1
local right_wing_fire_light = get(fire_right_wing_lit) == 1
local left_eng_fire_light = get(fire_left_eng_lit) == 1
local right_eng_fire_light = get(fire_right_eng_lit) == 1
local left_eng_ext_ready_light = get(ext_left_ready_lit) == 1
local right_eng_ext_ready_light = get(ext_right_ready_lit) == 1
local first_turn_ext_light = get(ext_first_ready_lit) == 1
local second_turn_ext_light = get(ext_second_ready_lit) == 1

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


function update()
	
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(fire_main_switcher, 0)
		not_loaded = false
	end	
	
	left_wing_fire_light = get(fire_left_wing_lit) == 1
	left_nacelle_fire_light = get(fire_left_nacelle_lit) == 1
	right_nacelle_fire_light = get(fire_right_nacelle_lit) == 1
	ru19_fire_light = get(fire_ru19_lit) == 1
	right_wing_fire_light = get(fire_right_wing_lit) == 1
	left_eng_fire_light = get(fire_left_eng_lit) == 1
	right_eng_fire_light = get(fire_right_eng_lit) == 1
	left_eng_ext_ready_light = get(ext_left_ready_lit) == 1
	right_eng_ext_ready_light = get(ext_right_ready_lit) == 1
	first_turn_ext_light = get(ext_first_ready_lit) == 1
	second_turn_ext_light = get(ext_second_ready_lit) == 1
	
end




components = {
	
	-----------------------
	-- panel lights --
	-----------------------
	
	-- left wing fire
	textureLit {
		image = get(left_wing_fire_led),
		position = {1012, 566, 80, 64},
		visible = function()
			return left_wing_fire_light
		end,
	},

	-- left nacelle fire
	textureLit {
		image = get(left_nacelle_fire_led),
		position = {1114, 566, 80, 64},
		visible = function()
			return left_nacelle_fire_light
		end,
	},
	
	-- right nacelle fire
	textureLit {
		image = get(right_nacelle_fire_led),
		position = {1214, 566, 80, 64},
		visible = function()
			return right_nacelle_fire_light
		end,
	},

	-- ru19 fire
	textureLit {
		image = get(ru19_eng_fire_led),
		position = {1314, 566, 80, 64},
		visible = function()
			return ru19_fire_light
		end,
	},	

	
	-- right wing fire
	textureLit {
		image = get(right_wing_fire_led),
		position = {1413, 566, 80, 64},
		visible = function()
			return right_wing_fire_light
		end,
	},	
	
	-- left engine fire
	textureLit {
		image = get(red_led),
		position = {698, 254, 17, 17},
		visible = function()
			return left_eng_fire_light
		end,
	},
	
	-- right engine fire
	textureLit {
		image = get(red_led),
		position = {714, 254, 17, 17},
		visible = function()
			return right_eng_fire_light
		end,
	},

	-- left engine ext ready
	textureLit {
		image = get(yellow_small_led),
		position = {510, 381, 27, 27},
		visible = function()
			return left_eng_ext_ready_light
		end,
	},	
	
	-- right engine ext ready
	textureLit {
		image = get(yellow_small_led),
		position = {510, 327, 27, 27},
		visible = function()
			return right_eng_ext_ready_light
		end,
	},	
	
	-- first turn ext ready
	textureLit {
		image = get(yellow_small_led),
		position = {510, 275, 27, 27},
		visible = function()
			return first_turn_ext_light
		end,
	},		

	-- second turn ext ready
	textureLit {
		image = get(yellow_small_led),
		position = {537, 381, 27, 27},
		visible = function()
			return second_turn_ext_light
		end,
	},	
	
	----------------
	-- clickables --
	----------------
	
	-- main switcher
	-- switch up
	clickable {
        position = {1156, 261, 35, 17},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(fire_main_switcher)
			if not switcher_pushed and a < 1 then 
				playSample(switch_sound, 0) 
				a = a + 1
			end
			switcher_pushed = true
			set(fire_main_switcher, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	

	-- switch down
	clickable {
        position = {1156, 278, 35, 17},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(fire_main_switcher)
			if not switcher_pushed and a > -1 then 
				playSample(switch_sound, 0) 
				a = a - 1
			end
			switcher_pushed = true
			set(fire_main_switcher, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	
	
	-- left engine ext cap
	switch {
        position = { 503, 412, 30, 35},
        state = function()
            return get(fire_left_eng_ext_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(fire_left_eng_ext_cap) ~= 0 then
                set(fire_left_eng_ext_cap, 0)
            else
                set(fire_left_eng_ext_cap, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- left engine extinguisher
	switch {
        position = { 1095, 280, 18, 18},
        state = function()
            return get(fire_left_eng_ext) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(fire_left_eng_ext_cap) == 1 then
			playSample(btn_click, 0)
			switcher_pushed = true
			if get(fire_left_eng_ext) ~= 0 then
                set(fire_left_eng_ext, 0)
            else
                set(fire_left_eng_ext, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
 	
	-- right engine ext cap
	switch {
        position = { 534, 412, 30, 35},
        state = function()
            return get(fire_right_eng_ext_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(fire_right_eng_ext_cap) ~= 0 then
                set(fire_right_eng_ext_cap, 0)
            else
                set(fire_right_eng_ext_cap, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	

	-- right engine extinguisher
	switch {
        position = { 1115, 280, 18, 18},
        state = function()
            return get(fire_right_eng_ext) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(fire_right_eng_ext_cap) == 1 then
			playSample(btn_click, 0)
			switcher_pushed = true
			if get(fire_right_eng_ext) ~= 0 then
                set(fire_right_eng_ext, 0)
            else
                set(fire_right_eng_ext, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 	
	
	-- second turn ext cap
	switch {
        position = { 565, 412, 30, 35},
        state = function()
            return get(fire_second_ext_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(fire_second_ext_cap) ~= 0 then
                set(fire_second_ext_cap, 0)
            else
                set(fire_second_ext_cap, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 		
	
	-- second turn extinguisher
	switch {
        position = { 1134, 280, 18, 18},
        state = function()
            return get(fire_second_ext) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
       onMouseClick = function()
            if not switcher_pushed and get(fire_second_ext_cap) == 1 then
			playSample(btn_click, 0)
			switcher_pushed = true
			if get(fire_second_ext) ~= 0 then
                set(fire_second_ext, 0)
            else
                set(fire_second_ext, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	
	-- left wing button
	clickable {
        position = {1011, 553, 90, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fire_left_wing_btn, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(fire_left_wing_btn, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
    },

	-- left nacelle button
	clickable {
        position = {1105, 553, 90, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fire_left_nacelle_btn, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(fire_left_nacelle_btn, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
    },

	-- right nacelle button
	clickable {
        position = {1202, 553, 90, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fire_right_nacelle_btn, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(fire_right_nacelle_btn, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
    },

	-- RU19 button
	clickable {
        position = {1302, 553, 90, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fire_ru19_btn, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(fire_ru19_btn, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
    },

	-- right wing button
	clickable {
        position = {1402, 553, 90, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(fire_right_wing_btn, 1)
			if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp = function()
			set(fire_right_wing_btn, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end
    },







}

