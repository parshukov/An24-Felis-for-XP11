-- simple logic of propellers, including autofeather and beta range
size = {2048, 2048}

-- source
defineProperty("prop_pitch_1", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[0]")) -- propeller pitch
defineProperty("prop_pitch_2", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[1]"))

defineProperty("prop1_rpm_rads", globalPropertyf("sim/flightmodel2/engines/prop_rotation_speed_rad_sec[0]"))  -- prop rotation rad/sec
defineProperty("prop2_rpm_rads", globalPropertyf("sim/flightmodel2/engines/prop_rotation_speed_rad_sec[1]"))

defineProperty("uprt1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))
defineProperty("uprt2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))

defineProperty("torq1", globalPropertyf("sim/cockpit2/engine/indicators/torque_n_mtr[0]")) -- take-off pressure must be 92, it's equals 1312 NM
defineProperty("torq2", globalPropertyf("sim/cockpit2/engine/indicators/torque_n_mtr[1]"))

defineProperty("fail1", globalPropertyi("sim/operation/failures/rel_engfai0"))
defineProperty("fail2", globalPropertyi("sim/operation/failures/rel_engfai1"))

defineProperty("apd_work_lit", globalPropertyi("sim/custom/xap/An24_start/apd_work_lit")) -- lamp for apd

-- controls
defineProperty("pitch_stop", globalPropertyi("sim/custom/xap/An24_prop/pitch_stop")) -- set up pitch mid stop
defineProperty("feather1_test1", globalPropertyi("sim/custom/xap/An24_prop/feather1_test1")) -- left prop feather test by IKM
defineProperty("feather2_test1", globalPropertyi("sim/custom/xap/An24_prop/feather2_test1")) -- right prop feather test by IKM
defineProperty("feather1_test2", globalPropertyi("sim/custom/xap/An24_prop/feather1_test2")) -- left prop feather test by reverse
defineProperty("feather2_test2", globalPropertyi("sim/custom/xap/An24_prop/feather2_test2")) -- right prop feather test by reverse
defineProperty("feather1_button", globalPropertyi("sim/custom/xap/An24_prop/feather1_button")) -- left prop feather button
defineProperty("feather2_button", globalPropertyi("sim/custom/xap/An24_prop/feather2_button")) -- right prop feather button

defineProperty("feather_test_cap", globalPropertyi("sim/custom/xap/An24_prop/feather_test_cap")) -- left prop feather test by IKM
defineProperty("pitch_stop_cap", globalPropertyi("sim/custom/xap/An24_prop/pitch_stop_cap"))
defineProperty("pitch_stop_set", globalPropertyi("sim/custom/xap/An24_prop/pitch_stop_set")) -- set up pitch mid stop


-- power
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

-- images
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20))
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20))


-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- switch prop stop
set_stop_command = findCommand("sim/engines/thrust_reverse_toggle")
function set_stop_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		if get(pitch_stop) == 1 then
			set(pitch_stop, 0)
			set(pitch_stop_cap, 1)
		else
			set(pitch_stop, 1)
			set(pitch_stop_cap, 0)			
		end
    end
return 0
end
registerCommandHandler(set_stop_command, 0, set_stop_handler)

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false



local torq_coef = 92 / 1300  -- 92 kg/cm2 equals 1312 N*m

-- mininmum pitch angle = 8 deg. mid stop = 19 deg. feather = 92.5 deg
-- sim pitch is different. means real - 10 deg
-- this means that mininmum pitch angle = -2 deg. mid stop = 9 deg. feather = 82.5 deg
-- all this may change

	local prop1_out_beta = false
	local prop2_out_beta = false

	local left_feather = false
	local right_feather = false

	local deg_coef = 8 + 9

	local left_counter = 0
	local right_counter = 0

	local feather_left = false
	local feather_right = false

	local feather_left_test = false
	local feather_right_test = false

	local left_feather_ready_lamp = false
	local right_feather_ready_lamp = false
	local left_exit_feather = false
	local right_exit_feather = false
	local left_feather_lamp = false
	local right_feather_lamp = false
	local stop_lamp = false

	local kfl_left = false
	local kfl_right = false

function update()
	local passed = get(frame_time)

