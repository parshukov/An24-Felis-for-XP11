-- UV-3M radio altimeter

size = { 200, 200 }
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))
-- radio altitude
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot"))  -- altitude, measured by gauge
defineProperty("dh_set", globalPropertyf("sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot"))  -- decision height, set by pilot

-- needle image
defineProperty("needleImage", loadImage("needles.dds", 86, 73, 18, 173))
defineProperty("yellow_needleImage", loadImage("needles.dds", 122, 63, 23, 193))

defineProperty("yellow_led", loadImage("leds.dds", 100, 0, 10, 10)) -- red led image
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image
defineProperty("black_cap2", loadImage("covers.dds", 69, 56, 54, 50)) -- black cap image
defineProperty("red_flag", loadImage("payload_panel.dds", 734, 22, 70, 25))

-- electrical
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("rv_sw", globalPropertyi("sim/custom/xap/An24_gauges/rv_2_sw")) 
defineProperty("rv2_cc", globalPropertyf("sim/custom/xap/An24_gauges/rv_2_cc"))  -- rv work

-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- result
defineProperty("radioalt", globalPropertyf("sim/custom/xap/An24_gauges/radioalt"))
defineProperty("radioalt_dh", globalPropertyi("sim/custom/xap/An24_gauges/radioalt_dh")) -- radio altitude is decision height


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

local time_counter = 0
local not_loaded = true
local alert_counter = 0


local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')
local alt_sound = loadSample('Custom Sounds/altitude_alert.wav')

local switcher_pushed = false

-- post frame calculations

local alt_angle = 0
local dh_angle = 90  -- DH altitude in degrees of scale
local red_led_vis = true  -- red flag that indicates that gauge is fail or OFF
local dh_led_vis = false
local switch_last = get(rv_sw)
local timer_started = false
local start_time = get(flight_time)
local passed = 0

local test = false

local angle = 0
local last_angle = 0



function update()
	passed = get(frame_time)
if  passed > 0 then

	dh_angle = get(dh_set)
	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(rv_sw, 0)
		not_loaded = false
	end

	-- power logic
	local power_27 = 0
	local power_115 = 0
	if get(bus_DC_27_volt_emerg) > 21 then power_27 = 1 else power_27 = 0 end
	if get(bus_AC_115_volt) > 110 then power_115 = 1 else power_115 = 0 end

	-- dh setting bug angle
	
	--[[if 0 > dh then dh_angle = 0  -- altimeter has different ranges on nonlinear scale
	elseif 20 > dh then dh_angle = dh / 20 * 30
	elseif 100 > dh then dh_angle = (dh - 20) / 80 * 130 + 30
	elseif 800 > dh then dh_angle = (dh - 100) / 700 * 180 + 160
	else dh_angle = 340
	end--]]
	
	
	-- logic of moving needle
	if power_27 * power_115 * get(rv_sw)> 0 then
		set(rv2_cc, 2)
		
		if not timer_started then 
			timer_started = true
			start_time = get(flight_time)
		end
		
		
		local a = get(altitude) * 0.3048  -- get altitude in meters	
		if test then a = 15 end
		
		if 0 > a then alt_angle = 0  -- altimeter has different ranges on nonlinear scale
		elseif 20 > a then alt_angle = a / 20 * 30
		elseif 100 > a then alt_angle = (a - 20) / 80 * 130 + 30
		elseif 800 > a then alt_angle = (a - 100) / 700 * 180 + 160
		else alt_angle = 340
		end
		
		-- self test after power ON
		if get(flight_time) - start_time < 5 and dh_angle - angle > 2 then alt_angle = dh_angle
		else start_time = start_time - 10
		end
		
		-- needle smooth move
		angle = last_angle + (alt_angle - last_angle) * passed * 3

		-- DH light
		if angle < dh_angle then 
			dh_led_vis = true
			if get(flight_time) - start_time > 220 then alert_counter = alert_counter + passed end
			if alert_counter > 0 and alert_counter < 4 then 
				set(radioalt_dh, 1)
				if not isSamplePlaying(alt_sound) then playSample(alt_sound, 1) end
			else stopSample(alt_sound) set(radioalt_dh, 0) end

		else 
			dh_led_vis = false
			alert_counter = 0
			stopSample(alt_sound)
		end
		-- red flag visibility
		red_led_vis = false
		-- set radioalt for SSOS
		set(radioalt, a)
		
	else
		red_led_vis = true
		dh_led_vis = false
		timer_started = false
		set(radioalt, 0)
		set(rv2_cc, 0)
		--stopSample(alt_sound)
	end
	local external = get(external_view) -- 0 = inside, 1 = external
	setSampleGain(alt_sound, 1000 * (1-external))
	
end
	-- last variables

	last_angle = angle
	
	set(dh_set, dh_angle)
	
end


components = {
	-- red flag
	texture {
		position = {85, 140, 30, 15},
		image = get(red_flag),
		visible = function()
			return red_led_vis
		end,	
		},

    -- meters needle
    needle {
        position = { 10, 10, 180, 180 },
        image = needleImage,
        angle = function() 
			return angle
        end
    },
	
    -- DH needle
    needle {
        position = { 3, 3, 194, 194 },
        image = yellow_needleImage,
        angle = function() 
			return dh_angle
        end
    },
	
	-- black cap
	texture{
	    position = { 74, 72, 56, 56 },
        image = get(black_cap),
	},
	
	-- black cap2
	texture{
	    position = { 30, 153, 75, 53 },
        image = get(black_cap2),
	},

	-- yellow led
	textureLit{
		position = {165, 1, 32, 30},
		image = get(yellow_led),
		visible = function()
			return dh_led_vis
		end
	},
	
    -- dh rotary
     clickable {
        position = { 0, 0, 18, 32},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			if dh_angle > 0 then 
				playSample(rot_click, 0) 
				dh_angle = dh_angle - 10
				set(dh_set, dh_angle)
			end
				
			return true
		end,
    },
 
	clickable {
        position = { 18, 0, 18, 32},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			if dh_angle < 310 then 
				playSample(rot_click, 0) 
				dh_angle = dh_angle + 10
				set(dh_set, dh_angle)
			end
				
			return true
		end,
    },
	
--[[
	rotary {
        -- image = rotaryImage;
        value = dh_set;
        step = 10 * 3.2808399; -- 10 meters in feet
        position = { 0, 0, 34, 32 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            v = math.floor((v * 10 * 3.2808399) + 0.5) / (10 * 3.2808399)
			if v > 700 * 3.2808399 then v = 700 * 3.2808399 end
			if v < 0 then v = 0 end
			return v
        end;
    };
--]]	
	-- test button
    clickable {
        position = {50, 10, 30, 30},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			test = true
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
		end,
		onMouseUp  = function() 
			test = false
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end,
    },
	
}

