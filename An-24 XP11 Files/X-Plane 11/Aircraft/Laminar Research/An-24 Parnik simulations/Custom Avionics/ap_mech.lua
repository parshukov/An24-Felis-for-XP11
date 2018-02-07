-- this is autopilot logic for Yak40 aircraft

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- controls
defineProperty("ap_roll_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_roll_diff"))  -- difference between needed and current roll (bank)
defineProperty("ap_pitch_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_pitch_diff"))  -- difference between needed and current pitch
defineProperty("ap_hdg_diff", globalPropertyf("sim/custom/xap/An24_ap/ap_hdg_diff"))  -- difference between needed and current heading
defineProperty("ap_roll_power", globalPropertyi("sim/custom/xap/An24_ap/ap_roll_power"))  -- power for aileron mechanic
defineProperty("ap_pitch_power", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch_power"))  -- power for elevator mechanic
defineProperty("ap_hdg_power", globalPropertyi("sim/custom/xap/An24_ap/ap_hdg_power"))  -- power for rudder mechanic

defineProperty("ap_trim", globalPropertyi("sim/custom/xap/An24_ap/ap_trim"))  -- use trimmer of AP
defineProperty("elevator_trim", globalPropertyf("sim/cockpit2/controls/elevator_trim")) -- sim pitch trimmer

defineProperty("roll_spd", globalPropertyf("sim/flightmodel/position/P")) -- current roll speed deg/sec
defineProperty("pitch_spd", globalPropertyf("sim/flightmodel/position/Q")) -- current pitch speed deg/sec
defineProperty("yaw_spd", globalPropertyf("sim/custom/xap/An24_ap/ap_yaw_spd")) -- current yaw speed deg/sec
defineProperty("slip", globalPropertyf("sim/cockpit2/gauges/indicators/slip_deg"))
defineProperty("indicated_roll", globalPropertyf("sim/custom/xap/An24_ap/indicated_roll"))  -- roll from AHZ

defineProperty("main_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.

-- AP mechs
defineProperty("ap_roll_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_roll_comm"))
defineProperty("ap_pitch_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_pitch_comm"))
defineProperty("ap_yaw_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_yaw_comm"))


local roll_spd_lim = 5
local pitch_spd_lim = 5 -- 5
local hdg_spd_lim = 1

local roll_norm_diff = 10 -- how far AP starts to slow down rotation
local pitch_norm_diff = 20  -- 10 -- how far AP starts to slow down rotation
local hdg_norm_diff = 10 -- how far AP starts to slow down rotation


local ail_pos_need = 0 -- nedded aileron position
local elev_pos_need = 0 -- needed elevator position
local rudd_pos_need = 0 -- needed rudder position

local roll_clar = 0.01 -- clarify the roll change speed
local pitch_clar = 0.01 -- clarity the pitch change speed
local hdg_clar = 0.01 -- clarify the heading change speed

