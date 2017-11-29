size = { 200, 200 }

-- long needle image
defineProperty("longNeedleImage", loadImage("needles.dds", 86, 73, 18, 173))

-- short needle image
defineProperty("shortNeedleImage", loadImage("needles.dds", 0, 0, 16, 88))

-- ias variable
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot"))

-- tas variable
-- defineProperty("tas", globalPropertyf("sim/flightmodel/position/true_airspeed"))  -- true auspeed in meters per sec

-- barometric altitude
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt. maybe in feet, maybe in meters.
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  -- pressire at sea level in.Hg


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

-- tables for needed cabin alt
local alt_table = {{ -50000, 0.5},    -- bugs workaround
				  { 0, 1 },    -- on standard pressure zero level
          		  {  2000, 1.0296 },
				  {  4000, 1.0569 },
				  {  6000, 1.0888 },
				  {  8000, 1.1229 },
				  {  10000, 1.1606 },
				  {  12000, 1.1873 },
				  {  14000, 1.2267 },
				  {  16404, 1.2881 },   -- 5 km
          		  {  19685, 1.3478 },   -- 6 km
          		  {  22000, 1.4009 },
				  {  24000, 1.4428 },
				  {  26000, 1.4925 },
				  {  28000, 1.5474 },
				  {  30000, 1.6096 },
          		  {  1000000, 3 }}   -- linear above


-- 50 km/h at 10 degrees
-- 350 km/h at 340 degrees

-- post frame calculations
local ias_amgle
local tas_angle

function update()
	-- calculate IAS
	local v_ias = get(ias) * 1.852
    if 750 < v_ias then v = 750 end
    if 30 > v_ias then ias_amgle = 0
    else ias_amgle = (v_ias - 100) * 285 / 600 + 33
    end

	-- calculate TAS
	local real_alt = get(msl_alt) * 3.28083 + (29.92 - get(baro_press)) * 1000  -- calculate barometric altitude in feet
	local baro_coef = interpolate(alt_table, real_alt)  -- get coeficient
	local v_tas = v_ias * baro_coef
    if 1100 < v_tas then v_tas = 1100 end
    if 380 > v_tas then v_tas = 380 end
	tas_angle = (v_tas - 400) * 340 / 700 - 170

end

-- altimeter consists of several components
components = {
	-- positioning gauge
	--[[rectangle {
		position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	},--]]
	
    -- tas needle
    needle {
        position = { 40, 40, 120, 120 },
        image = get(shortNeedleImage),
        angle = function()
            return tas_angle
        end
    },
	
	rectangle {
		position = {95, 35, 10, 70},
		color = {0.05, 0.05, 0.05, 1},	
	},
	
    -- ias needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(longNeedleImage),
        angle = function()
			return ias_amgle
        end
    },

}



