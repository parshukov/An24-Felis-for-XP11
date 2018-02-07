size = {320, 150}

-- define property table
defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/com1_frequency_hz"))  -- set the frequency


-- images table
defineProperty("glass_cap", loadImage("scales_1.png", 142, 418, 78, 32))
defineProperty("digitsImage", loadImage("white-digits.png", 3, 0, 10, 196)) 


-- variables for separate manipulations
local freq_100 = 0  -- digits before period
local freq_10 = 0   -- digits after period

local freq_10_show = 0

local rot_click = loadSample('Custom Sounds/rot_click.wav')

function update()
   local freq = get(frequency)
   
   -- calculate separate digits
   freq_100 = math.floor(freq / 100)  -- cut off last two digits
   freq_10 = freq - freq_100 * 100  -- cut off first digits 
   
   local freq_last = freq_10 - math.floor(freq_10 / 10) * 10 
   
   if freq_last == 2 or freq_last == 7 
      then freq_last = 5
      else freq_last = 0
   end

   freq_10_show = freq_10 * 10 + freq_last
   


end


-- device consist of several components

components = {

    
    -----------------
    -- images --
    -----------------

    -- hundreds digits
    digitstape {
        position = { 111, 90, 44, 30},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = false,
        value = function()
           return freq_100 
        end
    }; 
    
    -- decimals digits
    digitstape {
        position = { 170, 90, 44, 30},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = true,
        value = function()
           return freq_10_show 
        end
    }; 
    
   -- glass cap image
    texture { 
        position = { 105, 79, 115, 53 },
        image = get(glass_cap)
    },
 
--[[
    -- left knob
    needle {
        position = { 17, 49, 43, 43 },
        image = get(small_knob),    
        angle = function()
           return (freq_100 - 118) * 40
        end,
    
    },
 
    -- right knob
    needle {
        position = { 139, 49, 43, 43 },
        image = get(small_knob),    
        angle = function()
           return freq_10 * 36 / 5
        end,
    
    },

--]]
    ---------------------
    -- click zones --
    ---------------------
    
    -- click zones for left knob
    clickable {
       position = { 10, 25, 40, 60 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_100 = freq_100 - 1
            if freq_100 < 118 then freq_100 = 136 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },
    
    clickable {
       position = { 50, 25, 40, 60},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_100 = freq_100 + 1
            if freq_100 > 136 then freq_100 = 118 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },    

    
    -- click zones for right knob
    clickable {
       position = { 225, 25, 40, 60 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_10 = math.floor((freq_10_show - 25) / 10)
            
            if freq_10 < 0 then freq_10 = 97 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },
    
    clickable {
       position = { 265, 25, 40, 60 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_10 = math.floor((freq_10_show + 25) / 10)

            if freq_10 > 97 then freq_10 = 0 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },  
	
--[[	
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,0.5},
	
	}, 
--]]
}

