

size = {240, 200}

defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

defineProperty("dev_num", 0)
defineProperty("radio", globalPropertyi("sim/cockpit2/radios/actuators/adf1_frequency_hz"))
defineProperty("adf", globalPropertyf("sim/cockpit2/radios/indicators/adf1_relative_bearing_deg"))
defineProperty("fail", globalPropertyi("sim/operation/failures/rel_adf1"))
defineProperty("audio_selection", globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf1"))

defineProperty("ark_need_freq", globalPropertyi("sim/custom/xap/An24_ark/ark1_need_freq"))

defineProperty("ark_band_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_band_need"))
defineProperty("ark_tune_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune_need"))
defineProperty("ark_fine_tune_need", globalPropertyi("sim/custom/xap/An24_ark/ark1_fine_tune_need"))


defineProperty("button", globalPropertyi("sim/custom/xap/An24_ark/ark1_button"))
defineProperty("ark_mode", globalPropertyi("sim/custom/xap/An24_ark/ark1_mode"))
defineProperty("ark_band", globalPropertyi("sim/custom/xap/An24_ark/ark1_band"))
defineProperty("band_fix", globalPropertyi("sim/custom/xap/An24_ark/ark1_band_fix"))
defineProperty("ark_tune", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune"))
defineProperty("tune_fix", globalPropertyi("sim/custom/xap/An24_ark/ark1_tune_fix"))
defineProperty("ark_fine_tune", globalPropertyi("sim/custom/xap/An24_ark/ark1_fine_tune"))
defineProperty("ant_sw", globalPropertyi("sim/custom/xap/An24_ark/ark1_ant_sw"))
defineProperty("cw_sw", globalPropertyi("sim/custom/xap/An24_ark/ark1_cw"))


-- power
defineProperty("bus27", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg"))
defineProperty("bus115", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt"))
defineProperty("ark_cc", globalPropertyf("sim/custom/xap/An24_ark/ark1_cc"))

-- time
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec")) -- sim time


-- result
defineProperty("res_angle", globalPropertyf("sim/custom/xap/An24_ark/ark1_angle"))
defineProperty("res_signal", globalPropertyf("sim/custom/xap/An24_ark/ark1_signal"))


-- images
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("scale", loadImage("ark_scale.png", 0, 66, 1024, 190))
defineProperty("scale_plank", loadImage("ark_scale.png", 0, 0, 1, 65))


-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))


local freq_table = {}  -- table of frequencies on every button
		-- fill the table
		freq_table["one"] = 120
		freq_table["two"] = 222
		freq_table["three"] = 333
		freq_table["four"] = 444
		freq_table["five"] = 555
		freq_table["six"] = 666
		freq_table["seven"] = 777
		freq_table["eight"] = 888
		freq_table["nine"] = 999


local button_pressed = 0  -- actual pressed button
local actual_freq = get(radio)  -- actual freq on device
local needed_freq = actual_freq  -- new freq for animation




-- reading file or fill the table with default values
function file_read()
	local filename
	if get(dev_num) == 0 then filename = panelDir .. "/an24_ark1.ini" else filename = panelDir .. "/an24_ark2.ini" end -- define file by device number
	local file = io.open(filename, "r")
	-- if file exist - read it and fill the freq_table with new values
	if file then
		local lines = file:read("*a")
		for k, v in string.gmatch(lines, "(%w+)=(%d+)") do
			freq_table[k] = tonumber(v)
		end
		print("reading from file frequency table for ARK#", get(dev_num) + 1)
		print("one","=",freq_table["one"])
		print("two","=",freq_table["two"])
		print("three","=",freq_table["three"])
		print("four","=",freq_table["four"])
		print("five","=",freq_table["five"])
		print("six","=",freq_table["six"])
		print("seven","=",freq_table["seven"])
		print("eight","=",freq_table["eight"])
		print("nine","=",freq_table["nine"])
		file:close()
	else print ("no .ini file for ARK#",get(dev_num) + 1,"- using default values")
	end
	return true
end



-- saving file
function file_save()
	local filename
	local success = false -- check operation
	if get(dev_num) == 0 then filename = panelDir .. "/an24_ark1.ini" else filename = panelDir .. "/an24_ark2.ini" end -- define file by device number
	local savefile = io.open(filename, "w")
	savefile:write("one","=",freq_table["one"]," \n")
	savefile:write("two","=",freq_table["two"]," \n")
	savefile:write("three","=",freq_table["three"]," \n")
	savefile:write("four","=",freq_table["four"]," \n")
	savefile:write("five","=",freq_table["five"]," \n")
	savefile:write("six","=",freq_table["six"]," \n")
	savefile:write("seven","=",freq_table["seven"]," \n")
	savefile:write("eight","=",freq_table["eight"]," \n")
	savefile:write("nine","=",freq_table["nine"]," \n")
	
	--for k, v in pairs(freq_table) do savefile:write(k,"=",v," \n") end
	if savefile then success = true end
	savefile:close()
	
	return success
end



-- get digits from given freq
function get_digits(freq)
	local v = freq
	local check = v > 0
	local check 
	if v > 1340 then 
		v = 1340
	elseif v < 120 then 
		v = 120
	end
	-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
	local d1 = 120
	if v >= 1180 then d1 = 1180
	elseif v >= 1020 then d1 = 1020
	elseif v >= 880 then d1 = 880
	elseif v >= 720 then d1 = 720
	elseif v >= 580 then d1 = 580
	elseif v >= 420 then d1 = 420
	elseif v >= 280 then d1 = 280
	end

	local d2 = v - d1
	
	return d1, d2
end


-- update table of freq with given freq by button number
function update_table(v)
	local but = get(button)
	if but == 1 then freq_table["one"] = v
	elseif but == 2 then freq_table["two"] = v
	elseif but == 3 then freq_table["three"] = v
	elseif but == 4 then freq_table["four"] = v
	elseif but == 5 then freq_table["five"] = v
	elseif but == 6 then freq_table["six"] = v
	elseif but == 7 then freq_table["seven"] = v
	elseif but == 8 then freq_table["eight"] = v
	elseif but == 9 then freq_table["nine"] = v
	end
	--print(but, v)
	local saved = file_save()
	if not saved then print("saving file from ARK #", get(dev_num), " incomplete") 
	else print("saving file from ARK #", get(dev_num), "successful")
	end
	return true
end


-- read table and return freq by button
function read_table()
	local v = actual_freq
	local but = get(button)
	if but == 1 then v = freq_table["one"]
	elseif but == 2 then v = freq_table["two"]
	elseif but == 3 then v = freq_table["three"]
	elseif but == 4 then v = freq_table["four"]
	elseif but == 5 then v = freq_table["five"]
	elseif but == 6 then v = freq_table["six"]
	elseif but == 7 then v = freq_table["seven"]
	elseif but == 8 then v = freq_table["eight"] 
	elseif but == 9 then v = freq_table["nine"]
	end
	return v
end

local notLoaded = true
local passed = 0
local time_last = get(flight_time)

local band, tune = get_digits(actual_freq)  -- actual position of knobs
set(ark_band_need, band)
set(ark_tune_need, tune)
local fine_tune = 0
local power = false
local last_band_update = time_last
local last_tune_update = time_last
local angle = 0 -- result angle of compas
local last_button = get(button)
local last_band_fix = get(band_fix)
local last_tune_fix = get(tune_fix)

local eng_check = true

-- width of visible window area
local winWidth = 72 / 1024

-- height of one degrees in texture coord
local step = 160 / 950
set(ark_need_freq, get(radio))

local time_counter = 0
local band_counter = get(ark_band_need)
local tune_pos = (0.036 - winWidth / 2) + step * (get(ark_tune_need)) / 29.09

local power_counter = -1
local ark_start_sound = loadSample('Custom Sounds/ark11_start.wav')
local ark_rotate_sound = loadSample('Custom Sounds/ark11_rotate.wav')



-- every frame calculations
function update()
	-- fill the table with startup frequencies
	if notLoaded then 
		file_read()
		notLoaded = false
	end
	
	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and eng_check then
		set(ark_mode, 0)
		eng_check = false
	end
	
	local button_now = get(button)
	if button_now ~= last_button then 
		needed_freq = read_table()
		set(ark_need_freq, needed_freq)
	end
	last_button = button_now
	
	
	local mode = get(ark_mode)
	local sim_time = get(flight_time)
	passed = get(frame_time)
if  passed > 0 then
	local band = get(ark_band_need)
	local tune = get(ark_tune_need)
	-- power calculations
	power = mode > 0 and get(fail) < 6 and get(bus27) > 21 and get(bus115) > 110   -- power calculations
--	print(power)
	if power then set(ark_cc, 8) else set(ark_cc, 0) end
	
	if power and get(cw_sw) == 1 and mode == 2 then set(audio_selection, 1) else set(audio_selection, 0) end
	
	-- make sounds
	if power then power_counter = power_counter + get(frame_time) else power_counter = -1 end
	if power_counter > 0 and power_counter < 1 then
		if not isSamplePlaying(ark_start_sound) then playSample(ark_start_sound, 0) end
	end
	if not power then stopSample(ark_start_sound) end
	
	local external = get(external_view)
	setSampleGain(ark_start_sound, 100 * (1 - external))
	setSampleGain(ark_rotate_sound, 500 * (1 - external))
	
	actual_freq = band + tune -- check last setted freq	
	
	-- animate knobs and set new freq
	needed_freq = get(ark_need_freq)
	if needed_freq ~= actual_freq and power then
		-- play sounds 
		if not isSamplePlaying(ark_rotate_sound) then playSample(ark_rotate_sound, 1) end
		
		--print(needed_freq)
		local needed_band, needed_tune = get_digits(needed_freq)
		-- set band to needed band
		-- if band is on the border of round
		if sim_time - last_band_update > 0.2 then
			last_band_update = sim_time
			if needed_band == 1180 and band == 120 then band = 1180
			elseif needed_band == 120 and band == 1180 then band = 120
			elseif needed_band < band then  -- rotate band untill it equal needed
				if band == 1180 then band = 1020
				elseif band == 1020 then band = 880
				elseif band == 880 then band = 720
				elseif band == 720 then band = 580
				elseif band == 580 then band = 420
				elseif band == 420 then band = 280
				elseif band == 280 then band = 120
				end
			elseif needed_band > band then
				if band == 120 then band = 280
				elseif band == 280 then band = 420
				elseif band == 420 then band = 580
				elseif band == 580 then band = 720
				elseif band == 720 then band = 880
				elseif band == 880 then band = 1020
				elseif band == 1020 then band = 1180
				end
			end
		end
		
		if sim_time - last_tune_update > 0.02 then
			last_tune_update = sim_time
			-- set tune
			if needed_tune - tune  < -5 then tune = tune - 5
			elseif needed_tune - tune < 0 then tune = tune - 1
			elseif needed_tune - tune > 5 then tune = tune + 5
			elseif needed_tune - tune > 0 then tune = tune + 1
			end
		end
		
	else
		stopSample(ark_rotate_sound)
	end	
	-- set frequency
	set(radio, band + tune)	
	set(ark_band, band)
	set(ark_tune, tune)
	set(ark_band_need, band)
	set(ark_tune_need, tune)
	
	--------------------------
	-- save knobs position --
	--------------------------
	local band_fix_now = get(band_fix)
	if band_fix_now ~= last_band_fix and band_fix_now == 0 then
		local d1, d2 = get_digits(read_table())
		local fr = get(ark_band_need) + d2
		update_table(fr)
	end
	
	local tune_fix_now = get(tune_fix)
	if tune_fix_now ~= last_tune_fix and tune_fix_now == 0 then
		local d1, d2 = get_digits(read_table())
		local fr = d1 + get(ark_tune_need)
		update_table(fr)	
	end
	
	last_band_fix = band_fix_now
	last_tune_fix = tune_fix_now			
	--------------------------
	-- bearing calculations --
	--------------------------
	
	local source_angle = get(adf)
	local signal = 0
	if power then
		if source_angle ~= 90 then signal = 1 + (math.random() - 0.49999) * 0.2 
		else signal = math.random() * 0.2
		end
		if mode == 1 and signal > 0.5 then
			angle = source_angle + (math.random() - 0.49999) * 10
		elseif mode == 4 and signal > 0.5 then
			local a = angle - source_angle
			if a > 180 then a = a - 360
			elseif a < -180 then a = a + 360 end
			if math.abs(a) < 90 then angle = source_angle + (math.random() - 0.49999) * 3
			else angle = source_angle + (math.random() - 0.49999) * 2 + 180 end			
		elseif mode == 3 then
			angle = angle + get(ant_sw) * passed * 20
			signal = signal * math.abs(math.cos(math.rad(source_angle - angle)))
		elseif mode == 1 or mode == 4 then
			angle = angle - (math.random() -  0.35) * 5
		end	
	end
	if angle > 180 then angle = angle - 360
	elseif angle < -180 then angle = angle + 360 end
	
	set(res_signal, signal)
	set(res_angle, angle)
	
end
	band_counter = get(ark_band_need)
	tune_pos = (0.036 - winWidth / 2) + step * (get(ark_tune_need)) / 29.09
end

components = {

	--[[rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1,0,0,1},

	},--]]
	-------------
	-- buttons --
	-------------
	-- P
	clickable {
       position = { 144, 146, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            button_pressed = 0
			set(button, button_pressed)
			--read_table()
            return true
        end
    }, 

	-- 1
	clickable {
       position = { 137, 142, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 1 then
            	button_pressed = 1
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    }, 

	-- 2
	clickable {
       position = { 137, 134, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 2 then
            	button_pressed = 2
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },	

	-- 3
	clickable {
       position = { 137, 125, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 3 then
            	button_pressed = 3
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },	

	-- 4
	clickable {
       position = { 137, 116, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 4 then
            	button_pressed = 4
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },
	
	-- 5
	clickable {
       position = { 137, 107, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 5 then
            	button_pressed = 5
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },	
	
	-- 6
	clickable {
       position = { 144, 110, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 6 then
            	button_pressed = 6
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },	
		
	-- 7
	clickable {
       position = { 144, 119, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 7 then
            	button_pressed = 7
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },

	-- 8
	clickable {
       position = { 144, 128, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 8 then
            	button_pressed = 8
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },

	-- 9
	clickable {
       position = { 144, 137, 7, 8 },
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
            if button_pressed ~= 9 then
            	button_pressed = 9
				set(button, button_pressed)
				--needed_freq = read_table()
            end
            return true
        end
    },	
	
	----------------
	-- mode --
	--------------
	
	rotary {
        position = { 138, 165, 20, 20},
        value = ark_mode;
        adjuster = function(v)
            if 0 > v then
                v = 0;
            elseif 4 < v then
                v = 4
            end
			return v
        end;
    },
	
	-----------------
	-- band knob --
	-----------------
	-- rotate left
	clickable {
       position = {152, 107, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new band
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			
			if B == 120 then B = 1180
			elseif B == 280 or B == 580 or B == 880 or B == 1180 then
				B = B - 160
			else B = B - 140
			end
			-- save new freq
			set(ark_band_need, B)
			set(ark_need_freq, B + T)
			
			--[[
			if band == 120 then band = 1180
			elseif band == 280 or band == 580 or band == 880 or band == 1180 then
				band = band - 160
			else band = band - 140
			end
			-- save new freq
			needed_freq = band + tune
			--]]
			
			
			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {164, 107, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new band
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			
			if B == 1180 then B = 120
			elseif B == 120 or B == 420 or B == 720 or B == 1020 then
				B = B + 160
			else B = B + 140
			end
			-- save new freq
			set(ark_band_need, B)
			set(ark_need_freq, B+T)
			--[[if band == 1180 then band = 120
			elseif band == 120 or band == 420 or band == 720 or band == 1020 then
				band = band + 160
			else band = band + 140
			end
			-- save new freq
			needed_freq = band + tune--]]
			return true
        end
    },
	

	-----------------
	-- tune knob --
	-----------------
	-- rotate left
	clickable {
       position = {175, 143, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			T = T + 4
			local limit = 160
			--if B == 280 or B == 580 or B == 880 or B == 1180 then limit = 140 end
			--if T > limit then T = limit end
			if T > 160 then T = 160 end
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			
			--[[tune = tune + 4
			if tune > 160 then tune = 160 end
			-- save new freq
			needed_freq = band + tune--]]
			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {187, 143, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)
			T = T - 4
			if T < 0 then T = 0 end
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			
			--[[tune = tune - 4
			if tune < 0 then tune = 0 end
			-- save new freq
			needed_freq = band + tune--]]
			return true
        end
    },
	
	-----------------
	-- fine tune knob --
	-----------------
	-- rotate left
	clickable {
       position = {212, 165, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)			
			local FT = get(ark_fine_tune)
			T = T + 1
			if T > 160 then T = 160
			else FT = FT + 5
			end
			-- save new freq and fine tune
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			set(ark_fine_tune, FT)
			--[[tune = tune + 1
			if tune > 160 then tune = 160 
			else fine_tune = fine_tune + 5
			end
			-- save new freq
			needed_freq = band + tune
			set(ark_fine_tune, fine_tune)--]]
			return true
        end
    },
	
	-- rotate right
	clickable {
       position = {222, 165, 10, 20},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			-- bands are 120, 280, 420, 580, 720, 880, 1020, 1180
			-- calculate new tune
			local B = get(ark_band_need)
			local T = get(ark_tune_need)			
			local FT = get(ark_fine_tune)
			T = T - 1
			if T < 0 then T = 0
			else FT = FT - 5
			end
			-- save new freq and fine tune
			set(ark_tune_need, T)
			set(ark_need_freq, B+T)
			set(ark_fine_tune, FT)			
			
			
			--[[tune = tune - 1
			if tune < 0 then tune = 0 
			else fine_tune = fine_tune - 5
			end
			-- save new freq
			needed_freq = band + tune
			set(ark_fine_tune, fine_tune)--]]
			return true
        end
    },
	
	
	---------------------
	-- safe freq fixes --
	---------------------

    -- save switch band
    switch {
        position = { 157, 135, 10, 10},
        state = function()
            return get(band_fix) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(band_fix) ~= 0 then
                set(band_fix, 0)
            else
                set(band_fix, 1)
            end
            return true;
        end
    },	
	
    -- save switch tune
    switch {
        position = { 180, 130, 10, 10},
        state = function()
            return get(tune_fix) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(tune_fix) ~= 0 then
                set(tune_fix, 0)
            else
                set(tune_fix, 1)
            end
            return true;
        end
    },	
	
	-- ramka tumbler
	-- rotate right
	clickable {
       position = {213, 106, 10, 13},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("rotateright.png")
        },  
        
        onMouseClick = function()
			set(ant_sw, 1)
			return true
        end,
		onMouseUp = function()
			set(ant_sw, 0)
			return true
		end
    },
	
	-- rotate left
	clickable {
       position = {203, 106, 10, 13},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("rotateleft.png")
        },  
        
        onMouseClick = function()
			set(ant_sw, -1)
			return true
        end,
		onMouseUp = function()
			set(ant_sw, 0)
			return true
		end
    },
	
	----------------
	-- indicators --
	----------------
	
	-- band counter
	digitstape {
        position = { 140, 60, 90, 35};
        image = digitsImage;
        digits = 4;
		allowNonRound = true;
		showLeadingZeros = false;
        value = function() 
            return band_counter; 
        end;
    }; 
	
    -- tune
    tape {
        position = { 0, 0, 136, 190},
        image = get(scale),
        window = { winWidth, 1.0 },

        -- calculate pitch level
        scrollX = function()
            return tune_pos;
        end,
    },	
	
	-- scale plank
	texture {
		position = {67, 0, 2, 190},
		image = get(scale_plank),
	},
	
	
	
	
	
}


