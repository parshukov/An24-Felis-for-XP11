-- this is the simple logic of engine's vibration
size = {2048, 2048}

-- define property table
defineProperty("eng1_fail", globalPropertyf("sim/operation/failures/rel_engfai0")) -- engine fail
defineProperty("eng2_fail", globalPropertyf("sim/operation/failures/rel_engfai1"))


defineProperty("high_vibro", globalPropertyi("sim/custom/xap/An24_gauges/high_vibro"))  -- high vibration

-- sources
defineProperty("eng1_fire", globalPropertyf("sim/operation/failures/rel_engfir0")) -- engine fire
defineProperty("eng2_fire", globalPropertyf("sim/operation/failures/rel_engfir1"))

defineProperty("eng1_oil_p", globalPropertyf("sim/flightmodel/engine/ENGN_oil_press_psi[0]"))  -- oil pressure
defineProperty("eng2_oil_p", globalPropertyf("sim/flightmodel/engine/ENGN_oil_press_psi[1]"))

defineProperty("chip_detect1", globalPropertyf("sim/cockpit/warnings/annunciators/chip_detected[0]")) -- chip in engine1
defineProperty("chip_detect2", globalPropertyf("sim/cockpit/warnings/annunciators/chip_detected[1]")) -- chip in engine1

defineProperty("eng_rpm1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]")) -- engine rpm in % of N1   
defineProperty("eng_rpm2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

defineProperty("virt_rud1", globalPropertyf("sim/custom/xap/An24_misc/virt_rud1"))
defineProperty("virt_rud2", globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"))

-- power
defineProperty("iv41_sw", globalPropertyi("sim/custom/xap/An24_gauges/iv41_sw"))
defineProperty("iv41_test", globalPropertyi("sim/custom/xap/An24_gauges/iv41_test"))
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"))

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time

-- images
defineProperty("needleImg", loadImage("needles.dds", 226, 0, 118, 4))
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))

local time_counter = 0
local not_loaded = true

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

local fire_counter1 = 0
local fire_counter2 = 0

local chip_counter1 = 0
local chip_counter2 = 0

local oil_counter1 = 0
local oil_counter2 = 0

local vibro_angle1 = -30
local vibro_angle2 = -30

local vibro_lit1 = false
local vibro_lit2 = false

local last_angle1 = -30
local actual_angle1 = -30

local last_angle2 = -30
local actual_angle2 = -30

function update()
	-- time calculations
	passed = get(frame_time)
