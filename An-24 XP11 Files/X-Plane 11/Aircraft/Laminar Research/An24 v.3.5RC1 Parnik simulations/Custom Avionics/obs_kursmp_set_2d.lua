size = {200, 200}

-- define property table
defineProperty("obs", globalPropertyf("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot"))  -- set the course
defineProperty("fromto", globalPropertyi("sim/custom/xap/An24_gauges/obs1_fromto"))  -- set the from or to course
defineProperty("fromto_lit", globalPropertyi("sim/custom/xap/An24_gauges/obs1_fromto_lit")) -- Nav-To-From indication, nav1, pilot, 0 is flag, 1 is to, 2 is from.
-- images table
defineProperty("digitsImage", loadImage("white-digits.png", 3, 0, 10, 196)) 
defineProperty("tmb_up", loadImage("tumbler_up.dds")) 
defineProperty("tmb_dn", loadImage("tumbler_down.dds")) 

defineProperty("toImage", loadImage("navigator_panel_2d.dds", 1000, 708, 17, 12)) 
defineProperty("fromImage", loadImage("navigator_panel_2d.dds", 994, 724, 30, 12)) 

local obs_num = get(obs)
local fromto_light = get(fromto_lit)

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

function update()
	obs_num = get(obs)
	fromto_light = get(fromto_lit)
end

-- device consist of several components

components = {

    
    -----------------
    -- images --
    -----------------

	-- black hole
	rectangle {
        position = { 50, 82, 40, 17},		
		color = {0,0,0,1},
	},
	
    -- digits
    digitstape {
        position = { 50, 80, 40, 20},
        image = digitsImage,
        digits = 3,
        showLeadingZeros = true,
		allowNonRound = true,
		--fractional = 2,
        value = function()
           return obs_num
        end
    }; 
 
	-- to lamp
	textureLit {
		position = { 117, 117, 17, 12},
		image = get(toImage),
		visible = function()
			return fromto_light == 1
		end
	
	},
  
 	-- from lamp
	textureLit {
		position = { 110, 69, 30, 12},
		image = get(fromImage),
		visible = function()
			return fromto_light == 2
		end
	
	}, 
 
    ---------------------
    -- click zones --
    ---------------------
    
	-- from/to switcher
    switch {
        position = { 115, 55, 20, 80},
        state = function()
            return get(fromto) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(fromto) ~= 0 then
                set(fromto, 0)
            else
                set(fromto, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

    -- rotary for curse set
    rotary {
        -- image = rotaryImage;
        value = obs;
        step = 1;
        position = { 100, 35, 55, 40 };
        adjuster = function(v)
            playSample(rot_click, 0)
			v = math.floor(v + 0.5)
			if v > 359 then v = v - 360
			elseif v < 0 then v = v + 360 end
			return v
        end;
    };	
	
	-- position gauge
--[[	rectangle {
		position = {99, 0, 2, 200},
		color = {1, 0, 0, 1},
	}, 
	rectangle {
		position = {0, 99, 200, 2},
		color = {1, 0, 0, 1},
	},	--]]
	
}
