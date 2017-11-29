-- this is light logic

-- define property table

defineProperty("nav_light_sw", globalPropertyi("sim/custom/xap/An24_misc/nav_light_sw")) -- nav lights and beacons switch
defineProperty("lan_light_sw", globalPropertyi("sim/custom/xap/An24_misc/lan_light_sw")) -- landing lights switch
defineProperty("lan_light_open_sw", globalPropertyi("sim/custom/xap/An24_misc/lan_light_open_sw")) -- landing lights switch
defineProperty("nav_light", globalPropertyf("sim/custom/xap/An24_misc/nav_light")) -- nav light can shine
defineProperty("beacon_light", globalPropertyf("sim/custom/xap/An24_misc/beacon_light")) -- beacon light ratio
defineProperty("azs_beacon_down", globalPropertyf("parshukovedition/beacon_down"))
defineProperty("azs_beacon_up", globalPropertyf("parshukovedition/beacon_up"))

defineProperty("cockpit_red", globalPropertyf("sim/custom/xap/An24_misc/cockpit_red")) -- red cockpit light rotary
defineProperty("cockpit_spot1", globalPropertyf("sim/custom/xap/An24_misc/cockpit_spot1")) -- cockpit spotlight rotary
defineProperty("cockpit_spot2", globalPropertyf("sim/custom/xap/An24_misc/cockpit_spot2")) -- cockpit spotlight rotary
defineProperty("cockpit_panel", globalPropertyf("sim/custom/xap/An24_misc/cockpit_panel")) -- cockpit spotlight rotary

