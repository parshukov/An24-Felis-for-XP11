-- this is first part of nav panel
size = {532, 671}

-- define property table
defineProperty("curs_mp1_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp1_sw")) 
defineProperty("curs_mp2_sw", globalPropertyi("sim/custom/xap/An24_gauges/curs_mp2_sw")) 

defineProperty("nav1_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nav1_subpanel"))

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

-- background image
defineProperty("background", loadImage("navigator_panel_2d.dds", 0, 0, 532, 671))
defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))
defineProperty("tmb_ctr", loadImage("tumbler_center.dds"))


components = {

    -- background image
    texture { 
        position = { 0, 0, size[1], size[2] },
        image = get(background)
    },


	nav_kursmp_set {
		position = {40, 263, 130, 130},
		},	
		
	nav_kursmp_set {
		position = {340, 263, 130, 130},
		frequency = globalPropertyf("sim/cockpit2/radios/actuators/nav2_frequency_hz"),
		},
	
	obs_kursmp_set_2d {
		position = {30, 30, 200, 200},
		},	
	
	obs_kursmp_set_2d {
		position = {285, 30, 200, 200},
		obs = globalPropertyf("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot"),
		fromto = globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto"),
		fromto_lit = globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto_lit"),
		},	
	
	curs_mp_2d {
		position = {177, 456, 170, 170},
		},	
	
	-- left CursMP switcher
    switch {
        position = { 215, 295, 20, 80},
        state = function()
            return get(curs_mp1_sw) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(curs_mp1_sw) ~= 0 then
                set(curs_mp1_sw, 0)
            else
                set(curs_mp1_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- right CursMP switcher
    switch {
        position = { 295, 295, 20, 80},
        state = function()
            return get(curs_mp2_sw) ~= 0
        end,
        btnOn = get(tmb_up),
		btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(curs_mp2_sw) ~= 0 then
                set(curs_mp2_sw, 0)
            else
                set(curs_mp2_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
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
        set(nav1_subpanel, 0 )
        return true
        end
    },	
	

}