if passed > 0 then
	local stop = get(pitch_stop)

	-- left prop calculations
	local left_rpm = get(prop1_rpm_rads) / 0.10471975511966
	local pitch_left = get(prop_pitch_1) + deg_coef
	local left_torq = get(torq1) * torq_coef
	local left_uprt = get(uprt1)
	local left_button = get(feather1_button)

	if left_rpm > 30 then
		-- limit pitch at beta
		if prop1_out_beta and pitch_left <= 21 then
			pitch_left = 21
			set(prop_pitch_1, pitch_left - deg_coef)
		end

		-- check if prop is out beta
		if pitch_left >= 21 and stop == 1 then prop1_out_beta = true
		else prop1_out_beta = false end
		

		-- autofeather and feather test
		if get(feather1_test1) == 1 then left_torq = 9
		elseif get(feather1_test2) == 1 then left_torq = -1 end

		left_feather = ((left_torq < 10 and left_uprt > 0.32) or (left_torq < 0 and left_uprt > 0.26)) or left_button == 1
		
		if left_feather then left_counter = left_counter + passed else left_counter = 0 end

		if left_feather and left_counter > 1 and left_rpm > 400 then 
			feather_left = true
			set(feather1_button, 1)	 -- need to test it
		end
		if left_button == 0 then feather_left = false end -- unfeather the prop, when button is unpressed

		-- feathering prop
		if feather_left and not feather_left_test and pitch_left < 92 then
			pitch_left = pitch_left + passed * 40
			set(prop_pitch_1, pitch_left - deg_coef)
		elseif feather_left_test and pitch_left < 30 then
			pitch_left = pitch_left + passed * 40
			set(prop_pitch_1, pitch_left - deg_coef)
		end

	else
		if left_button == 0 then feather_left = false end -- unfeather the prop, when button is unpressed
		
		if feather_left and pitch_left < 92 then
			pitch_left = pitch_left + passed * 40
			set(prop_pitch_1, pitch_left - deg_coef)
		elseif pitch_left > 8 and not feather_left then
			pitch_left = pitch_left - passed
			set(prop_pitch_1, pitch_left - deg_coef)
		elseif not feather_left then
			pitch_left = 8
			set(prop_pitch_1, pitch_left - deg_coef)
		end

	end

	-- right prop calculations
	local right_rpm = get(prop2_rpm_rads) / 0.10471975511966
	local pitch_right = get(prop_pitch_2) + deg_coef
	local right_torq = get(torq2) * torq_coef
	local right_uprt = get(uprt2)
	local right_button = get(feather2_button)

	if right_rpm > 30 then
		-- limit pitch at beta
		if prop1_out_beta and pitch_right <= 21 then
			pitch_right = 21
			set(prop_pitch_2, pitch_right - deg_coef)
		end

		-- check if prop is out beta
		if pitch_right >= 21 and stop == 1 then prop2_out_beta = true
		else prop2_out_beta = false end

		-- autofeather and feather test
		if get(feather2_test1) == 1 then right_torq = 9
		elseif get(feather2_test2) == 1 then right_torq = -1 end
		
		right_feather = ((right_torq < 10 and right_uprt > 0.32) or (right_torq < 0 and right_uprt > 0.26)) or right_button == 1

		if right_feather then right_counter = right_counter + passed else right_counter = 0 end

		if right_feather and right_counter > 1 and right_rpm > 400 then 
			feather_right = true 
			set(feather2_button, 1)	  -- need to test it
		end
		
		if right_button == 0 then feather_right = false end -- unfeather the prop, when button is unpressed
		
		-- feathering prop
		if feather_right and not feather_right_test and pitch_right < 92 then
			pitch_right = pitch_right + passed * 40
			set(prop_pitch_2, pitch_right - deg_coef)
		elseif feather_right_test and pitch_right < 30 then
			pitch_right = pitch_right + passed * 40
			set(prop_pitch_2, pitch_right - deg_coef)
		end

	else
		if right_button == 0 then feather_right = false end -- unfeather the prop, when button is unpressed
		
		if feather_right and pitch_right < 92 then
			pitch_right = pitch_right + passed * 40
			set(prop_pitch_2, pitch_right - deg_coef)
		elseif pitch_right > 8 and not feather_right then
			pitch_right = pitch_right - passed
			set(prop_pitch_2, pitch_right - deg_coef)
		elseif not feather_right then
			pitch_right = 8
			set(prop_pitch_2, pitch_right - deg_coef)
		end
	end


	-- lamp logic
	left_feather_ready_lamp = false
	right_feather_ready_lamp = false
	left_exit_feather = false
	right_exit_feather = false
	left_feather_lamp = false
	right_feather_lamp = false
	stop_lamp = false
	kfl_left = false
	kfl_right = false
	
	local starter = get(apd_work_lit) == 1
	
	if get(bus_DC_27_volt_emerg) > 21 then

		if feather_left or feather_left_test then left_feather_lamp = true end
		if feather_right or feather_right_test then right_feather_lamp = true end
		
		if left_feather_lamp or get(fail1) == 6 or (left_rpm < 225 and not starter) then kfl_left = true end
		if right_feather_lamp or get(fail2) == 6 or (right_rpm < 225 and not starter) then kfl_right = true end
		
		if pitch_left < 90 and pitch_left > 60 and not left_feather_lamp then left_exit_feather = true end
		if pitch_right < 90 and pitch_right > 60 and not right_feather_lamp then right_exit_feather = true end

		if left_rpm > 1200 and left_uprt > 0.26 and get(prop_pitch_1) > 18 - deg_coef and not left_exit_feather and not left_feather_lamp then left_feather_ready_lamp = true end
		if right_rpm > 1200 and right_uprt > 0.26 and get(prop_pitch_2) > 18 - deg_coef and not right_exit_feather and not right_feather_lamp then right_feather_ready_lamp = true end

		if stop == 0 then 
			stop_lamp = true 
			set(pitch_stop_set, 0)
		else
			stop_lamp = false
			set(pitch_stop_set, 1)
		end

	end

