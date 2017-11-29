size = {512, 512}

-- define property table
defineProperty("left_eng_main", globalPropertyi("sim/custom/xap/An24_covers/left_eng_main"))  -- left engine main cover
defineProperty("left_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/left_eng_ext"))  -- left engine exhaust cover
defineProperty("right_eng_main", globalPropertyi("sim/custom/xap/An24_covers/right_eng_main"))  -- right engine main cover
defineProperty("right_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/right_eng_ext"))  -- right engine exhaust cover
defineProperty("ru19_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/ru19_eng_ext"))  -- ru19 engine exhaust cover
defineProperty("antiice_left", globalPropertyi("sim/custom/xap/An24_covers/antiice_left"))  -- left anti-ice detector cover
defineProperty("antiice_right", globalPropertyi("sim/custom/xap/An24_covers/antiice_right"))  -- right anti-ice detector cover
defineProperty("rockets", globalPropertyi("sim/custom/xap/An24_covers/rockets"))  -- rockets cover
defineProperty("pitot_1", globalPropertyi("sim/custom/xap/An24_covers/pitot_1"))  -- pitot 1
defineProperty("pitot_2", globalPropertyi("sim/custom/xap/An24_covers/pitot_2"))  -- pitot 2
defineProperty("pitot_3", globalPropertyi("sim/custom/xap/An24_covers/pitot_3"))  -- pitot 3
defineProperty("grounding", globalPropertyi("sim/custom/xap/An24_covers/grounding"))  -- grounding wire
defineProperty("gear_blocks", globalPropertyi("sim/custom/xap/An24_covers/gear_blocks"))  -- gear blocks

defineProperty("ground_available", globalPropertyi("sim/custom/xap/An24_power/ground_available"))

--defineProperty("cabin_hatch", globalPropertyi("parshukovedition/lukbesson_switch"))  -- open/close cabin hatch
defineProperty("emerg_hatch1", globalPropertyi("sim/cockpit2/switches/custom_slider_on[8]"))  -- open/close emerg_hatch1
defineProperty("emerg_hatch2", globalPropertyi("sim/cockpit2/switches/custom_slider_on[9]"))  -- open/close emerg_hatch2
defineProperty("cargo_hatch1", globalPropertyi("sim/cockpit2/switches/custom_slider_on[4]"))  -- open/close cargo_hatch1
defineProperty("cargo_hatch2", globalPropertyi("sim/cockpit2/switches/custom_slider_on[6]"))  -- open/close cargo_hatch2
defineProperty("pax_door", globalPropertyi("sim/cockpit2/switches/custom_slider_on[5]"))  -- open/close pax_door
defineProperty("pax_ladder", globalPropertyi("sim/cockpit2/switches/custom_slider_on[7]"))  -- open/close pax_ladder

defineProperty("ground_sound", globalPropertyi("autumnsky/sound/gndsound"))

-- status
defineProperty("cabin_press", globalPropertyf("sim/cockpit/pressure/cabin_pressure_differential_psi"))
defineProperty("GS", globalPropertyf("sim/flightmodel/position/groundspeed"))  -- ground speed

