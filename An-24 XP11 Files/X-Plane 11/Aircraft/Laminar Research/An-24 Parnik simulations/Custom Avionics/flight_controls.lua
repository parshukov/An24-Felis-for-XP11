-- this is the animation calculations

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("airspeed", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("overr", globalPropertyf("sim/operation/override/override_control_surfaces")) -- override controls


-- controls
defineProperty("head_ratio", globalPropertyf("sim/flightmodel2/controls/heading_ratio"))
defineProperty("pitch_ratio", globalPropertyf("sim/flightmodel2/controls/pitch_ratio"))
defineProperty("roll_ratio", globalPropertyf("sim/flightmodel2/controls/roll_ratio"))
defineProperty("flap_ratio", globalPropertyf("sim/cockpit2/controls/flap_ratio"))

defineProperty("elevator_trim", globalPropertyf("sim/cockpit2/controls/elevator_trim")) -- sim pitch trimmer
defineProperty("aileron_trim", globalPropertyf("sim/cockpit2/controls/aileron_trim")) -- sim roll trimmer
defineProperty("rudder_trim", globalPropertyf("sim/cockpit2/controls/rudder_trim")) -- sim yaw trimmer

-- wings
defineProperty("ail_set_L", globalPropertyf("sim/flightmodel/controls/mwing07_ail1def")) -- inner aileron left Degrees, positive is trailing-edge down.
defineProperty("ail_set_R", globalPropertyf("sim/flightmodel/controls/mwing06_ail1def")) -- right Degrees, positive is trailing-edge down.

defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]")) -- inner flaps right
defineProperty("flap_out_L", globalPropertyf("sim/flightmodel2/wing/flap2_deg[4]")) -- outer flaps left
defineProperty("flap_out_R", globalPropertyf("sim/flightmodel2/wing/flap2_deg[5]")) -- outer flaps right

defineProperty("sim_flap_time", globalPropertyf("sim/aircraft/controls/acf_flap_deftime")) -- time to make flaps full cycle

-- tail
defineProperty("elevator_L", globalPropertyf("sim/flightmodel/controls/mwing02_elv1def")) -- Degrees, positive is trailing-edge down.
defineProperty("elevator_R", globalPropertyf("sim/flightmodel/controls/mwing01_elv1def")) -- Degrees, positive is trailing-edge down.
defineProperty("rudder", globalPropertyf("sim/flightmodel/controls/mwing08_rud1def"))


-- AP mechs
defineProperty("ap_roll_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_roll_comm"))
defineProperty("ap_pitch_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_pitch_comm"))
defineProperty("ap_yaw_comm", globalPropertyf("sim/custom/xap/An24_ap/ap_yaw_comm"))


-- create and define controls datarefs
createProp("sim/custom/xap/An24_controls/yoke_pitch", "float", 0);  -- commanded pitch. -1 = down, +1 = up
createProp("sim/custom/xap/An24_controls/yoke_roll", "float", 0);  -- commanded roll. -1 = left, +1 = right
createProp("sim/custom/xap/An24_controls/yoke_yaw", "float", 0);  -- commanded yaw. -1 = left, +1 = right

defineProperty("yoke_pitch", globalPropertyf("sim/custom/xap/An24_controls/yoke_pitch"))
defineProperty("yoke_roll", globalPropertyf("sim/custom/xap/An24_controls/yoke_roll"))
defineProperty("yoke_yaw", globalPropertyf("sim/custom/xap/An24_controls/yoke_yaw"))

set(overr, 0)



			  
local ail_actual_L = 0
local ail_actual_R = 0

local elevator_actual = 0

local rudder_actual = 0

local sync_counter = 0


function update()
	-- initialise
	set(overr, 1)
	
	
	
	local passed = get(frame_time)

	local IAS = get(airspeed)
	
	local trimm_infuence = math.min(1, math.abs(IAS) / 100)
	
	-- ailerons
	-- controll wheel rotates up to 65 deg each direction
	-- ailerons moves UP to 24 deg, down to 16 deg.
	-- set main control for ailerons
	local ail_coef = math.abs(get(roll_ratio)) ^ (1 + math.max(0, IAS - 150) / 50) -- wind dependency
	local roll_wheel = get(roll_ratio) * ail_coef -- yoke roll by pilots hands
	local roll_comm = roll_wheel + get(aileron_trim) * 0.5 * trimm_infuence + get(ap_roll_comm) -- add wheel ratio and trimmers. add AP here
	
	if roll_comm > 1 then roll_comm = 1
	elseif roll_comm < -1 then roll_comm = -1 end
	
	set(yoke_roll, roll_comm)
	
	local left_ail_deg = 0
	local right_ail_deg = 0
	if roll_comm > 0.001 then -- roll right
		left_ail_deg = math.min(roll_comm * 16, 16) 
		right_ail_deg = -math.min(roll_comm * 24, 24)
	elseif roll_comm < -0.001 then -- roll left
		right_ail_deg = -math.max(roll_comm * 16, -16)
		left_ail_deg = math.max(roll_comm * 24, -24)
	else
		left_ail_deg = 0
		right_ail_deg = 0
	end
	
	-- add smooth movements
	ail_actual_L = ail_actual_L + (left_ail_deg - ail_actual_L) * passed * 10
	ail_actual_R = ail_actual_R + (right_ail_deg - ail_actual_R) * passed * 10

	-- set results
	set(ail_set_L, ail_actual_L)
	set(ail_set_R, ail_actual_R)	
	




	-- elevator control
	-- elevator moves in range from 15 deg down to 30 deg up.
	
	local elev_coef = (math.abs(get(pitch_ratio)) ^ (1 + math.max(0, IAS - 150) / 150))
	local pitch_wheel = get(pitch_ratio) * elev_coef -- pitch commanded by pilot
	local pitch_comm = pitch_wheel + get(elevator_trim) * 0.5 * trimm_infuence + get(ap_pitch_comm) -- commanded pitch + trimmer
	
	if pitch_comm > 1 then pitch_comm = 1
	elseif pitch_comm < -1 then pitch_comm = -1 end
	
	set(yoke_pitch, pitch_comm)
	
	local elevator_deg = 0
	-- math.abs(pitch_comm)^(1 + IAS / 100)
	if pitch_comm < -0.001 then elevator_deg = -pitch_comm * 15
	elseif pitch_comm > 0.001 then elevator_deg = -pitch_comm * 30
	else elevator_deg = 0
	end


	-- smooth move and add hydraulic
	elevator_actual = elevator_actual + (elevator_deg - elevator_actual) * passed * 10
	
	--set(elevator_trim, 0)
	set(elevator_L, elevator_actual)
	set(elevator_R, elevator_actual)



	
	
	-- rudder control
	-- full travel of rudder is 25 deg
	local yaw_coef = (math.abs(get(head_ratio)) ^ (1 + math.max(0, IAS - 150) / 100))
	local yaw_wheel = get(head_ratio) * yaw_coef -- yaw by pilots
	local yaw_comm = yaw_wheel + get(rudder_trim) * 0.5 * trimm_infuence + get(ap_yaw_comm) -- commaded yaw + trimmers + AP
	
	if yaw_comm > 1 then yaw_comm = 1
	elseif yaw_comm < -1 then yaw_comm = -1 end
	
	set(yoke_yaw, yaw_comm)
	
	local yav_deg = yaw_comm * 25

	-- smooth moves and add hydraulics speed
	rudder_actual = rudder_actual + (yav_deg - rudder_actual) * passed * 5
	
	set(rudder, rudder_actual)
	


	
	

end

function onAvionicsDone()
	set(overr, 0)
	print("flight controls released")
end
