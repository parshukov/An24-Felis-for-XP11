-- this is the logic of Black Box system.
size = {2048, 2048}

-- collect datarefs for writing them into file
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("utc_time", globalPropertyf("sim/time/zulu_time_sec")) -- sim UTC time
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt in meters.
defineProperty("radio_alt", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot"))  -- altitude, measured by gauge
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))
defineProperty("pressure", globalPropertyf("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot"))
defineProperty("vvi", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot"))
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload
defineProperty("elevator", globalPropertyf("sim/flightmodel2/wing/elevator1_deg[0]")) -- elevator position deg. negative = UP
defineProperty("rudder", globalPropertyf("sim/flightmodel2/wing/rudder1_deg[0]")) -- rudder position deg. negative = right
defineProperty("aileron", globalPropertyf("sim/flightmodel2/wing/aileron1_deg[1]")) -- right aileron position. negative deg - right roll
defineProperty("course", globalPropertyf("sim/flightmodel/position/magpsi")) -- magnetic course
defineProperty("ikm_L", globalPropertyf("sim/custom/xap/An24_gauges/torque_left")) -- torque left
defineProperty("ikm_R", globalPropertyf("sim/custom/xap/An24_gauges/torque_left")) -- torque right
defineProperty("throttle1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))   
defineProperty("throttle2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))
defineProperty("roll", globalPropertyf("sim/custom/xap/An24_ap/indicated_roll")) -- roll for autopilot
defineProperty("pitch", globalPropertyf("sim/custom/xap/An24_ap/indicated_pitch")) -- pitch for autopilot
defineProperty("flap_deg1", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]"))  -- left flap deg

defineProperty("latitude", globalPropertyf("sim/flightmodel/position/latitude"))  -- degrees	The latitude of the aircraft
defineProperty("longitude", globalPropertyf("sim/flightmodel/position/longitude"))  -- degrees	The longitude of the aircraft

-- power
defineProperty("black_box", globalPropertyi("sim/custom/xap/An24_set/black_box"))  -- -- flight data recording
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear

-- single events
defineProperty("ice_on_plane", globalPropertyi("sim/cockpit2/annunciators/ice")) -- ice detected
defineProperty("fire_warinig", globalPropertyi("sim/custom/xap/An24_fire/fire_warinig")) -- fire warning for sirene logic
defineProperty("skv_siren", globalPropertyi("sim/custom/xap/An24_skv/skv_siren")) -- depressurisation
defineProperty("thrust_L", globalPropertyf("sim/cockpit2/engine/indicators/thrust_n[0]"))  -- engine thrust
defineProperty("thrust_R", globalPropertyf("sim/cockpit2/engine/indicators/thrust_n[1]"))  -- engine thrust
defineProperty("pitch_stop_set", globalPropertyi("sim/custom/xap/An24_prop/pitch_stop_set")) -- set up pitch mid stop
defineProperty("ap_on", globalPropertyi("sim/custom/xap/An24_ap/ap_on_lit"))  -- AP engaged light
defineProperty("high_vibro", globalPropertyi("sim/custom/xap/An24_gauges/high_vibro"))  -- high vibration
defineProperty("feather1_button", globalPropertyi("sim/custom/xap/An24_prop/feather1_button")) -- left prop feather button
defineProperty("feather2_button", globalPropertyi("sim/custom/xap/An24_prop/feather2_button")) -- right prop feather button
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   -- runway markers
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))
defineProperty("gear_down", globalPropertyi("sim/custom/xap/An24_gauges/gear_down")) -- all gears down
defineProperty("roll_high", globalPropertyf("sim/custom/xap/An24_gauges/roll_high")) -- to much roll
defineProperty("SSOS_alarm", globalPropertyi("sim/custom/xap/An24_gauges/SSOS_alarm"))  -- alarm for MSRP


defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 

local filename = panelDir.."/black_box/default_file.txt" -- current name of file

function create_file()
	-- this function creates new file with new name and stores it for further work
	local now = os.date("*t") -- take current date and time

	filename = panelDir.."/black_box/"..now["year"].."_"..now["month"].."_"..now["day"].."_"..now["hour"].."_"..now["min"]..".txt"
	
	local savefile = io.open(filename, "w")
	if savefile then
		savefile:write("this is the flight recordings. all parameters divided by TABs \n")
		savefile:write("sim zulu time \t")
		savefile:write("LAT \t")
		savefile:write("LONG \t")
		savefile:write("MSL alt \t")
		savefile:write("radio alt \t")
		savefile:write("baro alt \t")
		savefile:write("baro press \t")
		savefile:write("V/S \t")
		savefile:write("IAS \t")
		savefile:write("G-load \t")
		savefile:write("aileron deg \t")
		savefile:write("elevator deg \t")
		savefile:write("rudder deg \t")
		savefile:write("roll deg \t")
		savefile:write("pitch deg \t")
		savefile:write("mag course \t")
		savefile:write("torque L \t")
		savefile:write("torque R \t")
		savefile:write("throt L \t")
		savefile:write("throt R \t")
		savefile:write("flaps pos \t")
		savefile:write("single commands and failures \t")
		
		savefile:write("\n\n")
		savefile:close()
		return true
	else
		print("error saving file. check if there is \"black_box\" folder here: "..panelDir.. " and permissions for it")
		return false
	end
	
end


function write_file() -- write parameters to file
	local savefile = io.open(filename, "a")
	if savefile then
		savefile:write(convert_time(), "\t")
		savefile:write(math.floor(get(latitude) * 1000000 + 0.5) * 0.000001, "\t")
		savefile:write(math.floor(get(longitude) * 1000000 + 0.5) * 0.000001, "\t")
		savefile:write(math.floor(get(msl_alt) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(radio_alt) * 0.3048 * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(altitude) * 0.3048 * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(pressure) * 25.3970886 * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(vvi) * 0.00508 * 10 +0.5) * 0.1, "\t")
		savefile:write(math.floor(get(ias) * 1.852 * 10 +0.5) * 0.1, "\t")
		savefile:write(math.floor(get(gforce) * 100 + 0.5) * 0.01, "\t")
		local ailer = -get(aileron)
		if ailer < 0 then ailer = ailer * 1.5 end
		savefile:write(math.floor(ailer * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(-get(elevator) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(-get(rudder) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(roll) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(pitch) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(course) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(ikm_L) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(ikm_R) * 10 + 0.5) * 0.1, "\t")
		savefile:write(math.floor(get(throttle1) * 100 + 0.5), "\t")
		savefile:write(math.floor(get(throttle2) * 100 + 0.5), "\t")
		savefile:write(math.floor(get(flap_deg1) * 10 + 0.5) * 0.1, "\t")
		
		-- single signals
		if get(ice_on_plane) == 1 then savefile:write("icing,  ")end
		if get(fire_warinig) == 1 then savefile:write("fire,  ")end
		if get(skv_siren) == 1 then savefile:write("cab_alt,  ")end
		if get(thrust_L) < 0 then savefile:write("eng_L_neg,  ")end
		if get(thrust_R) < 0 then savefile:write("eng_R_neg,  ")end
		if get(pitch_stop_set) == 0 then savefile:write("props_nostop,  ")end
		if get(ap_on) == 1 then savefile:write("AP_ON,  ")end
		if get(high_vibro) == 1 then savefile:write("eng_stress,  ")end
		if get(feather1_button) == 1 or get(feather2_button) == 1 then savefile:write("prop_feather,  ")end
		if get(outer_marker) == 1 then savefile:write("Out_mark,  ")end
		if get(middle_marker) == 1 then savefile:write("Mid_mark,  ")end
		if get(inner_marker) == 1 then savefile:write("In_mark,  ")end
		if get(gear_down) == 1 then savefile:write("LG_down,  ")end
		if get(roll_high) == 1 then savefile:write("roll_high,  ")end
		if get(SSOS_alarm) == 1 then savefile:write("TAWS,  ")end
		
		savefile:write("\n")
		savefile:close()
		return true
	else
		print("cannot write into file")
		return false
	end

end

function convert_time()
	-- this function returns current zulu time in HH:MM:SS format string
	local time_sec = get(utc_time)
	local hours = math.floor(time_sec/3600)
	local minutes = math.floor(time_sec/60 - hours * 60)
	local sec = math.floor(time_sec - hours * 3600 - minutes * 60)
	
	if hours < 10 then hours = "0"..hours end
	if minutes < 10 then minutes = "0"..minutes end
	if sec < 10 then sec = "0"..sec end

	return hours..":"..minutes..":"..sec
	
end

local created = false -- flag fof successfully created file
local started = false -- flag for started logic and create faile once
local save_counter = 0

local power = true -- when power == 1 - system is working

function update()
	local passed = get(frame_time)
	
	-- check the power
	power = get(black_box) == 1 and get(bus_DC_27_volt) > 20 and (get(ias) * 1.852 > 70 or get(gear2_deflect) < 0.05) -- black box worknig when there is power and airplane is flying
	
	if not power then -- if system is OFF, then do nothing
		created = false
		started = false
	end

	if not started and power then -- when system turns ON, start new file
		created = create_file()
		started = true
	end
	
	if passed > 0 then
		save_counter = save_counter + passed
		if save_counter > 1 and created and power then -- when system turns ON, write the file
			save_counter = 0
			write_file() -- save data
		end
	end
	
end


components = {
	
	-- MSRP light
	textureLit {
		position = {740, 307, 20, 20},
		image = get(green_led),
		visible = function()
			return power
		end
	},

}