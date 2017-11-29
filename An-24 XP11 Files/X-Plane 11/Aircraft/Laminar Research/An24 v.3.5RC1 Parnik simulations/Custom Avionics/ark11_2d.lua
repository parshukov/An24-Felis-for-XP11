

size = {505, 455}

defineProperty("dev_num", 0)
defineProperty("radio", globalPropertyi("sim/cockpit2/radios/actuators/adf1_frequency_hz"))
defineProperty("adf", globalPropertyf("sim/cockpit2/radios/indicators/adf1_relative_bearing_deg"))
defineProperty("fail", globalPropertyi("sim/operation/failures/rel_adf1"))

defineProperty("ark_need_freq", globalPropertyi("sim/custom/xap/An24_ark/ark1_need_freq"))

defineProperty("ark_band_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_band_need"))
defineProperty("ark_tune_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune_need"))
defineProperty("ark_fine_tune_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_fine_tune_need"))

defineProperty("audio_selection", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf1"))
defineProperty("cw_sw", globalPropertyi("sim/custom/xap/An24_ark/ark1_cw"))

defineProperty("button", globalPropertyi("sim/custom/xap/An24_ark/ark1_button"))
defineProperty("ark_mode", globalPropertyi("sim/custom/xap/An24_ark/ark1_mode"))
defineProperty("ark_band", globalPropertyi("sim/custom/xap/An24_ark/ark1_band"))
defineProperty("band_fix", globalPropertyi("sim/custom/xap/An24_ark/ark1_band_fix"))
defineProperty("ark_tune", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune"))
defineProperty("tune_fix", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune_fix"))
defineProperty("ark_fine_tune", globalPropertyi("sim/custom/xap/An24_ark/ark1_fine_tune"))
defineProperty("ant_sw", globalPropertyi("sim/custom/xap/An24_ark/ark1_ant_sw"))


-- images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("scale", loadImage("ark_scale.png", 0, 66, 1024, 190))
defineProperty("scale_plank", loadImage("ark_scale.png", 0, 0, 1, 65))
-- buttons
defineProperty("butP", loadImage("radio_panel_2d.dds", 2, 693, 30, 30))
defineProperty("but1", loadImage("radio_panel_2d.dds", 31, 693, 30, 30))
defineProperty("but2", loadImage("radio_panel_2d.dds", 60, 693, 30, 30))
defineProperty("but3", loadImage("radio_panel_2d.dds", 90, 693, 30, 30))
defineProperty("but4", loadImage("radio_panel_2d.dds", 120, 693, 30, 30))
defineProperty("but5", loadImage("radio_panel_2d.dds", 150, 693, 30, 30))
defineProperty("but6", loadImage("radio_panel_2d.dds", 180, 693, 30, 30))
defineProperty("but7", loadImage("radio_panel_2d.dds", 210, 693, 30, 30))
defineProperty("but8", loadImage("radio_panel_2d.dds", 240, 693, 30, 30))
defineProperty("but9", loadImage("radio_panel_2d.dds", 270, 693, 30, 30))
-- knobs
defineProperty("rot_switch", loadImage("rot_switch.dds"))
defineProperty("knob_close", loadImage("radio_panel_2d.dds", 0, 745, 116, 116))
defineProperty("knob_open", loadImage("radio_panel_2d.dds", 132, 745, 116, 116))
defineProperty("knob_simple", loadImage("radio_panel_2d.dds", 260, 745, 116, 116))
-- tumbler
defineProperty("tmb_left", loadImage("tumbler_left.dds"))
defineProperty("tmb_right", loadImage("tumbler_right.dds"))
defineProperty("tmb_ctr_hor", loadImage("tumbler_center_hor.dds"))

local button_pressed = 0  -- actual pressed button
local mode_angle = -90
local band_img
local tune_img
local band_angle = 0
local tune_angle = 0
local fine_angle = 0
local tumbler_img
local band_counter = get(ark_band_need) -- width of visible window area
local winWidth = 72 / 1024 -- height of one degrees in texture coord
local step = 160 / 950
local tune_pos = (0.036 - winWidth / 2) + step * (get(ark_tune_need)) / 29.09

function update()
	button_pressed = get(button)
	mode_angle = get(ark_mode) * 45 - 90
	if get(band_fix) == 0 then band_img = get(knob_close) else band_img = get(knob_open) end
	if get(tune_fix) == 0 then tune_img = get(knob_close) else tune_img = get(knob_open) end
	band_angle = get(ark_band) * 40 / 132.5 + 160
	tune_angle = -get(ark_tune) * 2.25 + 160
	fine_angle = -get(ark_fine_tune) - 20
	local tumbler = get(ant_sw)
	if tumbler == 0 then tumbler_img = get(tmb_ctr_hor)
	elseif tumbler == 1 then tumbler_img = get(tmb_right)
	else tumbler_img = get(tmb_left)
	end
	
	band_counter = get(ark_band_need)
	tune_pos = (0.036 - winWidth / 2) + step * (get(ark_tune_need)) / 29.09
	
end




-- width of visible window area
local winWidth = 72 / 1024

-- height of one degrees in texture coord
local step = 160 / 950



components = {
--[[
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,0.5},

	}, --]]

	----------------
	-- indicators --
	----------------
	
	-- band counter
	digitstape {
        position = { 113, 143, 50, 22};
        image = digitsImage;
        digits = 4;
		allowNonRound = true;
		showLeadingZeros = false;
        value = function() 
            return band_counter
        end;
    }; 
	
    -- tune
    tape {
        position = { 205, 310, 100, 140},
        image = get(scale),
        window = { winWidth, 1.0 },

        -- calculate pitch level
        scrollX = function()
            return tune_pos;
        end,
    },	
	
	-- scale plank
	texture {
		position = {254, 310, 2, 140},
		image = get(scale_plank),
	},
	
	-------------
	-- images --
	-------------
	-- P
	texture {
		position = {44, 234, 30, 30},
		image = get(butP),
		visible = function()
			return button_pressed ~= 0
		end
	},

	-- 1
	texture {
		position = {9, 209, 30, 30},
		image = get(but1),
		visible = function()
			return button_pressed ~= 1
		end
	},

	-- 2
	texture {
		position = {9, 164, 30, 30},
		image = get(but2),
		visible = function()
			return button_pressed ~= 2
		end
	},

	-- 3
	texture {
		position = {9, 119, 30, 30},
		image = get(but3),
		visible = function()
			return button_pressed ~= 3
		end
	},

	-- 4
	texture {
		position = {9, 74, 30, 30},
		image = get(but4),
		visible = function()
			return button_pressed ~= 4
		end
	},
	
	-- 5
	texture {
		position = {9, 25, 30, 30},
		image = get(but5),
		visible = function()
			return button_pressed ~= 5
		end
	},
		
	-- 6
	texture {
		position = {44, 50, 30, 30},
		image = get(but6),
		visible = function()
			return button_pressed ~= 6
		end
	},

	-- 7
	texture {
		position = {44, 100, 30, 30},
		image = get(but7),
		visible = function()
			return button_pressed ~= 7
		end
	},

	-- 8
	texture {
		position = {44, 145, 30, 30},
		image = get(but8),
		visible = function()
			return button_pressed ~= 8
		end
	},
	
	-- 9
	texture {
		position = {44, 190, 30, 30},
		image = get(but9),
		visible = function()
			return button_pressed ~= 9
		end
	},	
	
	-- mode switcher
	needle {
		position = {25, 340, 80, 80},
		image = get(rot_switch),
		angle = function()
			return mode_angle
		end
	},	
	
	-- band switcher
	needle {
		position = {82, 33, 116, 116},
		image = function()
			return band_img
		end,
		angle = function()
			return band_angle
		end
	},	
	
	-- tune switcher
	needle {
		position = {198, 205, 116, 116},
		image = function()
			return tune_img
		end,
		angle = function()
			return tune_angle
		end
	},	
	
	-- tune switcher
	needle {
		position = {380, 325, 116, 116},
		image = get(knob_simple),
		angle = function()
			return fine_angle
		end
	},		
	
	-- antenna switcher
	texture {
		position = {342, 45, 100, 30},
		image = function()
			return tumbler_img
		end,
	},	
	
	-------------
	-- buttons --
	-------------
	-- P
	clickable {
       position = { 40, 230, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            button_pressed = 0
			set(button, button_pressed)
            return true
        end
    }, 

	-- 1
	clickable {
       position = { 5, 205, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 1 then
            	button_pressed = 1
				set(button, button_pressed)
            end
            return true
        end
    }, 

	-- 2
	clickable {
       position = { 5, 160, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 2 then
            	button_pressed = 2
				set(button, button_pressed)
            end
            return true
        end
    },	

	-- 3
	clickable {
       position = { 5, 115, 35, 35  },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 3 then
            	button_pressed = 3
				set(button, button_pressed)
            end
            return true
        end
    },	

	-- 4
	clickable {
       position = { 5, 70, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 4 then
            	button_pressed = 4
				set(button, button_pressed)
            end
            return true
        end
    },
	
	-- 5
	clickable {
       position = { 5, 25, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 5 then
            	button_pressed = 5
				set(button, button_pressed)
            end
            return true
        end
    },	
	
	-- 6
	clickable {
       position = {  40, 50, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 6 then
            	button_pressed = 6
				set(button, button_pressed)
            end
            return true
        end
    },	
		
	-- 7
	clickable {
       position = {  40, 95, 35, 35  },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 7 then
            	button_pressed = 7
				set(button, button_pressed)
            end
            return true
        end
    },

	-- 8
	clickable {
       position = { 40, 140, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 8 then
            	button_pressed = 8
				set(button, button_pressed)
            end
            return true
        end
    },

	-- 9
	clickable {
       position = { 40, 185, 35, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 9 then
            	button_pressed = 9
				set(button, button_pressed)
            end
            return true
        end
    },	
	
	----------------
	-- mode --
	--------------
	
	rotary {
        position = { 25, 340, 80, 70},
        value = ark_mode;
        adjuster = function(v)
            if 0 > v then
                v = 0;
            elseif 4 < v then
                v = 4
            end
			return v
        end;
    },
	
	-----------------
	-- band knob --
	-----------------
	-- rotate left
	clickable {
       position = {90, 40, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new band
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			
			if B == 120 then B = 1180
			elseif B == 280 or B == 580 or B == 880 or B == 1180 then
				B = B - 160
			else B = B - 140
			end
			-- save new freq
			set(ark_band_need, B)
			set(ark_need_freq, B + T)
			
			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {140, 40, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new band
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			
			if B == 1180 then B = 120
			elseif B == 120 or B == 420 or B == 720 or B == 1020 then
				B = B + 160
			else B = B + 140
			end
			-- save new freq
			set(ark_band_need, B)
			set(ark_need_freq, B+T)

			return true
        end
    },
	

	-----------------
	-- tune knob --
	-----------------
	-- rotate left
	clickable {
       position = {205, 210, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			T = T + 4
			local limit = 160
			--if B == 280 or B == 580 or B == 880 or B == 1180 then limit = 140 end
			--if T > limit then T = limit end
			if T > 160 then T = 160 end
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)

			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {255, 210, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			T = T - 4
			if T < 0 then T = 0 end
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)

			return true
        end
    },
	
	-----------------
	-- fine tune knob --
	-----------------
	-- rotate left
	clickable {
       position = {390, 330, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)			
			local FT = get(ark_fine_tune)
			T = T + 1
			if T > 160 then T = 160
			else FT = FT + 5
			end
			-- save new freq and fine tune
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			set(ark_fine_tune, FT)

			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {440, 330, 50, 100},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)			
			local FT = get(ark_fine_tune)
			T = T - 1
			if T < 0 then T = 0
			else FT = FT - 5
			end
			-- save new freq and fine tune
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			set(ark_fine_tune, FT)			

			return true
        end
    },
	
	
	---------------------
	-- safe freq fixes --
	---------------------

    -- save switch band
    switch {
        position = { 90, 160, 100, 50},
        state = function()
            return get(band_fix) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(band_fix) ~= 0 then
                set(band_fix, 0)
            else
                set(band_fix, 1)
            end
            return true;
        end
    },	
	
    -- save switch tune
    switch {
        position = { 205, 160, 100, 50},
        state = function()
            return get(tune_fix) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(tune_fix) ~= 0 then
                set(tune_fix, 0)
            else
                set(tune_fix, 1)
            end
            return true;
        end
    },	
	
	-- ramka tumbler
	-- rotate right
	clickable {
       position = {395, 35, 50, 50},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			set(ant_sw, 1)
			return true
        end,
		onMouseUp = function()
			set(ant_sw, 0)
			return true
		end
    },
	
	-- rotate left
	clickable {
       position = {340, 35, 50, 50},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			set(ant_sw, -1)
			return true
        end,
		onMouseUp = function()
			set(ant_sw, 0)
			return true
		end
    },
	
	
	
}


