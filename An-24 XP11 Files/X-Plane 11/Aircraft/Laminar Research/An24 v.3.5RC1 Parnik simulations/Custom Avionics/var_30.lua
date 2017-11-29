size = { 200, 200 }

-- initialize component property table
defineProperty("vvi", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot"))

-- background image
-- defineProperty("background", loadImage("var-10.dds", 0, 0, size[1], size[2]))

-- needle image
defineProperty("needleImage", loadImage("needles.dds", 86, 73, 18, 173))

local variometer_table = { 
{  -100, -180 },
{  -30, -180 },
{  -20, -140 }, 
{  -10, -80 },
{  10, 80 },
{  20, 140 },
{  30, 180 },
{ 100, 180 }} 

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

-- post frame calculations
local vvi_angle
function update()
    vvi_angle = interpolate(variometer_table, get(vvi) * 0.00508) - 90
end


components = {
	-- positioning gauge
	--[[rectangle {
		position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	},--]]

    -- vvi needle
   needle {
        position = { 10, 10, 180, 180 },
        image = get(needleImage),
        angle = function() 
			return vvi_angle
        end
    },
}

