defineProperty("siren_flaps", globalPropertyi("sim/custom/xap/An24_gauges/flaps_siren"))
defineProperty("siren_auasp", globalPropertyi("sim/custom/xap/An24_gauges/auasp_warning"))
defineProperty("siren_ssos", globalPropertyi("sim/custom/xap/An24_gauges/ssos_warning"))
defineProperty("siren_fire", globalPropertyi("sim/custom/xap/An24_fire/fire_warinig"))
defineProperty("siren_gears", globalPropertyi("sim/custom/xap/An24_gauges/gear_siren"))
defineProperty("skv_siren", globalPropertyi("sim/custom/xap/An24_skv/skv_siren")) 
defineProperty("skv_siren_alarm", globalPropertyi("sim/custom/xap/An24_skv/skv_siren_alarm")) 

defineProperty("siren_armed", globalPropertyf("sim/cockpit/weapons/guns_armed"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time between frames
defineProperty("siren_button", globalPropertyi("sim/custom/xap/An24_gauges/siren_button")) -- button for temporary OFF sirene

defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

-- create commands for siren button
button_comm = findCommand("sim/annunciator/gear_warning_mute")  -- command for buzzer button

function button_handler (phase)
	if 1 == phase then
		set(siren_button, 1)
	else
		set(siren_button, 0)
	end
	return 0
end

registerCommandHandler(button_comm, 0, button_handler)

local counter = 0
local flaps_last = get(siren_flaps)
local gars_last = get(siren_gears)
local fire_last = get(siren_fire)
local skv_last = get(skv_siren)
local button_pressed = false

local siren_sound = loadSample('Custom Sounds/siren.wav')



function update()

	local button = get(siren_button)
	local external = get(external_view) -- 0 = inside, 1 = external
	
	local flaps = get(siren_flaps)
	local auasp = get(siren_auasp)
	local ssos = get(siren_ssos)
	local gears = get(siren_gears)
	local fire = get(siren_fire)
	local skv = get(skv_siren)
	local skv_alarm = get(skv_siren_alarm)
	
	if button == 1 then button_pressed = true end  -- if button pressed - siren will not work further, till new event come
	
	if (flaps == 1 or auasp == 1 or ssos == 1 or fire == 1 or gears == 1 or skv_alarm == 1) and not button_pressed then 
		if not isSamplePlaying(siren_sound) then playSample(siren_sound, 1) end
	else stopSample(siren_sound) end
	
	if flaps ~= flaps_last or gears ~= gars_last or fire ~= fire_last or auasp == 1 or ssos == 1 or skv ~= skv_last then button_pressed = false end  -- if some event come - logical button is released
	
	flaps_last = flaps
	gars_last = gears
	fire_last = fire
	skv_last = skv
	
	-- set loudness for external view
	setSampleGain(siren_sound, 800 * (1 - external))
	
	
end



