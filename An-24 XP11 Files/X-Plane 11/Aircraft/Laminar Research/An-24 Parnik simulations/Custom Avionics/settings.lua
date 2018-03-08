size = {562, 512}

-- define property table
createGlobalPropertyf("sim/custom/xap/An24_set/sound_volume", 900) -- global sound volume
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

defineProperty("set_real_fuel_meter", globalPropertyi("sim/custom/xap/An24_set/real_fuel_meter")) -- real fuel meter will show less fuel amount, then it's really is
defineProperty("set_real_ahz", globalPropertyi("sim/custom/xap/An24_set/real_ahz")) -- real ahz has errors and needs to be corrected
defineProperty("set_real_fire", globalPropertyi("sim/custom/xap/An24_set/real_fire")) -- fire will affect wings and nearest mech
defineProperty("set_real_startup", globalPropertyi("sim/custom/xap/An24_set/real_startup")) -- when start the engines a lot of thing must to be done
defineProperty("set_active_camera", globalPropertyi("sim/custom/xap/An24_set/active_camera")) -- use of moveing camera
defineProperty("set_real_generators", globalPropertyi("sim/custom/xap/An24_set/real_generators")) -- generators can fail if overload
defineProperty("set_real_gears", globalPropertyi("sim/custom/xap/An24_set/real_gears")) --  gears can fail in overspeed
defineProperty("set_real_brakes", globalPropertyi("sim/custom/xap/An24_set/real_brakes")) -- brakes can overheat and fail
defineProperty("set_real_tyres", globalPropertyi("sim/custom/xap/An24_set/real_tyres")) -- tyres can blow if too much brakes
defineProperty("hide_GPS", globalPropertyi("sim/custom/xap/An24_set/hide_GPS")) -- by default GPS is hided
defineProperty("hide_Garmin", globalPropertyi("sim/custom/xap/An24_set/hide_Garmin")) -- by default Garmin is hided
defineProperty("switch_rud", globalPropertyi("sim/custom/xap/An24_set/switch_rud")) -- switch or hold rud stopors
defineProperty("rud_close", globalPropertyi("sim/custom/xap/An24_misc/rud_close")) -- down RUD latch when hold mode is ON
defineProperty("north_GPK", globalPropertyi("sim/custom/xap/An24_set/north_GPK"))  -- GPK mode for north hemisphere
defineProperty("real_fuel", globalPropertyi("sim/custom/xap/An24_set/real_fuel")) -- switch for real fuel system or FSE compability
defineProperty("rsbn_dataset", globalPropertyi("sim/custom/xap/An24_rsbn/dataset"))  -- dataset, 0:CIS 1:USSR
defineProperty("black_box", globalPropertyi("sim/custom/xap/An24_set/black_box"))  -- flight data recording
defineProperty("kln_is_present", globalPropertyi("sim/custom/kln_is_present"))  -- flight data recording
--set(kln_is_present,0)
defineProperty("sound_volume", globalPropertyf("sim/custom/xap/An24_set/sound_volume"))  -- flight data recording


defineProperty("options_subpanel", globalPropertyi("sim/custom/xap/An24_panels/options_subpanel"))

local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local btn_click = loadSample('Custom Sounds/plastic_btn.wav')
local rot_click = loadSample('Custom Sounds/rot_click.wav')
local plastic_sound = loadSample('Custom Sounds/plastic_switch.wav')

local switcher_pushed = false

-- images
defineProperty("background", loadImage("settings.dds", 0, 0, size[1], size[2]))
defineProperty("tmb_up", loadImage("tumbler_up.dds", 0, 20, 32, 88))
defineProperty("tmb_dn", loadImage("tumbler_down.dds",  0, 20, 32, 88))
defineProperty("lever_image", loadImage("lever.dds",  0, 2, 42, 52))

-- settings table
local settings_table = {}
	settings_table["fuelmeter"] = 1
	settings_table["ahz"] = 1
	settings_table["fire"] = 1
	settings_table["startup"] = 1
	settings_table["camera"] = 1
	settings_table["generators"] = 1
	settings_table["gears"] = 1
	settings_table["brakes"] = 1
	settings_table["tyres"] = 1
	settings_table["klnispresent"] = 1
	settings_table["hidegarmin"] = 1
	settings_table["rudswitch"] = 1
	settings_table["gpknorth"] = 1
	settings_table["fuel"] = 1
	settings_table["dataset"] = 1
	settings_table["black_box"] = 0
	settings_table["volume"] = 900
	
	
