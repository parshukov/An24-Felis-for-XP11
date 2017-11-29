size = {350, 350}

-- define property table
-- source
defineProperty("gyro_curse", globalPropertyf("sim/custom/xap/An24_gauges/GIK_curse"))  -- gyro curse from GIK
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec"))  -- local time since aircraft was loaded 

createGlobalPropertyf("sim/custom/xap/An24_misc/ushdb_3_scale_angle", 0) -- поворот шкалы на УШДБ
createGlobalPropertyf("sim/custom/xap/An24_misc/ushdb_3_scale_dir", 0) -- направление поворота шкалы на УШДБ

defineProperty("ushdb_3_scale_angle", globalPropertyf("sim/custom/xap/An24_misc/ushdb_3_scale_angle")) -- поворот шкалы на УШДБ
defineProperty("ushdb_3_scale_dir", globalPropertyf("sim/custom/xap/An24_misc/ushdb_3_scale_dir")) -- поворот шкалы на УШДБ 

-- images
defineProperty("scale", loadImage("navigator_panel_2d.dds", 691, 774, 196, 196))
defineProperty("curse_needle", loadImage("needles.dds", 152.5, 26, 267, 36))
defineProperty("foreground", loadImage("navigator_panel_2d.dds", 0, 682, 341, 341))

-- set(obs, 0)

-- local variables
local scale_angle = 0  -- magnetic tilt
local curse_angle = 0
local rotate_dir = 0



-- postframe calculaions
function update()
	-- time calculations
	local passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	-- rotate scale
	--[[scale_angle = scale_angle + rotate_dir * passed * 5 	
	if scale_angle > 70 then scale_angle = 70
	elseif scale_angle < -70 then scale_angle = -70 end
	--]]
	local v = get(gyro_curse)     
    local delta = v - curse_angle
    if delta > 180 then delta = delta - 360
    elseif delta < -180 then delta = delta + 360 end
    curse_angle = curse_angle + 5 * delta * passed
    if curse_angle > 180 then curse_angle = curse_angle - 360
    elseif curse_angle < -180 then curse_angle = curse_angle + 360 end
    
end

end


components = {


	-- inner scale
	texture {
		position = {50, 100, 200, 200},
		image = get(scale),
	},
	
	-- big scale
	needle {
		position = {10, 60, 280, 280},
		image = get(foreground),
		angle = function()
			return get(ushdb_3_scale_angle)
		end 
	},
	
	
	-- curse needle
	needle {
		position = {10, 60, 280, 280},
		image = get(curse_needle),
		angle = function()
			return curse_angle + 90
		end 
	},	

	-- scale rotary
	clickable {
        position = {120, 0, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			set(ushdb_3_scale_dir, -1)
			return true
		end,
		onMouseUp = function()
			set(ushdb_3_scale_dir, 0)
			return true		
		end
		
    },
	clickable {
        position = {150, 0, 30, 40},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			set(ushdb_3_scale_dir, 1)
			return true
		end,
		onMouseUp = function()
			set(ushdb_3_scale_dir, 0)
			return true		
		end
    },--]]

	-- position gauge
--[[	rectangle {
		position = {149, 149, 2, 2},
		color = {1, 0, 0, 1},
	}, 
--]]

}