-- this is simple trimmer logic
size = {2048, 2048}

-- define property table
-- switchers
defineProperty("rudd_sw", globalPropertyi("sim/custom/xap/An24_trimm/rudd_sw")) -- rudder switch position
defineProperty("ail_sw", globalPropertyi("sim/custom/xap/An24_trimm/ail_sw")) -- rudder switch position

-- sources
defineProperty("ap_roll_power", globalPropertyi("sim/custom/xap/An24_ap/ap_roll_power"))  -- power for aileron mechanic
defineProperty("ap_pitch_power", globalPropertyi("sim/custom/xap/An24_ap/ap_pitch_power"))  -- power for elevator mechanic
defineProperty("ap_hdg_power", globalPropertyi("sim/custom/xap/An24_ap/ap_hdg_power"))  -- power for rudder mechanic
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

-- result
defineProperty("sim_rudd_trimm", globalPropertyf("sim/cockpit2/controls/rudder_trim"))  -- sim rudder trimmer
defineProperty("sim_ail_trimm", globalPropertyf("sim/cockpit2/controls/aileron_trim"))  -- sim aileron trimmer
defineProperty("sim_elev_trimm", globalPropertyf("sim/cockpit2/controls/elevator_trim"))  -- sim elevator trimmer

-- images
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20))
defineProperty("left_needle", loadImage("needles.dds", 340, 149, 27, 35))
defineProperty("right_needle", loadImage("needles.dds", 372, 149, 27, 35))

--set(sim_elev_trimm , -0.05) -- take off trim position

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

local power = false
local needle_pos = 0
local rudd_center_lit = false
local ail_center_lit = false

local rudd_trimm_off = false
local ail_trimm_off = false
local elev_trimm_off = false

function update()
	-- power calculations
	power = get(bus_DC_27_volt_emerg) > 21

	-- led calculations
	if power then
		rudd_center_lit = math.abs(get(sim_rudd_trimm)) < 0.01
		ail_center_lit = math.abs(get(sim_ail_trimm)) < 0.01
		rudd_trimm_off = get(ap_hdg_power) == 1
		ail_trimm_off = get(ap_roll_power) == 1
		elev_trimm_off = get(ap_pitch_power) == 1
	else
		rudd_center_lit = false
		ail_center_lit = false
		rudd_trimm_off = false
		ail_trimm_off = false
		elev_trimm_off = false
	end
	local elev_trim = get(sim_elev_trimm)
        needle_pos = (154 - elev_trim * 41)		--interpolate(pos_table, elev_trim)

    if needle_pos < 0 then needle_pos = 0
	elseif needle_pos > 235 then needle_pos = 235 end

	--needle_pos = 130 -- test
	
	-- 180 = 32% MAC
    -- 130 = 18% MAC
	
	
end

components = {

	--------------------
	-- lights --
	--------------------

	-- aileron trimm off
	textureLit {
		image = get(green_led),
		position = {640, 308, 20, 20},
		visible = function()
			return ail_trimm_off
		end,
	},

	-- rudder trimm off
	textureLit {
		image = get(green_led),
		position = {620, 308, 20, 20},
		visible = function()
			return rudd_trimm_off
		end,
	},

	-- aileron trimm center
	textureLit {
		image = get(green_led),
		position = {660, 308, 20, 20},
		visible = function()
			return ail_center_lit
		end,
	},

	-- rudder trimm center
	textureLit {
		image = get(green_led),
		position = {680, 308, 20, 20},
		visible = function()
			return rudd_center_lit
		end,
	},

	-- elevator trimm position
	free_texture {
        image = get(left_needle),
        position_x = 0,
        position_y = function()
             return 170 + needle_pos
             end,
        width = 27,
        height = 35,
    },

	-- elevator trimm position
	free_texture {
        image = get(right_needle),
        position_x = 190,
        position_y = function()
             return 170 + needle_pos
             end,
        width = 27,
        height = 35,
    },

	-------------------
	-- clickables --
	-------------------

	-- aileron trimm switcher
    -- switcher left
	clickable {
        position = { 1079, 373, 8, 17},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

       	onMouseClick = function()
			if power and not ail_trimm_off then
				local a = get(sim_ail_trimm)
				if power and not ail_trimm_off then
					if not switcher_pushed and a > -1 then 
					playSample(switch_sound, 0) 
					a = a - 0.01
					end
				switcher_pushed = true
				end
				if math.abs(a) < 0.005 then a = 0 end
				set(sim_ail_trimm, a)
			end
			set(ail_sw, -1)
			return true
		end,
		onMouseUp = function()
			set(ail_sw, 0)
			switcher_pushed = false
			playSample(switch_sound, 0) 
			return true
		end,
    },

	-- switcher right
	clickable {
        position = {1087, 373, 8, 17},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseClick = function()
			if power and not ail_trimm_off then
				local a = get(sim_ail_trimm)
				if power and not ail_trimm_off then
					if not switcher_pushed and a < 1 then 
					playSample(switch_sound, 0) 
					a = a + 0.01
					end
				switcher_pushed = true
				end
				if math.abs(a) < 0.005 then a = 0 end
				set(sim_ail_trimm, a)
			end
			set(ail_sw, 1)
			return true
		end,
		onMouseUp = function()
			set(ail_sw, 0)
			switcher_pushed = false
			playSample(switch_sound, 0) 
			return true
		end,
    },


	-- rudder trimm switcher
    -- switcher left
	clickable {
        position = {1097, 373, 8, 17},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("rotateleft.png")
        },

       	onMouseClick = function()
			if power and not rudd_trimm_off then
				local a = get(sim_rudd_trimm)
				if not switcher_pushed and a > -1 then 
				playSample(switch_sound, 0) 
				a = a - 0.01
			end
			switcher_pushed = true
				if math.abs(a) < 0.005 then a = 0 end
				set(sim_rudd_trimm, a)
			end
			set(rudd_sw, -1)
			return true
		end,
		onMouseUp = function()
			set(rudd_sw, 0)
			switcher_pushed = false
			playSample(switch_sound, 0)
			return true
		end,
    },

	-- switcher right
	clickable {
        position = {1106, 373, 8, 17},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("rotateright.png")
        },

        onMouseClick = function()
			if power and not rudd_trimm_off then
				local a = get(sim_rudd_trimm)
				if not switcher_pushed and a < 1 then 
				playSample(switch_sound, 0) 
				a = a + 0.01
			end
			switcher_pushed = true
				if math.abs(a) < 0.005 then a = 0 end
				set(sim_rudd_trimm, a)
			end
			set(rudd_sw, 1)
			return true
		end,
		onMouseUp = function()
			set(rudd_sw, 0)
			switcher_pushed = false
			playSample(switch_sound, 0)
			return true
		end,
    },

	-- elevator trimm switcher
    -- switcher up
	clickable {
        position = { 10, 324, 200, 100},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not elev_trimm_off then
				local a = get(sim_elev_trimm)
				if a > -1 then 
				a = a - 0.01
			end
			switcher_pushed = true
				set(sim_elev_trimm, a)
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- switcher down
	clickable {
        position = {10, 170, 200, 100},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

        onMouseClick = function()
			if not elev_trimm_off then
				local a = get(sim_elev_trimm)
				if a  < 1 then 
				a = a + 0.01
			end
			switcher_pushed = true
				set(sim_elev_trimm, a)
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,

    },







}


