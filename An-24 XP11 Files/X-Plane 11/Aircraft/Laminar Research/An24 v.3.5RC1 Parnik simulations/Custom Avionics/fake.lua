-- this is the fake gauges
size = {2048, 2048}

defineProperty("needles_1", loadImage("needles.dds", 0, 0, 16, 88)) 

-- this gauge also works as fake oil temperature gauge
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("eng_work_1", globalPropertyi("sim/flightmodel2/engines/engine_is_burning_fuel[0]"))
defineProperty("eng_work_2", globalPropertyi("sim/flightmodel2/engines/engine_is_burning_fuel[1]"))
defineProperty("flap1", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[0]")) -- current position
defineProperty("flap2", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[1]"))	-- current position
defineProperty("prop_pitch_1", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[0]")) -- propeller pitch
defineProperty("prop_pitch_2", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[1]"))
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))
defineProperty("oil_p_1", globalPropertyf("sim/cockpit2/engine/indicators/oil_pressure_psi[0]"))
defineProperty("oil_p_2", globalPropertyf("sim/cockpit2/engine/indicators/oil_pressure_psi[1]"))


-- results
createProp("sim/custom/xap/An24_engines/oil_temp_left", "float", 0);  -- oil temperature
createProp("sim/custom/xap/An24_engines/oil_temp_right", "float", 0);  -- oil temperature

defineProperty("oil_temp_left", globalPropertyf("sim/custom/xap/An24_engines/oil_temp_left"))
defineProperty("oil_temp_right", globalPropertyf("sim/custom/xap/An24_engines/oil_temp_right"))

local oil_t_angle_1 = -90
local oil_t_angle_2 = -90

local Toil_1 = get(thermo)
local Toil_2 = get(thermo)
local C_eng = 0.11
local Const1 = 0.1
local Const2 = 0.5

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 

function update()
	-- check power
	local power27 = 0
	if get(bus_DC_27_volt) > 21 then power27 = 1 else power27 = 0 end
	
	local passed = get(frame_time) * 0.2
	local Ò_air = get(thermo)
	local IAS = get(ias)
	-- calculate oil temperatures
	-- Ò_oil = Ò_oil + (C_eng * P_eng - (Ò_oil - Ò_air) * (Ñonst + CowlFlap_ratio * (RPM * PropAngle + IAS) * oil_press * C_oil)) * frame_time
	
	Toil_1 = Toil_1 + C_eng * get(N1) * get(eng_work_1) * passed - (Toil_1 - Ò_air) * passed * (Const1 + get(flap1) * (get(N1) * (math.min(5, get(prop_pitch_1) * 0.1 + 4)) * 0.0004 + IAS * 0.0005)) * (Const2 + math.min(4, get(oil_p_1) * 0.07031) * 0.125) -- left engine
	
	set(oil_temp_left, Toil_1)
	

	Toil_2 = Toil_2 + C_eng * get(N2) * get(eng_work_2) * passed - (Toil_2 - Ò_air) * passed * (Const1 + get(flap2) * (get(N2) * (math.min(5, get(prop_pitch_2) * 0.1 + 4)) * 0.0004 + IAS * 0.0005)) * (Const2 + math.min(4, get(oil_p_2) * 0.07031) * 0.125) -- right engine
	
	set(oil_temp_right, Toil_2)	
	
	
	-- left oil temp angle
	if power27 > 0 then
		oil_t_angle_1 = Toil_1 * 120 / 200 - 120
		-- set limits 
		if oil_t_angle_1 > -30 then oil_t_angle_1 = -30
		elseif oil_t_angle_1 < -150 then oil_t_angle_1 = -150
		end
	else
		oil_t_angle_1 = -155
	end

	-- right oil temp amgle
	if power27 > 0 then
		oil_t_angle_2 = Toil_2 * 120 / 200 - 120
		-- set limits 
		if oil_t_angle_2 > -30 then oil_t_angle_2 = -30
		elseif oil_t_angle_2 < -150 then oil_t_angle_2 = -150
		end
	else
		oil_t_angle_2 = -155
	end
	
	
end


components = {

   
    -- left oil temperature needle
    needle {
        position = { 1705, 1655, 106, 106 },
        image = get(needles_1),
        angle = function()
			return oil_t_angle_1
        end   
    }, 
 
    -- right oil temperature needle
    needle {
        position = { 1905, 1655, 106, 106 },
        image = get(needles_1),
        angle = function()
			return oil_t_angle_2
        end   
    }, 
 
    -- left engine air temp
    needle {
        position = { 393, 1095, 106, 106 },
        image = get(needles_1),
        angle = 75   
    }, 

    -- right engine air temp
    needle {
        position = { 503, 1095, 106, 106 },
        image = get(needles_1),
        angle = -75 
    }, 


    -- air pressure
    needle {
        position = { 600, 947, 100, 100 },
        image = get(needles_1),
        angle = -60 
    },


    -- start of pressurisation
    needle {
        position = { 887, 851, 110, 110 },
        image = get(needles_1),
        angle = -30 
    },

    -- pressure difference
    needle {
        position = { 804, 934, 110, 110 },
        image = get(needles_1),
        angle = 30 
    },
	
	
}