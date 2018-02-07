size = {825, 430}

-- define properties
-- custom switchers for anti-ice
defineProperty("pitot_1_sw", globalPropertyi("sim/custom/xap/An24_ice/pitot1_sw"))   -- pitot heat 1
defineProperty("pitot_2_sw", globalPropertyi("sim/custom/xap/An24_ice/pitot2_sw"))   -- pitot heat 2
defineProperty("prop_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/prop_ht_sw"))   -- propeller heat
defineProperty("wind_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/window_ht_sw"))   -- window heat
defineProperty("wing_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/wing_ht_sw"))  -- on/off wing heat
defineProperty("engine_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/engine_ht_sw"))  -- on/off engine heat
defineProperty("ice_detect_sw", globalPropertyi("sim/custom/xap/An24_ice/rio_sw"))  -- on/off ice detection
defineProperty("aoa_ht_sw", globalPropertyi("sim/custom/xap/An24_ice/aoa_ht_sw"))  -- on/off AOA heat

defineProperty("wing_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/wing_heat_lit"))  -- for 2D panel
defineProperty("engine_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/engine_heat_lit"))  -- for 2D panel
defineProperty("prop_left_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/prop_left_lit"))  -- for 2D panel
defineProperty("prop_right_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/prop_right_lit"))  -- for 2D panel
defineProperty("pitot1_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot1_lit"))  -- for 2D panel
defineProperty("pitot2_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot2_lit"))  -- for 2D panel
defineProperty("aoa_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/aoa_heat_lit"))  -- for 2D panel

defineProperty("pitot1_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot1_test_lit"))  -- for 2D panel
defineProperty("pitot2_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/pitot2_test_lit"))  -- for 2D panel
defineProperty("aoa_heat_test_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/aoa_heat_test_lit"))  -- for 2D panel
defineProperty("rio_heat_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/rio_heat_lit"))  -- for 2D panel

defineProperty("ice_left_eng_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/ice_left_eng_lit"))  -- for 2D panel
defineProperty("ice_right_eng_lit_2d", globalPropertyi("sim/custom/xap/An24_ice/ice_right_eng_lit"))  -- for 2D panel
defineProperty("thermo_angle_2d", globalPropertyf("sim/custom/xap/An24_ice/thermo_angle"))  -- for 2D panel

defineProperty("test_btn", globalPropertyi("sim/custom/xap/An24_ice/test_btn"))  -- for 2D panel
-- GPK panel
defineProperty("lat", globalPropertyf("sim/custom/xap/An24_gauges/GPK_lat")) -- latitude position on panel
defineProperty("lat_angle", globalPropertyf("sim/custom/xap/An24_gauges/GPK_lat_rotary")) -- angle for lat rotary
defineProperty("corr_switcher", globalPropertyi("sim/custom/xap/An24_gauges/GPK_corr_sw")) -- correction switcher ON/OFF
defineProperty("corr_rot", globalPropertyi("sim/custom/xap/An24_gauges/GPK_corr_rot")) -- correction rotary

-- skv
defineProperty("bleed1_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed1_sw")) 
defineProperty("bleed2_sw", globalPropertyi("sim/custom/xap/An24_skv/bleed2_sw")) 

defineProperty("right_subpanel", globalPropertyi("sim/custom/xap/An24_panels/right_subpanel"))

-- images
defineProperty("background", loadImage("right_panel_2d.dds", 0, 0, size[1], size[2]))
defineProperty("rot_switch", loadImage("rot_switch.dds"))
defineProperty("lat_rotary_img", loadImage("right_panel_2d.dds", 856, 8, 98, 98))


defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 
defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))

defineProperty("prop_up_img", loadImage("right_panel_2d.dds", 831, 117, 66, 66))
defineProperty("prop_ctr_img", loadImage("right_panel_2d.dds", 831, 188, 66, 66))
defineProperty("prop_dn_img", loadImage("right_panel_2d.dds", 831, 259, 66, 66))

local termo_angle = 0
local wing_heat_lit = false
local engine_heat_lit = false
local prop_heat_lit = false
local prop_left_lit = false
local prop_right_lit = false
local pitot1_lit = false
local pitot2_lit = false
local aoa_heat_lit = false

local pitot1_test_lit = false
local pitot2_test_lit = false
local aoa_heat_test_lit = false
local rio_heat_lit = false

local ice_left_eng_lit = false
local ice_right_eng_lit = false


