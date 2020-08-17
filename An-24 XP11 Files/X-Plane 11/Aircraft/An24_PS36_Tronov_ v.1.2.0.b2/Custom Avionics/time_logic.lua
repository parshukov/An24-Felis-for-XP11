-- this is time logic for all scripts

-- sim time
--defineProperty("sim_run_time", globalPropertyf("sim/time/total_flight_time_sec")) -- sim time
defineProperty("M", globalPropertyf("sim/flightmodel/position/M"))  -- some momentum of aircraft. it's remein one value, when sim paused
defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time


defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time

local time_last = get(sim_run_time)  -- time for previous frame
--local last_m = get(M)

function update()
	-- time calculations
	local time_now = get(sim_run_time)
	local passed = math.abs(time_now - time_last)
	--local curent_m = get(M)
	--print(passed)
	--if curent_m - last_m == 0 then passed = 0 end
	if passed > 0.1 then passed = 0.1 end
	
	set(frame_time, passed)
	
	-- last variables
	time_last = time_now
	--last_m = curent_m
	
end


