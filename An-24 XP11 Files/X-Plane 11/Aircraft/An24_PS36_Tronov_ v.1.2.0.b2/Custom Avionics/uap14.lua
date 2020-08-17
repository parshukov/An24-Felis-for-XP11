size = {200, 200}

-- define property table
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) -- ias variable
defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload
defineProperty("alpha", globalPropertyf("sim/flightmodel2/misc/AoA_angle_degrees"))  -- angle of attack
defineProperty("alpha_fail", globalPropertyi("sim/operation/failures/rel_AOA"))  -- angle of attack fail
defineProperty("auasp_warn", globalPropertyi("sim/custom/xap/An24_gauges/auasp_warning"))  -- warning
defineProperty("auasp_button", globalPropertyi("sim/custom/xap/An24_gauges/auasp_button"))  -- check button
defineProperty("aoa_sensor_angle", globalPropertyf("sim/custom/xap/An24_misc/aoa_sensor_angle"))  -- angle of AOA sensor

-- power
defineProperty("auasp_sw", globalPropertyi("sim/custom/xap/An24_gauges/auasp_sw"))  -- power switcher
defineProperty("auasp_cc", globalPropertyf("sim/custom/xap/An24_gauges/auasp_cc"))  -- power current
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec"))  -- local time since aircraft was loaded 

-- failures
defineProperty("stall_warn_fail", globalPropertyi("sim/operation/failures/rel_stall_warn")) -- failure of stall worning

-- images
defineProperty("needleImage", loadImage("needles.dds", 311, 73, 18, 173))
defineProperty("scaleImage", loadImage("scales_1.png", 402, 11, 106, 200))
defineProperty("sectorImage", loadImage("scales_1.png", 0, 387, 94, 124))
defineProperty("red_small_led", loadImage("leds.dds", 110, 0, 10, 10))

--[[
-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

if get(N1) < 70 and get(N2) < 70 then
	set(auasp_sw, 0)
end
--]]

-- local variables
local a_angle = -180
local g_angle = 135
local sector_angle = 0
local warn = false
local last_lamp_change = get(flight_time)
local actual_a = -180
local actual_g = 135

set(aoa_sensor_angle, 0)

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

function update()
	-- calculate power
	local power = get(bus_DC_27_volt) > 21 and get(bus_AC_115_volt) > 110 and get(auasp_sw) == 1
	
local passed = get(frame_time)

if passed > 0 then
	
	if power then
		-- calculate alpha
		if get(ias) > 50 and get(alpha_fail) < 6 then
			local a = 3 + get(alpha)
			a_angle = a * 180 / 15 - 180
			set(aoa_sensor_angle, a)
		else 
			a_angle = -180
		end
		
		
		
		-- calculate G force
		g_angle = -get(gforce) * 180 / 4 + 135
		
		-- set CC
		set(auasp_cc, 8)
		
		if get(auasp_button) == 1 then 
			a_angle = -33
			g_angle = 28
		end
		-- set warning
		if (actual_a > -35 and get(stall_warn_fail) < 6) or actual_g < 30 then
			if get(flight_time) - last_lamp_change > 0.16 then
				warn = not warn
				last_lamp_change = get(flight_time)
			end
		else
			warn = false			
		end
	else
		a_angle = -180
		g_angle = 135
		set(auasp_cc, 0)
		set(auasp_warn, 0)
		warn = false
	end
	-- set limits
	if a_angle < -180 then a_angle = -180
	elseif a_angle > 0 then a_angle = 0 end
	
	if g_angle < 0 then g_angle = 0 
	elseif g_angle > 180 then g_angle = 180 end
	
	-- smooth move of needles
	local delta_a = a_angle - actual_a
	actual_a = actual_a + delta_a * passed * 5
	
	local delta_g = g_angle - actual_g
	actual_g = actual_g + delta_g * passed * 5
	
	
	if warn then set(auasp_warn, 1) else set(auasp_warn, 0) end
	
end


	
end






components = {

	-- sector image
	texture {
		position = {39, 79, 94, 124},
		image = get(sectorImage),
	
	},	

    -- AOA needle
   needle {
        position = { 10, 10, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return actual_a
        end
    },

	-- cover scale
	texture {
		position = {93, -0.5, 106, 200},
		image = get(scaleImage),
	
	},

    -- G-force needle
	needle {
        position = { 10, 10, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return actual_g
        end
    },

	-- red led image
	textureLit {
		position = {0, 0, 32, 32},
		image = get(red_small_led),
		visible = function()
			return warn
		end
	
	},	
	
	-- AUASP check button
    clickable {
        position = {165, 0, 35, 35},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(auasp_button, 1)
			if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			return true
		end,
		onMouseUp  = function() 
			playSample(btn_click, 0) 
			switcher_pushed = false
			set(auasp_button, 0)
			return true
		end,
    },
	
	-- position gauge
--[[	rectangle {
		position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	}, --]]

}
