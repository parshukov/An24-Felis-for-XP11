
-- this is one of three mechanical device for autopilot AP45.

-- property table
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time
defineProperty("ap_power")  -- variable if autopilot is ON 

defineProperty("control_channel")  -- control channel witch is rudder, aileron or elevator trim
defineProperty("angle_difference")  -- difference angle between needed and curent position of aircraft

defineProperty("sensetivity")    -- quality of mechanic
defineProperty("limit_max")    -- upper limit of trimmer (max right, up)
defineProperty("limit_min")    -- lower limit of trimmer (max left, down)
defineProperty("deflect_time")  -- time for full deflection of used channel, sec
defineProperty("near_angle")  -- maximum agnle differense, where trimmers will work at not of all their range

local deflect = 0     -- new needed deflection
local last_stable_deflect = get(control_channel)   -- stable position

local deflect = 0

function update()

   local passed = get(frame_time)   -- time passed from the last frame
   local power = get(ap_power)                 -- power of autopilot
   local diff_angle = get(angle_difference)         -- control angle
   local maximum = get(limit_max)                  -- maximum deflection
   local minimum = -get(limit_min)                 -- minimum deflection
   local range = math.abs(maximum - minimum)           -- range of deflection
   local deflect_now = get(control_channel)    -- curent deflection
   local work_time = get(deflect_time)        -- time for full deflection from min to max or backward
   local near = get(near_angle)
   local sens = get(sensetivity)

--   deflect = deflect_now
 
   -- calculate new deflection and set it
if power == 1 and passed > 0 then    -- if autopilot is ON and sim runing
      
    -- normalize angle to range from -1 to +1
    
	local angle = diff_angle / near
	
	if angle > 1 then angle = 1
	elseif angle < -1 then angle = -1 end
	
	
	-- stable position calculations
	if angle > sens then
		last_stable_deflect = last_stable_deflect + 0.2 * passed / work_time 
	elseif angle < -sens then
		last_stable_deflect = last_stable_deflect - 0.2 * passed / work_time
	end
	
    if last_stable_deflect > maximum then last_stable_deflect = maximum  -- set limits of deflection
    elseif last_stable_deflect < minimum then last_stable_deflect = minimum end
	
    deflect = last_stable_deflect + angle * range * passed * 300 / work_time  -- calculating reaction of mechanic
     
 
    if deflect > maximum then deflect = maximum end  -- set limits of deflection
    if deflect < minimum then deflect = minimum end

    set(control_channel, deflect)    -- set calculated deflect
else
last_stable_deflect = deflect_now

end

end   