-- time bug workaround
if passed > 0 then
	-- initial switchers values
	time_counter = time_counter + passed
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(iv41_sw, 0)
		not_loaded = false
	end
	
	local vibro1 = 0
	local vibro2 = 0
	
	local rud1 = get(virt_rud1)
	local rud2 = get(virt_rud2)
	
	local rpm1 = get(eng_rpm1)
	local rpm2 = get(eng_rpm2)
	
	local fail1 = 0
	local fail2 = 0
	if get(eng1_fail) == 6 then fail1 = 1 end
	if get(eng2_fail) == 6 then fail2 = 1 end
	
	-- vibration sensors work fine when engines RPM are 98 - 101%
	-- when RPM more than 101% - vibration increases
	-- left engine
	if rpm1 >= 0 and rpm1 < 20 then vibro1 = rpm1 / 6.66
	elseif rpm1 >= 20 and rpm1 < 98 then vibro1 = 3 - (rpm1 - 20) / 39
	elseif rpm1 >= 98 and rpm1 <= 101 then vibro1 = 1
	else vibro1 = 1 + (rpm1 - 101) / 4 end

	-- right engine
	if rpm2 >= 0 and rpm2 < 20 then vibro2 = rpm2 / 6.66
	elseif rpm2 >= 20 and rpm2 < 98 then vibro2 = 3 - (rpm2 - 20) / 39
	elseif rpm2 >= 98 and rpm2 <= 101 then vibro2 = 1
	else vibro2 = 1 + (rpm2 - 101) / 4 end
	
	-- vibration for failed engines
	vibro1 = vibro1 + fail1 * rpm1 / 30
	vibro2 = vibro2 + fail2 * rpm2 / 30
	
	-- vibration may slowly increase on engine fire
	if get(eng1_fire) == 6 and fire_counter1 <= 7 then fire_counter1 = fire_counter1 + passed * 0.2 * rpm1 * rud1 / 100 end
	if get(eng2_fire) == 6 and fire_counter2 <= 7 then fire_counter2 = fire_counter2 + passed * 0.2 * rpm2 * rud2 / 100 end
	
	-- vibration may increase if engine destroying
	if get(chip_detect1) == 1 and chip_counter1 <= 7 then chip_counter1 = chip_counter1 + chip_counter1 * 0.1 * passed * rpm1 * rud1 / 100 end
	if get(chip_detect2) == 1 and chip_counter1 <= 7 then chip_counter1 = chip_counter1 + chip_counter2 * 0.1 * passed * rpm1 * rud2 / 100 end
	
	-- vibration may increase if oil pressure is low and then engine may heat and destroy
	if get(eng1_oil_p) * 0.07031 < 3 and oil_counter1 <= 7 then oil_counter1 = oil_counter1 + passed * 0.05 * rpm1 * rud1 / 100 end
	if get(eng2_oil_p) * 0.07031 < 3 and oil_counter2 <= 7 then oil_counter2 = oil_counter2 + passed * 0.05 * rpm2 * rud2 / 100 end
	
	-- result vibration and engine faulre
	vibro1 = vibro1 + (fire_counter1 + chip_counter1 + oil_counter1) * rpm1 / 100
	if vibro1 > 7 then vibro1 = 7 end
	if vibro1 > 6 then 
		logDebug("ENGINE 1 FAILURE BY VIBRATION")
		set(eng1_fail, 6)
	end
	
	
	vibro2 = vibro2 + (fire_counter2 + chip_counter2 + oil_counter2) * rpm1 / 100
	if vibro2 > 7 then vibro2 = 7 end	
	if vibro2 > 6 then
		logDebug("ENGINE 2 FAILURE BY VIBRATION")
		set(eng2_fail, 6)
	end
	
	-- calculate angles
	
	local power = get(iv41_sw) == 1 and get(bus_DC_27_volt) > 21
	
	if power then
		
		if vibro1 > 4 or vibro2 > 4 then set(high_vibro, 1) else set(high_vibro, 0) end
		
		if get(iv41_test) == 1 then
			vibro1 = 6
			vibro2 = 6
		end
		
		vibro_angle1 = vibro1 * 90 / 7 - 45
		vibro_angle2 = vibro2 * 90 / 7 - 45
		
		vibro_lit1 = vibro1 > 4
		vibro_lit2 = vibro2 > 4
		
	else
		vibro_lit1 = false
		vibro_lit2 = false
		vibro_angle1 = -45
		vibro_angle2 = -45
		set(high_vibro, 0)
	end

	actual_angle1 = last_angle1 + (vibro_angle1 - last_angle1) * passed * 3
	last_angle1 = actual_angle1
	
	actual_angle2 = last_angle2 + (vibro_angle2 - last_angle2) * passed * 3
	last_angle2 = actual_angle2
	

	
end

end


components = {
	
	-- left engine vibration
	needle {
		position = {995, 913, 110, 110},
		image = get(needleImg),
		angle = function()
			return actual_angle1 + 90
		end
	},

	-- right engine vibration
	needle {
		position = {1094, 913, 110, 110},
		image = get(needleImg),
		angle = function()
			return actual_angle2 + 90
		end
	},

	-- left engine high vibro
	textureLit {
		image = get(red_led),
		position = {601, 408, 20, 20},
		visible = function()
			return vibro_lit1
		end,
	},

	-- right engine high vibro
	textureLit {
		image = get(red_led),
		position = {620, 408, 20, 20},
		visible = function()
			return vibro_lit2
		end,
	},

    -- power switch
	switch {
        position = { 1175, 318, 15, 15},
        state = function()
            return get(iv41_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(iv41_sw) ~= 0 then
                set(iv41_sw, 0)
            else
                set(iv41_sw, 1)
            end
            return true;
			end
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- iv41_test
    clickable {
        position = {713, 500, 17, 17},  -- search and set right
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       	onMouseClick = function() 
			set(iv41_test, 1)
			if not switcher_pushed then
			playSample(btn_click, 0)
			switcher_pushed = true
			end
			return true
		end,
		onMouseUp  = function() 
			set(iv41_test, 0)
			playSample(btn_click, 0)
			switcher_pushed = false
			return true
		end,
    },	
	
}

