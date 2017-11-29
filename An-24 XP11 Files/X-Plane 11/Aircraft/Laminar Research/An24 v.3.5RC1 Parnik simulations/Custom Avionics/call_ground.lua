--Scripts for ground service
defineProperty("left_eng_main", globalPropertyi("sim/custom/xap/An24_covers/left_eng_main"))  -- left engine main cover
defineProperty("left_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/left_eng_ext"))  -- left engine exhaust cover
defineProperty("right_eng_main", globalPropertyi("sim/custom/xap/An24_covers/right_eng_main"))  -- right engine main cover
defineProperty("right_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/right_eng_ext"))  -- right engine exhaust cover
defineProperty("ru19_eng_ext", globalPropertyi("sim/custom/xap/An24_covers/ru19_eng_ext"))  -- ru19 engine exhaust cover
defineProperty("antiice_left", globalPropertyi("sim/custom/xap/An24_covers/antiice_left"))  -- left anti-ice detector cover
defineProperty("antiice_right", globalPropertyi("sim/custom/xap/An24_covers/antiice_right"))  -- right anti-ice detector cover
defineProperty("rockets", globalPropertyi("sim/custom/xap/An24_covers/rockets"))  -- rockets cover
defineProperty("pitot_1", globalPropertyi("sim/custom/xap/An24_covers/pitot_1"))  -- pitot 1
defineProperty("pitot_2", globalPropertyi("sim/custom/xap/An24_covers/pitot_2"))  -- pitot 2
defineProperty("pitot_3", globalPropertyi("sim/custom/xap/An24_covers/pitot_3"))  -- pitot 3
defineProperty("grounding", globalPropertyi("sim/custom/xap/An24_covers/grounding"))  -- grounding wire
defineProperty("gear_blocks", globalPropertyi("sim/custom/xap/An24_covers/gear_blocks"))  -- gear blocks

defineProperty("frequence",globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_hz"))
defineProperty("service_subpanel", globalPropertyi("sim/custom/xap/An24_panels/service_subpanel"))
defineProperty("ground_sound", globalPropertyi("autumnsky/sound/gndsound"))
defineProperty("ground_available", globalPropertyi("sim/custom/xap/An24_power/ground_available"))
defineProperty("power_mode", globalPropertyi("sim/custom/xap/An24_power/power_mode"))
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 


defineProperty("emerg1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[8]"))  -- open/close emerg_hatch1
defineProperty("emerg2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[9]"))  -- open/close emerg_hatch2
defineProperty("cargo1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[4]"))  -- open/close cargo_hatch1
defineProperty("cargo2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[6]"))  -- open/close cargo_hatch2
defineProperty("paxdoor", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[5]"))  -- open/close pax_door
defineProperty("time_sim1", globalPropertyf("sim/time/total_running_time_sec"))
defineProperty("main_menu_subpanel", globalPropertyi("sim/custom/xap/An24_panels/main_menu_subpanel"))
defineProperty("GS", globalPropertyf("sim/flightmodel/position/groundspeed"))  -- ground speed

local last_time = 0
local cur_time = 0.0

--7 - окончательный 1 - первое приветствие 2 - отключение питания от рации (простой шип) 3 - напоминание что не закрыто не убрано
--4- запрос апы 5- отключение апы 6 - повторное приветствие
local energy = 0
local check = 0
local check2 = 0	
local check3 = 0
local checktrue = 0
local offmain = 0

-- initial switchers values
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local time_counter = 0
local not_loaded = true

function update()


	time_counter = time_counter + get(frame_time)
	if get(N1) < 70 and get(N2) < 70 and time_counter > 0.3 and time_counter < 0.4 and not_loaded then
		set(bus_DC_27_volt, 0)
		set(main_menu_subpanel, 0)
		set(frequence, 13080)
		set(service_subpanel, 0)
		set(ground_sound, 0)
		check = 0
		check2 = 0
		check3 = 0
		not_loaded = false
	end	
  


			    if check3 == 0 then
					cur_time = get(time_sim1) + 1
					check3 = 1
				end
				if get(time_sim1) > cur_time then 
				
if get(GS) < 2 then
 
if get(emerg1) == 0 and get(emerg2) == 0 and get(cargo1) == 0 and get(cargo2) == 0 and get(paxdoor) == 0 and get(ground_available) == 0 
and get(left_eng_main) == 1 and get(left_eng_ext) == 1 and get(right_eng_ext) == 1 and get(right_eng_main) == 1 and get(ru19_eng_ext) == 1 and get(antiice_left)==1
and get(antiice_right) == 1 and get(rockets) == 1 and get(pitot_1) == 1 and get(pitot_2)==1 and get(pitot_3)==1 and get(grounding) == 1 and get(gear_blocks) == 1 then
		checktrue = 1
		else
		checktrue = 0
		end

if get(bus_DC_27_volt) > 21 then energy = 1 else energy = 0 end

if (get(frequence) == 13180) and (energy == 1) and (get(service_subpanel)==0) then
     if check == 0 then 
	 set(ground_sound,1) 
	 set(service_subpanel, 1) 
	 check = 1
	 else
     set(ground_sound,6)
	 set(service_subpanel, 1) 
	 check2 = 0
	 end
  	
    end

	if get(frequence) == 13180 and energy == 0 and get(service_subpanel)==0 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) end
	if get(frequence) ~= 13180 and energy == 0 and get(service_subpanel)==0 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) end
	if get(frequence) == 13180 and energy == 0 and check==1 and get(service_subpanel)==1 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) set(service_subpanel, 0) end
	if get(frequence) ~= 13180 and energy == 1 and checktrue == 1 and check==1 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,7) check = 0 end
	if get(frequence) ~= 13180 and energy == 1 and checktrue == 0 and check==1 and check2 == 0 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,3) check2 = 1 end
	
	else
	if get(frequence) == 13180 and energy == 0 and get(service_subpanel)==0 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) end
	if get(frequence) ~= 13180 and energy == 0 and get(service_subpanel)==0 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) end
	if get(frequence) == 13180 and energy == 0 and check==1 and get(service_subpanel)==1 and get(ground_sound)~=4 and get(ground_sound)~=5 then set(ground_sound,2) set(service_subpanel, 0) end
	if get(frequence) ~= 13180 and energy == 1 and checktrue == 1 and check==1 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,7) check = 0 end
	if get(frequence) ~= 13180 and energy == 1 and checktrue == 0 and check==1 and check2 == 0 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,3) check2 = 1 end
	if get(frequence) == 13180 and energy == 1 and checktrue == 0 and check==1 and check2 == 0 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,3) check2 = 1 end
	if get(frequence) == 13180 and energy == 1 and checktrue == 1 and check==1 and get(service_subpanel)==1 then set(service_subpanel, 0) set(ground_sound,7) check = 0 end
    
	end
	check3 = 0 
	end	
end
