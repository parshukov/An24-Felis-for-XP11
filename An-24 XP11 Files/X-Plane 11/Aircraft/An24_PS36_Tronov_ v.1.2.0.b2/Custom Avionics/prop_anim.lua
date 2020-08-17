-- this is prop animation logic

-- dataRefs
defineProperty("override_1", globalPropertyi("sim/flightmodel2/engines/prop_disc/override[0]")) -- override
defineProperty("override_2", globalPropertyi("sim/flightmodel2/engines/prop_disc/override[1]"))

defineProperty("prop_is_disc_1", globalPropertyi("sim/flightmodel2/engines/prop_is_disc[0]")) -- bool 1 = disc, 0 = prop
defineProperty("prop_is_disc_2", globalPropertyi("sim/flightmodel2/engines/prop_is_disc[1]"))

defineProperty("prop_angle_1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_angle[0]")) -- current rotation angle of prop
defineProperty("prop_angle_2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_angle[1]"))

defineProperty("prop_angle_12", globalPropertyf("sim/flightmodel2/engines/prop_rotation_angle_deg[0]")) -- current rotation angle of prop
defineProperty("prop_angle_22", globalPropertyf("sim/flightmodel2/engines/prop_rotation_angle_deg[1]"))

defineProperty("prop1_rpm_rads", globalPropertyf("sim/flightmodel2/engines/prop_rotation_speed_rad_sec[0]"))  -- prop rotation rad/sec
defineProperty("prop2_rpm_rads", globalPropertyf("sim/flightmodel2/engines/prop_rotation_speed_rad_sec[1]"))

--------------------
-- disc variables --

defineProperty("disc_s_dim1", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_s_dim[0]"))
defineProperty("disc_s_dim2", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_s_dim[1]"))

defineProperty("disc_alpha_side1", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_side[0]"))
defineProperty("disc_alpha_side2", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_side[1]"))

defineProperty("side_length_ratio1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_length_ratio[0]"))
defineProperty("side_length_ratio2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_length_ratio[1]"))

defineProperty("side_s_dim1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_s_dim[0]"))
defineProperty("side_s_dim2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_s_dim[1]"))

defineProperty("disc_alpha_inside1", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_inside[0]"))
defineProperty("disc_alpha_inside2", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_inside[1]"))

defineProperty("side_alpha_inside1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_alpha_inside[0]"))
defineProperty("side_alpha_inside2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_alpha_inside[1]"))

defineProperty("side_t_dim1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_t_dim[0]"))
defineProperty("side_t_dim2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_t_dim[1]"))

defineProperty("disc_alpha_front1", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_front[0]"))
defineProperty("disc_alpha_front2", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_alpha_front[1]"))

defineProperty("side_width1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_width[0]"))
defineProperty("side_width2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_width[1]"))

defineProperty("side_number_of_blades1", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_number_of_blades[0]"))
defineProperty("side_number_of_blades2", globalPropertyf("sim/flightmodel2/engines/prop_disc/side_number_of_blades[1]"))

defineProperty("disc_width1", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_width[0]"))
defineProperty("disc_width2", globalPropertyf("sim/flightmodel2/engines/prop_disc/disc_width[1]"))




-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time


-- take control from sim by plugin
set(override_1, 0)
set(override_2, 0)

-- release control by plugin
function onAvionicsDone()
	set(override_1, 0)
	set(override_2, 0)
	print("props released")
end

local left_prop_angle = 0
local right_prop_angle = 0

local counter = 0
local not_loaded = true

function update()
	local passed = get(frame_time)
	
	-- set override after few seconds
	counter = counter + passed
	if not_loaded and counter > 0.3 and counter < 0.5 then
		set(override_1, 1)
		set(override_2, 1)
		not_loaded = false
	end
	
	
	local left_rpm = get(prop1_rpm_rads) / 0.10471975511966
	local right_rpm = get(prop2_rpm_rads) / 0.10471975511966
	
	-- set disk visible
	if left_rpm > 300 then set(prop_is_disc_1, 1) else set(prop_is_disc_1, 0) end
	if right_rpm > 300 then set(prop_is_disc_2, 1) else set(prop_is_disc_2, 0) end
	
	-- set rotation angle	
	left_prop_angle = left_prop_angle + left_rpm * passed * 2
	right_prop_angle = right_prop_angle + right_rpm * passed * 2
	
	if left_prop_angle > 360 then left_prop_angle = left_prop_angle - 360 end
	if right_prop_angle > 360 then right_prop_angle = right_prop_angle - 360 end
	
	-- set limits
	local left_angle = left_prop_angle
	local right_angle = right_prop_angle
	while left_angle > 360 do left_angle = left_angle - 360 end
	while right_angle > 360 do right_angle = right_angle - 360 end
	
	set(prop_angle_1, left_angle)
	set(prop_angle_2, right_angle)
	set(prop_angle_12, left_angle)
	set(prop_angle_22, right_angle)	
	
	
	-- test
	set(disc_s_dim1, 1)
	set(disc_s_dim2, 1)
	set(disc_alpha_side1, 0.2)
	set(disc_alpha_side2, 0.2)	
	set(side_length_ratio1, 1)
	set(side_length_ratio2, 1)
	set(side_s_dim1, 1)
	set(side_s_dim2, 1)
	set(disc_alpha_inside1, 0.5)
	set(disc_alpha_inside2, 0.5)
	set(side_alpha_inside1, 0)
	set(side_alpha_inside2, 0)	
	set(side_t_dim1, 1)
	set(side_t_dim2, 1)
	set(disc_alpha_front1, 1 - left_rpm / 2300)  -- prop disc opacity
	set(disc_alpha_front2, 1 - right_rpm / 2300)
	set(side_width1, 0.1)
	set(side_width2, 0.1)
	set(side_number_of_blades1, 2)
	set(side_number_of_blades2, 2)
	set(disc_width1, 0.03)  -- prop disc width
	set(disc_width2, 0.03)
	

end

