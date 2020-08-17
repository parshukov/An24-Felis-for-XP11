defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))
defineProperty("internal_view", globalPropertyi("sim/graphics/view/view_is_internal"))

-- power
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 
defineProperty("bus_DC_27_volt_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_36_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_volt")) -- power 36 volt

defineProperty("AGD_left_switch", globalPropertyf("sim/custom/xap/An24_gauges/AGD_left"))  -- switcher to turn ON/OFF AGD_left
defineProperty("AGD_right_switch", globalPropertyf("sim/custom/xap/An24_gauges/AGD_right"))  -- switcher to turn ON/OFF AGD_right
defineProperty("AGB_left_switch", globalPropertyf("sim/custom/xap/An24_gauges/AGB_left"))  -- switcher to turn ON/OFF AGB_left

defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

-- coordinates of airplane and camera
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) -- position X
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) -- position Y
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) -- position Z

defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) -- camera position X
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) -- camera position Y
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) -- camera position Z

-----------------------------------------------------------------------------------
defineProperty("head_x", globalPropertyf("sim/graphics/view/pilots_head_x"))
defineProperty("head_y", globalPropertyf("sim/graphics/view/pilots_head_y")) ---Пример 
defineProperty("head_z", globalPropertyf("sim/graphics/view/pilots_head_z"))
------------------------------------------------------------------------------------

---------cockpit-------------
local cockpits=0
local local_cockpit_x=0 
local local_cockpit_z=0 --Пример 
local local_cockpit_y=0
---------------------------------

---------cabin----------------
local cabin=0
local local_cabin_x=0 
local local_cabin_z=0 --Пример 
local local_cabin_y=0
---------------------------------

---------luggage----------------
local luggage=0
local local_luggage_x=0 
local local_luggage_z=0 --Пример 
local local_luggage_y=0
---------------------------------

--восстановлено начало--

--звуки систем в кабине----
local systems_sound = loadSample('Custom Sounds/an_24_systems.wav')
local systems_gain = 0

playSample(systems_sound, 1)
setSampleGain(systems_sound, 0)

--звуки гироскопов
local gyro_sound = loadSample('Custom Sounds/carflt_gyro.wav')
local gyro_gain = 0

playSample(gyro_sound, 0 )
setSampleGain(gyro_sound, 0)

-- PO750 inverter
local po750_sound = loadSample('Custom Sounds/po750.wav')
local po750_gain = 0

playSample(po750_sound, 1)
setSampleGain(po750_sound, 0)

defineProperty("inv_PT750", globalPropertyi("sim/custom/xap/An24_power/inv_PT750"))

-- PT1000 inverter
local pt1000_sound = loadSample('Custom Sounds/pt1000.wav')
local pt1000_gain = 0

playSample(pt1000_sound, 1)
setSampleGain(pt1000_sound, 0)

defineProperty("inv_PT1000_1", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_1"))  -- inverters
defineProperty("inv_PT1000_2", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_2"))

--восстановлено конец---

-- window wind
local wind_sound = loadSample('Custom Sounds/window_wind.wav')
-- engine sounds in windows
local eng_snd_1 = loadSample('Custom Sounds/an24 engn1_out.wav')
local eng_snd_2 = loadSample('Custom Sounds/an24 engn2_out.wav')
local eng_snd_3 = loadSample('Custom Sounds/an24 engn3_out.wav')

local eng_snd_gain = 0

playSample(eng_snd_1, 1) -- engine sound
playSample(eng_snd_2, 1) -- engine sound
playSample(eng_snd_3, 1) -- engine sound

setSampleGain(eng_snd_1, 0)
setSampleGain(eng_snd_2, 0)
setSampleGain(eng_snd_3, 0)

local last_dist = 0

playSample(wind_sound, 1) -- wind in windows
setSampleGain(wind_sound, 0)

defineProperty("hole1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[2]"))  
defineProperty("hole2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[3]")) 
-----------luk------------------
defineProperty("hole3", globalPropertyf("parshukovedition/lukbesson_switch"))
----------- люки, двери --------
defineProperty("hole4", globalPropertyi("sim/cockpit2/switches/custom_slider_on[4]"))  -- open/close cargo_hatch1
defineProperty("hole5", globalPropertyi("sim/cockpit2/switches/custom_slider_on[6]"))  -- open/close cargo_hatch2
defineProperty("hole6", globalPropertyi("sim/cockpit2/switches/custom_slider_on[5]"))  -- open/close pax_door
------------запасные -----------
defineProperty("hole7", globalPropertyi("sim/cockpit2/switches/custom_slider_on[8]"))  -- open/close emerg_hatch1
defineProperty("hole8", globalPropertyi("sim/cockpit2/switches/custom_slider_on[9]"))  -- open/close emerg_hatch2

