-- this is DME gauge with simple logic of power
size = {200, 200}

-- define properties
defineProperty("distance", globalPropertyf("sim/cockpit2/radios/indicators/dme_dme_distance_nm"))  -- distance in NM
defineProperty("power_sw", globalPropertyi("sim/custom/xap/An24_gauges/dme_on"))  -- power switcher
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("dme_cc", globalPropertyf("sim/custom/xap/An24_gauges/dme_cc")) 

-- images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196)) 
defineProperty("flagImg", loadImage("needles.dds", 360, 0, 90, 6))

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')

local switcher_pushed = false

local dist_km = 0
local dist_m = 0
local power = 0
local red_flag = true

function update()
	
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(power_sw, 0)
		not_loaded = false
	end
	
	if get(bus_DC_27_volt) * get(power_sw) > 21 then power = 1 else power = 0 end
	
	if power then set(dme_cc, 5) else set(dme_cc, 0) end
	
	local dist = get(distance) * power
	if dist > 0 then 
		dist_km = dist * 1.852 
		if dist_km > 999.9 then dist_km = 999.9 end
		dist_m = dist_km * 10 -- math.floor(dist_km) * 10
		dist_km = math.floor(dist_km + 0.05)
		red_flag = false
	else
		red_flag = true
	end

	
end





components = {

    -- distance digits
    digitstape {
        position = { 8, 85, 130, 50},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = true,
		allowNonRound = true,
        value = function()
           return dist_km
        end
    };
	
    -- distance digits
    digitstape {
        position = { 145, 85, 40, 50},
        image = digitsImage,
        digits = 1,
        showLeadingZeros = true,
		allowNonRound = false,
        value = function()
           return dist_m
        end
    };

	texture {
		position = { 8, 103, 184, 12},
		image = get(flagImg),
		visible = function()
			return red_flag
		end
	},
	
	-- DME power switch
    switch {
        position = { 180, 0, 20, 20},
        state = function()
            return get(power_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(power_sw) ~= 0 then
                set(power_sw, 0)
            else
                set(power_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
--[[	rectangle {
			position = {0,0,200,200},
			color = {1,0,0,1},
	}, --]]


}

