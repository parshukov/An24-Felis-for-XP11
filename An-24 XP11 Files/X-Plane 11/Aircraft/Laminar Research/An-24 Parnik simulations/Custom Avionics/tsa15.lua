size = { 200, 200 }

-- initialize component property table
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]"))   
defineProperty("ru19_N1", globalPropertyf("sim/custom/xap/An24_start/ru19_N1")) 

--defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]"))

defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- barometric alt. maybe in feet, maybe in meters.
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  -- pressire at sea level in.Hg


defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- background image
-- defineProperty("background", loadImage("ite2.dds", 0, 0, 155, 155))

-- needle image
defineProperty("needle_long", loadImage("needles.dds", 67, 70, 16, 179)) 
--defineProperty("needle_N2", loadImage("needles.dds", 168, 78, 19, 163))


-- local variables
local left_angle = 50
--local right_angle = 50
local left_angle_last = 50
--local right_angle_last = 50
local left_angle_actual = 50
--local right_angle_actual = 50

local passed = 0

local tro_table = {{ 0.0, 0.0 },    -- OFF
                  {  37, 38 },    -- idle
          	      {  87, 100 }, -- takeoff
          	      {  1000, 1000 }}    -- bugs

-- tables for altitude correction
local alt_table_ru19 = {{ -50000, 1 },    -- bugs workaround
				  { 0.00, 1 },    -- on standard pressure zero level
            	  {  4000, 0.9756},    -- 4000 ft
           		  {  8000, 0.9434 },    -- 8000 ft
          		  {  13000, 0.89},   -- 13000 ft
          		  {  100000, 0.7 }}   -- linear above 13000 ft
				  
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

-- post frame calculations
function update()
	-- altitude calculations
	local alt = get(msl_alt) * 3.28083 -- MSL alt in feet
	local alt_baro = (29.92 - get(baro_press)) * 1000
	local alt_coef = interpolate(alt_table_ru19, alt + alt_baro) 
	
	-- recalculate N1
	local n1 = interpolate(tro_table, get(N1)) * alt_coef
	set(ru19_N1, n1)

	left_angle = n1 * 3.07 + 50
	
	passed = get(frame_time)
if  passed > 0 then
	-- set smooth move
	left_angle_actual = left_angle_last + (left_angle - left_angle_last) * passed * 4
	--right_angle_actual = right_angle_last + (right_angle - right_angle_last) * passed * 4
end
	-- last variables
	left_angle_last = left_angle_actual
	--right_angle_last = right_angle_actual
	
end


components = {
 
 -- right needle
 --[[   needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_N2),
        angle = function() 
            return right_angle_actual
        end
    }, --]]

    -- left needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_long),
        angle = function() 
            return left_angle_actual
        end
    },   

    
   -- positioning gauge
  --[[ rectangle {
   		position = {99, 99, 2, 2},
   		color = {1,0,0,1},
   }, --]]

}