defineProperty("ias", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))

-- props idle sounds
local prop_inn_1 = loadSample('Custom Sounds/prop_idle_inn.wav')
local prop_inn_2 = loadSample('Custom Sounds/prop_idle_inn.wav')
local prop_out_1 = loadSample('Custom Sounds/prop_idle_out.wav')
local prop_out_2 = loadSample('Custom Sounds/prop_idle_out.wav')

playSample(prop_inn_1, 1) -- prop sound
playSample(prop_inn_2, 1) -- prop sound
playSample(prop_out_1, 1) -- prop sound
playSample(prop_out_2, 1) -- prop sound

setSampleGain(prop_inn_1, 0)
setSampleGain(prop_inn_2, 0)
setSampleGain(prop_out_1, 0)
setSampleGain(prop_out_2, 0)

defineProperty("prop_pitch_1", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[0]")) -- propeller pitch
defineProperty("prop_pitch_2", globalPropertyf("sim/cockpit2/engine/actuators/prop_pitch_deg[1]"))

defineProperty("eng1_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("ru19_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm


local last_dist = 0

function update()

	local passed = get(frame_time)
	local power = get(bus_DC_27_volt) > 20 or get(bus_DC_27_volt_emerg)> 20
	
	--local gyro_power = (get(bus_DC_27_volt) > 20 or get(bus_DC_27_volt_emerg)> 20 ) and  get(bus_AC_36_volt)> 30                                  
	
	local external = get(external_view) -- 0 = inside, 1 = external
	local internal = get(internal_view) -- 0 = external, 1 = inside
	
	local camera_distance = math.sqrt(((get(view_x)-get(local_x))^2)+((get(view_y)-get(local_y))^2)+((get(view_z)-get(local_z))^2)) -- in meters
	if camera_distance < 10 then camera_distance = 10 end -- limit minimum distance
	
	local dist_coef = 200 / camera_distance ^ 1.1
	if dist_coef > 1 then dist_coef = 1 end
	-- calculate camera/aircraft speed
	local spd_time = math.min(0.0001, passed)
	local camera_spd = -(camera_distance - last_dist) / spd_time
	
	last_dist = camera_distance
	
	local dopp_coef = camera_spd * 0.02
	if dopp_coef > 400 then dopp_coef = 300
	elseif dopp_coef < -300 then dopp_coef = -300 end
	

	--print(camera_distance)
	
	--systems sound
	if power and systems_gain < 1000 then systems_gain = systems_gain + passed * 300
	elseif systems_gain > 0 then systems_gain = systems_gain - passed * 300 end
	if systems_gain > 1000 then systems_gain = 1000
	elseif systems_gain < 0 then systems_gain = 0 end	
	
	-- PO750 inverter
	if power and get(inv_PT750) == 1 and po750_gain < 1000 then po750_gain = po750_gain + passed * 300
	elseif po750_gain > 0 then po750_gain = po750_gain - passed * 300 end
	if po750_gain > 1000 then po750_gain = 1000
	elseif po750_gain < 0 then po750_gain = 0 end

	-- PT1000 inverter
	local pt1000_peak_gain = 950
	if power and (get(inv_PT1000_1) == 1 or get(inv_PT1000_2) == 1) and pt1000_gain < pt1000_peak_gain then
    pt1000_gain = pt1000_gain + passed * 300
	elseif pt1000_gain > 0 then
    pt1000_gain = pt1000_gain - passed * 300
  end
	if pt1000_gain > pt1000_peak_gain then
    pt1000_gain = pt1000_peak_gain
	elseif pt1000_gain < 0 then
    pt1000_gain = 0
  end
  
    -- Gyro and (get(inv_PT1000_1) == 1 or get(inv_PT1000_2) == 1)
    if power and get(inv_PT750) == 1 then
    gyro_gain = 400
    else gyro_gain = 0  end
    
  
	-- noise when open windows in flight
	local window_open = math.max(get(hole1), get(hole2), get(hole3)) 
	local window_open1 = math.max(get(hole5), get(hole6), get(hole7), get(hole8))
	local window_open2 = math.max(get(hole4))
	
	local spd = get(ias) * 0.5
	

			
	-- engine sounds
--[[

	setSampleGain(eng_snd_1, 800 * (external + window_open * (1 - external)) * N1 * dist_coef)
	setSampleGain(eng_snd_2, 800 * (external + window_open * (1 - external)) * N2 * dist_coef)
	setSampleGain(eng_snd_3, 1000 * (external + window_open * (1 - external)) * N3 * dist_coef)
	
	setSamplePitch(eng_snd_1, 1000 * N1 + dopp_coef)
	setSamplePitch(eng_snd_2, 1000 * N2 + dopp_coef)
	setSamplePitch(eng_snd_3, 1000 * N3 + dopp_coef)
--]]	
	
------------------------------Координаты кокпита-----------------------------------------------------------
if get(head_x)<-0.96 or get(head_x)>0.96 then local_cockpit_x=0  else local_cockpit_x=1 end   
if get(head_z)>-5.9 or get(head_z)<-7.6  then local_cockpit_z=0 else  local_cockpit_z=1 end  --Пример 
if get(head_y)<-1.25 or get(head_y)>0.2 then local_cockpit_y=0 else  local_cockpit_y=1 end 

if local_cockpit_z==1 and local_cockpit_x==1 and local_cockpit_y==1 then cockpits=1  else cockpits=0   end 

------------------------------Координаты багажного отделения-----------------------------------------------------------
if get(head_x)<-1.35 or get(head_x)>1.35 then local_luggage_x=0  else local_luggage_x=1 end   
if get(head_z)>-3.9 or get(head_z)<-5.7  then local_luggage_z=0 else  local_luggage_z=1 end  --Пример 
if get(head_y)<-1.3 or get(head_y)>0.1 then local_luggage_y=0 else  local_luggage_y=1 end 

if local_luggage_z==1 and local_luggage_x==1 and local_luggage_y==1 then luggage=1  else luggage=0   end 

------------------------------Координаты кабины-----------------------------------------------------------
if get(head_x)<-1.35 or get(head_x)>1.35 then local_cabin_x=0  else local_cabin_x=1 end   
if get(head_z)>9.0 or get(head_z)<-3.8  then local_cabin_z=0 else  local_cabin_z=1 end  --Пример 
if get(head_y)<-1.3 or get(head_y)>0.1 then local_cabin_y=0 else  local_cabin_y=1 end 

if local_cabin_z==1 and local_cabin_x==1 and local_cabin_y==1 then cabin=1  else cabin=0   end 

	
	-- prop sounds
	local prop_angle_1 = get(prop_pitch_1)
	local prop_angle_2 = get(prop_pitch_2)
	
	if prop_angle_1 < 1 then prop_angle_1 = 1 end
	if prop_angle_2 < 1 then prop_angle_2 = 1 end
	
	local prop_loud_1 = 1000 / prop_angle_1
	local prop_loud_2 = 1000 / prop_angle_2
	
	local N1 = get(eng1_N1) * 0.01
	local N2 = get(eng2_N1) * 0.01
	local N3 = get(ru19_N1) * 0.01
	
	setSampleGain(prop_inn_1, prop_loud_1 * (1 - external) * 2 * N1)
	setSampleGain(prop_inn_2, prop_loud_2 * (1 - external) * 2 * N2)
	
	if      get(external_view)==0   and cockpits==1 then 	
	setSampleGain(prop_out_1, prop_loud_1 * (external + window_open * (1 - external)) * N1 * dist_coef)
	setSampleGain(prop_out_2, prop_loud_2 * (external + window_open * (1 - external)) * N2 * dist_coef)
	
	elseif  get(external_view)==0   and luggage==1    then
	setSampleGain(prop_out_1, prop_loud_1 * (external + window_open2 * (1 - external)) * N1 * dist_coef)
	setSampleGain(prop_out_2, prop_loud_2 * (external + window_open2 * (1 - external)) * N2 * dist_coef)	
	
    elseif  get(external_view)==0   and cabin==1    then
	setSampleGain(prop_out_1, prop_loud_1 * (external + window_open1 * (1 - external)) * N1 * dist_coef)
	setSampleGain(prop_out_2, prop_loud_2 * (external + window_open1 * (1 - external)) * N2 * dist_coef)    end

	setSamplePitch(prop_inn_1, 1000 * N1)
	setSamplePitch(prop_inn_2, 1000 * N2)
	setSamplePitch(prop_out_1, 1000 * N1 + dopp_coef)
	setSamplePitch(prop_out_2, 1000 * N2 + dopp_coef) 
	
----------------------Шум ветра----------------------------------------
	if      cockpits==1 then
    	local wind_gain = math.min(1000,  window_open * spd * 10) * (1 - external)
    	setSampleGain(wind_sound, wind_gain)
    	
    elseif  cabin==1    then		
	    local wind_gain = math.min(1000, window_open1 * spd * 10) * (1 - external)
	    setSampleGain(wind_sound, wind_gain)                                end

----------------------внешние звуки двигателей-------------------------	
	if      get(external_view)==1   then 
	    setSampleGain(eng_snd_1,  800  * dist_coef)
	    setSampleGain(eng_snd_2,  800  * dist_coef)
	    setSampleGain(eng_snd_3,  800  * dist_coef)
     	setSamplePitch(eng_snd_1, 1000 * N1)
    	setSamplePitch(eng_snd_2, 1000 * N2)	    
        setSamplePitch(eng_snd_3, 1000 * N3)                                 end
        
        
-------------- звуки систем в самолете ------------------------        
  	if  get(external_view)==0       then 
  	    setSampleGain(systems_sound, systems_gain * 0.5 * (1 - external))
  	    setSamplePitch(systems_sound, systems_gain)
  	elseif  get(internal_view)==0   then 	    
          setSampleGain(systems_sound, 0)
          setSampleGain(systems_sound, 0)                                      end        

-------------- звуки преобразователей в кокпите ------------------------        
	if      get(external_view)==0   and cockpits==1 then 
	    setSampleGain(po750_sound, po750_gain * 0.5 * (1 - external))
	    setSamplePitch(po750_sound, po750_gain)	   
	    setSampleGain(pt1000_sound, pt1000_gain * 0.5 * (1 - external))
	    setSamplePitch(pt1000_sound, pt1000_gain)

    elseif  get(external_view)==0   and cockpits==0 then 	    
        setSampleGain(po750_sound, 0)
        setSampleGain(pt1000_sound, 0)                                      end
        
-------------- звуки гироскопов в кокпите ------------------------   
    -- gyro sounds
	if get(external_view)==0 and cockpits==1 and (get(inv_PT1000_1) == 1 or get(inv_PT1000_2) == 1) and (get(AGB_left_switch) == 1 or get(AGD_left_switch) == 1 or get(AGD_right_switch) == 1) then
	setSampleGain(gyro_sound, gyro_gain)            
	elseif  get(internal_view)==0   then 
	setSampleGain(gyro_sound, 0)    end

        
--------------  звуки моторов в кокпите ------------------------------------------------------       
	if      get(external_view)==0   and cockpits==1 then                    -- если в кокпите
	    setSampleGain(eng_snd_1, 500 * N1 * window_open * (1 - external) + 50 * N1 * window_open1 * (1 - external) + 200 * N1 * window_open2 * (1 - external)) 
	    setSampleGain(eng_snd_2, 500 * N2 * window_open * (1 - external) + 50 * N2 * window_open1 * (1 - external) + 200 * N2 * window_open2 * (1 - external))
	    setSampleGain(eng_snd_3, 500 * N3 * window_open * (1 - external) + 50 * N3 * window_open1 * (1 - external) + 200 * N3 * window_open2 * (1 - external))  

	elseif  get(external_view)==0   and luggage==1  then    
        setSampleGain(eng_snd_1, 500 * N1 * window_open2 * (1 - external) + 50 * N1 * window_open * (1 - external) + 50 * N1 * window_open1 * (1 - external))
        setSampleGain(eng_snd_2, 500 * N2 * window_open2 * (1 - external) + 50 * N2 * window_open * (1 - external) + 50 * N2 * window_open1 * (1 - external))
        setSampleGain(eng_snd_3, 500 * N3 * window_open2 * (1 - external) + 50 * N3 * window_open * (1 - external) + 50 * N3 * window_open1 * (1 - external)) 	     

    elseif  get(external_view)==0   and cabin==1    then                -- иначе если в кабине
        setSampleGain(eng_snd_1, 500 * N1 * window_open1 * (1 - external) + 50 * N1 * window_open * (1 - external) + 100 * N1 * window_open2 * (1 - external))
        setSampleGain(eng_snd_2, 500 * N2 * window_open1 * (1 - external) + 50 * N2 * window_open * (1 - external) + 100 * N2 * window_open2 * (1 - external))
        setSampleGain(eng_snd_3, 500 * N3 * window_open1 * (1 - external) + 50 * N3 * window_open * (1 - external) + 100 * N3 * window_open2 * (1 - external))  
        
    end

     	setSamplePitch(eng_snd_1, 800 * N1)
    	setSamplePitch(eng_snd_2, 800 * N2)                   
    	setSamplePitch(eng_snd_3, 800 * N3)
        
 	--print("work")

end
