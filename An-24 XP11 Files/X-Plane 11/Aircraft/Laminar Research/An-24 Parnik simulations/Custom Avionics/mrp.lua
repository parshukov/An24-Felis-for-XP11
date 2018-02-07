size = {2048, 2048}

-- define property table
-- datarefs
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   -- runway markers
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))

defineProperty("alt", globalPropertyf("sim/flightmodel/position/y_agl"))
defineProperty("mrp_mode", globalPropertyi("sim/custom/xap/An24_gauges/mrp_mode")) -- 0 - landing, 1 = navigation
--defineProperty("marker_audio", globalPropertyi("sim/cockpit/radios/gear_audio_working"))

-- power
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))
defineProperty("mrp_cc", globalPropertyf("sim/custom/xap/An24_gauges/mrp_cc"))

-- fail
defineProperty("fail", globalPropertyi("sim/operation/failures/rel_marker"))

-- images
defineProperty("white_led", loadImage("leds.dds", 0, 0, 20, 20))
defineProperty("blue_led", loadImage("leds.dds", 80, 0, 20, 20))
defineProperty("yellow_led", loadImage("leds.dds", 60, 0, 20, 20))



local out_lit = false
local mid_lit = false
local in_lit = false

function update()
	local mode = get(mrp_mode)
	--print(mode)
	if get(bus_DC_27_volt_emerg) > 21 and ((get(alt) < 5000 and mode == 0) or mode == 1) then
		set(mrp_cc, 2)
		set(fail, 0)
		out_lit = get(outer_marker) > 0
		mid_lit = get(middle_marker) > 0
		in_lit = get(inner_marker) > 0
	else
		set(mrp_cc, 0)
		set(fail, 6)
		out_lit = false
		mid_lit = false
		in_lit = false
	end

end


components = {

	-- outer marker light
	textureLit {
		image = get(blue_led),
		position = {641, 408, 19, 19},
		visible = function()
			return out_lit
		end,
	},

	-- middle marker light
	textureLit {
		image = get(yellow_led),
		position = {720, 349, 19, 19},
		visible = function()
			return mid_lit
		end,
	},

	-- inner marker light
	textureLit {
		image = get(white_led),
		position = {660, 408, 19, 19},
		visible = function()
			return in_lit
		end,
	},



}