-- reading file or set properties with default values
function file_read()
	local filename = panelDir .. "/an24_settings.ini"
	local file = io.open(filename, "r")
	-- if file exist - read it and fill the variables with new values
	if file then
		local lines = file:read("*a")
		print("reading settings")
		for k, v in string.gmatch(lines, "(%w+)=(%d+)") do
			settings_table[k] = tonumber(v)
			print(k, v)
		end
		file:close()
		-- update values from table
		set(set_real_fuel_meter, settings_table["fuelmeter"])
		set(set_real_ahz, settings_table["ahz"])
		set(set_real_fire, settings_table["fire"])
		set(set_real_startup, settings_table["startup"])
		set(set_real_generators, settings_table["generators"])
		set(set_real_gears, settings_table["gears"])
		set(set_real_brakes, settings_table["brakes"])
		set(set_real_tyres, settings_table["tyres"])
		set(set_active_camera, settings_table["camera"])
		set(kln_is_present, settings_table["klnispresent"])		
		set(hide_Garmin, settings_table["hidegarmin"])
		set(switch_rud, settings_table["rudswitch"])
		set(north_GPK, settings_table["gpknorth"])
		set(real_fuel, settings_table["fuel"])
		set(rsbn_dataset, settings_table["dataset"])
		set(black_box, settings_table["black_box"])
		set(sound_volume, settings_table["volume"])
		print("settings readed successfully")
	else print ("no .ini file with settings - using default values")
	end
	return true
end

-- saving file
function file_save()
	local filename = panelDir .. "/an24_settings.ini"
	local success = false -- check operation
	local savefile = io.open(filename, "w")
	savefile:write("fuelmeter","=",get(set_real_fuel_meter)," \n")
	savefile:write("ahz","=",get(set_real_ahz)," \n")
	savefile:write("fire","=",get(set_real_fire)," \n")
	savefile:write("startup","=",get(set_real_startup)," \n")
	savefile:write("generators","=",get(set_real_generators)," \n")
	savefile:write("gears","=",get(set_real_gears)," \n")
	savefile:write("brakes","=",get(set_real_brakes)," \n")
	savefile:write("tyres","=",get(set_real_tyres)," \n")
	savefile:write("camera","=",get(set_active_camera)," \n")
	savefile:write("klnispresent","=",get(kln_is_present)," \n")
	savefile:write("hidegarmin","=",get(hide_Garmin)," \n")
	savefile:write("rudswitch","=",get(switch_rud)," \n")
	savefile:write("gpknorth","=",get(north_GPK)," \n")
	savefile:write("fuel","=",get(real_fuel)," \n")
	savefile:write("dataset","=",get(rsbn_dataset)," \n")
	savefile:write("black_box","=",get(black_box)," \n")
	savefile:write("sound_volume","=",get(sound_volume)," \n")
	if savefile then success = true end
	savefile:close()
	
	return success
end


local notLoaded = true
local last_vol = 1000

function update()
	if notLoaded then
		file_read()
		notLoaded = false
	end
	
	if get(frame_time) == 0 then setMasterGain(0) 
	else setMasterGain(get(sound_volume)) end


end

