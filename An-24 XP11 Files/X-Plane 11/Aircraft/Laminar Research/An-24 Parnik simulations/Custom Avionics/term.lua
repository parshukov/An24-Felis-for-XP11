size = { 200, 200 }

-- initialize component property table
defineProperty("EGT", globalPropertyf("sim/cockpit2/engine/indicators/EGT_deg_C[2]"))


-- needle image
defineProperty("NeedleImage", loadImage("needles.dds", 67, 70, 16, 179)) 

defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image

local angle = 0

function update()
    local v = get(EGT)
	angle = (v - 200) * 195 / 800 - 110
	
	-- set limits
	if angle < -110 then angle = -117
	elseif angle > 103 then angle = 103 end
	

-- -110 = 200
-- 85 = 1000
end

-- EGT indicator consists of several components
components = {

   
    -- white needle
       needle {
        position = { 10, 10, 180, 180 },
        image = get(NeedleImage),
        angle = function()
			return angle
        end
    },
	
	-- black cap
	texture{
	    position = { 72, 72, 56, 56 },
        image = get(black_cap),
	},
	

}

