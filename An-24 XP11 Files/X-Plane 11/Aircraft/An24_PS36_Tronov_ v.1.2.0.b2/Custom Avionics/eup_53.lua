size = {200, 200}

-- define property table
defineProperty("turn", globalPropertyf("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_copilot"))

-- needle image
defineProperty("NeedleImage", loadImage("needles.dds", 105, 104, 16, 110))

-- power
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) --- power bus
defineProperty("eup53_sw", globalPropertyi("sim/custom/xap/An24_gauges/eup53_sw")) -- gauge switcher
defineProperty("eup53_cc", globalPropertyf("sim/custom/xap/An24_gauges/eup53_cc")) -- current consumption

-- failures
defineProperty("fail", globalPropertyi("sim/operation/failures/rel_cop_tsi")) -- gauge switcher

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

-- local variables
local turn_ind_angle = 0
 
-- post frame calculations

function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(eup53_sw, 0)
		not_loaded = false
	end
	
	
	-- check power and current
	local power = 0
	if get(bus_DC_27_volt_emerg) > 21 and get(eup53_sw) > 0 then
		power = 1
		set(eup53_cc, 2)
	else
		power = 0
		set(eup53_cc, 0)
	end
	--print("work here")	
	if power > 0 then
		turn_ind_angle = get(turn) * 0.6
	else turn_ind_angle = 0 end

	-- set limits
	if turn_ind_angle > 35 then turn_ind_angle = 35
	elseif turn_ind_angle < -35 then turn_ind_angle = -35 end
	

	return true
end

components = {

	
	-- needle
	needle {
		position = {-20, -87, 240, 240},
		image = get(NeedleImage),
		angle = function()
			return turn_ind_angle
		end,
	},

	-- power switch
    switch {
        position = { 0, 0, 25, 27},
        state = function()
            return get(eup53_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(eup53_sw) ~= 0 then
                set(eup53_sw, 0)
            else
                set(eup53_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 
	

--[[	-- test rectangle
	rectangle {
		position = {99, 74, 2, 2},
		color = {1,0,0,1},
	
	}, --]]















}