size = {2048, 2048}

-- define images
defineProperty("tapeImage", loadImage("ag_tape.dds", 0, 0, 256, 1024))
defineProperty("planeImage", loadImage("needles.dds", 73, 1, 121, 27))
defineProperty("flagImage", loadImage("needles.dds", 85, 36, 58, 22))
defineProperty("triangle", loadImage("triangle.png", 0, 0, 8, 8))
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20))
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20))
defineProperty("left_ahz_fail_txt", loadImage("lamps.dds", 0, 0, 50, 30))
defineProperty("right_ahz_fail_txt", loadImage("lamps.dds", 100, 0, 50, 30))
defineProperty("third_ahz_fail_txt", loadImage("lamps.dds", 50, 0, 50, 30))
defineProperty("roll_left_txt", loadImage("lamps.dds", 150, 0, 50, 30))
defineProperty("roll_right_txt", loadImage("lamps.dds", 200, 0, 50, 30))
defineProperty("check_ahz_txt", loadImage("lamps.dds", 0, 30, 50, 30))
defineProperty("planka", loadImage("ag_tape.dds", 0, 156, 10, 200))

-- define component property table.
defineProperty("pitch_left", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll_left", globalPropertyf("sim/flightmodel/position/phi"))
defineProperty("pitch_right", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll_right", globalPropertyf("sim/flightmodel/position/phi"))
--defineProperty("slip", globalPropertyf("sim/flightmodel/misc/slip"))
--defineProperty("turn", globalPropertyf("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot"))
-- ias variable
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt"))
defineProperty("AGB_left", globalPropertyi("sim/custom/xap/An24_gauges/AGB_left"))
defineProperty("AGD_left", globalPropertyi("sim/custom/xap/An24_gauges/AGD_left"))
defineProperty("AGD_right", globalPropertyi("sim/custom/xap/An24_gauges/AGD_right"))
defineProperty("AHZ_cc", globalPropertyf("sim/custom/xap/An24_gauges/AHZ_cc"))
defineProperty("bkk_sw", globalPropertyi("sim/custom/xap/An24_gauges/bkk_sw"))
defineProperty("bkk_sw_cap", globalPropertyi("sim/custom/xap/An24_gauges/bkk_sw_cap"))
defineProperty("bkk_check_sw", globalPropertyi("sim/custom/xap/An24_gauges/bkk_check_sw"))
defineProperty("bkk_check_sw_cap", globalPropertyi("sim/custom/xap/An24_gauges/bkk_check_sw_cap"))

defineProperty("AP_roll", globalPropertyf("sim/custom/xap/An24_ap/indicated_roll")) -- roll for autopilot
defineProperty("AP_pitch", globalPropertyf("sim/custom/xap/An24_ap/indicated_pitch")) -- pitch for autopilot

defineProperty("roll_high", globalPropertyf("sim/custom/xap/An24_gauges/roll_high")) -- to much roll


-- failures
defineProperty("left_fail", globalPropertyi("sim/operation/failures/rel_ss_ahz")) -- failure for pilot ahz
defineProperty("right_fail", globalPropertyi("sim/operation/failures/rel_cop_ahz")) -- failure for copilot ahz

-- time from simulator start
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("sim_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- reality
defineProperty("set_real_ahz", globalPropertyi("sim/custom/xap/An24_set/real_ahz")) -- real ahz has errors and needs to be corrected

-- create datarefs for SmartCopilot compatibility
createGlobalPropertyf("sim/custom/xap/An24_misc/ag1_pitch", 0) -- òàíãàæ íà ÀÃ1
createGlobalPropertyf("sim/custom/xap/An24_misc/ag2_pitch", 0) -- òàíãàæ íà ÀÃ2
createGlobalPropertyf("sim/custom/xap/An24_misc/ag3_pitch", 0) -- òàíãàæ íà ÀÃ3
createGlobalPropertyf("sim/custom/xap/An24_misc/ag1_pitch_rot", 0) -- òàíãàæ íà ÀÃ1
createGlobalPropertyf("sim/custom/xap/An24_misc/ag2_pitch_rot", 0) -- òàíãàæ íà ÀÃ2
createGlobalPropertyf("sim/custom/xap/An24_misc/ag3_pitch_rot", 0) -- òàíãàæ íà ÀÃ3

createGlobalPropertyf("sim/custom/xap/An24_misc/ag3_roll", 0) -- êðåí íà ÀÃ3

defineProperty("ag1_roll", globalPropertyf("sim/custom/xap/An24_misc/ag1_roll")) -- roll for anmation
defineProperty("ag2_roll", globalPropertyf("sim/custom/xap/An24_misc/ag2_roll")) -- roll for anmation
defineProperty("ag3_roll", globalPropertyf("sim/custom/xap/An24_misc/ag3_roll")) -- roll for anmation

defineProperty("ag1_pitch", globalPropertyf("sim/custom/xap/An24_misc/ag1_pitch")) -- pitch for anmation
defineProperty("ag2_pitch", globalPropertyf("sim/custom/xap/An24_misc/ag2_pitch")) -- pitch for anmation
defineProperty("ag3_pitch", globalPropertyf("sim/custom/xap/An24_misc/ag3_pitch")) -- pitch for anmation

defineProperty("ag1_pitch_rot", globalPropertyf("sim/custom/xap/An24_misc/ag1_pitch_rot")) -- pitch rotary for anmation
defineProperty("ag2_pitch_rot", globalPropertyf("sim/custom/xap/An24_misc/ag2_pitch_rot")) -- pitch rotary for anmation
defineProperty("ag3_pitch_rot", globalPropertyf("sim/custom/xap/An24_misc/ag3_pitch_rot")) -- pitch rotary for anmation

defineProperty("arrest_third", globalPropertyi("sim/custom/xap/An24_set/arrest_third")) -- SmartCopilot usage
defineProperty("right_agd_arrest", globalPropertyi("sim/custom/xap/An24_set/right_agd_arrest")) -- SmartCopilot usage
defineProperty("left_agd_arrest", globalPropertyi("sim/custom/xap/An24_set/left_agd_arrest")) -- SmartCopilot usage

-- SmartCopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))  -- 0 - íå îïðåäåëåíî/ïëàãèí íå íàéäåí, 1 - ñëåéâ, 2 - ìàñòåð


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')

local cup_open_sound = loadSample('Custom Sounds/cup_open.wav')
local cup_close_sound = loadSample('Custom Sounds/cup_close.wav')

local switcher_pushed = false

-- height of visible window area
local winHeight = 130 / 512

-- height of one degrees in texture coord
local pitch_deg = 2.0 / 512

local now = get(sim_time)

local real_num = get(set_real_ahz)
local real = real_num == 1

-- left horizont
local initial_roll_err_left = 0 --math.random(-50, 50) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local roll_err_left = 0  -- collective error will increased during flight
local roll_corr_left = 0  -- correction for errors and arrest
local roll_left_show = 0  -- result roll
local roll_off_left = 0 -- math.random(-2, 2)* real_num -- determine the direction for AG fall
local initial_pitch_err_left = 0 --math.random(-60, 60) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local pitch_err_left = 0  -- collective error will increased during flight
local pitch_corr_left = 0  -- correction for errors and arrest
local pitch_left_show = 0  -- result roll
local pitch_off_left = 0 --math.random(-2, 2) * real_num -- determine the direction for AG fall
local arrest_left = 0  -- variable for arresting process
local pitch_rot_left = 0
local ahz_left_fail = true
local ahz_start_left = get(sim_time)

-- right horizont
local initial_roll_err_right = 0 --math.random(-50, 50) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local roll_err_right = 0  -- collective error will increased during flight
local roll_corr_right = 0  -- correction for errors and arrest
local roll_right_show = 0  -- result roll
local roll_off_right = 0 --math.random(-2, 2) * real_num -- determine the direction for AG fall
local initial_pitch_err_right = 0 --math.random(-60, 60) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local pitch_err_right = 0  -- collective error will increased during flight
local pitch_corr_right = 0  -- correction for errors and arrest
local pitch_right_show = 0  -- result roll
local pitch_off_right = 0 --math.random(-2, 2) * real_num -- determine the direction for AG fall
local arrest_right = 0  -- variable for arresting process
local pitch_rot_right = 0
local ahz_right_fail = true
local ahz_start_right = get(sim_time)

-- third horizont
local initial_roll_err_third = 0 --math.random(-20, 20) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local roll_err_third = 0  -- collective error will increased during flight
local roll_corr_third = 0  -- correction for errors and arrest
local roll_third_show = 0  -- result roll
local roll_off_third = 0 --math.random(-2, 2) * real_num -- determine the direction for AG fall
local initial_pitch_err_third = 0 --math.random(-30, 30) * real_num -- initial error, ehich will be decreased to 0 after connecting power
local pitch_err_third = 0  -- collective error will increased during flight
local pitch_corr_third = 0  -- correction for errors and arrest
local pitch_third_show = 0  -- result roll
local pitch_off_third = 0 --math.random(-2, 2) * real_num -- determine the direction for AG fall
local arrest_push_third = false -- validate if arrest button is pushed
local pitch_rot_third = 0
local ahz_third_fail = true
local ahz_start_third = get(sim_time)

local roll_left_big = false
local roll_right_big = false
local check_ahz = false
local check_bkk = false

local left_agd_arrest_start = now - 10
local right_agd_arrest_start = now - 10

local power_roll_left = 0 --get(roll_left)
local power_pitch_left = 0 --get(pitch_left)

local power_roll_right = 0 --get(roll_right)
local power_pitch_right = 0 --get(pitch_right)

local power_roll_third = 0 --get(roll_right)
local power_pitch_third = 0 --get(pitch_right)

local time_counter = 0
local notLoaded = true

local power27 = 0
local power27_main = 0
local power36 = 0

local eng_check = true
add_roll_left = 0
add_roll_right = 0
add_roll_third = 0

add_pitch_left = 0
add_pitch_right = 0
add_pitch_third = 0

flag1 = 0
flag2 = 0
flag3 = 0


function update()
	-- time variables
	local passed = get(frame_time)
	now = get(sim_time)
	
if get(left_agd_arrest) == 1 then
	left_agd_arrest_start = now
end
	
if get(right_agd_arrest) == 1 then
	right_agd_arrest_start = now
end

local active_logic = get(ismaster) ~= 1

	
if passed > 0 then
	real_num = get(set_real_ahz)
	real = real_num == 1

	-- initial switchers values
	if get(N1) < 70 and get(N2) < 70 and eng_check and time_counter > 0.3 and time_counter < 0.4 then
		set(AGB_left, 0)
		set(AGD_left, 0)
		set(AGD_right, 0)
		set(bkk_sw, 0)
		set(bkk_sw_cap, 1)
		eng_working = true
		eng_check = false
	end
	
	-- set initial AHZ position
	time_counter = time_counter + passed
	if real and time_counter > 0.3 and time_counter < 0.4 and notLoaded and get(N1) < 70 and get(N2) < 70 then
		initial_roll_err_left = math.random(-50, 50)
		roll_off_left = math.random(-2, 2)
		initial_pitch_err_left = math.random(-60, 60)
		pitch_off_left = math.random(-2, 2)
		
		initial_roll_err_right = math.random(-50, 50)
		roll_off_right = math.random(-2, 2)
		initial_pitch_err_right = math.random(-60, 60)
		pitch_off_right = math.random(-2, 2)
		
		initial_roll_err_third = math.random(-20, 20)
		roll_off_third = math.random(-1, 1)
		initial_pitch_err_third = math.random(-30, 30)
		pitch_off_third = math.random(-1, 1)
		
		notLoaded = false
	elseif real and time_counter > 0.3 and time_counter < 0.4 and notLoaded then 
		roll_off_left = math.random(-2, 2)
		pitch_off_left = math.random(-2, 2)
		
		roll_off_right = math.random(-2, 2)
		pitch_off_right = math.random(-2, 2)
		
		roll_off_third = math.random(-1, 1)
		pitch_off_third = math.random(-1, 1)	
	
		notLoaded = false	
	end
	
	-- calculate power
	if get(bus_DC_27_volt_emerg) > 21 then power27 = 1 else power27 = 0 end
	if get(bus_DC_27_volt) > 21 then power27_main = 1 else power27_main = 0 end
	if get(bus_AC_36_volt) > 28 then power36 = 1 else power36 = 0 end

	local fail_left = get(left_fail)
	local fail_right = get(right_fail)
	
	if now - left_agd_arrest_start < 4 then arrest_left = 1 else arrest_left = 0 end
	if now - right_agd_arrest_start < 4 then arrest_right = 1 else arrest_right = 0 end
	
	local AGD_left_sw = get(AGD_left)
	local AGD_right_sw = get(AGD_right)
	local AGB_left_sw = get(AGB_left)
	
	-------------------
	-- left --
	
	if active_logic then
	
		-- calculate roll and pitch for power off
		if power27 * power36 * get(AGD_left) ~= 0 and flag1 == 1 then
		add_roll_left = power_roll_left - get(roll_left) 
		add_pitch_left =  power_pitch_left - get(pitch_left)
		flag1 = 0
		end
		
		if power27 * power36 * get(AGD_left) == 0 or fail_left == 6 then
			flag1 = 1
			else
			power_roll_left = get(roll_left) + add_roll_left
			power_pitch_left = get(pitch_left) + add_pitch_left
		end 
		
		

		-- calculate power ON and OFF initial roll and pitch
		if power27 * power36 * AGD_left_sw == 0 or fail_left == 6 then
			if math.abs(initial_roll_err_left) < 50 then initial_roll_err_left = initial_roll_err_left + passed * roll_off_left * real_num end
			if math.abs(initial_pitch_err_left) < 60 then initial_pitch_err_left = initial_pitch_err_left + passed * pitch_off_left * real_num end
		else
			if initial_roll_err_left > 0.1 then initial_roll_err_left = initial_roll_err_left - passed 
			elseif initial_roll_err_left < -0.1 then initial_roll_err_left = initial_roll_err_left + passed
			else initial_roll_err_left = 0 end
			if initial_pitch_err_left > 0.1 then initial_pitch_err_left = initial_pitch_err_left - passed
			elseif initial_pitch_err_left < -0.1 then initial_pitch_err_left = initial_pitch_err_left + passed
			else initial_pitch_err_left = 0 end
		end

		-- calculate collective error
		if math.abs(roll_err_left) < 20 then roll_err_left = roll_err_left + roll_err_left * (math.random() - 0.49999) * passed * 0.001 * real_num end
		if math.abs(pitch_err_left) < 20 then pitch_err_left = pitch_err_left + pitch_err_left * (math.random() - 0.49999) * passed * 0.001 * real_num end

		-- arresting mechanism
		if power27 * power36 * arrest_left * get(AGD_left) > 0 and fail_left < 6 then
			-- set new correction
			--if math.abs(initial_roll_err_left) < 0.1 then
				if roll_left_show > 0.1 then roll_corr_left = roll_corr_left + 10 * passed
				elseif roll_left_show < -0.1 then roll_corr_left = roll_corr_left - 10 * passed end
			--end
			if math.abs(initial_pitch_err_left) < 0.1 then
				if pitch_left_show > 0.1 then pitch_corr_left = pitch_corr_left + 5 * passed
				elseif pitch_left_show < -0.1 then pitch_corr_left = pitch_corr_left - 5 * passed end
			end
			-- reset errors
			if power_roll_left > 0.1 then power_roll_left = power_roll_left - passed
			elseif power_roll_left < -0.1 then power_roll_left = power_roll_left + passed end
			if power_pitch_left > 0.1 then power_pitch_left = power_pitch_left - passed
			elseif power_pitch_left < -0.1 then power_pitch_left = power_pitch_left + passed end

			if initial_roll_err_left > 0.1 then initial_roll_err_left = initial_roll_err_left - passed * 2
			elseif initial_roll_err_left < -0.1 then initial_roll_err_left = initial_roll_err_left + passed * 2 end
			if initial_pitch_err_left > 0.1 then initial_pitch_err_left = initial_pitch_err_left - passed * 12
			elseif initial_pitch_err_left < -0.1 then initial_pitch_err_left = initial_pitch_err_left + passed * 12 end

			if roll_err_left > 0.1 then roll_err_left = roll_err_left - passed
			elseif roll_err_left < -0.1 then roll_err_left = roll_err_left + passed end
			if pitch_err_left > 0.1 then pitch_err_left = pitch_err_left - passed
			elseif pitch_err_left < 0.1 then pitch_err_left = pitch_err_left + passed end
		end

		-- main formula for curent position
		roll_left_show = power_roll_left - roll_corr_left --+ roll_err_left+ initial_roll_err_left 
		pitch_left_show = power_pitch_left - pitch_corr_left --+ pitch_err_left + initial_pitch_err_left  
			-- final result is a summ of power position, initial error of gauge, collective error of gauge and correction of this error
		-- limit pitch
		if pitch_left_show > 80 then pitch_left_show = 80
		elseif pitch_left_show < -80 then pitch_left_show = -80 end
		
		set(ag1_pitch, pitch_left_show) 
		set(ag1_roll, roll_left_show)
		
		
		-----------------------
		-- right --
		-- calculate roll and pitch for power off
		if power27 * power36 * get(AGD_right) ~= 0 and flag2 == 1 then
		add_roll_right = power_roll_right - get(roll_right) 
		add_pitch_right = power_pitch_right - get(pitch_right)
		flag2 = 0
		end
		
		if power27 * power36 * get(AGD_right) == 0 or fail_right == 6 then
			flag2 = 1
			else
			power_roll_right = get(roll_right) + add_roll_right
			power_pitch_right = get(pitch_right) + add_pitch_right
		end 
		
		-- calculate power ON and OFF initial roll and pitch
		if power27_main * power36 * AGD_right_sw == 0 or fail_right == 6 then
			if math.abs(initial_roll_err_right) < 50 then initial_roll_err_right = initial_roll_err_right + passed * roll_off_right * real_num end
			if math.abs(initial_pitch_err_right) < 60 then initial_pitch_err_right = initial_pitch_err_right + passed * pitch_off_right * real_num end
		else
			if initial_roll_err_right > 0.1 then initial_roll_err_right = initial_roll_err_right - passed 
			elseif initial_roll_err_right < -0.1 then initial_roll_err_right = initial_roll_err_right + passed 
			else initial_roll_err_right = 0 end
			if initial_pitch_err_right > 0.1 then initial_pitch_err_right = initial_pitch_err_right - passed
			elseif initial_pitch_err_right < -0.1 then initial_pitch_err_right = initial_pitch_err_right + passed 
			else initial_pitch_err_right = 0 end
		end

		-- calculate collective error
		if math.abs(roll_err_right) < 20 then roll_err_right = roll_err_right + roll_err_right * (math.random() - 0.49999) * passed * 0.001 * real_num end
		if math.abs(pitch_err_right) < 20 then pitch_err_right = pitch_err_right + pitch_err_right * (math.random() - 0.49999) * passed * 0.001 * real_num end

		-- arresting mechanism
		if power27_main * power36 * arrest_right * get(AGD_right) > 0 and fail_right < 6 then
			-- set new correction
			-- set new correction
			--if math.abs(initial_roll_err_right) < 0.1 then
				if roll_right_show > 0.1 then roll_corr_right = roll_corr_right + 10 * passed
				elseif roll_right_show < -0.1 then roll_corr_right = roll_corr_right - 10 * passed end
			--end
			if math.abs(initial_pitch_err_right) < 0.1 then
				if pitch_right_show > 0.1 then pitch_corr_right = pitch_corr_right + 5 * passed
				elseif pitch_right_show < -0.1 then pitch_corr_right = pitch_corr_right - 5 * passed end
			end

			-- reset errors
			if power_roll_right > 0.1 then power_roll_right = power_roll_right - passed
			elseif power_roll_right < -0.1 then power_roll_right = power_roll_right + passed end
			if power_pitch_right > 0.1 then power_pitch_right = power_pitch_right - passed
			elseif power_pitch_right < -0.1 then power_pitch_right = power_pitch_right + passed end

			if initial_roll_err_right > 0.1 then initial_roll_err_right = initial_roll_err_right - passed * 2
			elseif initial_roll_err_right < -0.1 then initial_roll_err_right = initial_roll_err_right + passed * 2 end
			if initial_pitch_err_right > 0.1 then initial_pitch_err_right = initial_pitch_err_right - passed * 12
			elseif initial_pitch_err_right < -0.1 then initial_pitch_err_right = initial_pitch_err_right + passed * 15 end

			if roll_err_right > 0.1 then roll_err_right = roll_err_right - passed
			elseif roll_err_right < -0.1 then roll_err_right = roll_err_right + passed end
			if pitch_err_right > 0.1 then pitch_err_right = pitch_err_right - passed
			elseif pitch_err_right < 0.1 then pitch_err_right = pitch_err_right + passed end
		end

		-- main formula for curent position
		roll_right_show = power_roll_right - roll_corr_right --+ roll_err_right + initial_roll_err_right  
		pitch_right_show = power_pitch_right - pitch_corr_right --+ pitch_err_right + initial_pitch_err_right 
			-- final result is a summ of power position, initial error of gauge, collective error of gauge and correction of this error
		-- limit pitch
		if pitch_right_show > 80 then pitch_right_show = 80
		elseif pitch_right_show < -80 then pitch_right_show = -80 end

		-- set variables for AP
		set(AP_roll, roll_right_show)
		set(AP_pitch, pitch_right_show)
		
		set(ag2_pitch, pitch_right_show) 
		set(ag2_roll, roll_right_show)

		-----------------------
		-- third --
		-- calculate roll and pitch for power off
		if power27 * power36 * get(AGB_left) ~= 0 and flag3 == 1 then
		add_roll_third = power_roll_third - get(roll_left) 
		add_pitch_third =  power_pitch_third - get(pitch_left)
		flag3 = 0
		end
		
		if power27 * power36 * get(AGB_left) == 0 or fail_left == 6 then
			flag3 = 1
			else
			power_roll_third = get(roll_left) + add_roll_third
			power_pitch_third = get(pitch_left) + add_pitch_third
		end 

		-- calculate power ON and OFF initial roll and pitch
		if power27_main * power36 * AGB_left_sw == 0 or fail_right == 6 then
			if math.abs(initial_roll_err_third) < 20 then initial_roll_err_third = initial_roll_err_third + passed * roll_off_third * 0.01 * real_num end
			if math.abs(initial_pitch_err_third) < 30 then initial_pitch_err_third = initial_pitch_err_third + passed * pitch_off_third * 0.01 * real_num end
		else
			if initial_roll_err_third > 0.1 then initial_roll_err_third = initial_roll_err_third - passed * 0.01
			elseif initial_roll_err_third < -0.1 then initial_roll_err_third = initial_roll_err_third + passed * 0.01
			else initial_roll_err_third = 0 end
			if initial_pitch_err_third > 0.1 then initial_pitch_err_third = initial_pitch_err_third - passed * 0.01
			elseif initial_pitch_err_third < -0.1 then initial_pitch_err_third = initial_pitch_err_third + passed * 0.01
			else initial_pitch_err_third = 0 end
		end

		-- calculate collective error
		if math.abs(roll_err_third) < 20 then roll_err_third = roll_err_third + roll_err_third * (math.random() - 0.49999) * passed * 0.001 * real_num end
		if math.abs(pitch_err_third) < 20 then pitch_err_third = pitch_err_third + pitch_err_third * (math.random() - 0.49999) * passed * 0.001 * real_num end

		-- arresting mechanism
		if get(arrest_third) * get(AGB_left) > 0 and fail_right < 6 then
			-- set new correction
			if math.abs(initial_roll_err_third) < 0.1 then
				if roll_third_show > 0.1 then roll_corr_third = roll_corr_third + 6 * passed
				elseif roll_third_show < -0.1 then roll_corr_third = roll_corr_third - 6 * passed end
			end
			if math.abs(initial_pitch_err_third) < 0.1 then
				if pitch_third_show > 0.1 then pitch_corr_third = pitch_corr_third + 6 * passed
				elseif pitch_third_show < -0.1 then pitch_corr_third = pitch_corr_third - 6 * passed end
			end

			-- reset errors
			if power_roll_third > 0.1 then power_roll_third = power_roll_third - passed
			elseif power_roll_third < -0.1 then power_roll_third = power_roll_third + passed end
			if power_pitch_third > 0.1 then power_pitch_third = power_pitch_third - passed
			elseif power_pitch_third < -0.1 then power_pitch_third = power_pitch_third + passed end

			if initial_roll_err_third > 0.1 then initial_roll_err_third = initial_roll_err_third - passed * 12
			elseif initial_roll_err_third < -0.1 then initial_roll_err_third = initial_roll_err_third + passed * 12 end
			if initial_pitch_err_third > 0.1 then initial_pitch_err_third = initial_pitch_err_third - passed * 12
			elseif initial_pitch_err_third < -0.1 then initial_pitch_err_third = initial_pitch_err_third + passed * 12 end

			if roll_err_third > 0.1 then roll_err_third = roll_err_third - passed
			elseif roll_err_third < -0.1 then roll_err_third = roll_err_third + passed end
			if pitch_err_third > 0.1 then pitch_err_third = pitch_err_third - passed
			elseif pitch_err_third < 0.1 then pitch_err_third = pitch_err_third + passed end
		end

		--print(AGB_left_sw, initial_pitch_err_third, pitch_err_third, power_pitch_third)
		
		-- main formula for curent position
		roll_third_show = power_roll_third - roll_corr_third --+ roll_err_third + initial_roll_err_third 
		pitch_third_show = power_pitch_third - pitch_corr_third --+ pitch_err_third + initial_pitch_err_third 
			-- final result is a summ of power position, initial error of gauge, collective error of gauge and correction of this error
		-- limit pitch
		if pitch_third_show > 80 then pitch_third_show = 80
		elseif pitch_third_show < -80 then pitch_third_show = -80 end
		
		set(ag3_pitch, pitch_third_show) 
		set(ag3_roll, roll_third_show)
	
	end	
	----------------------------

	-- lamp and flags logic
	if power27 > 0 then
		if power36 == 0 or fail_left == 6 or AGD_left_sw == 0 or arrest_left > 0 then ahz_left_fail = true
		else ahz_left_fail = false end
		if power36 == 0 or fail_right == 6 or AGD_right_sw == 0 or arrest_right > 0 or power27_main == 0 then ahz_right_fail = true
		else ahz_right_fail = false end
		if power36 == 0 or fail_left == 6 or AGB_left_sw == 0 or get(arrest_third) > 0 or power27_main == 0 then ahz_third_fail = true
		else ahz_third_fail = false end
	else
		ahz_left_fail = false
		ahz_right_fail = false
		ahz_third_fail = false
	end



	-- power consumption
	local agb_left_cc = 0
	local agd_left_cc = 0
	local agd_right_cc = 0

	if power27 > 0 then
		if not ahz_left_fail then agd_left_cc = 1 else agd_left_cc = 0 end
		if not ahz_right_fail then agd_right_cc = 1 else agd_right_cc = 0 end
		if not ahz_third_fail then agb_left_cc = 1 else agb_left_cc = 0 end
	end

	local bkk = get(bkk_sw) * power27 * power36  -- check if BKK unit is work

	set(AHZ_cc, agb_left_cc + agd_left_cc + agd_right_cc + bkk)


	-- lamps again for 15 sec after turn ON
	if power27 > 0 then
		local bkk_check_switch = get(bkk_check_sw)
		if bkk > 0 and power36 == 1 and (bkk_check_switch == 0 or bkk_check_switch == 2) then check_bkk = true else check_bkk = false end

		if (now - ahz_start_left < 15 and now - ahz_start_left > 0) or check_bkk then ahz_left_fail = true end
		if (now - ahz_start_right < 15 and now - ahz_start_right > 0) or check_bkk then ahz_right_fail = true end
		if (now - ahz_start_third < 15 and now - ahz_start_third > 0) or check_bkk then ahz_third_fail = true end
		
		roll_left_show = get(ag1_roll)
		roll_right_show = get(ag2_roll)
		roll_third_show = get(ag3_roll)
		
		-- big roll indication
		if get(ias) * 1.852	< 230 and bkk > 0 then
			if roll_left_show < -15 then
				roll_left_big = true
				roll_right_big = false
			elseif roll_left_show > 15 then
				roll_left_big = false
				roll_right_big = true
			else
				roll_left_big = false
				roll_right_big = false
			end
		elseif bkk > 0 then
			if roll_left_show < -32 then
				roll_left_big = true
				roll_right_big = false
			elseif roll_left_show > 32 then
				roll_left_big = false
				roll_right_big = true
			else
				roll_left_big = false
				roll_right_big = false
			end
		end

		if roll_left_big or roll_right_big then set(roll_high, 1) else set(roll_high, 0) end

		check_ahz = math.abs(roll_left_show - roll_right_show) > 7 or math.abs(roll_left_show - roll_third_show) > 7 or math.abs(roll_right_show - roll_third_show) > 7 or bkk == 0
	else
		roll_left_big = false
		roll_right_big = false
		check_ahz = false
		check_bkk = false
		ahz_left_fail = false
		ahz_right_fail = false
		ahz_third_fail = false
		set(roll_high, 0)
	end

	-- set animation
	--set(ag1_roll, roll_left_show)
	--set(ag2_roll, roll_right_show)
	
	
	

end

end



components = {

	-- left AGD
    -- attitude tape
    tape {
        position = { 1229, 1874, 145, 148},
        image = get(tapeImage),
        window = { 1.0, winHeight },

        -- calculate pitch level
        scrollY = function()
            return (0.5 - winHeight / 2) - pitch_deg * (get(ag1_pitch) + get(ag1_pitch_rot));
        end,
    },


	-- arrest button
    clickable {
       position = { 1368, 2015, 30, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

        onMouseClick = function(x, y, button)
			set(left_agd_arrest, 1)
            return true
        end,
		onMouseUp = function()
			set(left_agd_arrest, 0)
            return true		
		end

    },

    -- pitch rotary
    clickable {
       position = { 1202, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_left = get(ag1_pitch_rot) - 1
			if pitch_rot_left < -12 then pitch_rot_left = -12 end
			set(ag1_pitch_rot, pitch_rot_left)
            return true
        end,
    },
    clickable {
       position = { 1217, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_left = get(ag1_pitch_rot) + 1
			if pitch_rot_left > 12 then pitch_rot_left = 12 end
			set(ag1_pitch_rot, pitch_rot_left)
            return true
        end,
    },
	-- rotary indicator
	rectangle {
		position = { 1208, 1887.5, 9, 20},
		color = {0,0,0,1},
	},

    free_texture {
        image = get(triangle),
        position_x = 1210,
        position_y = function()
			return 1894 - get(ag1_pitch_rot) * 0.7
		end,
        width = 6,
        height = 6
    },

	-- fail indicator
	textureLit {
		position = {1369, 1849, 30, 30},
		image = get(red_led),
		visible = function()
			return ahz_left_fail
		end,
	},

	-- switcher
    switch {
        position = { 918, 326, 15, 15},
        state = function()
            return get(AGD_left) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(AGD_left) ~= 0 then
                set(AGD_left, 0)
            else
                set(AGD_left, 1)
				ahz_start_left = get(sim_time)
            end
			end
            return true;
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	---------------------------------------
	-- right AGD
    -- attitude tape
    tape {
        position = { 1629, 1874, 145, 148},
        image = get(tapeImage),
        window = { 1.0, winHeight },

        -- calculate pitch level
        scrollY = function()
            return (0.5 - winHeight / 2) - pitch_deg * (get(ag2_pitch) + get(ag2_pitch_rot));
        end,
    },

	-- aircraft image
  --[[  needle {
        position = { 1621, 1868, 160, 160 },
        image = get(planeImage),
        angle = function()
            return roll_right_show
        end
    }, 	--]]


--[[	rectangle {
		position = { 1768, 2015, 30, 30 },
		color = {1,0,0,1},
	}, --]]

	-- arrest button
    clickable {
       position = { 1768, 2015, 30, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

        onMouseClick = function(x, y, button)
			set(right_agd_arrest, 1)
            return true
        end,
		onMouseUp = function()
			set(right_agd_arrest, 0)
            return true		
		end,

    },

    -- pitch rotary
    clickable {
       position = { 1605, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_right = get(ag2_pitch_rot) - 1
			if pitch_rot_right < -12 then pitch_rot_right = -12 end
			set(ag2_pitch_rot, pitch_rot_right)
            return true
        end,
    },
    clickable {
       position = { 1620, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_right = get(ag2_pitch_rot) + 1
			if pitch_rot_right > 12 then pitch_rot_right = 12 end
			set(ag2_pitch_rot, pitch_rot_right)
            return true
        end,
    },

	-- rotary indicator
	rectangle {
		position = { 1609, 1887.5, 9, 20},
		color = {0,0,0,1},
	},

    free_texture {
        image = get(triangle),
        position_x = 1611,
        position_y = function()
			return 1894 - get(ag2_pitch_rot) * 0.7
		end,
        width = 6,
        height = 6
    },

	-- fail indicator
	textureLit {
		position = {1769, 1849, 30, 30},
		image = get(red_led),
		visible = function()
			return ahz_right_fail
		end,
	},


	-- switcher
    switch {
        position = { 825, 272, 15, 15},
        state = function()
            return get(AGD_right) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(AGD_right) ~= 0 then
                set(AGD_right, 0)
            else
                set(AGD_right, 1)
				ahz_start_right = get(sim_time)
            end
			end
            return true;
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	---------------------------------
	-- third AGD
    -- attitude tape
    tape {
        position = { 1428, 1874, 145, 148},
        image = get(tapeImage),
        window = { 1.0, winHeight / 1.3},

        -- calculate pitch level
        scrollY = function()
            return (0.5 - winHeight / 2 / 1.3) - pitch_deg * (get(ag3_pitch) + get(ag3_pitch_rot));
			--(pitch_third_show + pitch_rot_third);
        end,
    },

--[[	-- gray plank
	rectangle {
		position = {1499, 1945, 6, 100},
		color = {0.5, 0.5, 0.51, 1},
	},
	-- black plank
	rectangle {
		position = {1499, 1848, 6, 100},
		color = {0.1, 0.1, 0.1, 1},
	},--]]

	-- planka
	rectangle {
        position = { 1497, 1849, 7, 200 },
        color= {0,0,0,0.5},
	},

	-- planka
	texture {
        position = { 1498, 1849, 5, 200 },
        image = get(planka),
	},

	-- aircraft image
    needle {
        position = { 1420, 1868, 160, 160 },
        image = get(planeImage),
        angle = function()
            return roll_third_show
        end
    },

--[[	rectangle {
		position = { 1568, 2015, 30, 30 },
		color = {1,0,0,1},
	}, --]]

	-- arrest button
    clickable {
       position = { 1568, 2015, 30, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

        onMouseClick = function(x, y, button)
			if not arrest_push_third then
				arrest_push_third = true
				set(arrest_third, 1)
			end
            return true
        end,
        onMouseUp = function(x, y, button)
			arrest_push_third = false
			set(arrest_third, 0)
            return true
        end,

    },

    -- pitch rotary
    clickable {
       position = { 1403, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_third = get(ag3_pitch_rot) - 1
			if pitch_rot_third < -12 then pitch_rot_third = -12 end
			set(ag3_pitch_rot, pitch_rot_third)
            return true
        end,
    },
    clickable {
       position = { 1417, 1850, 15, 30 },

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseClick = function(x, y, button)
			pitch_rot_third = get(ag3_pitch_rot) + 1
			if pitch_rot_third > 12 then pitch_rot_third = 12 end
			set(ag3_pitch_rot, pitch_rot_third)
            return true
        end,
    },

	-- rotary indicator
	rectangle {
		position = { 1409, 1887.5, 9, 20},
		color = {0,0,0,1},
	},

    free_texture {
        image = get(triangle),
        position_x = 1410,
        position_y = function()
			return 1894 - get(ag3_pitch_rot) * 0.7
		end,
        width = 6,
        height = 6
    },

		-- fail indicator
	texture {
		position = {1425, 1980, 70, 30},
		image = get(flagImage),
		visible = function()
			return ahz_third_fail or power27 == 0 
		end,
	},

	-- switcher
    switch {
        position = { 900, 326, 15, 15},
        state = function()
            return get(AGB_left) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(AGB_left) ~= 0 then
                set(AGB_left, 0)
            else
                set(AGB_left, 1)
				ahz_start_third = get(sim_time)
            end
			end
            return true;
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	------------------------------
	-- lamps over panel --
	------------------------------
	-- fail indicator left
	textureLit {
		position = {1398, 518, 45, 27},
		image = get(left_ahz_fail_txt),
		visible = function()
			return ahz_left_fail
		end,
	},

	-- fail indicator third
	textureLit {
		position = {1455, 518, 43, 27},
		image = get(third_ahz_fail_txt),
		visible = function()
			return ahz_third_fail
		end,
	},

	-- fail indicator right
	textureLit {
		position = {1007, 484, 45, 27},
		image = get(right_ahz_fail_txt),
		visible = function()
			return ahz_right_fail
		end,
	},

	-- left roll indicator
	textureLit {
		position = {1062, 484, 45, 27},
		image = get(roll_left_txt),
		visible = function()
			return roll_left_big
		end,
	},
	-- right roll indicator
	textureLit {
		position = {1119, 484, 43, 27},
		image = get(roll_right_txt),
		visible = function()
			return roll_right_big
		end,
	},

	-- check ahz
	textureLit {
		position = {1174, 484, 43, 27},
		image = get(check_ahz_txt),
		visible = function()
			return check_ahz
		end,
	},

	--------------------------
	-- bkk switcher and cap --

	-- bkk cap
    switch {
        position = { 0, 445, 35, 44},
        state = function()
            return get(bkk_sw_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseDown = function()
            if get(bkk_sw_cap) ~= 0 then
                set(bkk_sw_cap, 0)
				playSample(cup_open_sound, 0) 
				set(bkk_sw, 1)
            else
				playSample(cup_close_sound, 0) 
                set(bkk_sw_cap, 1)
            end
            return true;
        end
    },

	-- bkk switcher
  switch {
        position = { 880, 326, 15, 15},
        state = function()
            return get(bkk_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(bkk_sw_cap) ~= 0 then
				if get(bkk_sw) ~= 0 then
					set(bkk_sw, 0)
					playSample(switch_sound, 0)
				else
					set(bkk_sw, 1)
					playSample(switch_sound, 0)
				end
			end
            return true;
        end
    },

	-- bkk test cap
	switch {
        position = { 0, 490, 33, 44},
        state = function()
            return get(bkk_check_sw_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(bkk_check_sw_cap) ~= 0 then
                set(bkk_check_sw_cap, 0)
                playSample(cup_open_sound, 0)
				set(bkk_check_sw, 1)
            else
                playSample(cup_close_sound, 0)
                set(bkk_check_sw_cap, 1)
            end
            return true;
        end
    },

	-- switch up
    clickable {
        position = {862, 374, 15, 7},  -- search and set right

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if get(bkk_check_sw_cap) == 1 then set(bkk_check_sw, 2) end
			return true
		end,
		onMouseUp = function()
			set(bkk_check_sw, 1)
			return true
		end

    },
	-- switch down
    clickable {
        position = {862, 365, 15, 7},  -- search and set right

       cursor = {
            x = 16, 
            y = 32, 
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if get(bkk_check_sw_cap) == 1 then set(bkk_check_sw, 0) end
			return true
		end,
		onMouseUp = function()
			set(bkk_check_sw, 1)
			return true
		end

    },

	-- check indicator
	textureLit {
		position = {700, 428, 20, 20},
		image = get(green_led),
		visible = function()
			return check_bkk
		end,
	},


}