-- sim variables
defineProperty("sim_lan_light_angle", globalPropertyf("sim/aircraft/view/acf_lanlite_the")) -- angle of OpenGL light
defineProperty("sim_taxi_light_sw", globalPropertyf("sim/cockpit/electrical/taxi_light_on")) -- sim landing light switcher
defineProperty("sim_lan_light_sw", globalPropertyf("sim/cockpit/electrical/landing_lights_on")) -- sim landing light switcher
defineProperty("sim_nav_light_sw", globalPropertyf("sim/cockpit/electrical/nav_lights_on")) -- sim nav light switcher
defineProperty("sim_bec_light_sw", globalPropertyf("sim/cockpit/electrical/beacon_lights_on")) -- sim nav light switcher
defineProperty("sim_lan_light_ratio", globalPropertyf("sim/cockpit2/switches/landing_lights_switch[0]")) -- landing lights switch
defineProperty("sim_lan_light_slider", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[17]")) -- landing lights position
defineProperty("sim_lan_light_open", globalPropertyf("sim/cockpit2/switches/custom_slider_on[17]")) -- landing lights open/close

-- cockpit lights
defineProperty("sim_panel_light", globalPropertyf("sim/cockpit2/switches/panel_brightness_ratio[0]")) -- 2D panel light
defineProperty("sim_cab_light1", globalPropertyf("sim/cockpit2/switches/panel_brightness_ratio[1]")) -- cockpit flood
defineProperty("sim_cab_light2", globalPropertyf("sim/cockpit2/switches/panel_brightness_ratio[2]")) -- cockpit spotlight
defineProperty("sim_cab_light3", globalPropertyf("sim/cockpit2/switches/panel_brightness_ratio[3]")) -- cockpit spotlight

-- power
defineProperty("nav_light_cc", globalPropertyf("sim/custom/xap/An24_misc/nav_light_cc")) -- light current consumption
defineProperty("bec_light_cc", globalPropertyf("sim/custom/xap/An24_misc/bec_light_cc")) -- light current consumption
defineProperty("lan_light_cc", globalPropertyf("sim/custom/xap/An24_misc/lan_light_cc")) -- light current consumption
defineProperty("cockpit_light_cc", globalPropertyf("sim/custom/xap/An24_misc/cockpit_light_cc")) -- light current consumption

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

defineProperty("rel_wing1L", globalPropertyi("sim/operation/failures/rel_wing1L"))  -- Wing separations
defineProperty("rel_wing2L", globalPropertyi("sim/operation/failures/rel_wing2L"))  -- Wing separations
defineProperty("rel_wing3L", globalPropertyi("sim/operation/failures/rel_wing3L"))  -- Wing separations
defineProperty("rel_wing4L", globalPropertyi("sim/operation/failures/rel_wing4L"))  -- Wing separations
defineProperty("rel_wing1R", globalPropertyi("sim/operation/failures/rel_wing1R"))  -- Wing separations
defineProperty("rel_wing2R", globalPropertyi("sim/operation/failures/rel_wing2R"))  -- Wing separations
defineProperty("rel_wing3R", globalPropertyi("sim/operation/failures/rel_wing3R"))  -- Wing separations
defineProperty("rel_wing4R", globalPropertyi("sim/operation/failures/rel_wing4R"))  -- Wing separations


-- time from simulator start
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("sim_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time
defineProperty("sim_version", globalPropertyi("sim/custom/xap/sim_version"))  -- saved sim version

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

-- commands
-- switch landing light
lan_light_command = findCommand("sim/lights/landing_lights_toggle")
function lan_light_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then 
		if get(lan_light_sw) == 0 then
			set(lan_light_sw, 1)
			set(lan_light_open_sw, 1)
		else
			set(lan_light_sw, 0)
			set(lan_light_open_sw, 0)			
		end
    end
return 0
end
registerCommandHandler(lan_light_command, 0, lan_light_handler)

-- switch taxi light
taxi_light_command = findCommand("sim/lights/taxi_lights_toggle")
function taxi_light_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then 
		if get(lan_light_sw) == 0 then
			set(lan_light_sw, -1)
			set(lan_light_open_sw, 1)
		else
			set(lan_light_sw, 0)
			set(lan_light_open_sw, 0)			
		end
    end
return 0
end
registerCommandHandler(taxi_light_command, 0, taxi_light_handler)



local time_counter = 0
local not_loaded = true


-- local variables
local now = get(sim_time)
local FREQ = 8
local angle = -8

function update()
	-- time variables
	now = get(sim_time)
	local passed = get(frame_time)
if passed > 0 and passed < 0.1 then

	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(nav_light_sw, 0)
		set(sim_taxi_light_sw, 0)
		set(sim_bec_light_sw, 0)
		set(sim_lan_light_sw, 0)
		not_loaded = false
	end
	
	-- power calculations
	local power27 = get(bus_DC_27_volt) 
	local power_em = get(bus_DC_27_volt_emerg)
	local ano_switch = get(nav_light_sw)

	-- nav light logic
	local nav_bright = 0
	if power_em * ano_switch > 21 then nav_bright = (power_em - 10) * ano_switch / 17 end -- nav lights will fade out when power loss
	if nav_bright > 1 then nav_bright = 1 end
	set(nav_light, nav_bright)
	set(nav_light_cc, nav_bright * 8)
	-- set default switch
	if nav_bright > 0 then set(sim_nav_light_sw, 1) else set(sim_nav_light_sw, 0) end
	-- wing separation will turn off the external lights. i'm too lazy to make it in 3D
	if get(rel_wing1L) == 6 or get(rel_wing2L) == 6 or get(rel_wing2L) == 6 or get(rel_wing2L) == 6 or get(rel_wing1R) == 6 or get(rel_wing2R) == 6 or get(rel_wing3R) == 6 or get(rel_wing4R) == 6 then set(sim_nav_light_sw, 0) end
	
	-- beacons logic
	--if get(azs_beacon_down)==1 then
		local bec_bright = 0
	if power27 * ano_switch > 21 then 
		if get(sim_version) ~= 10 then bec_bright = (math.sin(now * FREQ) + 0.5) * (power27 - 10) / (2 * 15) else bec_bright = 0 end
		--set(sim_bec_light_sw, 1)
	else --set(sim_bec_light_sw, 0)
	end 
	if power27 > 21 then
	if get(azs_beacon_down)==1 or get(azs_beacon_up)==1 then
		set(sim_bec_light_sw,1)
	else
		set(sim_bec_light_sw,0)
	end
	end
	set(beacon_light, bec_bright)
	set(bec_light_cc, bec_bright * 8)
	--else
	--set(sim_bec_light_sw, 0)
	
	--end
	
	-- landing light logic
	local lan_sw = get(lan_light_sw)
	local lan_brt = 0 
	if power27 > 21 and lan_sw == 1 then
		lan_brt = 1 -- 0.7
	elseif power27 > 21 and lan_sw == -1 then
		lan_brt = 1 --0.4
	else 
		lan_brt = 0
	end
	set(lan_light_cc, 20 * lan_brt)
	
	-- open landing light
	if power27 > 21 then set(sim_lan_light_open, get(lan_light_open_sw)) end
	--print(get(sim_lan_light_open))
	-- set angle for light
	 
	if lan_sw ~= 0 then angle = -9 - 90 * (-get(sim_lan_light_slider) + 1) + lan_sw * 1.5 end
	if angle < -30 then lan_brt = 0 end
	--print(lan_brt)
	if lan_brt > 0 then 
		set(sim_lan_light_sw, 1) 
		--set(sim_taxi_light_sw, 1)
	else 
		set(sim_lan_light_sw, 0) 
		--set(sim_taxi_light_sw, 0)
	end
	set(sim_taxi_light_sw, 0)
	
	
	set(sim_lan_light_angle, angle)
	set(sim_lan_light_ratio, lan_brt)	
	-- button for open landing lights
	-- set(sim_lan_light_ratio, 0.5)
	
	-- cockpit light
	local panel_ratio = get(cockpit_panel)
	if panel_ratio == 1 then panel_ratio = 2
	elseif panel_ratio == -1 then panel_ratio = 1.5
	else panel_ratio = 0 end

	local cockpit_ratio = get(cockpit_red)
	local spot1 = get(cockpit_spot1)
	local spot2 = get(cockpit_spot2)
	if power_em > 21 then
		set(sim_panel_light, math.max(panel_ratio, (cockpit_ratio * 2 + spot1 + spot2) / 1.5, 0.1))
		set(sim_cab_light1, cockpit_ratio * 1.5 + 0.1)
		set(sim_cab_light2, spot1 * 1.5 + 0.1)
		set(sim_cab_light3, spot2 * 1.5 + 0.1)
		set(cockpit_light_cc, panel_ratio * 4 + cockpit_ratio * 15 + spot1 * 4 + spot2 * 4)
	else 	
		set(sim_panel_light, 0.1)
		set(sim_cab_light1, 0.1)
		set(sim_cab_light2, 0.1)
		set(sim_cab_light3, 0.1)
		set(cockpit_light_cc, 0)
	end
	
	
end

end