local plane_must_heat = false

local lat_rotary_angle = 0

function update()
	termo_angle = get(thermo_angle_2d)

	wing_heat_lit = get(wing_heat_lit_2d) == 1
	engine_heat_lit = get(engine_heat_lit_2d) == 1
	prop_left_lit = get(prop_left_lit_2d) == 1
	prop_right_lit = get(prop_right_lit_2d) == 1
	pitot1_lit = get(pitot1_lit_2d) == 1
	pitot2_lit = get(pitot2_lit_2d) == 1
	aoa_heat_lit = get(aoa_heat_lit_2d) == 1

	pitot1_test_lit = get(pitot1_test_lit_2d) == 1
	pitot2_test_lit = get(pitot2_test_lit_2d) == 1
	aoa_heat_test_lit = get(aoa_heat_test_lit_2d) == 1
	rio_heat_lit = get(rio_heat_lit_2d) == 1

	ice_left_eng_lit = get(ice_left_eng_lit_2d) == 1
	ice_right_eng_lit = get(ice_right_eng_lit_2d) == 1
	
	lat_rotary_angle = -get(lat_angle) * 290	
	
end


components = {

	-- background
	texture {
		image = get(background),
		position = {0, 0, size[1], size[2]},

	},	

	-- gauges --
	-- thermoneter
	needle { 
		image = get(needles_1),
		position = {315, 285, 110, 110},
		angle = function()
			return termo_angle
		end,	
	},

	-- black cap
	texture{
	    position = {352, 320, 40, 40},
        image = get(black_cap),
	},

	-----------------
	-- lights --
	-----------------

	-- wing heat
	textureLit {
		image = get(green_led),
		position = {231, 226, 30, 30},
		visible = function()
			return wing_heat_lit
		end,
	},	
	textureLit {
		image = get(green_led),
		position = {534, 226, 30, 30},
		visible = function()
			return wing_heat_lit
		end,
	},	

	-- engine heat
	textureLit {
		image = get(green_led),
		position = {295, 226, 30, 30},
		visible = function()
			return engine_heat_lit
		end,
	},
	textureLit {
		image = get(green_led),
		position = {478, 226, 30, 30},
		visible = function()
			return engine_heat_lit
		end,
	},	
	
	-- prop left
	textureLit {
		image = get(green_led),
		position = {359, 226, 30, 30},
		visible = function()
			return prop_left_lit
		end,
	},	

	-- prop right
	textureLit {
		image = get(green_led),
		position = {419, 226, 30, 30},
		visible = function()
			return prop_right_lit
		end,
	},
	
	-- pitot left light
	textureLit {
		image = get(green_led),
		position = {631, 131, 19, 19},
		visible = function()
			return pitot1_lit
		end,
	},		
	
	-- pitot left test light
	textureLit {
		image = get(green_led),
		position = {614, 9, 19, 19},
		visible = function()
			return pitot1_test_lit
		end,
	},		
	textureLit {
		image = get(green_led),
		position = {645, 9, 19, 19},
		visible = function()
			return pitot1_test_lit
		end,
	},	
	
	-- pitot right light
	textureLit {
		image = get(green_led),
		position = {755, 131, 19, 19},
		visible = function()
			return pitot2_lit
		end,
	},	

	-- pitot right test light
	textureLit {
		image = get(green_led),
		position = {736, 9, 19, 19},
		visible = function()
			return pitot2_test_lit
		end,
	},	
	textureLit {
		image = get(green_led),
		position = {769, 9, 19, 19},
		visible = function()
			return pitot2_test_lit
		end,
	},	

	-- AOA light
	textureLit {
		image = get(green_led),
		position = {692, 131, 19, 19},
		visible = function()
			return aoa_heat_lit
		end,
	},		
	
	-- AOA test light
	textureLit {
		image = get(green_led),
		position = {692, 9, 19, 19},
		visible = function()
			return aoa_heat_test_lit
		end,
	},	
	
	-- RIO heat light
	textureLit {
		image = get(green_led),
		position = {89, 301, 22, 22},
		visible = function()
			return rio_heat_lit
		end,
	},
	textureLit {
		image = get(green_led),
		position = {135, 301, 22, 22},
		visible = function()
			return rio_heat_lit
		end,
	},

	-- left engine in ice light
	textureLit {
		image = get(red_led),
		position = {198, 283, 30, 30},
		visible = function()
			return ice_left_eng_lit
		end,
	},
	
	-- right engine in ice light
	textureLit {
		image = get(red_led),
		position = {255, 283, 30, 30},
		visible = function()
			return ice_right_eng_lit
		end,
	},
	
	--------------------
	-- clickables --
	--------------------

	-- test button
    clickable {
        position = {455, 275, 40, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(test_btn, 1)
			return true
		end,
		onMouseUp = function()
			set(test_btn, 0)
			return true
		end,

    },	
	
	-- windows heat switch
    switch {
        position = { 10, 5, 25, 80},
        state = function()
            return get(wind_ht_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(wind_ht_sw) ~= 0 then
                set(wind_ht_sw, 0)
            else
                set(wind_ht_sw, 1)
            end
            return true;
        end
    }, 
    switch {
        position = { 85, 5, 25, 80},
        state = function()
            return get(wind_ht_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(wind_ht_sw) ~= 0 then
                set(wind_ht_sw, 0)
            else
                set(wind_ht_sw, 1)
            end
            return true;
        end
    }, 

	-- engines heat switch
    switch {
        position = { 177, 5, 25, 80},
        state = function()
            return get(engine_ht_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(engine_ht_sw) ~= 0 then
                set(engine_ht_sw, 0)
            else
                set(engine_ht_sw, 1)
            end
            return true;
        end
    },
    switch {
        position = { 250, 5, 25, 80},
        state = function()
            return get(engine_ht_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(engine_ht_sw) ~= 0 then
                set(engine_ht_sw, 0)
            else
                set(engine_ht_sw, 1)
            end
            return true;
        end
    },	
	
	-- images
	texture{
		position = {345, 5, 25, 80},
		image = function()
			local a = get(wing_ht_sw)
			if a == 1 then return get(tmb_dn)
			elseif a == -1 then return get(tmb_up)
			else return get(tmb_ctr) end
		end,
	},	
	texture{
		position = {395, 5, 25, 80},
		image = function()
			local a = get(wing_ht_sw)
			if a == 1 then return get(tmb_dn)
			elseif a == -1 then return get(tmb_up)
			else return get(tmb_ctr) end
		end,
	},			
	-- wing heat up
    clickable {
        position = {345, 45, 75, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(wing_ht_sw) - 1
			if a < -1 then a  = -1 end
			set(wing_ht_sw, a)
			return true
		end,
		
    },	
	-- wing heat down
    clickable {
        position = {345, 5, 75, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(wing_ht_sw) + 1
			if a > 1 then a  = 1 end
			set(wing_ht_sw, a)
			return true
		end,
		
    },	
	
	-- images
	texture{
		position = {495, 15, 60, 60},
		image = function()
			local a = get(prop_ht_sw)
			if a == 1 then return get(prop_up_img)
			elseif a == -1 then return get(prop_dn_img)
			else return get(prop_ctr_img) end
		end,
	},	
	-- prop heat down
    clickable {
        position = {495, 0, 60, 45},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(prop_ht_sw) - 1
			if a < -1 then a  = -1 end
			set(prop_ht_sw, a)
			return true
		end,
		
    },

	-- prop heat up
    clickable {
        position = {495, 45, 60, 45},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(prop_ht_sw) + 1
			if a > 1 then a  = 1 end
			set(prop_ht_sw, a)
			return true
		end,
		
    },	

	-- images
	texture{
		position = {87, 182, 25, 80},
		image = function()
			local a = get(ice_detect_sw)
			if a == 1 then return get(tmb_up)
			elseif a == -1 then return get(tmb_dn)
			else return get(tmb_ctr) end
		end,
	},	
	texture{
		position = {132, 182, 25, 80},
		image = function()
			local a = get(ice_detect_sw)
			if a == 1 then return get(tmb_up)
			elseif a == -1 then return get(tmb_dn)
			else return get(tmb_ctr) end
		end,
	},		
	-- ice detect down
    clickable {
        position = {80, 180, 80, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ice_detect_sw) - 1
			if a < -1 then a  = -1 end
			set(ice_detect_sw, a)
			return true
		end,
		
    },

	-- ice detect up
    clickable {
        position = {80, 220, 80, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(ice_detect_sw) + 1
			if a > 1 then a  = 1 end
			set(ice_detect_sw, a)
			return true
		end,
		
    },

	-- images
	texture{
		position = {630, 40, 25, 80},
		image = function()
			local a = get(pitot_1_sw)
			if a == 1 then return get(tmb_up)
			elseif a == -1 then return get(tmb_dn)
			else return get(tmb_ctr) end
		end,
	},

	texture{
		position = {690, 40, 25, 80},
		image = function()
			local a = get(aoa_ht_sw)
			if a == 1 then return get(tmb_up)
			elseif a == -1 then return get(tmb_dn)
			else return get(tmb_ctr) end
		end,
	},

	texture{
		position = {750, 40, 25, 80},
		image = function()
			local a = get(pitot_2_sw)
			if a == 1 then return get(tmb_up)
			elseif a == -1 then return get(tmb_dn)
			else return get(tmb_ctr) end
		end,
	},
	
	-- pitot1 heat down
    clickable {
        position = {625, 40, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_1_sw) - 1
			if a < -1 then a  = -1 end
			set(pitot_1_sw, a)
			return true
		end,
		
    },

	-- pitot1 heat up
    clickable {
        position = {625, 80, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_1_sw) + 1
			if a > 1 then a  = 1 end
			set(pitot_1_sw, a)
			return true
		end,
		
    },	
	
	-- aoa sensor heat down
    clickable {
        position = {685, 40, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(aoa_ht_sw) - 1
			if a < -1 then a  = -1 end
			set(aoa_ht_sw, a)
			return true
		end,
		
    },

	-- aoa sensor hean up
    clickable {
        position = {685, 80, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(aoa_ht_sw) + 1
			if a > 1 then a  = 1 end
			set(aoa_ht_sw, a)
			return true
		end,
		
    },		
	
	-- pitot heat down
    clickable {
        position = {745, 40, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_2_sw) - 1
			if a < -1 then a  = -1 end
			set(pitot_2_sw, a)
			return true
		end,
		
    },

	-- pitot heat up
    clickable {
        position = {745, 80, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			local a = get(pitot_2_sw) + 1
			if a > 1 then a  = 1 end
			set(pitot_2_sw, a)
			return true
		end,
		
    },

    -- system1 switch
    switch {
        position = {665, 323, 25, 80 },
        state = function()
            return get(bleed1_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(bleed1_sw) ~= 0 then
                set(bleed1_sw, 0)
            else
                set(bleed1_sw, 1)
            end
            return true;
        end
    },

    -- system2 switch
    switch {
        position = {743, 323, 25, 80},
        state = function()
            return get(bleed2_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(bleed2_sw) ~= 0 then
                set(bleed2_sw, 0)
            else
                set(bleed2_sw, 1)
            end
            return true;
        end
    },	
	
	-- fake switcher
	texture {
		 position = {602, 323, 25, 80 },
		 image = get(tmb_up),
	},

	-- correction turn switch
	needle {
		position = {602, 215, 80, 80},
		image = get(rot_switch),
		angle = function()
			return get(corr_rot) * 30
		end
	},

	-- clickable to turn left correction rotary
	clickable {
        position = {600, 220, 40, 60},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(corr_rot) - 1
			if a < -5 then a = -5 end
			set(corr_rot, a)
		end,
    },

	-- clickable to turn right correction rotary
	clickable {
        position = {640, 220, 40, 60},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(corr_rot) + 1
			if a > 5 then a = 5 end
			set(corr_rot, a)
		end
    },
	
	-- correction power switcher
    switch {
        position = { 690, 245, 25, 80},
        state = function()
            return get(corr_switcher) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(corr_switcher) ~= 0 then
                set(corr_switcher, 0)
            else
                set(corr_switcher, 1)
            end 
            return true;
        end 
    }, 	
	
	-- lat switch rotary
	needle {
		position = {716, 205, 98, 98},
		image = get(lat_rotary_img),
		angle = function()
			return lat_rotary_angle
		end
	},

	-- clickable to turn left latitude rotary
	clickable {
        position = {720, 210, 40, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(lat) + 5
			if a > 90 then a = 90 end
			set(lat, a)
			set(lat_angle, math.sin(math.rad(a)))
		end,
    },
	-- clickable to turn right latitude rotary
	clickable {
        position = {770, 210, 40, 90},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(lat) - 5
			if a < 0 then a = 0 end
			set(lat, a)
			set(lat_angle, math.sin(math.rad(a)))
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
        set(right_subpanel, 0 )
		return true
        end
    },	

}