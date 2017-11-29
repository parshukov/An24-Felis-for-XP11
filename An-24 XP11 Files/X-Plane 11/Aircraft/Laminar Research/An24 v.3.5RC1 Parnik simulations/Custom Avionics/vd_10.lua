size = { 200, 200 }

-- initialize component property table
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))
-- all images need to be replaced
-- background image
-- defineProperty("background", loadImage("needles.dds", 0, 0, 160, 160))

-- meters needle image
defineProperty("longNeedleImage", loadImage("needles.dds", 86, 73, 18, 173))

-- hundreds of meters needle image
defineProperty("shortNeedleImage", loadImage("needles.dds", 51, 0, 15, 89))
                                                              
-- calibration needle needle image
defineProperty("topNeedleImage", loadImage("needles.dds", 188, 72, 14, 176))
defineProperty("bottomNeedleImage", loadImage("needles.dds", 204, 105, 14, 110))

-- handler image
-- defineProperty("rotaryImage", loadImage("needles.dds", 66, 170, 32, 32))

-- pressure value
defineProperty("pressure", globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot"))

-- digits images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 1, 0, 14, 196))

-- post frame caclulations
local thouthand_angle = 0
local hundreds_angle = 0
local ten_thouthand_angle = 0
local pressure_num = get(pressure) * 25.3970886
local cal_ndl_angle = get(pressure) * 25.3970886 - get(altitude) * 0.02 - 760 


function update()
	local alt = get(altitude) * 0.3048 -- altitude in meters
	if alt > 10000 then alt = 10000 end
	
	thouthand_angle = alt * 0.0001 * 360.0
	hundreds_angle = alt * 0.001 * 360.0
	ten_thouthand_angle = alt * 0.00001 * 360.0
	cal_ndl_angle = get(pressure) * 25.3970886 - get(altitude) * 0.02 - 760 
	pressure_num = get(pressure) * 25.3970886
	
	return true
end


-- altimeter consists of several components
components = {
	-- pressure in millimeters of mercury
   digitstape {
        position = { 150, 89, 50, 22};
        image = digitsImage;
        digits = 3;
        
        value = function() 
            return pressure_num; 
        end;
    }; 
	rectangle {
		position = { 150, 89, 50, 22},
		color = {0, 0, 0, 0.3},
	},

    -- calibration needle
    needle {
        position = { 45, 45, 110, 110 },
        image = get(bottomNeedleImage),
        angle = function() 
			return ten_thouthand_angle
        end,
    },
	
    -- thousands meters needle
    needle {
        position = { 40, 40, 120, 120 },
        image = get(shortNeedleImage),
        angle = function() 
            return thouthand_angle
        end
    },     
    
    -- hundreds meters needle
    needle {
        position = { 15, 15, 170, 170 },
        image = get(longNeedleImage),
        angle = function() 
			return hundreds_angle 
        end,
    },
	
   
    -- calibration needle
    needle {
        position = { 5, 5, 190, 190 },
        image = get(topNeedleImage),
        angle = function() 
            return cal_ndl_angle
        end
    },    
    
    -- pressure rotary
    rotary {
        -- image = rotaryImage;
        value = pressure;
        step = 1 / 25.3970886;
        position = { 168, 0, 32, 30 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            local a = math.floor((v * 25.3970886) + 0.5) / 25.3970886
			if a < 20.4747 then a = 20.4747
			elseif a > 31.7359 then a = 31.7359 end
			return a
        end;
    };
    
}

