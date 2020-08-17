-- this is simple logic for KursMP system
size = {200, 200}

-- define property table
-- sources
defineProperty("obs1_fromto", globalPropertyi("sim/custom/xap/An24_gauges/obs1_fromto")) -- obs from-to switcher
defineProperty("obs2_fromto", globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto")) -- obs from-to switcher
defineProperty("sp_ils", globalPropertyi("sim/custom/xap/An24_gauges/sp_ils")) -- switcher between SP-50 and ILS system
defineProperty("nav_select", globalPropertyi("sim/custom/xap/An24_gauges/nav_select")) -- selector between NAV1 and NAV2
defineProperty("mrp_mode", globalPropertyi("sim/custom/xap/An24_gauges/mrp_mode")) -- 0 - landing, 1 = navigation

defineProperty("v_plank_1", globalPropertyf("sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot")) -- horizontal deflection on course
defineProperty("h_plank_1", globalPropertyf("sim/cockpit2/radios/indicators/nav1_vdef_dots_pilot")) -- vertical deflection on glideslope
defineProperty("cr_flag_1", globalPropertyf("sim/cockpit2/radios/indicators/nav1_flag_from_to_pilot")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.
defineProperty("gs_flag_1", globalPropertyf("sim/cockpit/radios/nav1_CDI"))  -- glideslope flag. 0 - flag is shown

defineProperty("v_plank_2", globalPropertyf("sim/cockpit2/radios/indicators/nav2_hdef_dots_pilot")) -- horizontal deflection on course
defineProperty("h_plank_2", globalPropertyf("sim/cockpit2/radios/indicators/nav2_vdef_dots_pilot")) -- vertical deflection on glideslope
defineProperty("cr_flag_2", globalPropertyf("sim/cockpit2/radios/indicators/nav2_flag_from_to_pilot")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.
defineProperty("gs_flag_2", globalPropertyf("sim/cockpit/radios/nav2_CDI"))  -- glideslope flag. 0 - flag is shown
defineProperty("nav1_deg", globalPropertyf("sim/cockpit2/radios/indicators/nav1_relative_bearing_deg")) -- nav1 bearing
defineProperty("nav2_deg", globalPropertyf("sim/cockpit2/radios/indicators/nav2_relative_bearing_deg")) -- nav1 bearing

defineProperty("rsbn_deflection", globalPropertyf("sim/custom/xap/An24_rsbn/defl"))
defineProperty("rsbn_flag", globalPropertyi("sim/custom/xap/An24_rsbn/flag"))

-- fail
defineProperty("fail1", globalPropertyf("sim/operation/failures/rel_nav1"))
defineProperty("fail2", globalPropertyf("sim/operation/failures/rel_nav2"))

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("curs_mp1_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp1_sw")) 
defineProperty("curs_mp2_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp2_sw")) 
defineProperty("curs_mp_cc", globalPropertyf("sim/custom/xap/An24_gauges/curs_mp_cc")) 


-- result
defineProperty("k1_flag", globalPropertyi("sim/custom/xap/An24_gauges/k1_flag")) -- flag for course on left kppm
defineProperty("k2_flag", globalPropertyi("sim/custom/xap/An24_gauges/k2_flag")) -- flag for course on right kppm
defineProperty("g1_flag", globalPropertyi("sim/custom/xap/An24_gauges/g1_flag")) -- flag for glide on left kppm
defineProperty("g2_flag", globalPropertyi("sim/custom/xap/An24_gauges/g2_flag")) -- flag for glide on right kppm
defineProperty("curs_1", globalPropertyf("sim/custom/xap/An24_gauges/curs_1")) -- KursMP course for left kppm
defineProperty("curs_2", globalPropertyf("sim/custom/xap/An24_gauges/curs_2")) -- KursMP course for right kppm
defineProperty("glide_1", globalPropertyf("sim/custom/xap/An24_gauges/glide_1")) -- KursMP glide for left kppm
defineProperty("glide_2", globalPropertyf("sim/custom/xap/An24_gauges/glide_2")) -- KursMP glide for right kppm

defineProperty("vor_1", globalPropertyf("sim/custom/xap/An24_gauges/vor_1")) -- KursMP course for left kppm
defineProperty("vor_2", globalPropertyf("sim/custom/xap/An24_gauges/vor_2")) -- KursMP course for right kppm

defineProperty("obs1_fromto_lit", globalPropertyi("sim/custom/xap/An24_gauges/obs1_fromto_lit")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.
defineProperty("obs2_fromto_lit", globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto_lit")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.


-- images
defineProperty("red_small_led", loadImage("leds.dds", 110, 0, 10, 10)) 

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames


-- select NAV left
NAV_left_command = findCommand("sim/autopilot/hsi_select_nav_1")
function NAV_left_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(nav_select) - 1
		if a < 0 then a = 0 end
		set(nav_select, a)
	end
return 0
end
registerCommandHandler(NAV_left_command, 0, NAV_left_handler)

-- select NAV right
NAV_right_command = findCommand("sim/autopilot/hsi_select_nav_2")
function NAV_right_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		local a = get(nav_select) + 1
		if a > 4 then a = 4 end
		set(nav_select, a)
	end
return 0
end
registerCommandHandler(NAV_right_command, 0, NAV_right_handler)

local switch_sound = loadSample('Custom Sounds/plastic_switch.wav')


local switcher_pushed = false

local time_counter = 0
local not_loaded = true

-- local variables
local k1_lamp = false
local k2_lamp = false
local g1_lamp = false
local g2_lamp = false
local bearing1 = 0
local bearing2 = 0

function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(curs_mp1_sw, 0)
		set(curs_mp2_sw, 0)
		not_loaded = false
	end
	
	
	-- power calculations
	local power1 = 0
	local power2 = 0
	local power27 = get(bus_DC_27_volt) > 21
	if power27 and get(bus_AC_115_volt) > 110 then
		if get(curs_mp1_sw) == 1 and get(fail1) < 6 then
			power1 = 1
		else power1 = 0 end
		if get(curs_mp2_sw) == 1 and get(fail2) < 6 then
			power2 = 1
		else power2 = 0 end
	else 
		power1 = 0
		power2 = 0
	end
	-- set current
	set(curs_mp_cc, (power1 + power2) * 3)
	local ils_sp = get(sp_ils)
	local nav_flag1 = get(cr_flag_1)
	local nav_flag2 = get(cr_flag_2)
	-- calcuate lamps and flags
	k1_lamp = (nav_flag1 == 0 or (get(gs_flag_1) == 1 and ils_sp == 0)) and power1 == 1 -- lamps will glow, when it must and there is power for them
	k2_lamp = (nav_flag2 == 0 or (get(gs_flag_2) == 1 and ils_sp == 0)) and power2 == 1
	g1_lamp = (get(gs_flag_1) == 0 or ils_sp == 0) and power1 == 1
	g2_lamp = (get(gs_flag_2) == 0 or ils_sp == 0) and power2 == 1

	
	local k1_flag_vis = 0
	if k1_lamp or power1 == 0 then k1_flag_vis = 1 end  -- flags will show when they must, or there is no power
	local k2_flag_vis = 0
	if k2_lamp or power2 == 0 then k2_flag_vis = 1 end
	local g1_flag_vis = 0
	if g1_lamp or power1 == 0 then g1_flag_vis = 1 end
	local g2_flag_vis = 0
	if g2_lamp or power2 == 0 then g2_flag_vis = 1 end
	local rsbn_flag_vis = 0
	if get(rsbn_flag) == 0 then rsbn_flag_vis = 1 end
	
	-- calculate courses 
	local course1 = 0
	local course2 = 0
	local coursersbn = 0
	local glide1 = 0
	local glide2 = 0
	local fromto1 = get(obs1_fromto)
	local fromto2 = get(obs2_fromto)
	if k1_flag_vis == 0 then course1 = -get(v_plank_1) * (fromto1 * 2 - 1) * power1 end -- check the from/to selector. it may be + here.
	if rsbn_flag_vis == 0 then coursersbn = -get(rsbn_deflection) end
	if k2_flag_vis == 0 then course2 = -get(v_plank_2) * (fromto2 * 2 - 1) * power2 end
	if g1_flag_vis == 0 then glide1 = get(h_plank_1) * power1 * ils_sp end
	if g2_flag_vis == 0 then glide2 = get(h_plank_2) * power2 * ils_sp end


	-- calculate FROM/TO lamps
	if power1 == 1 then
		if fromto1 == 0 then set(obs1_fromto_lit, nav_flag1)
		elseif nav_flag1 == 2 then set(obs1_fromto_lit, 1)
		elseif nav_flag1 == 1 then set(obs1_fromto_lit, 2)
		else set(obs1_fromto_lit, 0) end	
	else set(obs1_fromto_lit, 0) end

	if power2 == 1 then
		if fromto2 == 0 then set(obs2_fromto_lit, nav_flag2)
		elseif nav_flag2 == 2 then set(obs2_fromto_lit, 1)
		elseif nav_flag2 == 1 then set(obs2_fromto_lit, 2)
		else set(obs2_fromto_lit, 0) end	
	else set(obs2_fromto_lit, 0) end
	
	--print(course1, get(v_plank_1), (get(obs1_fromto) * 2 - 1), power1)
	
	-- add random noise deflection
	if coursersbn == 0 and math.random() > 0.997 then 
		coursersbn = (math.random() - 0.49999) * 15 * power1 
		rsbn_flag_vis = 1 - power1
	end
	if course1 == 0 and math.random() > 0.997 then 
		course1 = (math.random() - 0.49999) * 15 * power1 
		k1_lamp = false
		k1_flag_vis = 1 - power1
	end
	if course2 == 0 and math.random() > 0.997 then 
		course2 = (math.random() - 0.49999) * 15 * power2 
		k2_lamp = false
		k2_flag_vis = 1 - power1
	end
	if glide1 == 0 and math.random() > 0.997 then 
		glide1 = (math.random() - 0.49999) * 15 * power1 
		g1_lamp = false
		g1_flag_vis = 1 - power1
	end
	if glide2 == 0 and math.random() > 0.997 then 
		glide2 = (math.random() - 0.49999) * 15 * power2 
		g2_lamp = false
		g2_flag_vis = 1 - power1
	end

	-- set course and glide planks position, depending on selected source
	local sel_nav = get(nav_select)
		if sel_nav == 0 then -- selected "RSBN"
		set(curs_1, coursersbn)
		set(curs_2, coursersbn)
		set(glide_1, 0)
		set(glide_2, 0)	
		set(k1_flag, rsbn_flag_vis)
		set(k2_flag, rsbn_flag_vis)
		set(g1_flag, 1)
		set(g2_flag, 1)	
	elseif sel_nav == 1 then -- selected "RSBN-SP-50"
		set(curs_1, coursersbn)
		set(curs_2, course1)
		set(glide_1, 0)
		set(glide_2, glide1)	
		set(k1_flag, rsbn_flag_vis)
		set(k2_flag, k1_flag_vis)
		set(g1_flag, 1)
		set(g2_flag, g1_flag_vis)
	elseif sel_nav == 2 then -- selected "1"
		set(curs_1, course1)
		set(curs_2, course1)
		set(glide_1, glide1)
		set(glide_2, glide1)	
		set(k1_flag, k1_flag_vis)
		set(k2_flag, k1_flag_vis)
		set(g1_flag, g1_flag_vis)
		set(g2_flag, g1_flag_vis)
	elseif sel_nav == 3 then
		set(curs_1, course1)
		set(curs_2, course2)
		set(glide_1, glide1)
		set(glide_2, glide2)	
		set(k1_flag, k1_flag_vis)
		set(k2_flag, k2_flag_vis)
		set(g1_flag, g1_flag_vis)
		set(g2_flag, g2_flag_vis)
	else
		set(curs_1, course2)
		set(curs_2, course2)
		set(glide_1, glide2)
		set(glide_2, glide2)	
		set(k1_flag, k2_flag_vis)
		set(k2_flag, k2_flag_vis)
		set(g1_flag, g2_flag_vis)
		set(g2_flag, g2_flag_vis)
	end
	
	-- NAV bearing
	local nav1 = get(nav1_deg)
	local nav2 = get(nav2_deg)
	
	if power1 == 1 and nav1 ~= 90 then bearing1 = nav1 + (math.random() - 0.49999) * 2 
	elseif power1 == 1 then bearing1 = bearing1 + (math.random() - 0.3) * 2
	end
	
	if bearing1 > 180 then bearing1 = bearing1 - 360
	elseif bearing1 < -180 then bearing1 = bearing1 + 360 end
	
	if power2 == 1 and nav2 ~= 90 then bearing2 = nav2 + (math.random() - 0.49999) * 2 
	elseif power2 == 1 then bearing2 = bearing2 + (math.random() - 0.3) * 2
	end
	
	if bearing2 > 180 then bearing2 = bearing2 - 360
	elseif bearing2 < -180 then bearing2 = bearing2 + 360 end
	
	set(vor_1, bearing1)
	set(vor_2, bearing2)

end


components = {

	-- K1 led
	textureLit {
		image = get(red_small_led),
		position = {30, 92, 11, 11},
		visible = function()
			return k1_lamp
		end,
	},

	-- G1 led
	textureLit {
		image = get(red_small_led),
		position = {30, 49, 11, 11},
		visible = function()
			return g1_lamp
		end,
	},


	-- K2 led
	textureLit {
		image = get(red_small_led),
		position = {156, 92, 11, 11},
		visible = function()
			return k2_lamp
		end,
	},

	-- G2 led
	textureLit {
		image = get(red_small_led),
		position = {156, 49, 11, 11},
		visible = function()
			return g2_lamp
		end,
	},

	-- switcher SP-50/ILS
    switch {
        position = {  10, 120, 50, 60},
        state = function()
            return get(sp_ils) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(sp_ils) ~= 0 then
                set(sp_ils, 0)
            else
                set(sp_ils, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- switcher for MRP mode
    switch {
        position = {  140, 120, 50, 60},
        state = function()
            return get(mrp_mode) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(mrp_mode) ~= 0 then
                set(mrp_mode, 0)
            else
                set(mrp_mode, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	
	-- nav selector
    clickable {
        position = {60, 10, 40, 50},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			local a = get(nav_select)
			if a > 0 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			set(nav_select, a)
		end
    },
    clickable {
        position = {100, 10, 40, 50},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			local a = get(nav_select)
			if a < 4 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			set(nav_select, a)
		end
    },





	
}