end

end

components = {
	-----------------------
	-- controls --
	-----------------------


	-- feather test cap switch
	switch {
        position = {923, 466, 22, 30},
        state = function()
            return get(feather_test_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(feather_test_cap) ~= 0 then
                set(feather_test_cap, 0)
            else
                set(feather_test_cap, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- pitch stop cap switch
	switch {
        position = {950, 452, 50, 94},
        state = function()
            return get(pitch_stop_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(pitch_stop_cap) ~= 0 then
                set(pitch_stop_cap, 0)
				set(pitch_stop, 1)
            else
                set(pitch_stop_cap, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },


	-- pitch stop switch
	switch {
        position = {1041, 373, 16, 16},
        state = function()
            return get(pitch_stop) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed and get(pitch_stop_cap) == 1 then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(pitch_stop) ~= 0 then
                set(pitch_stop, 0)
            else
                set(pitch_stop, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

   -- left test 1 switch
    clickable {
       position = {1021, 280, 17, 17 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			set(feather1_test1, 1 )
			feather_left_test = true
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
        end,
		onMouseUp = function()
			set(feather1_test1, 0 )
			feather_left_test = false
			switcher_pushed = false
			playSample(btn_click, 0) 
			return true
		end
    },	
	
   -- right test 1 switch
    clickable {
       position = {1040, 280, 17, 17},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			set(feather2_test1, 1 )
			feather_right_test = true
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
        end,
		onMouseUp = function()
			set(feather2_test1, 0 )
			feather_right_test = false
			switcher_pushed = false
			playSample(btn_click, 0) 
			return true
		end
    },	
 
	-- left test 2 switch
    clickable {
       position = {1059, 280, 17, 17},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			set(feather1_test2, 1 )
			feather_left_test = true
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
        end,
		onMouseUp = function()
			set(feather1_test2, 0 )
			feather_left_test = false
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end
    },	
	
	-- right test 2 switch
    clickable {
       position = {1080, 280, 17, 17},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			set(feather2_test2, 1 )
			feather_right_test = true
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
        end,
		onMouseUp = function()
			set(feather2_test2, 0 )
			feather_right_test = false
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end
    },	
	
--[[	



	-- right test 2 switch
	switch {
        position = {1080, 280, 17, 17},
        state = function()
            return get(feather2_test2) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(feather2_test2) ~= 0 then
                set(feather2_test2, 0)
				feather_right = false
				feather_right_test = false
            else
                set(feather2_test2, 1)
                feather_right_test = true
            end
            return true;
        end
    },
--]]
	-- left red button
	switch {
        position = {417, 269, 42, 84},
        state = function()
            return get(feather1_button) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(feather1_button) ~= 0 then
                set(feather1_button, 0)
            else
                set(feather1_button, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- right red button
	switch {
        position = {460, 269, 42, 84},
        state = function()
            return get(feather2_button) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(feather2_button) ~= 0 then
                set(feather2_button, 0)
            else
                set(feather2_button, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },


	--------------
	-- lamps --
	--------------

	-- exit from feather left
	textureLit {
		image = get(green_led),
		position = {600, 255, 17, 17},
		visible = function()
			return left_exit_feather
		end,
	},

	-- exit from feather right
	textureLit {
		image = get(green_led),
		position = {616.5, 255, 17, 17},
		visible = function()
			return  right_exit_feather
		end,
	},

	-- feather left ready
	textureLit {
		image = get(green_led),
		position = {633, 255, 17, 17},
		visible = function()
			return left_feather_ready_lamp
		end,
	},

	-- feather right ready
	textureLit {
		image = get(green_led),
		position = {649, 255, 17, 17},
		visible = function()
			return right_feather_ready_lamp
		end,
	},

	-- feather left
	textureLit {
		image = get(red_led),
		position = {665.5, 255, 17, 17},
		visible = function()
			return left_feather_lamp
		end,
	},

	-- feather right
	textureLit {
		image = get(red_led),
		position = {681, 255, 17, 17},
		visible = function()
			return right_feather_lamp
		end,
	},

	-- kfl left
	textureLit {
		image = get(red_led),
		position = {427, 322, 18, 18}, 
		visible = function()
			return kfl_left
		end,
	},

	-- kfl right
	textureLit {
		image = get(red_led),
		position = {472, 322, 18, 18},
		visible = function()
			return kfl_right
		end,
	},

	-- left prop not on stop
	textureLit {
		image = get(red_led),
		position = {680, 408, 20, 20},
		visible = function()
			return stop_lamp
		end,
	},

	-- right prop not on stop
	textureLit {
		image = get(red_led),
		position = {700, 408, 20, 20},
		visible = function()
			return stop_lamp
		end,
	},

}
