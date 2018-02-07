-- this is engineer's sounds

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("radioalt", globalPropertyf("sim/custom/xap/An24_gauges/radioalt"))
defineProperty("vvi", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot"))

defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  -- vertical deflection of front gear
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
defineProperty("gear3_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of right gear

defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  -- deploy of front gear
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear

defineProperty("uprt1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))   
defineProperty("uprt2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))

defineProperty("radioalt_dh", globalPropertyi("sim/custom/xap/An24_gauges/radioalt_dh")) -- radio altitude is decision height

-- SmartCopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))  -- 0 - не определено/плагин не найден, 1- слейв, 2 - мастер



-- define all sounds
local speed_up = loadSample('Crew_sounds/nav_speed_up.wav')
local speed_100 = loadSample('Crew_sounds/nav_speed_100.wav')
local speed_120 = loadSample('Crew_sounds/nav_speed_120.wav')
local speed_140 = loadSample('Crew_sounds/nav_speed_140.wav')
local speed_160 = loadSample('Crew_sounds/nav_speed_160.wav')
local speed_v1 = loadSample('Crew_sounds/nav_v1.wav')
--local speed_200 = loadSample('Crew_sounds/nav_speed_200.wav')
local speed_220 = loadSample('Crew_sounds/nav_speed_220.wav')
--local speed_250 = loadSample('Crew_sounds/nav_speed_250.wav')
local rotate = loadSample('Crew_sounds/nav_rotate.wav')
local alt_safe = loadSample('Crew_sounds/nav_safe.wav')
local alt_600 = loadSample('Crew_sounds/nav_alt_600.wav')
local alt_500 = loadSample('Crew_sounds/nav_alt_500.wav')
local alt_400 = loadSample('Crew_sounds/nav_alt_400.wav')
local alt_300 = loadSample('Crew_sounds/nav_alt_300.wav')
local alt_200 = loadSample('Crew_sounds/nav_alt_200.wav')
local alt_100 = loadSample('Crew_sounds/nav_alt_100.wav')
local alt_60 = loadSample('Crew_sounds/nav_alt_60.wav')
local alt_50 = loadSample('Crew_sounds/nav_alt_50.wav')
local alt_40 = loadSample('Crew_sounds/nav_alt_40.wav')
local alt_30 = loadSample('Crew_sounds/nav_alt_30.wav')
local alt_20 = loadSample('Crew_sounds/nav_alt_20.wav')
local alt_10 = loadSample('Crew_sounds/nav_alt_10.wav')
local alt_5 = loadSample('Crew_sounds/nav_alt_5.wav')
local alt_4 = loadSample('Crew_sounds/nav_alt_4.wav')
local alt_3 = loadSample('Crew_sounds/nav_alt_3.wav')
local alt_2 = loadSample('Crew_sounds/nav_alt_2.wav')
local alt_1 = loadSample('Crew_sounds/nav_alt_1.wav')
local rating = loadSample('Crew_sounds/nav_rating.wav')



local speed_up_was = false --
local speed_100_was = false --
local speed_120_was = false --
local speed_140_was = false --
local speed_160_was = false --
local speed_v1_was = false --
--local speed_200_was = false
local speed_220_was = false --
--local speed_250_was = false
local rotate_was = false --
local alt_safe_was = false --
local alt_600_was = false --
local alt_500_was = false --
local alt_400_was = false --
local alt_300_was = false --
local alt_200_was = false --
local alt_100_was = false --
local alt_60_was = false --
local alt_50_was = false --
local alt_40_was = false --
local alt_30_was = false --
local alt_20_was = false --
local alt_10_was = false --
local alt_5_was = false --
local alt_4_was = false --
local alt_3_was = false --
local alt_2_was = false --
local alt_1_was = false --
local rating_was = false --




local speech_timer = 20 -- if this timer > 0 then there is some phrase playing and other phrases have to wait.
local v_ias_last = 0


function update()

	local cpl_active = get(ismaster) == 1 or get(ismaster) == 2

	local passed = get(frame_time)
	local external = get(external_view) == 1
	
	local v_ias = get(ias) * 1.852 -- km/h
	local r_alt = get(radioalt) -- m
	local v_spd = get(vvi) * 0.00508 -- m/s
	
	local gear_defl = get(gear1_deflect) + get(gear2_deflect) + get(gear3_deflect)
	local gear_dep = get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy)
	local ruds = get(uprt1) + get(uprt2)

	speech_timer = speech_timer - passed
	if speech_timer < 0 then speech_timer = 0 end
	
	if speech_timer == 0 and not external and not cpl_active then -- here goes speech logic
		-- takeoff phrases
		if gear_defl > 0.1 and ruds > 1.6 and gear_dep > 2.9 then -- we are on ground and taking off
			if v_ias > v_ias_last and v_ias > 50 and v_ias < 55 and not speed_up_was then -- speeding up
				playSample(speed_up, 0)
				speed_up_was = true
				speed_100_was = false
				speed_120_was = false
				speech_timer = 1
			elseif v_ias > v_ias_last and v_ias > 95 and v_ias < 105 and not speed_100_was then -- speed 100
				playSample(speed_100, 0)
				speech_timer = 1 
				speed_100_was = true
				speed_120_was = false
			elseif v_ias > v_ias_last and v_ias > 115 and v_ias < 125 and not speed_120_was then -- speed 120
				playSample(speed_120, 0)
				speech_timer = 1 
				speed_120_was = true
				speed_140_was = false
			elseif v_ias > v_ias_last and v_ias > 135 and v_ias < 145 and not speed_140_was then -- speed 140
				playSample(speed_140, 0)
				speech_timer = 1 	
				speed_140_was = true
				speed_160_was = false
			elseif v_ias > v_ias_last and v_ias > 155 and v_ias < 165 and not speed_160_was then -- speed 160
				playSample(speed_160, 0)
				speech_timer = 1 
				speed_160_was = true
				speed_v1_was = false
			elseif v_ias > v_ias_last and v_ias > 175 and v_ias < 185 and not speed_v1_was then -- speed 180, V1
				playSample(speed_v1, 0)
				speech_timer = 1
				speed_v1_was = true
				rotate_was = false
			elseif v_ias > v_ias_last and v_ias > 195 and v_ias < 205 and not rotate_was then -- speed 200, Vr
				playSample(rotate, 0)
				speech_timer = 1 
				speed_220_was = false
				rotate_was = true
			elseif v_ias > v_ias_last and v_ias > 215 and v_ias < 225 and not speed_220_was then -- speed 220
				playSample(speed_220, 0)
				speech_timer = 1 
				speed_220_was = true
			end
		-- we just taked off and ready to retract L.G.
		elseif v_spd > 1 and r_alt > 5 and r_alt < 25 and gear_dep > 2.9 and ruds > 1.4 and not alt_safe_was then		
			playSample(alt_safe, 0)
			alt_safe_was = true
			speech_timer = 1 		
		-- determine if we are descending for landing
		elseif v_spd < 0 and ruds < 1.4 then
			if r_alt > 595 and r_alt < 605 and not alt_600_was then -- alt 600
				playSample(alt_600, 0)
				speech_timer = 2 
				alt_600_was = true
				alt_500_was = false
			elseif r_alt > 495 and r_alt < 505 and not alt_500_was then -- alt 500
				playSample(alt_500, 0)
				speech_timer = 2 
				alt_600_was = false
				alt_500_was = true
				alt_400_was = false
			elseif r_alt > 395 and r_alt < 405 and not alt_400_was then -- alt 400
				playSample(alt_400, 0)
				speech_timer = 1 
				alt_500_was = false
				alt_400_was = true
				alt_300_was = false			
			elseif r_alt > 295 and r_alt < 305 and not alt_300_was then -- alt 300
				playSample(alt_300, 0)
				speech_timer = 1 
				alt_400_was = false
				alt_300_was = true
				alt_200_was = false	
			elseif r_alt > 195 and r_alt < 205 and not alt_200_was then -- alt 200
				playSample(alt_200, 0)
				speech_timer = 1 
				alt_300_was = false
				alt_200_was = true
				alt_100_was = false
			elseif get(radioalt_dh) == 1 and not rating_was and not (gear_defl > 0.2 and gear_dep > 2.9 and v_ias < 40) then -- decission callout
				playSample(rating, 0)
				speech_timer = 1 	
				rating_was = true
				-- reset takeoff callouts
				speed_up_was = false 
				speed_100_was = false 
				speed_120_was = false 
				speed_140_was = false 
				speed_160_was = false 
				speed_v1_was = false
				speed_200_was = false
				speed_220_was = false
				rotate_was = false			
				alt_safe_was = false			
			elseif r_alt > 95 and r_alt < 105 and not alt_100_was then -- alt 100
				playSample(alt_100, 0)
				speech_timer = 1 
				alt_200_was = false
				alt_100_was = true
				alt_60_was = false
			elseif r_alt > 57 and r_alt < 63 and not alt_60_was then -- alt 60
				playSample(alt_60, 0)
				speech_timer = 1 
				alt_100_was = false
				alt_60_was = true
				alt_50_was = false
			elseif r_alt > 47 and r_alt < 53 and not alt_50_was then -- alt 50
				playSample(alt_50, 0)
				speech_timer = 1 
				alt_60_was = false
				alt_50_was = true
				alt_40_was = false
			elseif r_alt > 37 and r_alt < 43 and not alt_40_was then -- alt 40
				playSample(alt_40, 0)
				speech_timer = 1 
				alt_50_was = false
				alt_40_was = true
				alt_30_was = false
			elseif r_alt > 27 and r_alt < 33 and not alt_30_was then -- alt 30
				playSample(alt_30, 0)
				speech_timer = 1 
				alt_40_was = false
				alt_30_was = true
				alt_20_was = false
			elseif r_alt > 17 and r_alt < 23 and not alt_20_was then -- alt 20
				playSample(alt_20, 0)
				speech_timer = 1 
				alt_30_was = false
				alt_20_was = true
				alt_10_was = false	
			elseif r_alt > 8 and r_alt < 12 and not alt_10_was then -- alt 10
				playSample(alt_10, 0)
				speech_timer = 1 
				alt_20_was = false
				alt_10_was = true
				alt_5_was = false
			elseif r_alt > 4.6 and r_alt < 5.4 and not alt_5_was then -- alt 5
				playSample(alt_5, 0)
				speech_timer = 1 
				alt_10_was = false
				alt_5_was = true
				alt_4_was = false
			elseif r_alt > 3.6 and r_alt < 4.4 and not alt_4_was then -- alt 4
				playSample(alt_4, 0)
				speech_timer = 1 
				alt_5_was = false
				alt_4_was = true
				alt_3_was = false
			elseif r_alt > 2.6 and r_alt < 3.4 and not alt_3_was then -- alt 3
				playSample(alt_3, 0)
				speech_timer = 1 
				alt_4_was = false
				alt_3_was = true
				alt_2_was = false
			elseif r_alt > 1.6 and r_alt < 2.4 and not alt_2_was then -- alt 2
				playSample(alt_2, 0)
				speech_timer = 1 
				alt_3_was = false
				alt_2_was = true
				alt_1_was = false
			elseif r_alt > 0.6 and r_alt < 1.4 and not alt_1_was then -- alt 1
				playSample(alt_1, 0)
				speech_timer = 1 
				alt_3_was = false
				alt_2_was = false
				alt_1_was = true				
			end	
		elseif (gear_defl > 0.2 and gear_dep > 2.9 and v_ias < 40) or r_alt > 700 then-- we are on ground, standing or taxiing. or fliying high
			-- reset all takeoff phrases
			speed_up_was = false 
			speed_100_was = false 
			speed_120_was = false 
			speed_140_was = false 
			speed_160_was = false 
			speed_v1_was = false
			speed_200_was = false
			speed_220_was = false
			rotate_was = false			
			alt_safe_was = false
			-- reset all descend phrases
			alt_600_was = false --
			alt_500_was = false --
			alt_400_was = false --
			alt_300_was = false --
			alt_200_was = false --
			alt_100_was = false --
			alt_60_was = false --
			alt_50_was = false --
			alt_40_was = false --
			alt_30_was = false --
			alt_20_was = false --
			alt_10_was = false --
			alt_5_was = false --
			alt_4_was = false --
			alt_3_was = false --
			alt_2_was = false --
			alt_1_was = false --
			rating_was = false -- 
		end

	
		
		
	
	end

	v_ias_last = v_ias
	
end