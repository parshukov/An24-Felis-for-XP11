-- this is rude try to make RLS
size = {256, 300}

-- define property table
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time
defineProperty("turn_sw", globalPropertyi("sim/cockpit2/switches/custom_slider_on[15]")) -- switch to rotate RLS
defineProperty("deg1", globalPropertyf("sim/flightmodel/position/psi")) -- acf mag heading
defineProperty("deg2", globalPropertyf("sim/flightmodel/position/hpath")) -- real mag heading

defineProperty("rls_power_sw", globalPropertyi("sim/custom/xap/An24_rls/rls_power_sw")) -- power switch
defineProperty("rls_power_cc", globalPropertyf("sim/custom/xap/An24_rls/rls_power_cc")) -- power switch
defineProperty("rls_scan_spd", globalPropertyi("sim/custom/xap/An24_rls/rls_scan_spd")) -- power switch
defineProperty("rls_mode", globalPropertyi("sim/custom/xap/An24_rls/rls_mode")) -- power switch
defineProperty("rls_mode_lamp", globalPropertyi("sim/custom/xap/An24_rls/rls_mode_lamp")) -- power switch
defineProperty("rls_bright", globalPropertyf("sim/custom/xap/An24_rls/rls_bright")) -- power switch
defineProperty("rls_contr", globalPropertyf("sim/custom/xap/An24_rls/rls_contr")) -- power switch
defineProperty("rls_signs", globalPropertyf("sim/custom/xap/An24_rls/rls_signs")) -- power switch

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt"))
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt"))

-- EFIS controls
defineProperty("map_mode", globalPropertyi("sim/cockpit2/EFIS/map_mode"))
defineProperty("map_mode_is_HSI", globalPropertyi("sim/cockpit2/EFIS/map_mode_is_HSI"))
defineProperty("map_range", globalPropertyi("sim/cockpit/switches/EFIS_map_range_selector"))

defineProperty("EFIS_weather_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_weather_on"))
defineProperty("EFIS_tcas_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_tcas_on"))
defineProperty("EFIS_airport_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_airport_on"))
defineProperty("EFIS_vor_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_vor_on"))
defineProperty("EFIS_ndb_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_ndb_on"))

defineProperty("EFIS_fix_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_fix_on"))
defineProperty("EFIS_page", globalPropertyi("sim/cockpit2/EFIS/EFIS_page"))
defineProperty("EFIS_fail", globalPropertyi("sim/operation/failures/rel_efis_2"))



-- images
defineProperty("mask1", loadImage("radar_mask1.png", 0, 0, 256, 256))
defineProperty("mask2", loadImage("radar_mask2.png", 0, 0, 256, 256))
defineProperty("scale", loadImage("radar_scale.png", 0, 0, 256, 180))

defineProperty("needle_1", loadImage("radar_scale.png", 0, 190, 256, 4))
defineProperty("needle_2", loadImage("radar_scale.png", 0, 200, 256, 4))
defineProperty("needle_3", loadImage("radar_scale.png", 0, 210, 256, 4))



local mask_angle = -10  -- angle for rotate mask
local rot_spd = 5  -- angular speed for rotate mask. deg/sec

local slip_angle = 0
local needle_show = 1
local mode = 0
local first_mask = true  -- switch between first and second mask

local power_counter = 0
local power = false

local brightness = 1
local sign_brt = 1
local contrast = 1

local range = get(map_range)

function update()

	-- lock some variables
	set(map_mode, 1)
	set(map_mode_is_HSI, 0)
	set(EFIS_page, 0)
	set(EFIS_weather_on, 1)
	set(EFIS_tcas_on, 0)
	set(EFIS_airport_on, 0)
	set(EFIS_vor_on, 0)
	set(EFIS_ndb_on, 0)
	set(EFIS_fix_on, 0)
	

	local current = 0  -- current consumption
	local power_switch = get(rls_power_sw)
	mode = get(rls_mode)
	local passed = get(frame_time)
	local power_el = get(bus_DC_27_volt) > 21 and get(bus_AC_36_volt) > 30 or get(bus_AC_115_volt) > 110
	rot_spd = get(rls_scan_spd)
	-- power couner
	if power_switch == 1 and mode == 0 and power_el then 
		power_counter = power_counter + passed * 10
		current = 1
	elseif power_switch == 0 and power_counter > 180 and power_el then power_counter = 170 end

	if not power_el then 
		power_counter = 0 
		current = 0
	end

	power = power_counter > 180
	
	-- debug
	--power = true
	--mode = 1
	
	-- radar calculations
	if power and mode == 1 then -- weather radar mode
		current = current + 1
		mask_angle = mask_angle + passed * rot_spd

		if mask_angle > 230 then
			mask_angle = -10
			first_mask = not first_mask
		end
	elseif power and mode == 2 then -- slip angle mode
		current = current + 3
		slip_angle = get(deg2) - get(deg1)
		needle_show = math.random(1, 3)
	end


	-- brightness
	if power then brightness = get(rls_bright) else brightness = 0 end
	
	-- contrast
	contrast = get(rls_contr)
	
	-- sign brightness
	sign_brt = get(rls_signs)
	
	-- lamp
	if power then set(rls_mode_lamp, mode) else set(rls_mode_lamp, 4) end
	
	current = current + brightness * 0.5 + sign_brt * 0.5
	set(rls_power_cc, current)
	
	
	 --очищаем штатную фмс
	--[[
	local i = 0 
	if countFMSEntries() > 0 then 
		for i = 1, countFMSEntries() do 
			clearFMSEntry(i) 
		end 
	end
--]]
	
end

components = {

	-- brightness of signs background
	rectangle_ctr {
		position = {0, 0, 256, 300},
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - sign_brt + rot_spd / 150
		end,
	},


	-- first mask
	needleLit {
		position = {-10, -10, 276, 276},
		image = get(mask1),
		angle = function()
			return -mask_angle + 90
		end,
		visible = function()
			return first_mask
		end
	},

	-- second mask
	needleLit {
		position = {-10, -10, 276, 276},
		image = get(mask2),
		angle = function()
			return mask_angle - 90
		end,
		visible = function()
			return not first_mask
		end
	},

	-- black mask to divide modes
	rectangle {
		position = {0, 0, 256, 300},
		color = {0,0,0,1},
		visible = function()
			return mode ~= 1
		end
	},
	
	-- slip beam
	needleLit {
		position = {-10, -10, 276, 276},
		image = function()
			local a
			if needle_show == 1 then a = get(needle_1)
			elseif needle_show == 2 then a = get(needle_2)
			else a = get(needle_3) end
			return a
		end,
		
		angle = function()
			return slip_angle - 90
		end,
		visible = function()
			return mode == 2
		end,
	},	

	-- contrast
	rectangle_ctr {
		position = {0, 0, 256, 300},
		R = 0,
		G = 0.2,
		B = 0,
		A = function()
			return math.max((0.5 + brightness/2 - contrast * 2) / 2, 0)
		end,
	},


	-- scale
	textureLit {
		position = {0, 85, 256, 180},
		image = get(scale),
	},

	-- brightness of monitor
	rectangle_ctr {
		position = {0, 0, 256, 300},
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - brightness
		end
	}, 
--[[
	-- scale
	texture {
		position = {0, 85, 256, 180},
		image = get(scale),
	},
--]]
    -- rotate switch
    switch {
        position = { 0, 0, 256, 300},
        state = function()
            return get(turn_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(turn_sw) ~= 0 then
                set(turn_sw, 0)
            else
                set(turn_sw, 1)
            end
            return true;
        end
    },

}
