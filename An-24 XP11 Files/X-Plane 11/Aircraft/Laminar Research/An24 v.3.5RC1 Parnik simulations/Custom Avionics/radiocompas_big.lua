size = {400, 400}

-- define property table
defineProperty("adf1", globalPropertyf("sim/custom/xap/An24_ark/ark1_angle")) -- bearing to NDB
defineProperty("adf2", globalPropertyf("sim/custom/xap/An24_ark/ark2_angle"))

defineProperty("vor1", globalPropertyf("sim/custom/xap/An24_gauges/vor_1")) -- bearing to VOR
defineProperty("vor2", globalPropertyf("sim/custom/xap/An24_gauges/vor_2")) -- bearing to VOR

defineProperty("ark_vor", globalPropertyf("sim/custom/xap/An24_gauges/ark_vor")) -- switcher ARK/VOR

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

createGlobalPropertyf("sim/custom/xap/An24_misc/ushdb_1_scale_angle", 0) -- поворот шкалы на УШДБ
createGlobalPropertyf("sim/custom/xap/An24_misc/ushdb_1_scale_dir", 0) -- направление поворота шкалы на УШДБ

defineProperty("ushdb_1_scale_angle", globalPropertyf("sim/custom/xap/An24_misc/ushdb_1_scale_angle")) -- поворот шкалы на УШДБ
defineProperty("ushdb_1_scale_dir", globalPropertyf("sim/custom/xap/An24_misc/ushdb_1_scale_dir")) -- поворот шкалы на УШДБ
-- SmartCopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))  -- 0 - не определено/плагин не найден, 1 - слейв, 2 - мастер


-- images
defineProperty("needle1", loadImage("needles.dds", 464, 15, 23, 237))
defineProperty("needle2", loadImage("needles.dds", 489, 15, 23, 237))
defineProperty("scale", loadImage("navigator_panel_2d.dds", 359, 718, 305, 305))

defineProperty("adf1_test", globalPropertyf("sim/cockpit2/radios/indicators/adf1_relative_bearing_deg"))

defineProperty("knob_img", loadImage("needles.dds", 344, 89, 51, 51)) 

local angle1 = 0
local angle2 = 0
local last_angle1 = 0
local last_angle2 = 0
--local scale_angle = 0
local rotate_dir = 0

set(ushdb_1_scale_angle, 0)
set(ushdb_1_scale_dir, 0)

function update()
	-- time calculations
	local passed = get(frame_time)
	local active_logic = get(ismaster) ~= 1
-- time bug workaround
if passed > 0 then
	
	-- rotate scale
	if active_logic then
		set(ushdb_1_scale_angle, get(ushdb_1_scale_angle) + get(ushdb_1_scale_dir) * passed * 10)
	end
	
	local switch = get(ark_vor)
	
	-- needle 1 smooth
	local v1 = 0
	if switch == 0 then v1 = get(adf1) else v1 = get(vor1) end
   	local delta1 = v1 - last_angle1
    if delta1 > 180 then delta1 = delta1 - 360
    elseif delta1 < -180 then delta1 = delta1 + 360 end
    angle1 = angle1 + 2 * delta1 * passed
    if angle1 > 180 then angle1 = angle1 - 360
    elseif angle1 < -180 then angle1 = angle1 + 360 end
	
	-- needle 2 smooth
	local v2 = 0
	if switch == 0 then v2 = get(adf2) else v2 = get(vor2) end
    
	local delta2 = v2 - last_angle2
    if delta2 > 180 then delta2 = delta2 - 360
    elseif delta2 < -180 then delta2 = delta2 + 360 end
    angle2 = angle2 + 2 * delta2 * passed
    if angle2 > 180 then angle2 = angle2 - 360
    elseif angle2 < -180 then angle2 = angle2 + 360 end	

end
	last_angle1 = angle1
	last_angle2 = angle2
end



components = {
	-- scale
	needle {
		position = {49, 49, 302, 302},
		image = get(scale),
		angle = function()
			return get(ushdb_1_scale_angle)
		end
	},

	-- needle 1
	needle {
		position = {61, 62, 276, 276},
		image = get(needle1),
		angle = function()
			return angle1 
		end
	},
	
	-- needle 2
	needle {
		position = {61, 62, 276, 276},
		image = get(needle2),
		angle = function()
			return angle2 
		end
	},

	-- rotary knob
	needle {
		position = {348, 348, 50, 50},
		image = get(knob_img),
		angle = function()
			return  -get(ushdb_1_scale_angle) * 5
		end
	},	
	
	-- scale rotary
	clickable {
        position = {349, 350, 25, 50},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
       	onMouseClick = function() 
			set(ushdb_1_scale_dir, 1)
			return true
		end,
		onMouseUp = function()
			set(ushdb_1_scale_dir, 0)
			return true		
		end
		
    },
	clickable {
        position = {374, 350, 25, 50},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
       	onMouseClick = function() 
			set(ushdb_1_scale_dir, -1)
			return true
		end,
		onMouseUp = function()
			set(ushdb_1_scale_dir, 0)
			return true		
		end
    },	


--[[	rectangle {
		position = {199, 199, 2, 2},
		color = {0.5,0,0,1},
	}, 
--]]

}


