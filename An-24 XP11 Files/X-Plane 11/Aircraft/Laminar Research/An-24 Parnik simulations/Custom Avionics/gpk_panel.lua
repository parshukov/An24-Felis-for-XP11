-- this is the simple logic of GPK correction panel
size = {2048, 2048}

-- define property table
-- source
defineProperty("lat", globalPropertyf("sim/custom/xap/An24_gauges/GPK_lat")) -- latitude position on panel
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("corr_switcher", globalPropertyi("sim/custom/xap/An24_gauges/GPK_corr_sw")) -- correction switcher ON/OFF
defineProperty("corr_rot", globalPropertyi("sim/custom/xap/An24_gauges/GPK_corr_rot")) -- correction rotary
defineProperty("north_GPK", globalPropertyi("sim/custom/xap/An24_set/north_GPK"))  -- GPK mode for north hemisphere

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) -- power 27 volt
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt")) -- power 36 volt
defineProperty("gpk_switch", globalPropertyf("sim/custom/xap/An24_gauges/GPK_sw"))  -- switcher to turn ON/OFF

-- fail
defineProperty("fail", globalPropertyf("sim/operation/failures/rel_cop_dgy"))

-- result
defineProperty("correct", globalPropertyf("sim/custom/xap/An24_gauges/GPK_corr")) -- correction on GPK panel
defineProperty("correct_ap", globalPropertyf("sim/custom/xap/An24_gauges/ap_GPK_corr")) -- correction on GPK panel
defineProperty("lat_angle", globalPropertyf("sim/custom/xap/An24_gauges/GPK_lat_rotary")) -- angle for lat rotary

defineProperty("SC_master", globalPropertyi("scp/api/ismaster")) -- status of SmartCopilot
defineProperty("sc_corr_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_corr_angle")) -- SmartCopilot
defineProperty("sc_corr_ap_angle", globalPropertyf("sim/custom/xap/An24_gauges/sc_corr_ap_angle")) -- SmartCopilot

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))


local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

-- rotate left
left_command = findCommand("sim/autopilot/vertical_speed_up")
function left_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(corr_rot) - 1
		if a < -5 then a = -5 end
		set(corr_rot, a)
    end
return 0
end
registerCommandHandler(left_command, 0, left_handler)

-- rotate right
right_command = findCommand("sim/autopilot/vertical_speed_down")
function right_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(corr_rot) + 1
		if a > 5 then a = 5 end
		set(corr_rot, a)
    end
return 0
end
registerCommandHandler(right_command, 0, right_handler)

-- rotate center
center_command = findCommand("sim/autopilot/vertical_speed_sync")
function center_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		set(corr_rot, 0)
    end
return 0
end
registerCommandHandler(center_command, 0, center_handler)


-------------

local time_counter = 0
local not_loaded = true

local passed = 0

local corr_angle = 0
local corr_ap_angle = 0
local turn_switcher = get(corr_rot)
local power = 0

-- postframe calculations
function update()
	-- time calculations
	passed = get(frame_time)
-- pre bug check
if passed > 0 then
	
	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(gpk_switch, 0)
		set(corr_switcher, 0)
		not_loaded = false
	end

	-- check power
	if get(bus_DC_27_volt) > 21 and get(bus_AC_36_volt) > 30 and get(gpk_switch) > 0 and get(fail) < 6 then
		power = 1 
	else power = 0 end
	
	-- earth rotation correction
	local earth_rot = 0
	if get(corr_switcher) > 0 then earth_rot = (2 * get(north_GPK) - 1) * 360 * math.sin(math.rad(get(lat))) * passed * power / 86164 end-- one astronomic day eq 86164 seconds
	-- correction angle
	turn_switcher = get(corr_rot)
	local rotate = -turn_switcher * 40 * passed * power / 60
	if rotate > 180 then rotate = rotate - 360
	elseif rotate < -180 then rotate = rotate + 360 end

	-- calculate result
	if get(SC_master) == 1 then
		corr_angle = get(sc_corr_angle)
	else
		corr_angle = corr_angle + earth_rot + rotate
		if corr_angle > 180 then corr_angle = corr_angle - 360
		elseif corr_angle < -180 then corr_angle = corr_angle + 360 end
		set(sc_corr_angle, corr_angle)
	end

	if get(SC_master) == 1 then
		corr_ap_angle = get(sc_corr_ap_angle)
	else
		corr_ap_angle = corr_ap_angle + earth_rot
		if corr_ap_angle > 180 then corr_ap_angle = corr_ap_angle - 360
		elseif corr_ap_angle < -180 then corr_ap_angle = corr_ap_angle + 360 end
		set(sc_corr_ap_angle,corr_ap_angle)
	end
	--print(earth_rot, corr_ap_angle)
	
	-- set result
	set(correct, corr_angle)
	set(correct_ap, corr_ap_angle)
	
end

end


components = {

	-- clickable to turn left correction rotary
	clickable {
        position = {1605, 650, 15, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(corr_rot) 
			if not switcher_pushed and a > -5 then 
				playSample(plastic_sound, 0) 
				a = a - 1
			end
			set(corr_rot, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- clickable to turn right correction rotary
	clickable {
        position = {1620, 650, 15, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(corr_rot) 
			if not switcher_pushed and a < 5 then 
				playSample(plastic_sound, 0) 
				a = a + 1
			end
			set(corr_rot, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- correction power switcher
    switch {
        position = { 1635, 670, 15, 15},
        state = function()
            return get(corr_switcher) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(corr_switcher) ~= 0 then
                set(corr_switcher, 0)
            else
                set(corr_switcher, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 


	-- clickable to turn left latitude rotary
	clickable {
        position = {1650, 650, 15, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(lat)
			if not switcher_pushed and a < 90 then 
				playSample(rot_click, 0) 
				a = a + 5
			end
			set(lat, a)
			set(lat_angle, math.sin(math.rad(a)))
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- clickable to turn right latitude rotary
	clickable {
        position = {1665, 650, 15, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(lat)
			if not switcher_pushed and a > 0 then 
				playSample(rot_click, 0) 
				a = a - 5
			end
			set(lat, a)
			set(lat_angle, math.sin(math.rad(a)))
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },


}

