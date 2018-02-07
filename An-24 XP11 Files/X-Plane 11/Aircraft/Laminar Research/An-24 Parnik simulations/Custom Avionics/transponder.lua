size = {58, 51}


-- define peoperty table
defineProperty("xpdr_code", globalPropertyf("sim/cockpit/radios/transponder_code"))
defineProperty("xpdr_mode", globalPropertyf("sim/cockpit/radios/transponder_mode")) 
defineProperty("xpdr_led", globalPropertyf("sim/cockpit/radios/transponder_light"))
ident = findCommand("sim/transponder/transponder_ident")  -- comand of transponder ident
defineProperty("xpdr_fail", globalPropertyi("sim/operation/failures/rel_g_xpndr"))


-- digits
defineProperty("digit_1", globalPropertyi("sim/custom/xap/An24_sq/digit_1"))
defineProperty("digit_2", globalPropertyi("sim/custom/xap/An24_sq/digit_2"))
defineProperty("digit_3", globalPropertyi("sim/custom/xap/An24_sq/digit_3"))
defineProperty("digit_4", globalPropertyi("sim/custom/xap/An24_sq/digit_4"))

-- switchers
defineProperty("emerg", globalPropertyi("sim/custom/xap/An24_sq/emerg"))
defineProperty("sq_emerg_cap", globalPropertyi("sim/custom/xap/An24_sq/sq_emerg_cap"))
defineProperty("sq_mode", globalPropertyi("sim/custom/xap/An24_sq/sq_mode"))

-- power
defineProperty("sq_sw", globalPropertyi("sim/custom/xap/An24_sq/sq_sw"))
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("sq_cc", globalPropertyf("sim/custom/xap/An24_sq/sq_cc"))


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(sq_sw, 0)
		not_loaded = false
	end
end


local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

local emergency = false
local power = false       -- transponder's power
local last_code = get(xpdr_code)

function getDigits(squawk)
    local d1 = math.floor(squawk / 1000)
    squawk = squawk - d1 * 1000
    local d2 = math.floor(squawk / 100)
    squawk = squawk - d2 * 100
    local d3 = math.floor(squawk / 10)
    local d4 = squawk - d3 * 10
    return d1, d2, d3, d4
end

-- set transponder code
function setSquawk(d1, d2, d3, d4)
	last_code = d1 * 1000 + d2 * 100 + d3 * 10 + d4
	if not emergency then
		set(xpdr_code, last_code)
	else set(xpdr_code, 7700) end
end

-- first digit of squawk code
defineProperty("code_1", 
        function()
			local d1, d2, d3, d4 = getDigits(last_code)
			return d1
        end)

-- second digit of squawk code
defineProperty("code_2", 
        function(self, value)
			local d1, d2, d3, d4 = getDigits(last_code)
            return d2
        end)

-- third digit of squawk code
defineProperty("code_3", 
        function(self, value)
			local d1, d2, d3, d4 = getDigits(last_code)
            return d3
        end)

-- last digit of squawk code
defineProperty("code_4", 
        function(self, value)
			local d1, d2, d3, d4 = getDigits(last_code)
            return d4
        end)

-- set knobs initial positions
set(digit_1, get(code_1))
set(digit_2, get(code_2))
set(digit_3, get(code_3))
set(digit_4, get(code_4))

function update()
	power = get(sq_sw) > 0 and get(xpdr_fail) < 6 and get(bus_DC_27_volt_emerg) > 21
	if power then 
		set(xpdr_mode, get(sq_mode)) 
		set(sq_cc, 3)
	else 
		set(xpdr_mode, 0) 
		set(sq_cc, 0)
	end
   
end  


-- transponder cosist of several components

components = {

    -- power switch
    switch {
        position = { 27, 40, 8, 8},
        state = function()
            return get(sq_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(sq_sw) ~= 0 then
                set(sq_sw, 0)
            else
                set(sq_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

   -- mode knob rotary
   rotary {
       position = {29, 15, 10, 10},
       value = sq_mode,
       step = 1,
       adjuster = function(v)
          if v >= 0 and v <= 3 then playSample(plastic_sound, 0) end
		  if v > 3 then v = 3 end
          if v < 0 then v = 0 end
          return v
       end,
   },   

    -- digit rotaries
    -- digit 1
    rotary {
        position = { 4, 2, 10, 10 },
        value = code_1;
        adjuster = function(v)
            if v >= 0 and v <= 7 then playSample(plastic_sound, 0) end
			if 0 > v then
                v = 0;
            elseif 7 < v then
                v = 7
            end
            local d1, d2, d3, d4 = getDigits(last_code)
			setSquawk(v, d2, d3, d4)
			set(digit_1, get(code_1))
        end;
    },
    
    -- digit 2
   rotary {
        position = { 17, 2, 10, 10 },
        value = code_2;
        adjuster = function(v)
            if v >= 0 and v <= 7 then playSample(plastic_sound, 0) end
			if 0 > v then
                v = 0;
            elseif 7 < v then
                v = 7
            end
            local d1, d2, d3, d4 = getDigits(last_code)
            setSquawk(d1, v, d3, d4)
			set(digit_2, get(code_2))
        end;
    },

    -- digit 3
    rotary {
        position = { 31, 2, 10, 10  },
        value = code_3;
        adjuster = function(v)
            if v >= 0 and v <= 7 then playSample(plastic_sound, 0) end
			if 0 > v then
                v = 0;
            elseif 7 < v then
                v = 7
            end
            local d1, d2, d3, d4 = getDigits(last_code)
            setSquawk(d1, d2, v, d4)
			set(digit_3, get(code_3))
        end;
    },

    -- digit 4
    rotary {
        position = { 45, 2, 10, 10  },
        value = code_4;
        adjuster = function(v)
           if v >= 0 and v <= 7 then playSample(plastic_sound, 0) end
		   if 0 > v then
                v = 0;
            elseif 7 < v then
                v = 7
            end
            local d1, d2, d3, d4 = getDigits(last_code)
            setSquawk(d1, d2, d3, v)
			set(digit_4, get(code_4))
        end;
    },


	-- ident button
    clickable {
       position = { 10, 30, 8, 8 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
			if power then commandOnce(ident) end
            return true
		end,
		onMouseUp  = function() 
			switcher_pushed = false
			playSample(btn_click, 0) 
			return true
		end,
    },  

	-- emergency button
 clickable {
       position = { 2, 38, 8, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if get(sq_emerg_cap) > 0 then
				if not switcher_pushed then 
				playSample(btn_click, 0) 
			end
			switcher_pushed = true
				emergency = not emergency
				if emergency then set(emerg, 1)
				else set(emerg, 0) end
				local d1, d2, d3, d4 = getDigits(last_code)
				setSquawk(d1, d2, d3, d4)
			end
        return true
		end,
		onMouseUp  = function() 
			switcher_pushed = false
			playSample(btn_click, 0) 
			return true
		end,
    }, 

	--[[rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,1},
	},--]]

}