--defineProperty("cabin_hatch_stat", globalPropertyf("parshukovedition/lukbesson"))  -- open/close cabin hatch
defineProperty("emerg_hatch1_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[8]"))  -- open/close emerg_hatch1
defineProperty("emerg_hatch2_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[9]"))  -- open/close emerg_hatch2
defineProperty("cargo_hatch1_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[4]"))  -- open/close cargo_hatch1
defineProperty("cargo_hatch2_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[6]"))  -- open/close cargo_hatch2
defineProperty("pax_door_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[5]"))  -- open/close pax_door
defineProperty("pax_ladder_stat", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[7]"))  -- open/close pax_ladder

defineProperty("service_subpanel", globalPropertyi("sim/custom/xap/An24_panels/service_subpanel"))

-- images
defineProperty("background", loadImage("ground_service.dds", 0, 0, size[1], size[2])) 
defineProperty("yellow", loadImage("ground_service.dds", 128, 486, 22, 22))
defineProperty("green", loadImage("ground_service.dds", 362, 487, 22, 22)) 
defineProperty("empty", loadImage("ground_service.dds", 0, 0, 1, 1)) 

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

 --Time Counter for sound FMOD
defineProperty("time_sim", globalPropertyf("sim/time/total_running_time_sec"))
--defineProperty("time_sim2", globalPropertyf("sim/time/total_running_time_sec"))
local last_time = 0
local cur_time = 0
local last_time2 = 0
local cur_time2 = 0
local check = 0
local checksound = 0
local time_counter = 0
local coeff_time = 1
local not_loaded = true


local door_can_open = true
local acf_is_moving = false

--local cabin_hatch_img = get(green)
local emerg_hatch1_img = get(green)
local emerg_hatch2_img = get(green)
local cargo_hatch1_img = get(green)
local cargo_hatch2_img = get(green)
local pax_door_img = get(green)
local pax_ladder_img = get(green)
local gnd_av_img = get(empty)
local fps_act=0



function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	fps_act=1/get(frame_time)
	if  fps_act > 26 then
		coeff_time = 1
	else
		coeff_time = 0.025/get(frame_time)
	end
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
			set(left_eng_main, 0)
			set(left_eng_ext, 0)
			set(right_eng_main, 0)
			set(right_eng_ext, 0)
			set(ru19_eng_ext, 0)
			set(antiice_left, 0)
			set(antiice_right, 0)
			set(rockets, 0)
			set(pitot_1, 0)
			set(pitot_2, 0)
			set(pitot_3, 0)
			set(grounding, 0)
			set(gear_blocks, 0)
			not_loaded = false
	end
	
	
	
	local press = get(cabin_press) * 0.07030696  -- pressure in kg/cm2
	door_can_open = press < 0.2
	local ground_speed = get(GS)
	acf_is_moving = ground_speed > 0.2
	
	if acf_is_moving then
		set(grounding, 1)
		set(gear_blocks, 1)
		set(ground_available, 0)
		gnd_av_img = get(empty)
	end
	
	-- cabin hatch status lights
	--local cabin_hatch_status = get(cabin_hatch_stat)
	--if cabin_hatch_status < 0.05 then cabin_hatch_img = get(green)
	--elseif cabin_hatch_status > 0.95 then cabin_hatch_img = get(empty)
	--else cabin_hatch_img = get(yellow) end
	
	-- emerg hatch 1 status lights
	local emerg_hatch1_status = get(emerg_hatch1_stat)
	if emerg_hatch1_status < 0.05 then emerg_hatch1_img = get(green)
	elseif emerg_hatch1_status > 0.95 then emerg_hatch1_img = get(empty)
	else emerg_hatch1_img = get(yellow) end
	
	-- emerg hatch 2 status lights
	local emerg_hatch2_status = get(emerg_hatch2_stat)
	if emerg_hatch2_status < 0.05 then emerg_hatch2_img = get(green)
	elseif emerg_hatch2_status > 0.95 then emerg_hatch2_img = get(empty)
	else emerg_hatch2_img = get(yellow) end	
	
	-- cargo hatch 1 status lights
	local cargo_hatch1_status = get(cargo_hatch1_stat)
	if cargo_hatch1_status < 0.05 then cargo_hatch1_img = get(green)
	elseif cargo_hatch1_status > 0.95 then cargo_hatch1_img = get(empty)
	else cargo_hatch1_img = get(yellow) end
	
	-- cargo hatch 2 status lights
	local cargo_hatch2_status = get(cargo_hatch2_stat)
	if cargo_hatch2_status < 0.05 then cargo_hatch2_img = get(green)
	elseif cargo_hatch2_status > 0.95 then cargo_hatch2_img = get(empty)
	else cargo_hatch2_img = get(yellow) end		
	
	-- pax door status lights
	local pax_door_status = get(pax_door_stat)
	if pax_door_status < 0.05 then pax_door_img = get(green)
	elseif pax_door_status > 0.95 then pax_door_img = get(empty)
	else pax_door_img = get(yellow) end	

	-- pax ladder status lights
	local pax_ladder_status = get(pax_ladder_stat)
	if pax_ladder_status < 0.05 then pax_ladder_img = get(green)
	elseif pax_ladder_status > 0.95 then pax_ladder_img = get(empty)
	else pax_ladder_img = get(yellow) end		
	

		   
			    if get(ground_available) == 4 then
			    if checksound == 0 then checksound = 1 gnd_av_img = get(yellow) cur_time2 = get(time_sim) + 8 * coeff_time set(ground_sound,4) end
				if get(time_sim) > cur_time2 then set(ground_available, 2) checksound = 0 end 
				end
				
				if get(ground_available) == 5 then
				if checksound == 0 then gnd_av_img = get(yellow) cur_time2 = get(time_sim) + 8 * coeff_time set(ground_sound,5) checksound = 1 end
				if get(time_sim) > cur_time2 then	set(ground_available, 3) checksound = 0 end
				end
	
	    --Zapusk APA
                if get(ground_available) == 2 then 
					if check == 0 then
						last_time = get(time_sim)
						cur_time = last_time + 9 * coeff_time
						check= 1
					end
					if get(time_sim) > cur_time then
						set(ground_available, 1)
						check=0
						gnd_av_img = get(green)
					end
				end
	    -- Stop APA			
                if get(ground_available) == 3 then
                if check == 0 then last_time = get(time_sim) cur_time = last_time + 9 * coeff_time check= 1 end
				if get(time_sim) > cur_time then set(ground_available, 0) check=0 gnd_av_img = get(empty) end
                end
end

components = {
	
	-- background image
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0.3,0.3,0.3,0.5},
	},
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(background)
	},
	
	-- cabin hatch
	--texture {
	--	position = { 240, 428, 30, 30 },
	--	image = function()
	--		return cabin_hatch_img
	--	end,
	--},
	
	-- emerg hatch 1
	texture {
		position = { 205, 338, 30, 30 },
		image = function()
			return emerg_hatch1_img
		end,
	},	
	
	-- emerg hatch 2
	texture {
		position = { 275, 220, 30, 30 },
		image = function()
			return emerg_hatch2_img
		end,
	},	
	
	-- cargo hatch 1
	texture {
		position = { 277, 350, 30, 30 },
		image = function()
			return cargo_hatch1_img
		end,
	},	
	
	-- cargo hatch 2
	texture {
		position = { 273, 110, 30, 30 },
		image = function()
			return cargo_hatch2_img
		end,
	},		
	
	-- pax door
	texture {
		position = { 205, 170, 30, 30 },
		image = function()
			return pax_door_img
		end,
	},		
	
	-- pax ladder
	texture {
		position = { 205, 140, 30, 30 },
		image = function()
			return pax_ladder_img
		end,
	},	
	
	texture {
		position = { 315, 330, 30, 30 },
		image = function()
			return gnd_av_img
		end,
	},		
	
	
	
	------------------
	-- switchers --
	------------------
	
    -- left engine cap
    switch {
        position = { 145, 370, 30, 30 },
        state = function()
            return get(left_eng_main) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(left_eng_main) ~= 0 then
				set(left_eng_main, 0)
			else
				set(left_eng_main, 1)
			end
            return true;
        end
    },

    -- left engine ext cap
    switch {
        position = { 140, 235, 30, 30 },
        state = function()
            return get(left_eng_ext) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(left_eng_ext) ~= 0 then
				set(left_eng_ext, 0)
			else
				set(left_eng_ext, 1)
			end
            return true;
        end
    },

    -- right engine cap
    switch {
        position = { 335, 370, 30, 30 },
        state = function()
            return get(right_eng_main) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(right_eng_main) ~= 0 then
				set(right_eng_main, 0)
			else
				set(right_eng_main, 1)
			end
            return true;
        end
    },

    -- right engine ext cap
    switch {
        position = { 337, 235, 30, 30 },
        state = function()
            return get(right_eng_ext) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(right_eng_ext) ~= 0 then
				set(right_eng_ext, 0)
			else
				set(right_eng_ext, 1)
			end
            return true;
        end
    },
	
    -- RU-19 ext cap
    switch {
        position = { 328, 205, 30, 30 },
        state = function()
            return get(ru19_eng_ext) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(ru19_eng_ext) ~= 0 then
				set(ru19_eng_ext, 0)
			else
				set(ru19_eng_ext, 1)
			end
            return true;
        end
    },	
	
	-- anti-ice left
    switch {
        position = { 220, 475, 30, 30 },
        state = function()
            return get(antiice_left) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(antiice_left) ~= 0 then
				set(antiice_left, 0)
			else
				set(antiice_left, 1)
			end
            return true;
        end
    },	
	
	-- anti-ice right
    switch {
        position = { 260, 475, 30, 30 },
        state = function()
            return get(antiice_right) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(antiice_right) ~= 0 then
				set(antiice_right, 0)
			else
				set(antiice_right, 1)
			end
            return true;
        end
    },	
		
	-- Rockets cap
    switch {
        position = { 273, 441, 30, 30 },
        state = function()
            return get(rockets) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(rockets) ~= 0 then
				set(rockets, 0)
			else
				set(rockets, 1)
			end
            return true;
        end
    },		

	-- pitot 1 cap
    switch {
        position = { 210, 441, 30, 30 },
        state = function()
            return get(pitot_1) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(pitot_1) ~= 0 then
				set(pitot_1, 0)
			else
				set(pitot_1, 1)
			end
            return true;
        end
    },	

	-- pitot 2 cap
    switch {
        position = { 205, 405, 30, 30 },
        state = function()
            return get(pitot_2) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(pitot_2) ~= 0 then
				set(pitot_2, 0)
			else
				set(pitot_2, 1)
			end
            return true;
        end
    },

	-- pitot 3 cap
    switch {
        position = { 277, 405, 30, 30 },
        state = function()
            return get(pitot_3) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(pitot_3) ~= 0 then
				set(pitot_3, 0)
			else
				set(pitot_3, 1)
			end
            return true;
        end
    },	
	
	-- grounding wire
    switch {
        position = { 260, 40, 30, 30 },
        state = function()
            return get(grounding) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(grounding) ~= 0 then
				set(grounding, 0)
			else
				set(grounding, 1)
			end
            return true;
        end
    },	
		
    -- gear blocks
    switch {
        position = { 145, 308, 30, 30 },
        state = function()
            return get(gear_blocks) ~= 0
        end,
        btnOn = get(green),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
			if get(gear_blocks) ~= 0 and not acf_is_moving then
				set(gear_blocks, 0)
			else
				set(gear_blocks, 1)
			end
            return true;
        end
    },	
	
    -- ground power
    switch {
        position = { 315, 330, 30, 30 },
        state = function()
            return get(ground_available) ~= 0
        end,
        --btnOn = get(green),
		onMouseClick = function()
				if get(ground_available) == 0 then
			    set(ground_available, 4)
				end
				
				if get(ground_available) == 1 then
				set(ground_available, 5)
				end
            return true;
        end
    },	




