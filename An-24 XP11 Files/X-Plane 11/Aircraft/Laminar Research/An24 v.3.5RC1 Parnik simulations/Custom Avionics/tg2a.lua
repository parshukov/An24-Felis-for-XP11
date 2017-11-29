size = { 200, 200 }

-- initialize component property table
-- defineProperty("EGT", globalPropertyf("sim/cockpit2/engine/indicators/EGT_deg_C[0]"))

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) -- power
defineProperty("temp_check", globalPropertyi("sim/custom/xap/An24_start/left_temp_check")) -- select temp check mode
defineProperty("egt_fail", globalPropertyi("sim/operation/failures/rel_EGT_ind_0")) -- gauge failure
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- flight time

defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature
defineProperty("uprt", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1")) 
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) 
defineProperty("eng_work", globalPropertyi("sim/flightmodel2/engines/engine_is_burning_fuel[0]")) 
defineProperty("engine_on_fire", globalPropertyi("sim/operation/failures/rel_engfir0"))  -- engine on fire
defineProperty("eng_power", globalPropertyf("sim/flightmodel/engine/ENGN_power[0]")) 

-- needle image
defineProperty("NeedleImage", loadImage("needles.dds", 16, 111, 16, 98)) 

defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image


local last_angle = -120
local actual_angle = -120


-- tables for power to temperature conversion
local power_table = {{ -50000, 0},    -- bugs workaround
				    { 0.0, 0.00 },    -- zero power
            	    { 200,  150 },    -- IDLE
           		    { 1130, 250 },    -- 30% UPRT
        		    { 1800, 350 },	 -- cruise power
          		    { 2100, 370 },   -- nominal power
          		    { 2700, 350 },   -- takeoff power
          		    { 10000, 600 }}   -- linear above

-- interpolate values using table as reference
local function interpolate(tbl, value)
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

function update()

	local power = get(bus_DC_27_volt) > 21
	local switch = get(temp_check)
	local fail = get(egt_fail) == 6
	local n1 = get(N1)
	local coef_uprt = 1 + get(uprt) / (1 + n1 * 0.1)
	local eng_FIRE = 0
	if get(engine_on_fire) == 6 then eng_FIRE = 1 end
	
	local v = get(thermo) + (700 * coef_uprt - n1 * 7 + interpolate(power_table, get(eng_power) * 0.0013411)) * get(eng_work) + 500 * eng_FIRE
	
	if switch == 0 and not fail then v = v		
	elseif power and switch == 1 and not fail then v = math.max(v, 240)
	elseif power and switch == -1 and not fail then v = math.max(v, 360)
	end
	
	--print(v, get(thermo), coef_uprt, get(eng_power), interpolate(power_table, get(eng_power) * 0.0013411))
	
	local angle = (v - 200) * 215 / 800 - 120
	
	-- set limits
	if angle < -120 then angle = -120
	elseif angle > 110 then angle = 110 end
	
	local delta = angle - last_angle
	local passed = get(frame_time)
	
    actual_angle = actual_angle + 1 * delta * passed	
	last_angle = actual_angle
	
-- -120 = 200
-- 95 = 1000
end

-- EGT indicator consists of several components
components = {

   
    -- white needle
       needle {
        position = { 10, 10, 180, 180 },
        image = get(NeedleImage),
        angle = function()
			return actual_angle
        end
    },
	
	-- black cap
	texture{
	    position = { 70, 70, 60, 60 },
        image = get(black_cap),
	},

}

