-- this is fire system logic and logic of fire itself
-- define property table
-- custom variables
-- switchers and buttons
defineProperty("fire_main_switcher", globalPropertyi("sim/custom/xap/An24_fire/fire_main_switcher"))  -- main switcher for fire system.
defineProperty("fire_left_wing_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_left_wing_btn"))  -- fire in left wing button
defineProperty("fire_left_wing_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_wing_lit"))  -- fire in left wing light
defineProperty("fire_right_wing_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_right_wing_btn"))  -- fire in right wing button
defineProperty("fire_right_wing_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_wing_lit"))  -- fire in right wing light
defineProperty("fire_left_nacelle_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_left_nacelle_btn"))  -- fire in left nacelle button
defineProperty("fire_left_nacelle_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_nacelle_lit"))  -- fire in left nacelle light
defineProperty("fire_right_nacelle_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_right_nacelle_btn"))  -- fire in right nacelle button
defineProperty("fire_right_nacelle_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_nacelle_lit"))  -- fire in right nacelle light
defineProperty("fire_ru19_btn", globalPropertyi("sim/custom/xap/An24_fire/fire_ru19_btn"))  -- fire in ru19 button
defineProperty("fire_ru19_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_ru19_lit"))  -- fire in ru19 light

-- engines lamps and buttons
defineProperty("fire_left_eng_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_lit"))  -- fire in left engine light
defineProperty("fire_right_eng_lit", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_lit"))  -- fire in right engine light

defineProperty("ext_left_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_left_ready_lit"))  -- left engine extinguisher ready
defineProperty("ext_right_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_right_ready_lit"))  -- right engine extinguisher ready
defineProperty("ext_first_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_first_ready_lit"))  -- furst turn extinguisher ready
defineProperty("ext_second_ready_lit", globalPropertyi("sim/custom/xap/An24_fire/ext_second_ready_lit"))  -- second turn extinguisher ready

defineProperty("fire_left_eng_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_ext"))  -- button for left engine fire extinguisher
defineProperty("fire_left_eng_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_left_eng_ext_cap"))  -- cap for button for left engine fire extinguisher

defineProperty("fire_right_eng_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_ext"))  -- button for right engine fire extinguisher
defineProperty("fire_right_eng_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_right_eng_ext_cap"))  -- cap for button for right engine fire extinguisher

defineProperty("fire_second_ext", globalPropertyi("sim/custom/xap/An24_fire/fire_second_ext"))  -- button for second turn fire extinguisher
defineProperty("fire_second_ext_cap", globalPropertyi("sim/custom/xap/An24_fire/fire_second_ext_cap"))  -- cap for button for second turn fire extinguisher

-- sim variables
defineProperty("sim_engine_fire1", globalPropertyi("sim/cockpit2/annunciators/engine_fires[0]"))  -- left engine fire indicator
defineProperty("sim_engine_fire2", globalPropertyi("sim/cockpit2/annunciators/engine_fires[1]"))  -- right engine fire indicator
defineProperty("sim_engine_fire3", globalPropertyi("sim/cockpit2/annunciators/engine_fires[2]"))  -- RU19 engine fire indicator

defineProperty("sim_engine_on_fire1", globalPropertyi("sim/operation/failures/rel_engfir0"))  -- left engine on fire
defineProperty("sim_engine_on_fire2", globalPropertyi("sim/operation/failures/rel_engfir1"))  -- right engine on fire
defineProperty("sim_engine_on_fire3", globalPropertyi("sim/operation/failures/rel_engfir2"))  -- RU19 engine on fire