--	
    -- cabin hatch
    --switch {
     --   position = { 240, 430, 30, 30 },
      --  state = function()
       --     return get(cabin_hatch) ~= 0
        --end,
        --btnOn = get(green),
        --btnOff = get(green),
        --onMouseClick = function()
		--	if get(cabin_hatch) ~= 0 then
		--		set(cabin_hatch, 0)
		--	else
		--		if door_can_open then set(cabin_hatch, 1) end
		--	end
         --   return true;
        --end
    --},	
	
    -- emerg hatch 1
    switch {
        position = { 205, 338, 30, 30 },
        state = function()
            return get(emerg_hatch1) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(emerg_hatch1) ~= 0 then
				set(emerg_hatch1, 0)
			else
				if door_can_open then set(emerg_hatch1, 1) end
			end
            return true;
        end
    },	
	
    -- emerg hatch 2
    switch {
        position = { 275, 220, 30, 30 },
        state = function()
            return get(emerg_hatch2) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(emerg_hatch2) ~= 0 then
				set(emerg_hatch2, 0)
			else
				if door_can_open then set(emerg_hatch2, 1) end
			end
            return true;
        end
    },		
	
    -- cargo hatch 1
    switch {
        position = { 277, 350, 30, 30 },
        state = function()
            return get(cargo_hatch1) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(cargo_hatch1) ~= 0 then
				set(cargo_hatch1, 0)
			else
				if door_can_open then set(cargo_hatch1, 1) end
			end
            return true;
        end
    },		
	
    -- cargo hatch 2
    switch {
        position = { 273, 110, 30, 30 },
        state = function()
            return get(cargo_hatch2) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(cargo_hatch2) ~= 0 then
				set(cargo_hatch2, 0)
			else
				if door_can_open then set(cargo_hatch2, 1) end
			end
            return true;
        end
    },		
	
    -- pax door
    switch {
        position = { 205, 170, 30, 30 },
        state = function()
            return get(pax_door) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(pax_door) ~= 0 then
				if get(pax_ladder) == 0 then set(pax_door, 0) end
			else
				if door_can_open then set(pax_door, 1) end
			end
            return true;
        end
    },		
	
    -- pax ladder
    switch {
        position = { 205, 140, 30, 30 },
        state = function()
            return get(pax_ladder) ~= 0
        end,
        --btnOn = get(green),
        --btnOff = get(green),
        onMouseClick = function()
			if get(pax_ladder) ~= 0 then
				set(pax_ladder, 0)
			else
				if get(pax_door) == 1 then set(pax_ladder, 1) end
			end
            return true;
        end
    },		
	

	-- quick prepare button
    clickable {
        position = {350, 0, 100, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(left_eng_main, 1)
			set(left_eng_ext, 1)
			set(right_eng_main, 1)
			set(right_eng_ext, 1)
			set(ru19_eng_ext, 1)
			set(antiice_left, 1)
			set(antiice_right, 1)
			set(rockets, 1)
			set(pitot_1, 1)
			set(pitot_2, 1)
			set(pitot_3, 1)
			set(grounding, 1)
			set(gear_blocks, 1)
			
			--set(cabin_hatch, 0)
			set(emerg_hatch1, 0)
			set(emerg_hatch2, 0)
			set(cargo_hatch1, 0)
			set(cargo_hatch2, 0)
			set(pax_door, 0)
			set(pax_ladder, 0)
		end
    }, 

	-- quick pack button
    clickable {
        position = {60, 0, 100, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(left_eng_main, 0)
			set(left_eng_ext, 0)
			set(right_eng_main, 0)
			set(right_eng_ext, 0)
			set(ru19_eng_ext, 0)
			set(antiice_left, 0)
			set(antiice_right, 0)
			set(rockets, 0)
			set(pitot_1, 0)
			set(pitot_2, 0)
			set(pitot_3, 0)
			set(grounding, 0)
			set(gear_blocks, 0)
			
		end
    }, 
	
	
	

   -- clickable area for closing main menu
    --clickable {
    --   position = { size[1]-20, size[2]-20, 20, 20 },
        
    --   cursor = { 
    --        x = 16, 
    --        y = 32, 
    --        width = 16, 
   --         height = 16, 
    --        shape = loadImage("clickable.png")
   --     },  
        
    --    onMouseClick = function()
    ---    set(service_subpanel, 0 )
     --   return true
    --    end
   -- },
}






