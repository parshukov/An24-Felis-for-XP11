defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

-- coordinates of airplane and camera
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) -- position X
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) -- position Y
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) -- position Z

defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) -- camera position X
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) -- camera position Y
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) -- camera position Z



-- window wind
local wind_sound = loadSample('Custom Sounds/window_wind.wav')
-- engine sounds in windows
local eng_snd_1 = loadSample('Custom Sounds/an24 engn1_out.wav')
local eng_snd_2 = loadSample('Custom Sounds/an24 engn2_out.wav')
local eng_snd_3 = loadSample('Custom Sounds/an24 engn3_out.wav')

playSample(eng_snd_1, 1) -- engine sound
playSample(eng_snd_2, 1) -- engine sound
playSample(eng_snd_3, 1) -- engine sound

setSampleGain(eng_snd_1, 0)
setSampleGain(eng_snd_2, 0)
setSampleGain(eng_snd_3, 0)

local last_dist = 0

playSample(wind_sound, 1) -- wind in windows
setSampleGain(wind_sound, 0)

defineProperty("hole1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[2]"))  
defineProperty("hole2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[3]")) 
defineProperty("ias", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))

-- props idle sounds
local prop_out_1 = loadSample('Custom Sounds/prop_idle_out.wav')
local prop_out_2 = loadSample('Custom Sounds/prop_idle_out.wav')

playSample(prop_out_1, 1) -- prop sound
playSample(prop_out_2, 1) -- prop sound

setSampleGain(prop_out_1, 0)
setSampleGain(prop_out_2, 0)

defineProperty("prop_pitch_1", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[0]")) -- propeller pitch
defineProperty("prop_pitch_2", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[1]"))

defineProperty("eng1_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("ru19_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm



local last_dist = 0

function update()

	local passed = get(frame_time)
	local power = get(bus_DC_27_volt) > 20 or get(bus_DC_27_volt_emerg)> 20
	local external = get(external_view) -- 0 = inside, 1 = external
	
	local camera_distance = math.sqrt(((get(view_x)-get(local_x))^2)+((get(view_y)-get(local_y))^2)+((get(view_z)-get(local_z))^2)) -- in meters
	if camera_distance < 10 then camera_distance = 10 end -- limit minimum distance
	
	local dist_coef = 200 / camera_distance ^ 1.1
	if dist_coef > 1 then dist_coef = 1 end
	-- calculate camera/aircraft speed
	local spd_time = math.min(0.0001, passed)
	local camera_spd = -(camera_distance - last_dist) / spd_time
	
	last_dist = camera_distance
	
	local dopp_coef = camera_spd * 0.02
	if dopp_coef > 400 then dopp_coef = 300
	elseif dopp_coef < -300 then dopp_coef = -300 end
	
	--print(camera_distance)
	
	
	-- noise when open windows in flight
	local window_open = math.max(get(hole1), get(hole2))
	local spd = get(ias) * 0.5
	local wind_gain = math.min(1000, window_open * spd * 10) * (1 - external)
	setSampleGain(wind_sound, wind_gain)
	
	-- prop sounds
	local prop_angle_1 = get(prop_pitch_1)
	local prop_angle_2 = get(prop_pitch_2)
	
	if prop_angle_1 < 1 then prop_angle_1 = 1 end
	if prop_angle_2 < 1 then prop_angle_2 = 1 end
	
	local prop_loud_1 = 1000 / prop_angle_1
	local prop_loud_2 = 1000 / prop_angle_2
	
	local N1 = get(eng1_N1) * 0.01
	local N2 = get(eng2_N1) * 0.01
	local N3 = get(ru19_N1) * 0.01
	
	
	--setSampleGain(prop_inn_1, prop_loud_1 * (1 - external) * 2 * N1)
	--setSampleGain(prop_inn_2, prop_loud_2 * (1 - external) * 2 * N2)
	setSampleGain(prop_out_1, prop_loud_1 * (external + window_open * (1 - external)) * N1 * dist_coef)
	setSampleGain(prop_out_2, prop_loud_2 * (external + window_open * (1 - external)) * N2 * dist_coef)
	
	--setSamplePitch(prop_inn_1, 1000 * N1)
	--setSamplePitch(prop_inn_2, 1000 * N2)
	setSamplePitch(prop_out_1, 1000 * N1 + dopp_coef)
	setSamplePitch(prop_out_2, 1000 * N2 + dopp_coef)
	
	-- engine sounds
--[[

	setSampleGain(eng_snd_1, 800 * (external + window_open * (1 - external)) * N1 * dist_coef)
	setSampleGain(eng_snd_2, 800 * (external + window_open * (1 - external)) * N2 * dist_coef)
	setSampleGain(eng_snd_3, 1000 * (external + window_open * (1 - external)) * N3 * dist_coef)
	
	setSamplePitch(eng_snd_1, 1000 * N1 + dopp_coef)
	setSamplePitch(eng_snd_2, 1000 * N2 + dopp_coef)
	setSamplePitch(eng_snd_3, 1000 * N3 + dopp_coef)
--]]	
	
	setSampleGain(eng_snd_1, 500 * N1 *  window_open * (1 - external))
	setSampleGain(eng_snd_2, 500 * N2 *  window_open * (1 - external))
	setSampleGain(eng_snd_3, 1000 * N3 *  window_open * (1 - external))
	
	setSamplePitch(eng_snd_1, 1000 * N1)
	setSamplePitch(eng_snd_2, 1000 * N2)
    setSamplePitch(eng_snd_3, 1000 * N3)	

	--print("work")

	
	
	
	

end