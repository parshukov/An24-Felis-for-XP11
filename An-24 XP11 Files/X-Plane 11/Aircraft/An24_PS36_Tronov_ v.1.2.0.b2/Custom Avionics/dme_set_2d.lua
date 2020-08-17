size = {266, 115}

-- define property table
defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/dme_frequency_hz"))  -- set the frequency
defineProperty("power_sw", globalPropertyi("sim/custom/xap/An24_gauges/dme_on"))  -- power switcher

-- images table
defineProperty("glass_cap", loadImage("scales_1.png", 142, 418, 78, 32))
defineProperty("digitsImage", loadImage("white-digits.png", 3, 0, 10, 196)) 
defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))

-- variables for separate manipulations
local freq_100 = 0
local freq_10 = 0
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local switch_sound = loadSample('Custom Sounds/metal_switch.wav')

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
        position = { 90, 70, 35, 25},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = false,
        value = function()
           return freq_100 
        end
    }; 
    
    -- decimals digits
    digitstape {
        position = {145, 70, 30, 25},
        image = digitsImage,
        digits = 2,
        showLeadingZeros = true,
        value = function()
           return freq_10 
        end
    }; 
    
   -- glass cap image
    texture { 
        position = { 84, 58, 100, 50 },
        image = get(glass_cap)
    },
 
	-- fake tumbler
	texture {
		position = { 30, 57, 20, 60 },
		image = get(tmb_dn),
	},

    ---------------------
    -- click zones --
    ---------------------
	-- DME power switch
	switch {
        position = {212, 57, 20, 60 },
        state = function()
            return get(power_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(power_sw) ~= 0 then
                set(power_sw, 0)
            else
                set(power_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
 
    -- click zones for left knob
    clickable {
       position = { 10, 10, 30, 40 },
        
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
       position = { 40, 10, 30, 40 },
        
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
       position = { 195, 10, 30, 40},
        
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
       position = { 225, 10, 30, 40 },
        
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

--[[	
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,0.5},
	
	}, 
	--]]
}
