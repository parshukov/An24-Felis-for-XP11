size = { 200, 200 }

-- initialize component property table
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_copilot"))
-- all images need to be replaced
-- background image
-- defineProperty("background", loadImage("needles.dds", 0, 0, 160, 160))

-- meters needle image
defineProperty("longNeedleImage", loadImage("needles.dds", 105, 74, 16, 171))

-- electric
defineProperty("uvid_30_cc", globalPropertyf("sim/custom/xap/An24_gauges/uvid_30_cc")) -- gauge current consumption
defineProperty("uvid_30_sw", globalPropertyf("sim/custom/xap/An24_gauges/uvid_30_sw")) -- gauge switcher ON/OF
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

-- pressure value
defineProperty("pressure", globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_copilot"))

-- failures
defineProperty("failure", globalPropertyi("sim/operation/failures/rel_cop_alt"))

-- digits images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("digitsImageZeros", loadImage("white_digit_zeros_strip.png", 0, 0, 16, 196))
-- red led image
defineProperty("red_led", loadImage("leds.dds", 110, 0, 10, 10)) 


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true




-- post frame caclulations
local meters_angle = 0
local alt = get(altitude)
local red_led_vis = false
local pressure_num = get(pressure) * 25.3970886

local angle_actual = 0
local last_angle = 0

function update()

	-- initial switchers values
	local passed = get(frame_time)
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(uvid_30_sw, 0)
		not_loaded = false
	end

	local power_27 = 0
	local power_115 = 0
	local switcher = get(uvid_30_sw)
	local fail = get(failure)
	-- power logic
	if get(bus_DC_27_volt_emerg) > 21 then power_27 = 1 else power_27 = 0 end
	if get(bus_AC_115_volt) > 110 then power_115 = 1 else power_115 = 0 end
	-- gauge logic
	if power_27 * power_115 * switcher > 0 and fail < 6 then  -- altitude in meters. works only when power exist
		alt = get(altitude) * 0.3048 
		set(uvid_30_cc, 2)
	else set(uvid_30_cc, 0)	end 
	-- limit altitude
	if alt > 30000 then alt = 30000 end
	
	-- calculate angle for needle
	meters_angle = alt * 0.001 * 360.0

	angle_actual = last_angle + (meters_angle - last_angle) * passed * 3
	last_angle = angle_actual
	
	-- led logic
	if power_27 == 1 then
		if switcher == 1 and (power_115 == 0 or fail == 6) then
		red_led_vis = true
		else red_led_vis = false end
	else red_led_vis = false end
	
	pressure_num = get(pressure) * 25.3970886
	
end


-- altimeter consists of several components
components = {
	-- positioning gauge
	--[[rectangle {
	position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	},	--]]

	-- pressure in millimeters of mercury
	digitstape {
        position = { 70, 30, 60, 22};
        image = digitsImage;
        digits = 3;
        
        value = function() 
            return pressure_num; 
        end;
    }; 

	-- altitude in digits in tens of meters
	digitstape {
        position = { 44, 110, 115, 24};
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
        position = { 130, 110, 28, 24};
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
		position = {47, 110, 23, 24},
		color = {0.05, 0.05, 0.05, 1},
		visible = function()
			return alt < 10000
		end,
	},
	
	-- sign below zero 
	rectangle {
		position = {52, 119, 12, 5},
		color = {0.7, 0.7, 0.7, 0.9},
		visible = function()
			return alt < 0
		end,
	},
	
    -- hundreds meters needle
   needle {
        position = { 10, 10, 180, 180 },
        image = get(longNeedleImage),
        angle = function() 
			return angle_actual
        end,
    },
	
    -- calibration needle
   --[[ needle {
        position = { 16, 16, 128, 128 },
        image = get(topNeedleImage),
        angle = function() 
            return get(pressure) * 25.3970886 - get(altitude) * 0.02 - 760 
        end
    },     --]]  
    
    -- pressure rotary
    rotary {
        -- image = rotaryImage;
        value = pressure;
        step = 1 / 25.3970886;
        position = { 0, 0, 35, 32 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            local a = math.floor((v * 25.3970886) + 0.5) / 25.3970886
			if a < 20.4747 then a = 20.4747
			elseif a > 31.7359 then a = 31.7359 end
			return a
        end;
    };
	
	-- red fail led
	textureLit{
		position = {166, 2, 32, 32},
		image = get(red_led),
		visible = function()
			return red_led_vis
		end
	
	},
	   
}

