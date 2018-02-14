--search and include KLN 90, if it exist in Custom Avionics



defineProperty("kln_is_present", globalPropertyi("sim/custom/kln_is_present"))


createProp("sim/custom/kln_power", "int", 1);
defineProperty("kln_power", globalPropertyi("sim/custom/kln_power"));
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt")) 


local coded = componentFileName == "KLN90_enabler.sec"
local filename1 = "Output/FMS plans/KLN 90B/0.fms"
local filename2 = "KLN 90B Navdata/database.txt"
-- check if KLN main file is present and enable it if so.
if (isFileExists(panelDir.."/Custom Avionics/KLN90.lua") and not coded) or (isFileExists(panelDir.."/Custom Avionics/KLN90.sec") and coded) then 
	print("found KLN90, trying to open it")
	if isFileExists(filename1)==true and isFileExists(filename2)==true then
		--set(kln_is_present, 1)
		
	end
	-- include("KLN90.lua") 
	-- decided to exclude the 2D panel and use only 3D one.
end

function update()
	-- KLN power calculation
	if get(bus_DC_27_volt) > 19 then set(kln_power, 1) else set(kln_power, 1) end

end
