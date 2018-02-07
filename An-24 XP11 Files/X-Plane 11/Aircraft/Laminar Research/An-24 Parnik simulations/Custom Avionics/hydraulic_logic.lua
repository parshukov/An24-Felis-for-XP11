-- this is simple logic for calculations of hydraulic system

-- define properties
defineProperty("main_press", globalPropertyf("sim/custom/xap/An24_hydro/main_press")) -- pressure in main system. initial 120 kg per square sm. maximum 160.
defineProperty("emerg_press", globalPropertyf("sim/custom/xap/An24_hydro/emerg_press")) -- pressure in emergency system. initial 120 kg per square sm. maximum 160.
defineProperty("hydro_quantity", globalPropertyf("sim/custom/xap/An24_hydro/hydro_quantity")) -- quantity of hydraulic liquid. initially 28 liters. in work downs to 21 liters. also can flow out in come case of failure.
defineProperty("hydro_store", globalPropertyf("sim/custom/xap/An24_hydro/hydro_store")) -- pressure in main hydro storage
defineProperty("brake_press", globalPropertyf("sim/custom/xap/An24_hydro/brake_press"))  -- pressure in braking system
defineProperty("hydro_circle", globalPropertyi("sim/custom/xap/An24_hydro/hydro_circle"))  -- connect main and emergency feeds
defineProperty("emerg_pump_sw", globalPropertyi("sim/custom/xap/An24_hydro/emerg_pump_sw"))  -- emergency hydro pump switcher. if its ON and power exist - emergency bus will gain pressure