components = {
	-- background
	texture {
		image = get(background),
		position = {0, 0, size[1], size[2]},

	},	

   -- left throttle lever
   lever{
       position = { 515, 60, 40, 290},
       value = {sound_volume},
       lever_img = get(lever_image),
       minimum = 0,
       maximum = 1000,
   },	


	-- save file clickable
	clickable {
       position = {260, 30, 230, 50},
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			local file_saved = file_save()
			if file_saved then print("saving file with settings - success") else print("saving file with settings - error") end			
			return true
        end,
    },

	-- RE-READ file clickable
	clickable {
       position = {15, 30, 230, 50},
        
       cursor = { 
            x = 16, 
            y = 32, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
        onMouseClick = function()
			file_read()
			return true
        end,
    },

	-- set_real_fuel_meter
	switch {
        position = { 220, 412, 22, 50},
        state = function()
            return get(set_real_fuel_meter) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_fuel_meter) ~= 0 then
                set(set_real_fuel_meter, 0)
            else
                set(set_real_fuel_meter, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    }, 

	-- set_real_ahz
	switch {
        position = { 220, 362, 22, 50},
        state = function()
            return get(set_real_ahz) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_ahz) ~= 0 then
                set(set_real_ahz, 0)
            else
                set(set_real_ahz, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end, 
    },

	-- set_real_fire
	switch {
        position = {  220, 312, 22, 50},
        state = function()
            return get(set_real_fire) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_fire) ~= 0 then
                set(set_real_fire, 0)
            else
                set(set_real_fire, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end, 
    },

	-- set_real_startup
	switch {
        position = { 220, 262, 22, 50},
        state = function()
            return get(set_real_startup) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_startup) ~= 0 then
                set(set_real_startup, 0)
            else
                set(set_real_startup, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,  
    },

	-- set_active_camera
	switch {
        position = {  470, 412, 22, 50},
        state = function()
            return get(set_active_camera) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_active_camera) ~= 0 then
                set(set_active_camera, 0)
            else
                set(set_active_camera, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- set_real_generators
	switch {
        position = {  220, 212, 22, 50},
        state = function()
            return get(set_real_generators) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_generators) ~= 0 then
                set(set_real_generators, 0)
            else
                set(set_real_generators, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    
	-- set_real_gears
	switch {
        position = {  220, 162, 22, 50},
        state = function()
            return get(set_real_gears) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_gears) ~= 0 then
                set(set_real_gears, 0)
            else
                set(set_real_gears, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    
	-- set_real_brakes
	switch {
        position = {  220, 112, 22, 50},
        state = function()
            return get(set_real_brakes) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_brakes) ~= 0 then
                set(set_real_brakes, 0)
            else
                set(set_real_brakes, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end, 
    },   

	-- set_real_tyres
	switch {
        position = { 220, 62, 22, 50},
        state = function()
            return get(set_real_tyres) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(set_real_tyres) ~= 0 then
                set(set_real_tyres, 0)
            else
                set(set_real_tyres, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },   


	-- hide_GPS
	switch {
        position = { 470, 362, 22, 50},
        state = function()
            return get(kln_is_present) ~= 1
        end,
        btnOn = get(tmb_dn),
        btnOff = get(tmb_up),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(kln_is_present) == 0 then
                set(kln_is_present, 1)
				if get(hide_Garmin) == 0 then set(hide_Garmin, 1) end
            else
				set(kln_is_present, 0)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end, 
    },

	-- hide_Garmin
	switch {
        position = {  470, 312, 22, 50},
        state = function()
            return get(hide_Garmin) ~= 0
        end,
        btnOn = get(tmb_dn),
        btnOff = get(tmb_up),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(hide_Garmin) ~= 0 then
                set(hide_Garmin, 0)
				if get(kln_is_present) == 1 then set(kln_is_present, 0) end
            else
                set(hide_Garmin, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end, 
    },

	-- switch_rud
	switch {
        position = { 470, 262, 22, 50},
        state = function()
            return get(switch_rud) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(switch_rud) ~= 0 then
                set(switch_rud, 0)
            else
                set(switch_rud, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- north_GPK
	switch {
        position = { 470, 212, 22, 50},
        state = function()
            return get(north_GPK) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(north_GPK) ~= 0 then
                set(north_GPK, 0)
            else
                set(north_GPK, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- real_fuel
	switch {
        position = { 470, 162, 22, 50},
        state = function()
            return get(real_fuel) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(real_fuel) ~= 0 then
                set(real_fuel, 0)
            else
                set(real_fuel, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- rsbn_dataset
	switch {
        position = { 470, 112, 22, 50},
        state = function()
            return get(rsbn_dataset) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(rsbn_dataset) ~= 0 then
                set(rsbn_dataset, 0)
            else
                set(rsbn_dataset, 1)
            end
		end
            return true;
			
        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	
	-- black_box
	switch {
        position = { 470, 62, 22, 50},
        state = function()
            return get(black_box) ~= 0
        end,
        btnOn = get(tmb_up),
        btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(black_box) ~= 0 then
                set(black_box, 0)
            else
                set(black_box, 1)
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
        set(options_subpanel, 0 )
		return true
        end
    },
}

