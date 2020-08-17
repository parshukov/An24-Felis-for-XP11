size = {170, 170}

-- define property table
defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  -- set the frequency


-- images table
defineProperty("digitsImage", loadImage("white-digits.png", 3, 0, 10, 196)) 

-- variables for separate manipulations
local freq_100 = 0
local freq_10 = 0
local freq_num = get(frequency) / 100

function update()

   local freq = get(frequency)
   freq_num = freq / 100
   
   -- calculate separate digits
   freq_100 = math.floor(freq / 100)  -- cut off last two digits
   freq_10 = freq - freq_100 * 100  -- cut off first digits
	
end

local rot_click = loadSample('Custom Sounds/rot_click.wav')


-- device consist of several components

components = {

    
    -----------------
    -- images --
    -----------------

	-- black hole
	rectangle {
        position = { 103, 76, 47, 18},		
		color = {0,0,0,1},
	},
	
    -- digits
    digitstape {
        position = { 94, 74, 55, 20},
        image = digitsImage,
        digits = 6,
        showLeadingZeros = false,
		fractional = 2,
        value = function()
           return freq_num
        end
    }; 
    
    -- decimals digits
  --[[  digitstape {
        position = {109, 90, 20, 20},
        image = digitsImage,
        digits = 2,
        showLeadingZeros = true,
        value = function()
           return freq_10 
        end
    }; --]]
    

    ---------------------
    -- click zones --
    ---------------------
    
    -- click zones for left knob
    clickable {
       position = { 65, 35, 40, 50 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function(x, y, button) 
            playSample(rot_click, 0) 
			-- calculate new frequency
            freq_100 = freq_100 - 1
            if freq_100 < 108 then freq_100 = 117 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            
            return true
        end
    },
    
	clickable {
       position = { 65, 85, 40, 50},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function(x, y, button) 
            playSample(rot_click, 0) 
			-- calculate new frequency
            freq_100 = freq_100 + 1
            if freq_100 > 117 then freq_100 = 108 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            
            return true
        end
    },    

    
    -- click zones for right knob
    clickable {
       position = { 20, 60, 40, 50 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function(x, y, button) 
            playSample(rot_click, 0) 
			-- calculate new frequency
            freq_10 = freq_10 - 5
            if freq_10 < 0 then freq_10 = 95 end
            
            local a, b = math.modf(freq_10 / 5)
   			if b ~= 0 then freq_10 = a * 5 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            
            return true
        end
    },
    
    clickable {
       position = { 110, 60, 40, 50 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function(x, y, button) 
            playSample(rot_click, 0) 
			-- calculate new frequency
            freq_10 = freq_10 + 5
            if freq_10 > 95 then freq_10 = 0 end

            local a, b = math.modf(freq_10 / 5)
   			if b ~= 0 then freq_10 = a * 5 end
            
            local fr = freq_100 * 100 + freq_10
            set(frequency, fr)
            
            return true
        end
    },  

	-- position gauge
--[[	rectangle {
		position = {84, 0, 2, 170},
		color = {1, 0, 0, 1},
	}, 
	rectangle {
		position = {0, 84, 170, 2},
		color = {1, 0, 0, 1},
	},	
	--]]
}
