defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]")) -- 0.15 верт отклонение стоянка
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("gear3_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))

defineProperty("steer", globalPropertyf("sim/flightmodel2/gear/tire_steer_actual_deg[0]"))

defineProperty("thrust1", globalPropertyf("sim/flightmodel/engine/POINT_thrust[0]")) -- Newtons
defineProperty("thrust2", globalPropertyf("sim/flightmodel/engine/POINT_thrust[1]"))
defineProperty("thrust3", globalPropertyf("sim/flightmodel/engine/POINT_thrust[2]"))

defineProperty("M_roll", globalPropertyf("sim/flightmodel/forces/L_plug_acf")) -- pos right
defineProperty("M_pitch", globalPropertyf("sim/flightmodel/forces/M_plug_acf")) -- pos up
defineProperty("M_yaw", globalPropertyf("sim/flightmodel/forces/N_plug_acf")) -- pos right

defineProperty("F_side", globalPropertyf("sim/flightmodel/forces/fside_plug_acf")) -- pos right
defineProperty("F_vert", globalPropertyf("sim/flightmodel/forces/fnrml_plug_acf")) -- pos up
defineProperty("F_long", globalPropertyf("sim/flightmodel/forces/faxil_plug_acf")) -- pos aft

defineProperty("ias", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))
defineProperty("slip", globalPropertyf("sim/flightmodel/misc/slip"))

defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  --deploy of front gear
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of left gear


------------
--SETTINGS--
------------
koef_groundforce = 3 --3
koef_stabforce_air = 0.8 --0.8
koef_stabforce_ground = 0.2 --0.2
koef_propforce = 0 --0
koef_slipforce = 100 --100
koef_landgear = 0.5    -- 0ю5 positive nose up
------------
------------
------------

function update()
	
	delta_thrust = (get(thrust2) + get(thrust3)) - get(thrust1)
	if get(gear1_deflect) > 0.05 then
		stab_force = get(thrust2) * koef_stabforce_ground
		ground_force = delta_thrust * koef_groundforce	
	else
		ground_force = 0 
		stab_force = get(thrust2) * koef_stabforce_air
	end
	
	if stab_force < 0 then stab_force = 0 end
	
	thr1 = get(thrust1)
	thr2 = get(thrust2)
	if thr1 < 0 then thr1 = 0 end
	if thr2 < 0 then thr2 = 0 end
	prop_force = (thr1+ thr2) * koef_propforce
	
	slip_force = get(slip) * get(ias) * koef_slipforce

	result_roll = prop_force + slip_force
	result_yaw = ground_force + stab_force 
	
	set(M_roll, result_roll)
	set(M_yaw, result_yaw)
	
	--landgear pitch moment
	result_pitch = get(ias)^2 * (get(gear1_deploy) + get(gear2_deploy) + get(gear3_deploy))/3 * koef_landgear 
	set(M_pitch, result_pitch)

end
