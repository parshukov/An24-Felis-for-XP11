size = { 200, 200 }

-- initialize component property table
defineProperty("utc_time", globalPropertyf("sim/time/zulu_time_sec"))
defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec"))
defineProperty("world_green", globalPropertyf("sim/graphics/misc/cockpit_light_level_g"))  -- green component of natural light in cockpit

-- background image
--defineProperty("background", loadImage("achs1.dds", 0, 0, size[1], size[2]))
defineProperty("background_lit", loadImage("achs1_lit.dds", 0, 0, 200, 200))

-- needle images
defineProperty("time_hour_nd", loadImage("achs1.dds", 241, 10, 14, 160))
defineProperty("time_min_nd", loadImage("achs1.dds", 226, 10, 14, 160))
defineProperty("time_sec_nd", loadImage("achs1.dds", 213, 10, 14, 160))
defineProperty("flight_hour_nd", loadImage("achs1.dds", 25, 210, 7, 72))
defineProperty("flight_min_nd", loadImage("achs1.dds", 39, 210, 7, 72))
defineProperty("chrono_sec_nd", loadImage("achs1.dds", 50, 210, 8, 72))
defineProperty("chrono_min_nd", loadImage("achs1.dds", 62, 210, 8, 72))
-- lit
defineProperty("time_hour_nd_lit", loadImage("achs1_lit.dds", 241, 10, 14, 160))
defineProperty("time_min_nd_lit", loadImage("achs1_lit.dds", 226, 10, 14, 160))
defineProperty("time_sec_nd_lit", loadImage("achs1_lit.dds", 213, 10, 14, 160))
defineProperty("flight_hour_nd_lit", loadImage("achs1_lit.dds", 25, 210, 7, 72))
defineProperty("flight_min_nd_lit", loadImage("achs1_lit.dds", 39, 210, 7, 72))
defineProperty("chrono_sec_nd_lit", loadImage("achs1_lit.dds", 50, 210, 8, 72))
defineProperty("chrono_min_nd_lit", loadImage("achs1_lit.dds", 62, 210, 8, 72))


-- flag images
defineProperty("flag_0", loadImage("achs1.dds", 7, 221, 8, 6))  -- white
defineProperty("flag_1", loadImage("achs1.dds", 7, 238, 8, 6))  -- red
defineProperty("flag_2", loadImage("achs1.dds", 7, 230, 8, 6))  -- red/white
-- lit
defineProperty("flag_0_lit", loadImage("achs1_lit.dds", 7, 221, 8, 6))  -- white
defineProperty("flag_1_lit", loadImage("achs1_lit.dds", 7, 238, 8, 6))  -- red
defineProperty("flag_2_lit", loadImage("achs1_lit.dds", 7, 230, 8, 6))  -- red/white

-- sounds
local btn_click = loadSample('Custom Sounds/acs_btn.wav')
--local tik_tak = loadSample('Custom Sounds/acs_tik_tik.wav')

-- define needed variables
local sec_mode = 0  -- mode of sec-timer
local flight_mode = 0  -- mode of chronometer of flight time
local sec_time = 0  -- time of chronometer of sec
local flight_time = 0  -- time of flight
local start_sec = 0  -- time of sec chrono start
local start_flight = 0  -- time of flight chrono start

local night = false

local leftKnobClicked = false
local rightKnobClicked = false
local chrono_min_angle = 0
local chrono_sec_angle = 0

local flight_hour_angle = 0
local flight_min_angle = 0

local main_hour_angle = 0
local main_min_angle = 0
local main_sec_angle = 0

local flag_img = get(flag_1)

-- sec_timer
sec_timer_command = findCommand("sim/instruments/timer_start_stop")
function sec_timer_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
		if sec_mode == 0 then
			sec_mode = 1
            start_sec = get(sim_run_time)
        elseif sec_mode == 1 then
            sec_mode = 2
        else sec_mode = 0
        end		
    end
return 0
end
registerCommandHandler(sec_timer_command, 0, sec_timer_handler)

-- flight_timer
flight_timer_command = findCommand("sim/instruments/timer_reset")
function flight_timer_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if 0 == phase then
            if flight_mode == 0 then
               flight_mode = 1
               start_flight = get(sim_run_time)
            elseif flight_mode == 1 then
               flight_mode = 2
            else flight_mode = 0
            end	
    end
return 0
end
registerCommandHandler(flight_timer_command, 0, flight_timer_handler)



function update()
	local sim_time = get(sim_run_time)  -- take actual sim time in seconds
	local main_time = get(utc_time)  -- take actual UTC time
	
	-- flag image calc
	if flight_mode == 1 then flag_img = get(flag_1)
    elseif flight_mode == 2 then flag_img = get(flag_2)
    else flag_img = get(flag_0)
    end
	
	-- calculate chronometer's angles
	if sec_mode == 0 then 
        sec_time = 0
		chrono_min_angle = sec_time 
		chrono_sec_angle = sec_time
    elseif sec_mode == 1 then 
		sec_time = sim_time - start_sec
        chrono_min_angle = sec_time * 360 / (60 * 60)
		chrono_sec_angle = chrono_min_angle * 60
    else
        chrono_min_angle = sec_time * 360 / (60 * 60)
		chrono_sec_angle = chrono_min_angle * 60
    end
	
	-- calculate flight timer
	if flight_mode == 0 then 
        flight_time = 0
        flight_hour_angle = flight_time 
		flight_min_angle = flight_time 
    elseif flight_mode == 1 then 
        flight_time = sim_time - start_flight
        flight_hour_angle = flight_time * 360 / (60 * 60 * 12)
		flight_min_angle = flight_hour_angle * 12
    else
        flight_hour_angle = flight_time * 360 / (60 * 60 * 12)
		flight_min_angle = flight_hour_angle * 12
    end
	
	-- calculate clock
	main_sec_angle = main_time * 360 / 60
	main_min_angle = main_sec_angle / 60
	main_hour_angle = main_min_angle / 12
	
	-- determine the dark time
    if get(world_green) > 0.75 then night = false
       else night = true
    end 