defineProperty("sim_engine_ext1", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[0]"))  -- left engine fire extinguiher
defineProperty("sim_engine_ext2", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[1]"))  -- right engine fire extinguiher
defineProperty("sim_engine_ext3", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[2]"))  -- RU19 engine fire extinguiher

defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload
defineProperty("left_wing_det", globalPropertyi("sim/operation/failures/rel_wing1L")) -- left wing detach
defineProperty("right_wing_det", globalPropertyi("sim/operation/failures/rel_wing1R")) -- left wing detach

defineProperty("fire_warinig", globalPropertyi("sim/custom/xap/An24_fire/fire_warinig")) -- fire warning for sirene logic

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("fire_cc", globalPropertyf("sim/custom/xap/An24_fire/fire_cc")) 

--sim/custom/xap/An24_fire/fire_warinig
-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- reality
defineProperty("set_real_fire", globalPropertyi("sim/custom/xap/An24_set/real_fire")) -- fire will affect wings and nearest mech

set(sim_engine_ext1, 0)
set(sim_engine_ext2, 0)
set(sim_engine_ext3, 0)

local passed = 0
local sim_time = get(flight_time)


-- fake fire objects
local left_wing_fire = false
local right_wing_fire = false
local left_nacelle_fire = false
local right_nacelle_fire = false

-- extinguisher values
local first_turn_ready = true
local second_turn_ready = true

local left_eng_ready = true
local right_eng_ready = true

-- time counters
local left_eng_time = sim_time
local right_eng_time = sim_time
local ru19_time = sim_time

local left_wing_time = 0
local right_wing_time = 0

-- triggers
local left_nacelle_fired = false
local left_wing_fired = false
local right_nacelle_fired = false
local right_wing_fired = false


-- light timers
local left_wing_light_time = sim_time - 20
local right_wing_light_time = sim_time - 20
local left_nacelle_light_time = sim_time - 20
local right_nacelle_light_time = sim_time - 20
local ru19_light_time = sim_time - 20

-- lamp lit
local left_wing_light = false
local right_wing_light = false
local left_nacelle_light = false
local right_nacelle_light = false
local ru19_light = false



function update()
	passed = get(frame_time)
if  passed > 0 then
	sim_time = get(flight_time)
	
	-- power logic
	local power = get(fire_main_switcher) ~= 0 and get(bus_DC_27_volt) > 21  -- this will be extended
	
	-- reset time counters when engines work normally or fire were extinguished
	if get(sim_engine_fire1) == 0 or get(sim_engine_ext1) == 1 then left_eng_time = sim_time end
	if get(sim_engine_fire2) == 0 or get(sim_engine_ext2) == 1 then right_eng_time = sim_time end
	if get(sim_engine_fire3) == 0 or get(sim_engine_ext3) == 1 then ru19_time = sim_time end
	
	-- reset time for lamps
	if get(sim_engine_fire3) == 1 or get(fire_ru19_btn) == 1 then ru19_light_time = sim_time end
	if left_wing_fire or get(fire_left_wing_btn) == 1 then left_wing_light_time = sim_time end
	if right_wing_fire or get(fire_right_wing_btn) == 1 then right_wing_light_time = sim_time end
	if left_nacelle_fire or get(fire_left_nacelle_btn) == 1 then left_nacelle_light_time = sim_time end
	if right_nacelle_fire or get(fire_right_nacelle_btn) == 1 then right_nacelle_light_time = sim_time end	
	
	-- lamps logic
	if power then
		set(fire_cc, 15)
		set(fire_left_eng_lit, get(sim_engine_fire1)) -- left engine
		set(fire_right_eng_lit, get(sim_engine_fire2)) -- right engine
		if sim_time - ru19_light_time < 15 then 
			set(fire_ru19_lit, 1)
			ru19_light = true
		else 
			ru19_light = false
			set(fire_ru19_lit, 0) end  -- ru19 lamp
		
		if sim_time - left_wing_light_time < 15 then 
			set(fire_left_wing_lit, 1)
			left_wing_light = true
		else 
			set(fire_left_wing_lit, 0) 
			left_wing_light = false end -- left wing lamp
		
		if sim_time - right_wing_light_time < 15 then 
			set(fire_right_wing_lit, 1)
			right_wing_light = true
		else 
			set(fire_right_wing_lit, 0) 
			right_wing_light = false end -- right wing lamp
		
		if sim_time - left_nacelle_light_time < 15 then 
			set(fire_left_nacelle_lit, 1) 
			left_nacelle_light = true
		else 
			set(fire_left_nacelle_lit, 0) 
			left_nacelle_light = false end -- left nacelle lamp
		
		if sim_time - right_nacelle_light_time < 15 then 
			set(fire_right_nacelle_lit, 1)
			right_nacelle_light = true
		else 
			set(fire_right_nacelle_lit, 0) 
			right_nacelle_light = false end -- right nacelle lamp	
		
		-- ext ready lamps
		if first_turn_ready then set(ext_first_ready_lit, 1) else set(ext_first_ready_lit, 0) end
		if second_turn_ready then set(ext_second_ready_lit, 1) else set(ext_second_ready_lit, 0) end
		if left_eng_ready then set(ext_left_ready_lit, 1) else set(ext_left_ready_lit, 0) end
		if right_eng_ready then set(ext_right_ready_lit, 1) else set(ext_right_ready_lit, 0) end
	else
		set(fire_cc, 0)
		set(fire_left_eng_lit, 0) -- left engine
		set(fire_right_eng_lit, 0) -- right engine
		set(fire_ru19_lit, 0)
		set(fire_left_wing_lit, 0)
		set(fire_right_wing_lit, 0)
		set(fire_left_nacelle_lit, 0)
		set(fire_right_nacelle_lit, 0)
		ru19_light = false
		left_wing_light = false
		right_wing_light = false
		left_nacelle_light = false
		right_nacelle_light = false
		set(ext_first_ready_lit, 0)
		set(ext_second_ready_lit, 0)
		set(ext_left_ready_lit, 0)
		set(ext_right_ready_lit, 0)
		left_wing_light_time = sim_time - 20
		right_wing_light_time = sim_time - 20
		left_nacelle_light_time = sim_time - 20
		right_nacelle_light_time = sim_time - 20
		ru19_light_time = sim_time - 20
	end
	
	-- sirene logic
	if get(fire_main_switcher) == 1 and (ru19_light or left_wing_light or right_wing_light or left_nacelle_light or right_nacelle_light or get(fire_left_eng_lit) == 1 or get(fire_right_eng_lit) == 1) then
		set(fire_warinig, 1)
	else set(fire_warinig, 0) end
	
	-- extinguishers logic
	if power and get(fire_main_switcher) > 0 then
		-- left engine manual ext
		if get(fire_left_eng_ext) == 1 and left_eng_ready then 
			set(sim_engine_ext1, 1) 
			left_eng_ready = false
			set(sim_engine_on_fire1, 0)
		end
		-- right engine manual ext
		if get(fire_right_eng_ext) == 1 and right_eng_ready then
			right_eng_ready = false
			set(sim_engine_ext2, 1)
			set(sim_engine_on_fire2, 0)
		end
		-- automatic ext on ru19
		if ru19_light and first_turn_ready then
			first_turn_ready = false
			set(sim_engine_ext3, 1)
			set(sim_engine_on_fire3, 0)
		end
		-- manual ext on ru19
		if ru19_light and second_turn_ready and get(fire_second_ext) == 1 then
			second_turn_ready = false
			set(sim_engine_ext3, 1)
		end
		-- automatic ext on left wing
		if left_wing_light and first_turn_ready then
			first_turn_ready = false
			left_wing_fire = false
		end
		-- manual ext on left wing
		if left_wing_light and second_turn_ready and get(fire_second_ext) == 1 then
			second_turn_ready = false
			left_wing_fire = false
		end		
		-- automatic ext on right wing
		if right_wing_light and first_turn_ready then
			first_turn_ready = false
			right_wing_fire = false
		end
		-- manual ext on right wing
		if right_wing_light and second_turn_ready and get(fire_second_ext) == 1 then
			second_turn_ready = false
			right_wing_fire = false
		end			
		-- automatic ext on left nacelle
		if left_nacelle_light and first_turn_ready then
			first_turn_ready = false
			left_nacelle_fire = false
		end
		-- manual ext on left nacelle
		if left_nacelle_light and second_turn_ready and get(fire_second_ext) == 1 then
			second_turn_ready = false
			left_nacelle_fire = false
		end		
		-- automatic ext on right nacelle
		if right_nacelle_light and first_turn_ready then
			first_turn_ready = false
			right_nacelle_fire = false
		end
		-- manual ext on right nacelle
		if right_nacelle_light and second_turn_ready and get(fire_second_ext) == 1 then
			second_turn_ready = false
			right_nacelle_fire = false
		end			
		
		-- fire logic
		local real = get(set_real_fire) == 1
		-- fire timers
		if get(sim_engine_on_fire1) < 6 or not real then left_eng_time = sim_time end
		if get(sim_engine_on_fire2) < 6 or not real then right_eng_time = sim_time end
		if get(sim_engine_on_fire3) < 6 or not real then ru19_time = sim_time end
		
		-- nacelle will burn after 60 sec of engine burning
		if sim_time - left_eng_time > 60 and not left_nacelle_fired then 
			left_nacelle_fired = true
			left_wing_fire = true
		end
		-- wing will burn after 120 sec of engine burning
		if sim_time - left_eng_time > 120 and not left_wing_fired then
			left_wing_fired = true
			left_wing_fire = true
		end
		-- nacelle will burn after 60 sec of engine burning
		if sim_time - right_eng_time > 60 and not right_nacelle_fired then
			right_nacelle_fired = true
			right_nacelle_fire = true
		end
		-- ru19 will burn after 80 sec of engine burning
		if sim_time - right_eng_time > 80 and get(sim_engine_on_fire3) < 6 and get(sim_engine_ext3) == 0 then
			set(sim_engine_on_fire3, 6)
		end
		-- wing will burn after 120 sec of engine burning
		if sim_time - right_eng_time > 120 and not right_wing_fired then
			right_wing_fired = true
			right_wing_fire = true
		end
		
		-- result of fire is weakness of wings
		if left_wing_fire then left_wing_time = left_wing_time + passed end
		if right_wing_fire then right_wing_time = right_wing_time + passed end
		
		local G = get(gforce)
		
		if math.abs(G) > 4.5 - left_wing_time / 200 then set(left_wing_det, 6) end
		if math.abs(G) > 4.5 - right_wing_time / 200 then set(right_wing_det, 6) end

		
	end

end

	
end
