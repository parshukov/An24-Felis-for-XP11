size = {1015, 630}

-- background image
defineProperty("background", loadImage("radio_panel_2d.dds", 0, 0, size[1], size[2]))
defineProperty("radio_subpanel", globalPropertyi("sim/custom/xap/An24_panels/radio_subpanel"))



components = {
	
	rectangle {
		position = { 0, 0, size[1], size[2] },
		color = {0,0,0,0.5},
	},
	
    -- background image
    texture { 
        position = { 0, 0, size[1], size[2] },
        image = get(background)
    },	
	
	-- com 1
	com_set_2d {
		position = {14, 515, 230, 115},
		},
	
	-- com 2
	com_set_2d {
		position = {275, 515, 230, 115},
		frequency = globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_hz")
		},	

	dme_set_2d {
		position = {525, 515, 266, 115},		
	},
		
	ark_meter {
		position = {813, 532, 95, 95},
		},	

	ark_meter {
		position = {916, 532, 95, 95},
		signal = globalPropertyf("sim/custom/xap/An24_ark/ark2_signal"),
		},

	ark11_2d {
		position = {0, 53, 505, 455},
		},

	ark11_2d {
		position = {510, 53, 505, 455},
		dev_num = 1,
		ark_need_freq = globalPropertyi("sim/custom/xap/An24_ark/ark2_need_freq"),
		radio = globalPropertyi("sim/cockpit2/radios/actuators/adf2_frequency_hz"),
		adf = globalPropertyf("sim/cockpit2/radios/indicators/adf2_relative_bearing_deg"),
		fail = globalPropertyi("sim/operation/failures/rel_adf2"),

		audio_selection = globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf2"),
		cw_sw = globalPropertyi("sim/custom/xap/An24_ark/ark2_cw"),		
		
		ark_band_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_band_need"),
		ark_tune_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune_need"),
		ark_fine_tune_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_fine_tune_need"),
		button = globalPropertyi("sim/custom/xap/An24_ark/ark2_button"),
		ark_mode = globalPropertyi("sim/custom/xap/An24_ark/ark2_mode"),
		ark_band = globalPropertyi("sim/custom/xap/An24_ark/ark2_band"),
		band_fix = globalPropertyi("sim/custom/xap/An24_ark/ark2_band_fix"),
		ark_tune = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune"),
		tune_fix = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune_fix"),
		ark_fine_tune = globalPropertyi("sim/custom/xap/An24_ark/ark2_fine_tune"),
		ant_sw = globalPropertyi("sim/custom/xap/An24_ark/ark2_ant_sw"),
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
        set(radio_subpanel, 0 )
        return true
        end
    },	
	
}