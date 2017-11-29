size = { 200, 200 }

-- initialize component property table
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))


defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- background image
-- defineProperty("background", loadImage("ite2.dds", 0, 0, 155, 155))

-- needle image
defineProperty("needle_N1", loadImage("needles.dds", 145, 78, 19, 163)) 
defineProperty("needle_N2", loadImage("needles.dds", 168, 78, 19, 163))


-- local variables
local left_angle = 50
local right_angle = 50
local left_angle_last = 50
local right_angle_last = 50
local left_angle_actual = 50
local right_angle_actual = 50

-- table of throttles
local n1_table = {{ -100, -100 },    -- bugs workaround
                  {  0, 0 },
                  {  4, 0 },
		  {  5, 5 },
                  {  10, 10 },
                  {  11, 11 },
                  {  12, 12 },
				  {  13, 13 },
				  {  14, 14},
				  {  15, 15 },
				  {  16, 16 },
				  {  18, 18 },
                  {  20, 20 },
           	      {  110, 110 },    -- nominal
          	      {  10000, 110 }}    -- bugs workaround
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

local passed = 0

-- post frame calculations
function update()
	
	left_angle = interpolate(n1_table, get(N1)) * 3.07 + 50
	right_angle = interpolate(n1_table, get(N2)) * 3.07 + 50
	
	passed = get(frame_time)
if  passed > 0 then
	-- set smooth move
	left_angle_actual = left_angle_last + (left_angle - left_angle_last) * passed * 4
	right_angle_actual = right_angle_last + (right_angle - right_angle_last) * passed * 4
end
	-- last variables

	left_angle_last = left_angle_actual
	right_angle_last = right_angle_actual
	
end


components = {
 
 -- right needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_N2),
        angle = function() 
            return right_angle_actual
        end
    }, 

    -- left needle
    needle {
        position = { 10, 10, 180, 180 },
        image = get(needle_N1),
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