end



-- clock consists of several components
components = {
	-- bacground tecture
	textureLit {
		position = {0, 0, 200, 200},
		image = get(background_lit),
		visible = function()
			return night
		end,
	},

-----------------------------------
    -- chronometer --
-----------------------------------
    -- minutes needle
	needle {
        position = { 50, 3, 100, 100 },
        image = get(chrono_min_nd),
        angle = function()
			return chrono_min_angle
        end
    }, 
	
	-- minutes needle LIT
	needleLit {
        position = { 50, 3, 100, 100 },
        image = get(chrono_min_nd_lit),
        angle = function()
			return chrono_min_angle
        end,
		visible = function()
			return night
		end,
    }, 
    
    -- secondes needle
    needle {
        position = { 55, 8, 90, 90 },
        image = get(chrono_sec_nd),
        angle = function()
			return chrono_sec_angle
        end
    },  
    
    -- secondes needle LIT
    needleLit {
        position = { 55, 8, 90, 90 },
        image = get(chrono_sec_nd_lit),
        angle = function()
			return chrono_sec_angle
        end,
		visible = function()
			return night
		end,
    }, 
	
    -- chronometer knob
	clickable {
        position = {165, 0, 35, 40 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       onMouseClick = function() 
          if not rightKnobClicked then  
            playSample(btn_click, 0)
			if sec_mode == 0 then
               sec_mode = 1
               start_sec = get(sim_run_time)
            elseif sec_mode == 1 then
               sec_mode = 2
            else sec_mode = 0
            end
            rightKnobClicked = true
          end
          return true
       end,
       
       onMouseUp = function()
          rightKnobClicked = false
          return true
       end,

    }, 
-----------------------------------
    -- flight timer --
-----------------------------------
    -- flight mode flag
    texture { 
        position = { 93, 122, 13, 10 },
        image = function()
        	return flag_img
        end
    },
--[[	
    -- flight mode flag LIT
    textureLit { 
        position = { 93, 122, 13, 10 },
        image = function()
            if flight_mode == 1 then return get(flag_1_lit)
            elseif flight_mode == 2 then return get(flag_2_lit)
            else return get(flag_0_lit)
            end
        end,	
		visible = function()
			return night
		end,
    },
--]]
	-- hours needle
    needle {
        position = { 50, 102, 100, 90 },
        image = get(flight_hour_nd),
        angle = function()
			return flight_hour_angle 
        end,
    },
	
	-- hours needle LIT
    needleLit {
        position = { 50, 102, 100, 90 },
        image = get(flight_hour_nd_lit),
        angle = function()
			return flight_hour_angle 
        end,
		visible = function()
			return night
		end,	
    },
    
    -- minutes needle
    needle {
        position = { 50, 97, 100, 100 },
        image = get(flight_min_nd),
        angle = function()
			return flight_min_angle
        end,
    },  
    
	-- minutes needle LIT
    needleLit {
        position = { 50, 97, 100, 100 },
        image = get(flight_min_nd_lit),
        angle = function()
			return flight_min_angle
        end,
		visible = function()
			return night
		end,
    },      
    
    clickable {
        position = {0, 0, 30, 45 },
        
       cursor = { 
            x = 16, 
            y = 32,  
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        
       onMouseClick = function() 
          if not leftKnobClicked then  
            playSample(btn_click, 0)
			if flight_mode == 0 then
               flight_mode = 1
               start_flight = get(sim_run_time)
            elseif flight_mode == 1 then
               flight_mode = 2
            else flight_mode = 0
            end
            leftKnobClicked = true
          end  
          return true
       end,
       
       onMouseUp = function()
          leftKnobClicked = false
       end,
    },   
    
-----------------------------------    
    -- clock -- 
-----------------------------------
    -- hours needle
    needle {
        position = {5, 5, 190, 190 },
        image = get(time_hour_nd),
        angle = function() 
			return main_hour_angle
        end
    },  

    -- hours needle LIT
    needleLit {
        position = {5, 5, 190, 190 },
        image = get(time_hour_nd_lit),
        angle = function() 
			return main_hour_angle
        end,
		visible = function()
			return night
		end,	
    }, 
    -- minutes needle
    needle {
        position = {5, 5, 190, 190  },
        image = get(time_min_nd),
        angle = function() 
			return  main_min_angle
        end
    },  

    -- minutes needle LIT
    needleLit {
        position = {5, 5, 190, 190  },
        image = get(time_min_nd_lit),
        angle = function() 
			return  main_min_angle
        end,
		visible = function()
			return night
		end,
    }, 
    
    -- secondes needle
    needle {
        position = { 5, 5, 190, 190 },
        image = get(time_sec_nd),
        angle = function() 
			return main_sec_angle
        end
    },  

    -- secondes needle LIT
    needleLit {
        position = { 5, 5, 190, 190 },
        image = get(time_sec_nd_lit),
        angle = function() 
			return main_sec_angle
        end,
		visible = function()
			return night
		end,	
    },  
      

    

}

