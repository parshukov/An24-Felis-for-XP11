size = {227, 256}

-- define property table
defineProperty("adf1", globalPropertyi("sim/cockpit2/radios/actuators/adf1_frequency_hz"))
defineProperty("adf2", globalPropertyi("sim/cockpit2/radios/actuators/adf2_frequency_hz"))

defineProperty("nav1", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  -- set the frequency
defineProperty("nav2", globalPropertyf("sim/cockpit2/radios/actuators/nav2_frequency_hz"))  -- set the frequency
defineProperty("obs1", globalPropertyf("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot"))  -- set the course
defineProperty("obs2", globalPropertyf("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot"))  -- set the course

defineProperty("obs1_fromto_lit", globalPropertyi("sim/custom/xap/An24_gauges/obs1_fromto_lit")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.
defineProperty("obs2_fromto_lit", globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto_lit")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.

defineProperty("dme", globalPropertyf("sim/cockpit2/radios/actuators/dme_frequency_hz"))  -- set the frequency

defineProperty("flap_deg1", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]"))  -- left flap deg
defineProperty("flap_deg2", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]"))  -- right flap deg

defineProperty("baro1", globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot"))
defineProperty("baro2", globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_copilot"))

defineProperty("distance", globalPropertyf("sim/cockpit2/radios/indicators/dme_dme_distance_nm"))  -- distance in NM

defineProperty("info_subpanel", globalPropertyi("sim/custom/xap/An24_panels/info_subpanel"))

-- images
defineProperty("background", loadImage("info_panel.dds", 0, 0, size[1], size[2]))
defineProperty("digitsImage", loadImage("black_digit_strip.png", 1, 0, 14, 196))
defineProperty("from_img", loadImage("info_panel.dds", 227, 0, 29, 12))
defineProperty("to_img", loadImage("info_panel.dds", 227, 12, 29, 12))
defineProperty("none_img", loadImage("info_panel.dds", 228, 15, 1, 1))

local adf1_freq = get(adf1)
local adf2_freq = get(adf2)
local nav1_freq = get(nav1)
local nav2_freq = get(nav2)
local obs1_curs = get(obs1)
local obs2_curs = get(obs2)
local obs1_fromto_img = get(to_img)
local obs2_fromto_img = get(to_img)
local dme_freq = get(dme)
local flap_ind_angle = 0
local baro1_inhg = get(baro1)
local baro2_inhg = get(baro2)
local baro1_mm = baro1_inhg * 25.3970886
local baro2_mm = baro2_inhg * 25.3970886
local baro1_hpa = baro1_inhg * 33.863726
local baro2_hpa = baro2_inhg * 33.863726
local dist_nm = get(distance)
local dist_km = dist_nm * 1.852

function update()
	adf1_freq = get(adf1)
	adf2_freq = get(adf2)
	nav1_freq = get(nav1) / 100
	nav2_freq = get(nav2) / 100
	obs1_curs = get(obs1)
	obs2_curs = get(obs2)	
	if get(obs1_fromto_lit) == 1 then obs1_fromto_img = get(to_img) 
	elseif get(obs1_fromto_lit) == 2 then obs1_fromto_img = get(from_img) 
	else obs1_fromto_img = get(none_img) end
	if get(obs2_fromto_lit) == 1 then obs2_fromto_img = get(to_img) 
	elseif get(obs2_fromto_lit) == 2 then obs2_fromto_img = get(from_img) 
	else obs2_fromto_img = get(none_img) end
	dme_freq = get(dme) / 100
	flap_ind_angle = math.max(get(flap_deg1), get(flap_deg2))
	baro1_inhg = get(baro1)
	baro2_inhg = get(baro2)
	baro1_mm = baro1_inhg * 25.3970886
	baro2_mm = baro2_inhg * 25.3970886
	baro1_hpa = baro1_inhg * 33.863726
	baro2_hpa = baro2_inhg * 33.863726
	dist_nm = get(distance)
	dist_km = dist_nm * 1.852	
	
end





components = {
	-- background
	texture {
		image = get(background),
		position = {0, 0, size[1], size[2]},

	},

	-----------------------
	-- digits --
	---------------------
	-- adf1 frequency
   digitstape {
        position = { 55, 215, 50, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
        value = function()
			return adf1_freq
		end;
    };

	-- adf2 frequency
   digitstape {
        position = { 165, 215, 50, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 0;
        value = function()
			return adf2_freq
		end;
    };

	-- nav1 frequency
   digitstape {
        position = { 50, 183, 60, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 2;
        value = function()
			return nav1_freq
		end;
    };

	-- nav2 frequency
   digitstape {
        position = { 160, 183, 60, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 2;
        value = function()
			return nav2_freq
		end;
    };

	-- obs1 curse
   digitstape {
        position = { 50, 152, 35, 18};
        image = digitsImage;
        digits = 3;
        allowNonRound = false;
		showLeadingZeros = true;
		fractional = 0;
        value = function()
			return obs1_curs
		end;
    };
	texture	{
		position = {85, 153, 29, 12},
		image = function()
			return obs1_fromto_img
		end
	
	},
	
	-- obs2 curse
   digitstape {
        position = { 160, 152, 35, 18};
        image = digitsImage;
        digits = 3;
        allowNonRound = false;
		showLeadingZeros = true;
		fractional = 0;
        value = function()
			return obs2_curs
		end;
    };
	texture	{
		position = {195, 153, 29, 12},
		image = function()
			return obs2_fromto_img
		end
	
	},	
	
	-- dme frequency
   digitstape {
        position = { 50, 120, 60, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 2;
        value = function()
			return dme_freq
		end;
    };	
	
	-- flaps position
   digitstape {
        position = { 170, 120, 20, 18};
        image = digitsImage;
        digits = 2;
        allowNonRound = true;
		showLeadingZeros = true;
		fractional = 0;
        value = function()
			return flap_ind_angle
		end;
    };	

	-- dme distance km
   digitstape {
        position = { 50, 89, 50, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return dist_km
		end;
    };	

	-- dme distance nm
   digitstape {
        position = { 140, 89, 50, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return dist_nm
		end;
    };
	
	-- barometer 1 in mm hg
   digitstape {
        position = { 45, 56, 47, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return baro1_mm
		end;
    };	
	
	-- barometer 2 in mm hg
   digitstape {
        position = { 155, 56, 47, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return baro2_mm
		end;
    };	
	
	-- barometer 1 in in.hg
   digitstape {
        position = { 25, 32, 47, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 2;
        value = function()
			return baro1_inhg
		end;
    };

	-- barometer 1 in in.hg
   digitstape {
        position = { 135, 32, 47, 18};
        image = digitsImage;
        digits = 4;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 2;
        value = function()
			return baro2_inhg
		end;
    };

	-- barometer 1 in hPa
   digitstape {
        position = { 25, 10, 55, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return baro1_hpa
		end;
    };
	
	-- barometer 2 in hPa
   digitstape {
        position = { 135, 10, 55, 18};
        image = digitsImage;
        digits = 5;
        allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
        value = function()
			return baro2_hpa
		end;
    };	
	
	
	
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
			set(info_subpanel, 0 )
        return true
        end
    },
}