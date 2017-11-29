size = { 200, 200 }

-- initialize component property table
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt. maybe in feet, maybe in meters.
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  -- pressire at sea level in.Hg
-- pressure value
defineProperty("pressure", globalPropertyf("sim/custom/xap/An24_gauges/feet_meter_press"))



-- meters needle image
defineProperty("longNeedleImage", loadImage("needles.dds", 105, 74, 16, 171))

-- electric
defineProperty("feet_meter_cc", globalPropertyf("sim/custom/xap/An24_gauges/feet_meter_cc")) -- gauge current consumption
defineProperty("feet_meter_sw", globalPropertyf("sim/custom/xap/An24_gauges/feet_meter_sw")) -- gauge switcher ON/OF
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

-- failures
defineProperty("failure", globalPropertyi("sim/operation/failures/rel_cop_alt"))
defineProperty("static_fail", globalPropertyi("sim/operation/failures/rel_static2"))  -- static fail

-- digits images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("digitsImageZeros", loadImage("white_digit_zeros_strip.png", 0, 0, 16, 196))
-- red led image
-- defineProperty("red_led", loadImage("leds.dds", 110, 0, 10, 10)) 

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

-- increase pressure
pressure_add_command = findCommand("sim/instruments/ah_ref_up")
function pressure_add_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 5 == phase then
		local a = get(pressure) + 1 / 33.863726
		a = math.floor((a * 33.863726) + 0.5) / 33.863726
		if a < 20.4747 then a = 20.4747 end
		set(pressure, a)
    elseif 1 == phase then
		local a = get(pressure) + 0.1 / 33.863726
		--a = math.floor((a * 33.863726) + 0.5) / 33.863726
		if a < 20.4747 then a = 20.4747 end
		set(pressure, a)		
	end
return 0
end
registerCommandHandler(pressure_add_command, 0, pressure_add_handler)

-- decrease pressure
pressure_sub_command = findCommand("sim/instruments/ah_ref_down")
function pressure_sub_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 5 == phase then
		local a = get(pressure) - 1 / 33.863726
		a = math.floor((a * 33.863726) + 0.5) / 33.863726
		if a > 31.7359 then a = 31.7359 end
		set(pressure, a)
	elseif 1 == phase then
		local a = get(pressure) - 0.1 / 33.863726
		--a = math.floor((a * 33.863726) + 0.5) / 33.863726
		if a > 31.7359 then a = 31.7359 end
		set(pressure, a)
    end
return 0
end
registerCommandHandler(pressure_sub_command, 0, pressure_sub_handler)

local time_counter = 0
local not_loaded = true


-- post frame caclulations
local time_counter = 0
local not_loaded = true


-- post frame caclulations
local alt = get(msl_alt)
local feet_angle = alt * 0.001 * 360.0
local red_led_vis = true
local pressure_ind = get(pressure) * 33.863726
local angle_actual = feet_angle
local last_angle = feet_angle
local msl = get(msl_alt) * 3.28083

function update()
	
	-- initial switchers values
	local passed = get(frame_time)
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(feet_meter_sw, 0)
		not_loaded = false
	end
	
	local power_27 = 0
	local power_115 = 0
	local switcher = get(feet_meter_sw)
	local fail = get(failure)
	local block = get(static_fail)
	local passed = get(frame_time)
	-- power logic
	if get(bus_DC_27_volt) > 21 then power_27 = 1 else power_27 = 0 end
	if get(bus_AC_115_volt) > 110 then power_115 = 1 else power_115 = 0 end
	-- gauge logic

	if block < 6 then msl = get(msl_alt) * 3.28083
	else msl = msl + (get(msl_alt) * 3.28083 - msl) * passed * 0.001 end
	
	local real_alt = msl + (get(pressure) - get(baro_press)) * 1000  -- calculate barometric altitude in feet
	
	if power_27 * power_115 * switcher > 0 and fail < 6 then  -- altitude in feet. works only when power exist
		alt = real_alt-- * 0.3048 
	end 
	-- limit altitude
	if alt > 30000 then alt = 30000 end
	
	-- calculate angle for needle
	feet_angle = alt * 0.001 * 360.0
	
	angle_actual = last_angle + (feet_angle - last_angle) * passed * 3
	last_angle = angle_actual
	
	-- led logic
	if power_27 == 0 or switcher == 0 or power_115 == 0 or fail == 6 then
		red_led_vis = false
	else red_led_vis = true end
	
	pressure_ind = get(pressure) * 33.863726
	
end


-- altimeter consists of several components
components = {
	-- positioning gauge
	--[[rectangle {
		position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	},--]]
	
	-- red fail led
	rectangle{
		position = {96, 164, 8, 12},
		color = {0, 0, 0, 1},
		visible = function()
			return red_led_vis
		end
	
	},

	-- pressure in millimeters of mercury
	digitstape {
        position = { 70, 29, 60, 22};
        image = digitsImage;
		showLeadingZeros = true;
        digits = 4;
        value = function() 
            return pressure_ind
        end;
    }; 

	-- altitude in digits in tens of feet
	digitstape {
        position = { 65, 108, 78, 21};
        image = digitsImage;
        digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		showSign = false;
        value = function() 
            return alt / 10
        end;
    }; 
	
	digitstape {
        position = { 122, 108, 20, 21};
        image = digitsImageZeros;
        digits = 1;
		allowNonRound = false;
		showLeadingZeros = true;
		showSign = false;
        value = function() 
            return alt / 10
        end;
    }; 
	
	-- first zero not shows
	rectangle {
		position = {65, 108, 20, 21},
		color = {0.05, 0.05, 0.05, 1},
		visible = function()
			return alt < 10000
		end,
	},
	
	-- sign below zero 
	rectangle {
		position = {72, 116, 10, 3},
		color = {0.7, 0.7, 0.7, 0.9},
		visible = function()
			return alt < 0
		end,
	},
	
    -- hundreds feet needle
	needle {
        position = { 10, 10, 180, 180 },
        image = get(longNeedleImage),
        angle = function() 
			return angle_actual
        end,
    },
	
    -- pressure rotary
    rotary {
        -- image = rotaryImage;
        value = pressure;
        step = 1 / 33.863726;
        position = { 168, 0, 35, 32 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            local a = math.floor((v * 33.863726) + 0.5) / 33.863726
			if a < 20.4747 then a = 20.4747
			elseif a > 31.7359 then a = 31.7359 end
			return a
        end;
    };
	

	   
}

