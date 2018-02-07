--Scripts for FMOD 3D sound

defineProperty("int_cutoff", globalPropertyf("autumnsky/sound/interier_cutoff"))  -- cutoff detector
defineProperty("emerg1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[8]"))  -- open/close emerg_hatch1
defineProperty("emerg2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[9]"))  -- open/close emerg_hatch2
defineProperty("cargo1", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[4]"))  -- open/close cargo_hatch1
defineProperty("cargo2", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[6]"))  -- open/close cargo_hatch2
defineProperty("paxdoor", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[5]"))  -- open/close pax_door
defineProperty("leftwind", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[2]"))  -- open/close leftwindow
defineProperty("rightwind", globalPropertyf("sim/flightmodel2/misc/custom_slider_ratio[3]"))  -- open/close rightwindow
defineProperty("cabin_hatch", globalPropertyf("parshukovedition/lukbesson"))  -- open/close cabin hatch
local flag2=0
local flag1=0
function update()
	if get(emerg1) < 0.5 and get(emerg2) < 0.5 and get(cargo1) < 0.5 and get(cargo2) < 0.5 and get(paxdoor) < 0.5 and get(leftwind) < 0.5 and get(rightwind) < 0.5 and get(cabin_hatch) < 1 then
		if get(int_cutoff)>0.2 then
			set(int_cutoff,get(int_cutoff)-0.2)
		elseif get(int_cutoff)<=0.2 then
			set(int_cutoff,0)
		end
	elseif get(cabin_hatch) > 0.5 or get(leftwind) > 0.5 or get(rightwind) > 0.5 then
		if get(int_cutoff)<2.8 then
			set(int_cutoff,get(int_cutoff)+0.2)
		elseif get(int_cutoff)>=2.8 then
			set(int_cutoff,3)
		end
	elseif (get(cargo1) > 0.5 or get(emerg1) > 0.5) then
		if get(int_cutoff)>2.2 then
			set(int_cutoff,get(int_cutoff)-0.2)
			flag2=1
		elseif get(int_cutoff)<=2.2 and flag2==1 then
			set(int_cutoff,2)
			flag2=0
		elseif get(int_cutoff)<2 and flag2==0 then
			set(int_cutoff,get(int_cutoff)+0.2)
		end
	elseif get(paxdoor) > 0 or get(cargo2) > 0 or get(emerg2) > 0 then
		if get(int_cutoff)>1.2 then
			set(int_cutoff,get(int_cutoff)-0.2)
			flag1=1
		elseif get(int_cutoff)<=1.2 and flag1==1 then
			set(int_cutoff,1)
			flag1=0
		elseif get(int_cutoff)<1 and flag1==0 then
			set(int_cutoff,get(int_cutoff)+0.2)
		end	
	end
end
