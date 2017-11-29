size = {80, 80}

-- define property table
defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/dme_frequency_hz"))  -- set the frequency


-- images table
defineProperty("glass_cap", loadImage("scales_1.png", 142, 418, 78, 32))
defineProperty("digitsImage", loadImage("white-digits.png", 3, 0, 10, 196)) 


-- variables for separate manipulations
local freq_100  = 0
local freq_10 = 0

local rot_click = loadSample('Custom Sounds/rot_click.wav')

function update()
   local freq = get(frequency)
   
   -- calculate separate digits
   freq_100 = math.floor(freq / 100)  -- cut off last two digits
   freq_10 = freq - freq_100 * 100  -- cut off first digits


end


-- device consist of several components

components = {

    
    -----------------
    -- images --
    -----------------

    -- hundreds digits
    digitstape {
        position = { 5, 50, 30, 20},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = false,
        value = function()
           return freq_100 
        end
    }; 
    
    -- decimals digits
    digitstape {
        position = {45, 50, 30, 20},
        image = digitsImage,
        digits = 2,
        showLeadingZeros = true,
        value = function()
           return freq_10 
        end
    }; 
    
   -- glass cap image
    texture { 
        position = { 0, 43, 80, 36 },
        image = get(glass_cap)
    },
 

    ---------------------
    -- click zones --
    ---------------------
    
    -- click zones for left knob
    clickable {
       position = { 0, 0, 18, 35 },
        
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
            if freq_100 < 108 then freq_100 = 117 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },
    
    clickable {
       position = { 19, 0, 18, 35 },
        
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
            if freq_100 > 117 then freq_100 = 108 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },    

    
    -- click zones for right knob
    clickable {
       position = { 43, 0, 18, 35 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_10 = freq_10 - 5
            if freq_10 < 0 then freq_10 = 95 end
            
            local a, b = math.modf(freq_10 / 5)
   			if b ~= 0 then freq_10 = a * 5 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },
    
    clickable {
       position = { 62, 0, 18, 35 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function(x, y, button) 
            -- calculate new frequency
            freq_10 = freq_10 + 5
            if freq_10 > 95 then freq_10 = 0 end

            local a, b = math.modf(freq_10 / 5)
   			if b ~= 0 then freq_10 = a * 5 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            playSample(rot_click, 0)
            return true
        end
    },  

	
--[[	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,1},
	
	}, --]]
	
}