-- engines work
defineProperty("eng1_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time


-- gears
defineProperty("gear1", globalPropertyf("sim/flightmodel2/gear/deploy_ratio[0]")) -- gear deploy ratio. 0 = up, 1 = down
defineProperty("gear2", globalPropertyf("sim/flightmodel2/gear/deploy_ratio[1]")) -- gear deploy ratio. 0 = up, 1 = down
defineProperty("gear3", globalPropertyf("sim/flightmodel2/gear/deploy_ratio[2]")) -- gear deploy ratio. 0 = up, 1 = down
defineProperty("emerg_brake", globalPropertyf("sim/custom/xap/An24_hydro/emerg_brake"))  -- pressure in braking system
defineProperty("steer", globalPropertyf("sim/flightmodel2/gear/tire_steer_actual_deg[0]")) -- front gear steer deg
defineProperty("frontgear_use_hydro", globalPropertyi("sim/custom/xap/An24_hydro/frontgear_use_hydro")) -- front gear steering manipulates by hydraulic system
defineProperty("gear_valve", globalPropertyi("sim/custom/xap/An24_hydro/gear_valve")) -- position of gear valve for gydraulic calculations and animations maximum 160.
--defineProperty("brake1", globalPropertyf("sim/flightmodel/controls/l_brake_add")) -- gear brake ratio. 0 = min, 1 = max
--defineProperty("brake2", globalPropertyf("sim/flightmodel/controls/r_brake_add")) -- gear brake ratio. 0 = min, 1 = max


-- wipers
defineProperty("wiper1", globalPropertyf("sim/flightmodel2/misc/wiper_angle_deg[0]")) -- wiper position in degrees
defineProperty("wiper2", globalPropertyf("sim/flightmodel2/misc/wiper_angle_deg[1]")) -- wiper position in degrees
defineProperty("wiper_sw", globalPropertyi("sim/cockpit2/switches/wiper_speed")) 

-- flaps
defineProperty("flap1", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]")) -- flap deg
defineProperty("flap2", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]")) -- flap deg
defineProperty("flap3", globalPropertyf("sim/flightmodel2/wing/flap2_deg[0]")) -- flap deg
defineProperty("flap4", globalPropertyf("sim/flightmodel2/wing/flap2_deg[1]")) -- flap deg

-- power calculations
defineProperty("pump_cc", globalPropertyf("sim/custom/xap/An24_hydro/pump_cc")) -- emergency pump consumption
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt"))

-- feed from pumps depends on total presure
local hydro_feed_main = { 
{  0, 2.22},    
{  120, 2.22 },    
{  150, 1 },    
{  160, 0 },
{  200, 0 }}  

local hydro_feed_emerg = { 
{  0, 0.432 },    
{  120, 0.432 },    
{  150, 0.2 },    
{  160, 0 },
{  240, 0 }}  

local pump_press_to_cc = { 
{  0, 2 },    
{  120, 2 },    
{  150, 1 },    
{  160, 0 },
{  240, 0 }}  

local function interpolate(tbl, value) -- interpolate values using tables
    local lastActual = 0 
    local lastReference = 0 
    for _k, v in pairs(tbl) do
		if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end

local main_hydro_press = get(main_press)
local emerg_hydro_press = get(emerg_press)

local gear1_last = get(gear1)
local gear2_last = get(gear2)
local gear3_last = get(gear3)
--local brake1_last = get(brake1)
--local brake2_last = get(brake2)
local wiper1_last = get(wiper1)
local wiper2_last = get(wiper2)
local flap1_last = get(flap1)
local flap2_last = get(flap2)
local flap3_last = get(flap3)
local flap4_last = get(flap4)
local steer_last = get(steer)
local use_emerg = 0  -- using of emergency bus when main failed
local brake_last = get(brake_press)

local pump_sound = loadSample('Custom Sounds/hydro_pump.wav')
local pump_gain = 0

playSample(pump_sound, 1)
setSampleGain(pump_sound, 0)
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

-- every frame calculations

function update() 
	local passed = get(frame_time)
	local power = 0
	local power115 = 0
	local crossfeed = get(hydro_circle)
	local external = get(external_view) -- 0 = inside, 1 = external
	
	
	-- calculate power
	if get(bus_DC_27_volt_emerg) > 21 then power = 1
	else power = 0 end
	if get(bus_AC_115_volt) > 110 then power115 = 1
	else power115 = 0 end

-- all calculations produced only during sim work
if passed > 0 then	
	
	-- check if engines work	
	local left_eng
	if get(eng1_N1) > 40 then left_eng = 1 else left_eng = 0 end
	local right_eng
	if get(eng2_N1) > 40 then right_eng = 1 else right_eng = 0 end
	
	local emerg_pump = get(emerg_pump_sw)
	-- calculate emergency feed
	emerg_hydro_press = get(emerg_press) + interpolate(hydro_feed_emerg, emerg_hydro_press)	* power * power115 * passed * emerg_pump * 3
	
	-- sound of emerg pump
	if power * power115 * emerg_pump == 1 and pump_gain < 1000 then pump_gain = pump_gain + passed * 500
	elseif power * power115 * emerg_pump == 0 and pump_gain > 0 then pump_gain = pump_gain - passed * 500 end
	if pump_gain > 1000 then pump_gain = 1000
	elseif pump_gain < 0 then pump_gain = 0 end
	
	setSampleGain(pump_sound, pump_gain * 0.5 * (1 - external))
	setSamplePitch(pump_sound, pump_gain)
	
	-- calculate power current consumption
	set(pump_cc, interpolate(pump_press_to_cc, emerg_hydro_press) * power * emerg_pump)
	
	-- calculate the sources
	main_hydro_press = get(hydro_store) + (interpolate(hydro_feed_main, main_hydro_press ) * left_eng + interpolate(hydro_feed_main, main_hydro_press) * right_eng + interpolate(hydro_feed_emerg, main_hydro_press) * crossfeed) * passed * 3
	
	-- set crossfeed between main and emerg feeds
	main_hydro_press = main_hydro_press + (emerg_hydro_press - main_hydro_press) * passed * crossfeed
	emerg_hydro_press = emerg_hydro_press + (main_hydro_press - emerg_hydro_press) * passed * crossfeed
	
	-- calculate uses of pressure
	-- landing gear
	local gear_feed = math.abs(get(gear_valve)) * main_hydro_press / 20 -- last number for speed correction
	
	-- gear brakes
	local brake = get(brake_press)
	if brake < main_hydro_press and brake < 150 then brake = brake + (main_hydro_press - brake) * passed end -- calculate pressure for braking system
	local brake_feed = math.max(0, brake - brake_last)  -- braking system feeds from main hydro
	local emerg_brake_feed = get(emerg_brake) * 0.2
	
	-- wipers
	local wipers_feed = (math.abs(get(wiper1) - wiper1_last) + math.abs(get(wiper2) - wiper2_last)) * 0.02 -- last number for speed correction
	-- off wipers when pressure is low
	if main_hydro_press < 30 then set(wiper_sw, 0) end
	
	
	-- front gear steer
	local nosegear_feed =  math.abs(get(steer) - steer_last) * get(frontgear_use_hydro) * 0.5
	
	-- flaps
	local flaps_feed = (math.abs(get(flap1) - flap1_last) + math.abs(get(flap2) - flap2_last) + math.abs(get(flap3) - flap3_last) + math.abs(get(flap4) - flap4_last)) * 70

	-- calculate users for buses
	main_hydro_press = main_hydro_press - (gear_feed + brake_feed * (1 - use_emerg) + wipers_feed + nosegear_feed + flaps_feed * (1 - use_emerg)) * passed  
	if main_hydro_press < 40 or get(emerg_brake) > 0 then use_emerg = 1 else use_emerg = 0 end  -- when main bus failed - use emergency	
	emerg_hydro_press = emerg_hydro_press - (emerg_brake_feed + flaps_feed) * passed * use_emerg
	
	-- set minimal limits, maximum are set by interpolate tables; 
	if main_hydro_press < 10 then main_hydro_press = 10 end
	if emerg_hydro_press < 10 then emerg_hydro_press = 10 end

	-- calculate hydro-quantity
	local quantity = 28 - (get(hydro_store) + get(emerg_press)) / 50


	-- set results
	set(main_press, main_hydro_press)
	set(emerg_press, emerg_hydro_press)
	set(hydro_store, main_hydro_press)  -- later need to expand this logic
	set(hydro_quantity, quantity)
	set(brake_press, brake)

--print("work")
end
	-- set last variables
	gear1_last = get(gear1)
	gear2_last = get(gear2)
	gear3_last = get(gear3)
	--brake1_last = get(brake1)
	--brake2_last = get(brake1)
	wiper1_last = get(wiper1)
	wiper2_last = get(wiper2)
	flap1_last = get(flap1)
	flap2_last = get(flap2)
	flap3_last = get(flap3)
	flap4_last = get(flap4)
	steer_last = get(steer)
	brake_last = get(brake_press)


end

