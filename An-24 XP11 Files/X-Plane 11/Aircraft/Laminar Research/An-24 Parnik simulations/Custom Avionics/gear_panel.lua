-- this is panel gor gear indication
size = {169, 82}

-- define property table
-- source
defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  --deploy of front gear
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  -- deploy of right gear
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  -- deploy of left gear

defineProperty("gear_force", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))

defineProperty("flap_deg1", globalPropertyf("sim/flightmodel2/wing/flap1_deg[0]"))  -- left flap deg
defineProperty("flap_deg2", globalPropertyf("sim/flightmodel2/wing/flap1_deg[1]"))  -- right flap deg

defineProperty("N1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))
defineProperty("N2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))
defineProperty("flap_siren", globalPropertyf("sim/custom/xap/An24_gauges/flaps_siren"))
defineProperty("gear_siren", globalPropertyf("sim/custom/xap/An24_gauges/gear_siren"))

defineProperty("gear_down", globalPropertyi("sim/custom/xap/An24_gauges/gear_down")) -- all gears down

-- power
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

-- images
defineProperty("green_led", loadImage("gear_lamps.dds", 53, 2, 5, 10))
defineProperty("red_vert_led", loadImage("gear_lamps.dds", 42, 10, 5, 10))
defineProperty("red_hor_led", loadImage("gear_lamps.dds", 40, 2, 9, 5))

defineProperty("gear_led", loadImage("gear_lamps.dds", 0, 0, 36, 21))
defineProperty("flaps_led", loadImage("gear_lamps.dds", 0, 22, 36, 21))


local btn_click = loadSample('Custom Sounds/plastic_btn.wav')


local switcher_pushed = false

local front_green_vis = false
local left_green_vis = false
local right_green_vis = false

local front_red_vis = false
local left_red_vis = false
local right_red_vis = false

local gear_vis = false
local flap_vis = false

local test_button = false

function update()

	local throttle = (get(N1) + get(N2)) / 2
	-- power calc
	if get(bus_DC_27_volt_emerg) > 21 then
		-- front gear
		local front_gear = get(gear1_deploy)
		front_green_vis = front_gear > 0.99 or test_button
		front_red_vis = front_gear < 0.01 or test_button

		-- left gear
		local left_gear = get(gear2_deploy)
		left_green_vis = left_gear > 0.99 or test_button
		left_red_vis = left_gear < 0.01 or test_button

		-- right gear
		local right_gear = get(gear3_deploy)
		right_green_vis = right_gear > 0.99 or test_button
		right_red_vis = right_gear < 0.01 or test_button

		-- gear warn
		gear_vis = (throttle < 0.24 and not front_green_vis) or test_button

		local flaps = (get(flap_deg1) + get(flap_deg2)) / 2
		-- flap warn
		force = get(gear_force)
		flap_vis = (throttle > 0.76 and (flaps < 13 or flaps > 17) and front_green_vis) and force ~= 0 or test_button

		if throttle < 0.24 and not front_green_vis then set(gear_siren, 1) else set(gear_siren, 0) end
		if throttle > 0.76 and (flaps < 13 or flaps > 17) and front_green_vis and force ~= 0 then set(flap_siren, 1) else set(flap_siren, 0) end
		
		if front_gear > 0.99 and left_gear > 0.99 and right_gear > 0.99 then set(gear_down, 1) else set(gear_down, 0) end

	else
		front_green_vis = false
		left_green_vis = false
		right_green_vis = false

		front_red_vis = false
		left_red_vis = false
		right_red_vis = false

		gear_vis = false
		flap_vis = false
		set(gear_siren, 0)
		set(flap_siren, 0)
		set(gear_down, 0)
	end

end

components = {
	-- position gauge
--[[	rectangle {
		position = {1, 1, 167, 80},
		color = {1, 0, 0, 1},

	}, --]]

	-- front gear leds
	textureLit {
		position = {81, 47, 5, 10},
		image = get(green_led),
		visible = function()
			return front_green_vis
		end
	},

	textureLit {
		position = {81, 63, 5, 10},
		image = get(red_vert_led),
		visible = function()
			return front_red_vis
		end
	},

	-- left gear leds
	textureLit {
		position = {66, 42, 5, 10},
		image = get(green_led),
		visible = function()
			return left_green_vis
		end
	},

	textureLit {
		position = {65, 59, 9, 5},
		image = get(red_hor_led),
		visible = function()
			return left_red_vis
		end
	},

	-- right gear leds
	textureLit {
		position = {95, 42, 5, 10},
		image = get(green_led),
		visible = function()
			return right_green_vis
		end
	},

	textureLit {
		position = {93, 59, 9, 5},
		image = get(red_hor_led),
		visible = function()
			return right_red_vis
		end
	},

	-- gear warning
	textureLit {
		position = {17, 42, 36, 21},
		image = get(gear_led),
		visible = function()
			return gear_vis
		end
	},

	-- gear warning
	textureLit {
		position = {117, 42, 36, 21},
		image = get(flaps_led),
		visible = function()
			return flap_vis
		end
	},

	-- test button
    clickable {
        position = {70, 0, 30, 40},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			test_button = true
			if not switcher_pushed then 
				switcher_pushed = true
				playSample(btn_click, 0) 
			end
			return true
		end,
		onMouseUp = function()
			test_button = false
			switcher_pushed = false
			playSample(btn_click, 0) 
			return true
		end,
    },



}