function update()
	

	
	local passed = get(frame_time)
	local press = get(main_press) > 30

	
	-------------------
	-- roll logic

	local roll_diff = get(ap_roll_diff) / roll_norm_diff -- normalized roll diff
	if roll_diff > 1 then roll_diff = 1
	elseif roll_diff < -1 then roll_diff = -1 end

	local roll_spd_need = roll_diff * roll_spd_lim -- roll speed for reach the needed position
	local roll_spd_now = get(roll_spd) -- current roll speed

	local roll_power = get(ap_roll_power) == 1
	
	if not roll_power or not press then
		roll_spd_need = 0
		roll_spd_now = 0
	end

	local ail_pos_now = get(ap_roll_comm) -- current aileron position

	local ail_step = math.min(0.5, math.abs(roll_spd_now - roll_spd_need) * 0.05)
	
	if roll_spd_need > roll_spd_now + roll_clar then ail_pos_need = ail_pos_now + ail_step * passed
	elseif roll_spd_need < roll_spd_now - roll_clar then ail_pos_need = ail_pos_now - ail_step * passed
	end

	if ail_pos_need > 0.5 then ail_pos_need = 0.5
	elseif ail_pos_need < -0.5 then ail_pos_need = -0.5 end

	if roll_power and press then
		set(ap_roll_comm, ail_pos_need)
	else
		if ail_pos_need > 0 then ail_pos_need = ail_pos_need * 0.9
		elseif ail_pos_need < 0 then ail_pos_need = ail_pos_need * 0.9 end
		set(ap_roll_comm, ail_pos_need)
	end


	---------------------
	-- pitch logic
	local pitch_diff = get(ap_pitch_diff) / pitch_norm_diff  -- pitch speed for reach the needed position
	if pitch_diff > 1 then pitch_diff = 1
	elseif pitch_diff < -1 then pitch_diff = -1 end


	local pitch_spd_need = pitch_diff * pitch_spd_lim + math.abs(get(indicated_roll)) * 0.035
	local pitch_spd_now = get(pitch_spd) -- current pitch speed

	local pitch_power = get(ap_pitch_power) == 1
	
	if not pitch_power or not press then
		pitch_spd_need = 0
		pitch_spd_now = 0
	end

	local elev_pos_now = get(ap_pitch_comm) -- current elevator position

	local elev_step = math.min(0.5, math.abs(pitch_spd_now - pitch_spd_need) * 0.1)

	if pitch_spd_need > pitch_spd_now + pitch_clar then elev_pos_need = elev_pos_now + elev_step * passed
	elseif pitch_spd_need < pitch_spd_now - pitch_clar then elev_pos_need = elev_pos_now - elev_step * passed
	end

	if elev_pos_need > 0.5 then elev_pos_need = 0.5
	elseif elev_pos_need < -0.5 then elev_pos_need = -0.5 end

	if pitch_power and press then
		-- add here a logic for stab to release the pitch axis
		local use_trimm = get(ap_trim) == 1
		
		local stab_pos = get(elevator_trim)
		if elev_pos_need > 0.02 and stab_pos <= 1 and use_trimm then
			set(elevator_trim, stab_pos + passed * 0.01)
		elseif elev_pos_need < -0.02 and stab_pos >= -1 and use_trimm then
			set(elevator_trim, stab_pos - passed * 0.01)
		end
		set(ap_pitch_comm, elev_pos_need)
	else
		if elev_pos_need > 0 then elev_pos_need = elev_pos_need * 0.9
		elseif elev_pos_need < 0 then elev_pos_need = elev_pos_need * 0.9 end
		set(ap_pitch_comm, elev_pos_need)
	end




	---------------------
	-- heading logic

	local hdg_diff = get(ap_hdg_diff) / hdg_norm_diff  -- hdg speed for reach the needed position
	if hdg_diff > 1 then hdg_diff = 1
	elseif hdg_diff < -1 then hdg_diff = -1 end
	
	local hdg_spd_need = hdg_diff * hdg_spd_lim
	local hdg_spd_now = get(yaw_spd) -- current heading speed


	local hdg_power = get(ap_hdg_power) == 1
	
	if not hdg_power or not press then
		hdg_spd_need = 0
		hdg_spd_now = 0
	end

	local rudd_pos_now = get(ap_yaw_comm) -- current rudder position

	local rudd_step = math.min(0.1, math.abs(hdg_spd_now - hdg_spd_need) * 0.03)

	if hdg_spd_need < hdg_spd_now + hdg_clar then rudd_pos_need = rudd_pos_now + rudd_step * passed
	elseif hdg_spd_need > hdg_spd_now - hdg_clar then rudd_pos_need = rudd_pos_now - rudd_step * passed
	end

	if rudd_pos_need > 0.3 then rudd_pos_need = 0.3
	elseif rudd_pos_need < -0.3 then rudd_pos_need = -0.3 end

	if hdg_power and press then
		set(ap_yaw_comm, rudd_pos_need)
	else
		if rudd_pos_need > 0 then rudd_pos_need = rudd_pos_need * 0.9
		elseif rudd_pos_need < 0 then rudd_pos_need = rudd_pos_need * 0.9 end
		set(ap_yaw_comm, rudd_pos_need)
	end








end





