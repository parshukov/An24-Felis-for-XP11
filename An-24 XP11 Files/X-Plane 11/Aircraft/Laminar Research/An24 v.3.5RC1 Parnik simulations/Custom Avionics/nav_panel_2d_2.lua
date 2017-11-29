-- this is first part of nav panel
size = {493, 687}

-- define property table
defineProperty("curs_mp1_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp1_sw")) 
defineProperty("curs_mp2_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp2_sw")) 

defineProperty("ark_vor", globalPropertyi("sim/custom/xap/An24_gauges/ark_vor")) -- switcher ARK/VOR
defineProperty("vent_1_sw", globalPropertyi("sim/custom/xap/An24_misc/vent_1_sw"))

defineProperty("nav2_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nav2_subpanel"))

-- background image
defineProperty("background", loadImage("navigator_panel_2d.dds", 532, 0, 493, 687))
defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

components = {

    -- background image
    texture { 
        position = { 0, 0, size[1], size[2] },
        image = get(background)
    },	
	
	ush_2d {
		position = {55, 10, 295, 295},
		},	
	
	radiocompas_big_2d {
		position = {60, 393, 253, 253},
		},	
	
	dme {
		position = {357, 63, 80, 80},
		},

	-- cockpit vents switch
    switch {
        position = { 332, 523, 20, 80},
        state = function()
            return get(vent_1_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(vent_1_sw) ~= 0 then
                set(vent_1_sw, 0)
            else
                set(vent_1_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
		
	-- ARK/VOR switcher
    switch {
        position = { 382, 523, 20, 80},
        state = function()
            return get(ark_vor) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ark_vor) ~= 0 then
                set(ark_vor, 0)
            else
                set(ark_vor, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },	

	texture {
        position = { 435, 523, 20, 80},
		image = get(tmb_dn),
	},
	
	
	
   -- clickable area for closing main menu
    clickable {
       position = { size[1]-20, size[2]-20, 20, 20 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
        set(nav2_subpanel, 0 )
        return true
        end
    },	
	

}