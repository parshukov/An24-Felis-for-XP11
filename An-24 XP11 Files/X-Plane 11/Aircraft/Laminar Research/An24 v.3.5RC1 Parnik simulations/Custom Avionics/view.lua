
defineProperty("sy", globalPropertyf("sim/aircraft/view/acf_peY"))
defineProperty("sz", globalPropertyf("sim/aircraft/view/acf_peZ"))
defineProperty("alpha", globalPropertyf("sim/flightmodel2/misc/AoA_angle_degrees"))
defineProperty("swview", globalPropertyi("sim/custom/xap/An24_view/switch_view"))
defineProperty("swvib", globalPropertyi("sim/custom/xap/An24_view/switch_vib"))
defineProperty("py", globalPropertyf("sim/graphics/view/pilots_head_y"))
defineProperty("px", globalPropertyf("sim/graphics/view/pilots_head_x"))
defineProperty("pz", globalPropertyf("sim/graphics/view/pilots_head_z"))
defineProperty("az", globalPropertyf("sim/graphics/view/pilots_head_the"))
defineProperty("ax", globalPropertyf("sim/graphics/view/pilots_head_psi"))
defineProperty("ay", globalPropertyf("sim/graphics/view/cockpit_heading"))
defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))
defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload

defineProperty("timef", globalPropertyf("sim/time/total_flight_time_sec"))
defineProperty("gear_force1", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))
defineProperty("gear_force2", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("gear_force3", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))

defineProperty("set_active_camera", globalPropertyi("sim/custom/xap/An24_set/active_camera")) -- use of moveing camera
defineProperty("sim_version", globalPropertyi("sim/custom/xap/sim_version"))  -- saved sim version

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames


captview2 = findCommand("sim/view/forward_with_panel")
cockview2 = findCommand("sim/view/3d_cockpit_cmnd_look") -- command from X-Plane 10

a_last = 0
spdlast = get(speed)
koefspd = 0.01
koefairspd = 0.0001
deltalast = 0
amplitude = 0
amplitude2 = 0
koefalpha = 0.003
per = 1
koefgrnd = 0.000001
timelast = 0
deltaairspd = 0

function update()

	--points of view     0-captain 1-copilot 2-eng 3-navigator 4-overhead 5-passanger left to landing gear 6-passanger right to landing gear
	a = get(swview)
	delta = a - a_last
	if delta ~= 0 then
		if get(sim_version) == 10 then 
			commandOnce(cockview2)  -- XP10 view workaround
			if a == 0 or a == 10 then set(px , -0.45104) set(py , -0.301878) set(pz , -6.800526) set(az, -5) set(ax, 0)
			elseif a == 1 or a == 11 then set(px , 0.45104) set(py , -0.301878) set(pz , -6.800256) set(az, -5) set(ax, 0)
			elseif a == 2 or a == 12 then set(px , 0) set(py , -0.1583) set(pz , -6.908865) set(az, -60) set(ax, 0)
			elseif a == 3 or a == 13 then set(px , -0.58145) set(py , -0.44984) set(pz , -6.16666) set(az, -20) set(ax, 281)
			elseif a == 4 or a == 14 then set(px , 0) set(py , -0.614) set(pz , -6.608865) set(az, 48) set(ax, 0)
			elseif a == 5 or a == 15 then set(px , -1.2946) set(py , -0.851) set(pz , 2.0518) set(az, -20) set(ax, 310)
			elseif a == 6 or a == 16 then set(px , 1.2946) set(py , -0.851) set(pz , 2.0518) set(az, -20) set(ax, 50)
			end
		else
			if a == 0 or a == 10 then set(px , -0.45104) set(py , -0.301878) set(pz , -6.800526) set(az, -5) set(ax, 0)
			elseif a == 1 or a == 11 then set(px , 0.45104) set(py , -0.301878) set(pz , -6.800256) set(az, -5) set(ax, 0)
			elseif a == 2 or a == 12 then set(px , 0) set(py , -0.1583) set(pz , -6.908865) set(az, -60) set(ax, 0)
			elseif a == 3 or a == 13 then set(px , -0.58145) set(py , -0.44984) set(pz , -6.16666) set(az, -20) set(ax, 281)
			elseif a == 4 or a == 14 then set(px , 0) set(py , -0.614) set(pz , -6.608865) set(az, 48) set(ax, 0)
			elseif a == 5 or a == 15 then set(px , -1.2946) set(py , -0.851) set(pz , 2.0518) set(az, -20) set(ax, 310)
			elseif a == 6 or a == 16 then set(px , 1.2946) set(py , -0.851) set(pz , 2.0518) set(az, -20) set(ax, 50)
			end
		end
	end
	a_last = a

	-- active camera
	local camera_work = get(set_active_camera) == 1
	if camera_work then


		timenow = get(timef)
		swvib = get(swvib)
		deltatime = timenow - timelast
		if deltatime ~= 0 and swvib == 1 then

			--angle of attack
			angle = get(alpha)
			dalphatmp = math.abs(17 - angle)
			if dalphatmp < 2 then dalphatmp = 2 end
			dalpha = 1 / (dalphatmp * dalphatmp)
			tst = 0
			if angle < 90 and angle > 9.5 and (get(speed) > 50 or get(airspeed) > 30)then tst = 1 else tst = 0 end
			amplitude = tst * dalpha * koefalpha

			--airspeed
			if get(airspeed) > 270 then
			deltaairspd = get(airspeed) - 270
			if deltaairspd > 70 then deltaairspd = 70 end
			end
			amplitude3 = deltaairspd * koefairspd

			--ground
			spdnow = get(speed)
			g1 = get(gear_force1)
			g2 = get(gear_force2)
			g3 = get(gear_force3)
			gf = get(gforce)
			if (g1 + g2 + g3) > 0 then amptmp = 1 else amptmp = 0 end
			ampres = (g1 + g2 + g3) * spdnow
			amplitude2 = amptmp * ampres * spdnow * koefgrnd

		else amplitude = 0 amplitude2 = 0 amplitude3 = 0
		end
		timelast = timenow
		
		
		--vibration module
		local passed = get(timenow) * 50
		local resdrrr = get(sy) + math.sin(passed) * (amplitude + amplitude2 + amplitude3)
		set(sy , resdrrr)
	end
end
