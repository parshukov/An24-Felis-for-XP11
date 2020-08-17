-- this is cockpit ventilator angle calculations

-- define property table

defineProperty("vent_1", globalPropertyf("sim/custom/xap/An24_misc/vent_1"))
defineProperty("vent_2", globalPropertyf("sim/custom/xap/An24_misc/vent_2"))
defineProperty("vent_3", globalPropertyf("sim/custom/xap/An24_misc/vent_3"))
defineProperty("vent_4", globalPropertyf("sim/custom/xap/An24_misc/vent_4"))

defineProperty("vent_1_sw", globalPropertyi("sim/custom/xap/An24_misc/vent_1_sw"))
defineProperty("vent_2_sw", globalPropertyi("sim/custom/xap/An24_misc/vent_2_sw"))
defineProperty("vent_3_sw", globalPropertyi("sim/custom/xap/An24_misc/vent_3_sw"))
defineProperty("vent_4_sw", globalPropertyi("sim/custom/xap/An24_misc/vent_4_sw"))

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time
defineProperty("cam_in_cockpit", globalPropertyi("sim/graphics/view/view_is_external"))


local vent1_sound = loadSample('Custom Sounds/cockpit_fan.wav')
local vent2_sound = loadSample('Custom Sounds/cockpit_fan.wav')

playSample(vent1_sound, 1) -- fan sound
setSampleGain(vent1_sound, 0)
playSample(vent2_sound, 1) -- fan sound
setSampleGain(vent2_sound, 0)



local vent1_spd = 0
local vent2_spd = 0
local vent3_spd = 0
local vent4_spd = 0

local UP_SPD = 300
local DN_SPD = 100
local MAX_SPD = 1000  -- deg per second

function update()
	local passed = get(frame_time)
	local power = get(bus_DC_27_volt) > 21
	
	-- vent 1
	if power and get(vent_1_sw) == 1 then vent1_spd = vent1_spd + UP_SPD * passed
	else vent1_spd = vent1_spd - DN_SPD * passed end
	
	if vent1_spd > MAX_SPD then vent1_spd = MAX_SPD
	elseif vent1_spd < 0 then vent1_spd = 0 end
	
	set(vent_1, get(vent_1) + vent1_spd * passed)
	---------

	-- vent 2
	if power and get(vent_1_sw) == 1 then vent2_spd = vent2_spd + UP_SPD * passed
	else vent2_spd = vent2_spd - DN_SPD * passed end
	
	if vent2_spd > MAX_SPD then vent2_spd = MAX_SPD
	elseif vent2_spd < 0 then vent2_spd = 0 end
	
	set(vent_2, get(vent_2) + vent2_spd * passed)
	---------	
	
	-- vent 3
	if power and get(vent_1_sw) == 1 then vent3_spd = vent3_spd + UP_SPD * passed
	else vent3_spd = vent3_spd - DN_SPD * passed end
	
	if vent3_spd > MAX_SPD then vent3_spd = MAX_SPD
	elseif vent3_spd < 0 then vent3_spd = 0 end
	
	set(vent_3, get(vent_3) + vent3_spd * passed)
	---------

	-- vent 4
	if power and get(vent_1_sw) == 1 then vent4_spd = vent4_spd + UP_SPD * passed
	else vent4_spd = vent4_spd - DN_SPD * passed end
	
	if vent4_spd > MAX_SPD then vent4_spd = MAX_SPD
	elseif vent4_spd < 0 then vent4_spd = 0 end
	
	set(vent_4, get(vent_4) + vent4_spd * passed)
	---------
	
	
	-- vent loudness
	local inside = get(cam_in_cockpit) == 0
	if inside then setSampleGain(vent1_sound, math.min(vent1_spd * 10, 1000)) else setSampleGain(vent1_sound, 0) end
	if inside then setSampleGain(vent2_sound, math.min(vent2_spd * 10, 1000)) else setSampleGain(vent2_sound, 0) end
	
	setSamplePitch(vent1_sound, vent1_spd)
	setSamplePitch(vent2_sound, vent2_spd)

end


