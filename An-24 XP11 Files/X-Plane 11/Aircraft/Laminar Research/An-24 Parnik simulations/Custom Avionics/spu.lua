-- this is simple SPU logic
size = {140, 180}

-- define property table
defineProperty("audio_selection_com1", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_com1"))
defineProperty("audio_selection_com2", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_com2"))
defineProperty("audio_selection_nav1", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_nav1"))
defineProperty("audio_selection_nav2", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_nav2"))
--defineProperty("audio_selection_adf1", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf1"))
--defineProperty("audio_selection_adf2", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf2"))
defineProperty("audio_dme_enabled", globalPropertyi("sim/cockpit2/radios/actuators/audio_dme_enabled"))

defineProperty("spu_power_sw", globalPropertyi("sim/custom/xap/An24_gauges/spu_power_sw"))
defineProperty("spu_mode", globalPropertyi("sim/custom/xap/An24_gauges/spu_mode"))
defineProperty("bus27", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))

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


function update()
	-- initial switchers values
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(spu_power_sw, 0)
		not_loaded = false
	end

	local mode = get(spu_mode)
	local power = get(spu_power_sw) == 1 and get(bus27) > 21
	
	if mode == 4 and power then
		set(audio_selection_nav1, 1)
		set(audio_selection_nav2, 0)		
	elseif mode == 5 and power then
		set(audio_selection_nav1, 0)
		set(audio_selection_nav2, 1)
	else
		set(audio_selection_nav1, 0)
		set(audio_selection_nav2, 0)
	end


end



components = {
	
	-- mode rotay
	rotary {
        position = { 40, 50, 60, 60},
        value = spu_mode;
        adjuster = function(v)
			if v >= 0 and v <= 5 then playSample(plastic_sound, 0) end
		   if 0 > v then
                v = 0;
            elseif 5 < v then
                v = 5
            end
			return v
        end;
    },

    -- power switch
    switch {
        position = { 5, 20, 30, 40},
        state = function()
            return get(spu_power_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(spu_power_sw) ~= 0 then
                set(spu_power_sw, 0)
            else
                set(spu_power_sw, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	


}
