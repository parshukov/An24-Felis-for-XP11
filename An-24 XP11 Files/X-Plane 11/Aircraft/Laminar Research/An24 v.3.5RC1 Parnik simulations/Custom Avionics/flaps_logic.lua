-- this is the simple logic of flaps movement

-- define property table

-- hydraulic system
defineProperty("hydro_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.
defineProperty("flaps_valve", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve")) -- position of flaps valve for gydraulic calculations and animations.
defineProperty("emerg_press", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press")) -- pressure in emergency system. initial 120 kg per square sm. maximum 160.
defineProperty("flaps_valve_emerg", globalPropertyi("sim/custom/xap/An24_hydro/flaps_valve_emerg")) -- position of emergency flaps valve for gydraulic calculations and animations.
defineProperty("flaps_rotary", globalPropertyi("sim/custom/xap/An24_hydro/flaps_rotary")) -- position of flaps valve for gydraulic calculations and animations.

-- flap control
defineProperty("flap", globalPropertyf("sim/cockpit2/controls/flap_ratio")) -- 0 = retracted, 1 = extended

-- flaps
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]")) -- inner flaps right
defineProperty("flap_out_L", globalPropertyf("sim/flightmodel2/wing/flap1_deg[2]")) -- outer flaps left
defineProperty("flap_out_R", globalPropertyf("sim/flightmodel2/wing/flap1_deg[3]")) -- outer flaps right

-- enviroment
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))
defineProperty("flap_cc", globalPropertyf("sim/custom/xap/An24_hydro/flap_cc"))

-- SmartCopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))  -- 0 - не определено/плагин не найден, 1 - слейв, 2 - мастер

-- comands
flaps_command_up = findCommand("sim/flight_controls/flaps_up")
flaps_command_down = findCommand("sim/flight_controls/flaps_down")

function flaps_up_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 1 == phase then
		set(flaps_valve, -1)
		set(flaps_rotary, -1)
	else
		set(flaps_valve, 0)
		set(flaps_rotary, 0)
    end
return 0
end

function flaps_down_handler(phase)
	if 1 == phase then
		set(flaps_valve, 1)
		set(flaps_rotary, 1)
	else
		set(flaps_valve, 0)
		set(flaps_rotary, 0)
    end
return 0
end

registerCommandHandler(flaps_command_up, 0, flaps_up_handler)
registerCommandHandler(flaps_command_down, 0, flaps_down_handler)

-- local variables
local passed = 0

local flap_pos = get(flap) -- calculated position of virtual flap lever to manipulate flaps

-- local constants
local FLAP_SPEED = 0.008 / 14

-- post frame calculations
function update()
	
	local active_logic = get(ismaster) ~= 1
	
	passed = get(frame_time)
	local power = 0
	if get(bus_DC_27_volt) > 21 then power = 1 end

-- all calculations produced only during sim work
if passed > 0 and active_logic then
	-- calculate position
	local direction = get(flaps_valve) * power

	if direction ~= 0 then set(flap_cc, 5) else set(flap_cc, 0) end

	if get(hydro_press) < 40 and direction == -1 then direction = 0 end  -- limit movement of flaps when using emergency feed

	flap_pos = flap_pos + direction * get(hydro_press) * passed * FLAP_SPEED * (1 - get(flaps_valve_emerg))
	flap_pos = flap_pos + get(emerg_press) * get(flaps_valve_emerg) * passed * FLAP_SPEED / 2  * power  -- need to learn if emergency flap deploy work independent from main valve

	-- set limits
	if flap_pos > 1 then flap_pos = 1
	elseif flap_pos < 0 then flap_pos = 0
	end

	-- flap_pos = 0
	-- set result
	set(flap, flap_pos)

	set(flap_inn_L, flap_pos * 38)
	set(flap_inn_R, flap_pos * 38)
	set(flap_out_L, flap_pos * 38)
	set(flap_out_R, flap_pos * 38)
	
	-- print(get(flaps_valve))
end

end


