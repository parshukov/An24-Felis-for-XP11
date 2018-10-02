print("it's An24 version 3.5.8 Parnik Simulations")
size = { 2048, 2048 }

-- 3D panel issue workaround
fixedPanelWidth = 2048
fixedPanelHeight = 2048
local a=0
-- check sim version
createProp("sim/custom/xap/sim_version", "int", 9);
defineProperty("sim_version", globalPropertyi("sim/custom/xap/sim_version"))  -- saved sim version

defineProperty("sim_v", globalPropertys("sim/version/sim_build_string"))  -- sim version
lightsprefs_sett = {}
local line
local text_version = get(sim_v)

print("sim build date:", text_version)

local a = 1
local b = string.find(text_version, " ", a)
local vers_month = string.sub(text_version, a, b)
a = b+2
b = string.find(text_version, " ", a)
local vers_date = tonumber(string.sub(text_version, a, b))
a = b+1
b = string.find(text_version, " ", a)
local vers_year = tonumber(string.sub(text_version, a, b))

print("sim year is", vers_year)
if vers_year >= 2012 then set(sim_version, 10) end
function CCom(Comref)
    --Send only strings, and comDose can == 1 for default description
    --Will return the find command
    createCommand(Comref, "No decription given")
    return findCommand(Comref)
end

function regCom(CommandName,FuncName)
    --shortens the registering process.
    registerCommandHandler(CommandName, 1, FuncName);
end



--[[
-- Gizmo workaround
local gizmo_id = findPluginBySignature("http://github.com/benrussell/Gizmo")
print(gizmo_id, "\n")
local was_gizmo = false
if gizmo_id ~= -1  then
	if isPluginEnabled(gizmo_id) then 
		was_gizmo = true 
		print("disabling Gizmo", getPluginInfo(gizmo_id)) 
		disablePlugin(gizmo_id) 
	end
end

function onAvionicsDone()
	if was_gizmo and enablePlugin(gizmo_id) == 1 then print("Gizmo enabled again") end
end
--]]
---

-------------------------------------------------------
-- create custom variables for new logic and animation
-------------------------------------------------------
-- all initial values  defined for ON case. if aircraft is loaded as Cold&Dark - all variables will switch to OFF position

createProp("sim/custom/xap/An24_time/frame_time", "float", 0);

-----------------------------
-- power logic --
-----------------------------
-- buses
-- bus parameters
createProp("sim/custom/xap/An24_power/bus_DC_27_volt", "float", 27);



--createProp("parshukovedition/lightarray", "float[12]");


createProp("parshukovedition/test_lamp_pilot", "int", 0);
createProp("parshukovedition/test_lamp_pilot1_switch", "int", 0);
createProp("parshukovedition/test_lamp_pilot2_switch", "int", 0);

-----Lights in the cockpit
createProp("parshukovedition/overhead_lamp_left_mode", "int", 0);  --0 off, 1 red, 2 white
createProp("parshukovedition/overhead_lamp_left_bright", "float", 1);
createProp("parshukovedition/overhead_lamp_left_rot_updown", "float", 45);
createProp("parshukovedition/overhead_lamp_left_rot_around", "float", 0);

createProp("parshukovedition/overhead_lamp_right_mode", "int", 0);  --0 off, 1 red, 2 white
createProp("parshukovedition/overhead_lamp_right_bright", "float", 1);
createProp("parshukovedition/overhead_lamp_right_rot_updown", "float", 45);
createProp("parshukovedition/overhead_lamp_right_rot_around", "float", 0);


createProp("parshukovedition/overhead_lamp_pilot_right_mode", "int", 0);  --0 off, 1 red, 2 white
createProp("parshukovedition/overhead_lamp_pilot_right_bright", "float", 1);
createProp("parshukovedition/overhead_lamp_pilot_right_rot_updown", "float", 45);
createProp("parshukovedition/overhead_lamp_pilot_right_rot_around", "float", 0);

createProp("parshukovedition/overhead_lamp_pilot_left_mode", "int", 0);  --0 off, 1 red, 2 white
createProp("parshukovedition/overhead_lamp_pilot_left_bright", "float", 1);
createProp("parshukovedition/overhead_lamp_pilot_left_rot_updown", "float", 45);
createProp("parshukovedition/overhead_lamp_pilot_left_rot_around", "float", 0);
createProp("sim/custom/kln_is_present", "int", 0) 




---------
createProp("parshukovedition/soundCap", "int", 0);
createProp("parshukovedition/switch/main_cabin_light", "int", 0);
createProp("parshukovedition/switch/main_cabin_light_mode", "float", 1);
createProp("parshukovedition/switch/main_cabin_light_modeL", "int", 0);
createProp("parshukovedition/switch/main_cabin_light_modeR", "int", 0);
createProp("parshukovedition/push/steward_mode", "int", 0);
createProp("parshukovedition/push/steward", "int", 0);
createProp("parshukovedition/misc/podnos", "float", 0);
createProp("parshukovedition/isalerton", "int", 0);
createProp("parshukovedition/lukbesson", "float", 0);
createProp("parshukovedition/lukbesson_switch", "int", 0);
createProp("parshukovedition/beacon_up", "int", 0);
createProp("parshukovedition/beacon_down", "int", 0);
createProp("parshukovedition/ssosstate", "int", 0);
createProp("parshukovedition/flightdeckdoor", "float", 0);
createProp("parshukovedition/flightdeckdoor_toggle", "float", 0);
createProp("parshukovedition/flightdeckdoor_state", "float", 0);
createProp("parshukovedition/msrplight", "int", 0);
createProp("parshukovedition/testmsrp", "int", 0);
createProp("parshukovedition/testmsrp_sound_switch", "int", 0);
createProp("parshukovedition/testmsrp_cap", "int", 0);
createProp("parshukovedition/testmsrp_sound_switch_cap", "int", 0);
createProp("parshukovedition/msrp_switch", "int", 0);
createProp("parshukovedition/msrp_sound_switch", "int", 0);
createProp("parshukovedition/msrp_switch_cap", "int", 0);
createProp("parshukovedition/msrp_sound_switch_cap", "int", 0);
createProp("parshukovedition/nosmokingswitch", "int", 0);
createProp("parshukovedition/nosmokingswitchonoff", "int", 0);
createProp("parshukovedition/autopilot_state_PF", "float", 0);
createProp("parshukovedition/autopilot_state_FO", "float", 0);
createProp("parshukovedition/autopilot_state_PF_button", "int", 0);
createProp("parshukovedition/autopilot_state_FO_button", "int", 0);
createProp("parshukovedition/autopilot_state_PF_ApbuttonState", "float", 3);
createProp("parshukovedition/autopilot_state_FO_ApbuttonState", "float", 3);
createProp("parshukovedition/An24_gauges/curse_angle", "float", 0);
createProp("parshukovedition/clocks/sec_mode", "float", 0);
createProp("parshukovedition/clocks/flight_mode", "float", 0);
createProp("parshukovedition/clocks/chrono_sec_angle", "float", 0);
createProp("parshukovedition/clocks/chrono_min_angle", "float", 0);
createProp("parshukovedition/clocks/flight_min_angle", "float", 0);
createProp("parshukovedition/clocks/flight_hour_angle", "float", 0);
createProp("parshukovedition/clocks/sec_time", "float", 0);
createProp("parshukovedition/clocks/flight_time", "float", 0);
createProp("parshukovedition/clocks/start_sec", "float", 0);
createProp("parshukovedition/clocks/start_flight", "float", 0);


--FMOD by AutumnSky for cutoff cockpit
createProp("autumnsky/sound/interier_cutoff", "float", 0); -- 0- all close, 1- distant open 2 - middle open 3 - cockpit open
createProp("autumnsky/sound/gndsound", "int", 0);
createProp("autumnsky/sound/fmodvol", "float", 0); -- Main volume slider

--By Kirushin
createProp("sim/custom/xap/An24_gauges/nosewheel_mode_ready", "int", 0) 
createProp("sim/custom/xap/An24_gauges/nosewheel_mode_ready_delay", "int", 0); 
createProp("sim/custom/xap/An24_gauges/nosewheel_mode_time_to_ready", "int", 0);

createProp("sim/custom/xap/An24_power/bus_DC_27_amp", "float", 0);
createProp("sim/custom/xap/An24_power/bus_DC_27_volt_emerg", "float", 27);
createProp("sim/custom/xap/An24_power/bus_DC_27_amp_emerg", "float", 0);
createProp("sim/custom/xap/An24_power/bus_AC_36_volt", "float", 36);
createProp("sim/custom/xap/An24_power/bus_AC_36_amp", "float", 0);
createProp("sim/custom/xap/An24_power/bus_AC_115_volt", "float", 115);
createProp("sim/custom/xap/An24_power/bus_AC_115_amp", "float", 0);
-- inverters position
createProp("sim/custom/xap/An24_power/inv_PT1000_1", "int", 1);  -- inverters
createProp("sim/custom/xap/An24_power/inv_PT1000_2", "int", 0);
createProp("sim/custom/xap/An24_power/inv_PT750", "int", 1);
-- switchers
createProp("sim/custom/xap/An24_power/stg1_on_bus", "int", 1);  -- generator connected if 1 and dissconnected if 0
createProp("sim/custom/xap/An24_power/stg2_on_bus", "int", 1);
createProp("sim/custom/xap/An24_power/gs24_on_bus", "int", 1);
createProp("sim/custom/xap/An24_power/go1_on_bus", "int", 1);  -- generator connected if 1 and dissconnected if 0
createProp("sim/custom/xap/An24_power/go2_on_bus", "int", 1);
-- logic
createProp("sim/custom/xap/An24_power/main_on_emerg", "int", 1);  -- main bus connected to emergency bus
createProp("sim/custom/xap/An24_power/DC_source", "int", 1);  -- source for DC27v bus. 0 = Ground, 1 = STG1, 2 = STG2, 3 = GS24, 4 = bat. left gen by default
createProp("sim/custom/xap/An24_power/AC_source", "int", 1);  -- source for AC115 bus. 0 = Ground, 1 = generators, 2 = inverter
-- batteries
createProp("sim/custom/xap/An24_power/bat1_volt", "float", 24); -- battery voltage, initial 24V - full charge.
createProp("sim/custom/xap/An24_power/bat2_volt", "float", 24);
createProp("sim/custom/xap/An24_power/bat3_volt", "float", 24);
createProp("sim/custom/xap/An24_power/bat1_amp", "float", 0);  -- battery current, initial 0A. positive - battery load, negative - battery recharge.
createProp("sim/custom/xap/An24_power/bat2_amp", "float", 0);
createProp("sim/custom/xap/An24_power/bat3_amp", "float", 0);
createProp("sim/custom/xap/An24_power/bat_all_amp", "float", 0); -- overall load of batteries
createProp("sim/custom/xap/An24_power/bat_all_volt", "float", 0); -- overall voltage of batteries
createProp("sim/custom/xap/An24_power/bat1_on", "int", 1);  -- battery switch. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_power/bat2_on", "int", 1);
createProp("sim/custom/xap/An24_power/bat3_on", "int", 1);
createProp("sim/custom/xap/An24_power/bat_amp_cc", "float", 0);  -- shows if batteries are produces power
-- generators
createProp("sim/custom/xap/An24_power/stg1_volt", "float", 28.5);  -- generator STG18 voltage. initial 28.5V
createProp("sim/custom/xap/An24_power/stg2_volt", "float", 28.5);
createProp("sim/custom/xap/An24_power/gs24_volt", "float", 28.5);  -- generator GS-24
createProp("sim/custom/xap/An24_power/go1_volt", "float", 115);  -- generator GO-16 voltage. initial 115V
createProp("sim/custom/xap/An24_power/go2_volt", "float", 115);
createProp("sim/custom/xap/An24_power/stg1_amp", "float", 0);  -- generator current, initial 0A
createProp("sim/custom/xap/An24_power/stg2_amp", "float", 0);
createProp("sim/custom/xap/An24_power/gs24_amp", "float", 0);
createProp("sim/custom/xap/An24_power/go1_amp", "float", 0);  -- generator current, initial 0A
createProp("sim/custom/xap/An24_power/go2_amp", "float", 0);
createProp("sim/custom/xap/An24_power/stg1_amp_cc", "float", 0);  -- generator current consumption as starter, initial 0A
createProp("sim/custom/xap/An24_power/stg2_amp_cc", "float", 0);
createProp("sim/custom/xap/An24_power/gs24_amp_cc", "float", 0);
createProp("sim/custom/xap/An24_power/stg1_on", "int", 1);  -- generator connected to engine if 1 and dissconnected if 0
createProp("sim/custom/xap/An24_power/stg2_on", "int", 1);
createProp("sim/custom/xap/An24_power/stg1_is_gen", "int", 1); -- generator can work as starter for his engine, if this variable = 0.
createProp("sim/custom/xap/An24_power/stg2_is_gen", "int", 1);
createProp("sim/custom/xap/An24_power/gs24_is_gen", "int", 1);
createProp("sim/custom/xap/An24_power/stg1_starter", "int", 0); -- generator can work as starter for his engine, if this variable = 0.-- generator worknig as starter
createProp("sim/custom/xap/An24_power/stg2_starter", "int", 0);
createProp("sim/custom/xap/An24_power/gs24_starter", "int", 0);

-- electric panel switchers
createProp("sim/custom/xap/An24_power/AC36_volt_mode", "int", 0);  -- mode switcher for AC 36 voltmeter, 9 positions 0-8
createProp("sim/custom/xap/An24_power/AC115_volt_mode", "int", 0);  -- mode switcher for AC 115 voltmeter, 7 positions 0-6
createProp("sim/custom/xap/An24_power/DC_volt_mode", "int", 2);  -- mode switcher for DC voltmeter, 11 positions 0-10
createProp("sim/custom/xap/An24_power/PT1000_mode", "int", 2);  -- switcher for PT1000. 0 = emerg, 1 = off, 2 = on
createProp("sim/custom/xap/An24_power/PO750_mode", "int", 2);  -- switcher for PO750. 0 = ground, 1 = off, 2 = on
createProp("sim/custom/xap/An24_power/GS24_mode", "int", 2);  -- start from: 0 = ground power, 1 = off, 2 = GS24
createProp("sim/custom/xap/An24_power/power_mode", "int", 2);  -- power mode: 0 = Ground, 1 = off, 2 = airplane
createProp("sim/custom/xap/An24_power/emerg_mode", "int", 1);  -- switcher for emergency power. 0 = auto, 1 = on main bus, 2 = emergency bus only
createProp("sim/custom/xap/An24_power/STG_disconnect_cap1", "int", 0);  -- red cap for STG disconnectiong button
createProp("sim/custom/xap/An24_power/STG_disconnect_cap2", "int", 0);  -- red cap for STG disconnectiong button
createProp("sim/custom/xap/An24_power/emerg_cap", "float", 0);  -- red cap for emergency mode switcher
-- ground power
createProp("sim/custom/xap/An24_power/ground_available", "int", 0);  -- boolean, shows if ground power available

-----------------------------
-- Smart Copilot Sync --
-----------------------------
-- KPPM
createProp("sim/custom/xap/An24_gauges/scale_angle_1_smartcopilot", "float", 0); -- kppm1 sync
createProp("sim/custom/xap/An24_gauges/scale_angle_2_smartcopilot", "float", 0); -- kppm2 sync
createProp("sim/custom/xap/An24_gauges/rotate_dir_1_smartcopilot", "int", 0); -- kppm1 rotary sync
createProp("sim/custom/xap/An24_gauges/rotate_dir_2_smartcopilot", "int", 0); -- kppm1 rotary sync
createProp("sim/custom/xap/An24_gauges/sc_KPPM_1_curse_angle", "float", 0);
createProp("sim/custom/xap/An24_gauges/sc_KPPM_2_curse_angle", "float", 0);
-- ZK-52
createProp("sim/custom/xap/An24_gauges/zk_scale_angle_smartcopilot", "float", 0);
createProp("sim/custom/xap/An24_gauges/zk_rotate_dir_smartcopilot", "int", 0);
createProp("sim/custom/xap/An24_gauges/sc_ZK_curse_angle", "float", 0);

-- art_horizons
createProp("sim/custom/xap/An24_set/arrest_third", "int", 0);
createProp("sim/custom/xap/An24_set/right_agd_arrest", "int", 0);
createProp("sim/custom/xap/An24_set/left_agd_arrest", "int", 0);

-- GPK
createProp("sim/custom/xap/An24_gauges/sc_corr_angle", "float", 0);
createProp("sim/custom/xap/An24_gauges/sc_corr_ap_angle", "float", 0);
createProp("sim/custom/xap/An24_gauges/sc_curse_angle", "float", 0);
createProp("sim/custom/xap/An24_gauges/sc_ap_curse_angle", "float", 0);
-- GIK
createProp("sim/custom/xap/An24_gauges/sc_angle", "float", 0);
createProp("sim/custom/xap/An24_gauges/sc_ap_angle", "float", 0);


-----------------------------
-- hydraulic logic --
-----------------------------


createProp("sim/custom/xap/An24_hydro/main_press", "float", 100);  -- pressure in main system. initial 120 kg per square sm. maximum 160.
createProp("sim/custom/xap/An24_hydro/emerg_press", "float", 100);  -- pressure in emergency system. initial 120 kg per square sm. maximum 160.
createProp("sim/custom/xap/An24_hydro/hydro_quantity", "float", 28);  -- quantity of hydraulic liquid. initially 28 liters. in work downs to 21 liters. also can flow out in come case of failure.
createProp("sim/custom/xap/An24_hydro/hydro_store", "float", 100);  -- pressure in main hydro storage
createProp("sim/custom/xap/An24_hydro/brake_press", "float", 60);  -- pressure in braking system with hydrostorage
createProp("sim/custom/xap/An24_hydro/emerg_brake", "float", 0);  -- pressure in braking system
createProp("sim/custom/xap/An24_hydro/hydro_circle", "int", 0);  -- connect main and emergency feeds

createProp("sim/custom/xap/An24_hydro/frontgear_use_hydro", "int", 1);  -- front gear steering manipulates by hydraulic system
createProp("sim/custom/xap/An24_hydro/gear_valve", "int", 0);  -- position of gear valve for gydraulic calculations and animations
createProp("sim/custom/xap/An24_hydro/gear_rotary", "int", 0);  -- position of gear rotary, that blocks gear valve for gydraulic calculations and animations
createProp("sim/custom/xap/An24_hydro/direction", "int", 0); -- -- gear request ( used for SmartCopilot )
createProp("sim/custom/xap/An24_hydro/gear_unblock", "int", 0);  -- remove block from gear retraction on ground
createProp("sim/custom/xap/An24_hydro/gear_unblock_cap", "int", 0);  -- cap for remove block from gear retraction on ground
createProp("sim/custom/xap/An24_hydro/flaps_valve", "int", 0);  -- position of flap valve for gydraulic calculations and animations
createProp("sim/custom/xap/An24_hydro/flaps_valve_emerg", "int", 0);  -- position of flap valve for emergensy flap deploy
createProp("sim/custom/xap/An24_hydro/flaps_valve_emerg_cap", "int", 0);  -- position of cap of flap valve for emergensy flap deploy
createProp("sim/custom/xap/An24_hydro/flaps_rotary", "int", 0);  -- position of flaps rotary, that blocks gear valve for gydraulic calculations and animations
createProp("sim/custom/xap/An24_hydro/emerg_pump_sw", "int", 0);  -- emergency hydro pump switcher. if its ON and power exist - emergency bus will gain pressure
createProp("sim/custom/xap/An24_hydro/abs_sw", "int", 0);  -- switcher for AntiBlocking System
-- elecrical part
createProp("sim/custom/xap/An24_hydro/pump_cc", "float", 0);  -- emergency pump current consumption
createProp("sim/custom/xap/An24_hydro/flap_cc", "float", 0);  -- flaps current consumption
-- for 2d panels
createProp("sim/custom/xap/An24_hydro/main_press_angle", "float", 0);  --
createProp("sim/custom/xap/An24_hydro/emerg_press_angle", "float", 0);  --
createProp("sim/custom/xap/An24_hydro/store_press_angle", "float", 0);  --
createProp("sim/custom/xap/An24_hydro/left_press_angle", "float", 0);  --
createProp("sim/custom/xap/An24_hydro/right_press_angle", "float", 0);  --
createProp("sim/custom/xap/An24_hydro/hydro_quantity_angle", "float", 0);  --
-----------------------------
-- fuel logic --
-----------------------------
createProp("sim/custom/xap/An24_fuel/fire_valve1", "float", 1);  -- fire valve for engine 1
createProp("sim/custom/xap/An24_fuel/fire_valve2", "float", 1);  -- fire valve for engine 2
createProp("sim/custom/xap/An24_fuel/fire_valve3", "float", 0);  -- fire valve for engine 3
createProp("sim/custom/xap/An24_fuel/fire_valve1_sw", "int", 1);  -- fire valve switch for engine 1
createProp("sim/custom/xap/An24_fuel/fire_valve2_sw", "int", 1);  -- fire valve switch for engine 2
createProp("sim/custom/xap/An24_fuel/fire_valve3_sw", "int", 0);  -- fire valve switch for engine 3
createProp("sim/custom/xap/An24_fuel/fuel_circle_valve_sw", "int", 0);  -- valve for fuel circulation between left and right tanks
createProp("sim/custom/xap/An24_fuel/fuel_circle_valve", "int", 0);  -- valve for fuel circulation between left and right tanks
createProp("sim/custom/xap/An24_fuel/pump1_switch", "int", 2);  -- switcher for fuel pump 1
createProp("sim/custom/xap/An24_fuel/pump2_switch", "int", 1);  -- switcher for fuel pump 2
createProp("sim/custom/xap/An24_fuel/pump3_switch", "int", 1);  -- switcher for fuel pump 3
createProp("sim/custom/xap/An24_fuel/pump4_switch", "int", 2);  -- switcher for fuel pump 4
createProp("sim/custom/xap/An24_fuel/q_meter1_switch", "int", 1);  -- switcher for quantity meter left
createProp("sim/custom/xap/An24_fuel/q_meter2_switch", "int", 1);  -- switcher for quantity meter right
createProp("sim/custom/xap/An24_fuel/ff_meter_switch", "int", 1);  -- switcher for fuel flow meter
createProp("sim/custom/xap/An24_fuel/auto_ff_switch", "int", 1);  -- switcher for fuel flow automat
createProp("sim/custom/xap/An24_fuel/auto_ff", "int", 1);  -- automatic fuel flow
createProp("sim/custom/xap/An24_fuel/quantity_mode", "int", 1);  -- mode of quantity meter
createProp("sim/custom/xap/An24_fuel/tank1_q_ind", "float", 0);  -- quantity indication
createProp("sim/custom/xap/An24_fuel/tank2_q_ind", "float", 0);  -- quantity indication
createProp("sim/custom/xap/An24_fuel/tank3_q_ind", "float", 0);  -- quantity indication
createProp("sim/custom/xap/An24_fuel/tank4_q_ind", "float", 0);  -- quantity indication
createProp("sim/custom/xap/An24_fuel/tank1_pump", "int", 1);  -- fake fuel pump
createProp("sim/custom/xap/An24_fuel/tank2_pump", "int", 1);  -- fake fuel pump
createProp("sim/custom/xap/An24_fuel/tank3_pump", "int", 1);  -- fake fuel pump
createProp("sim/custom/xap/An24_fuel/tank4_pump", "int", 1);  -- fake fuel pump

createProp("sim/custom/xap/An24_fuel/fuel_access1", "float", 1);  -- result from fuel system for feed engines
createProp("sim/custom/xap/An24_fuel/fuel_access2", "float", 1);  -- result from fuel system for feed engines
createProp("sim/custom/xap/An24_fuel/fuel_access3", "float", 1);  -- result from fuel system for feed engines

createProp("sim/custom/xap/An24_fuel/fuel_stop1", "int", 1);  -- stops on center panel
createProp("sim/custom/xap/An24_fuel/fuel_stop2", "int", 1);  -- stops on center panel

createProp("sim/custom/xap/An24_fuel/fuel_stop1_cap", "int", 0);  -- stops on center panel cap
createProp("sim/custom/xap/An24_fuel/fuel_stop2_cap", "int", 0);  -- stops on center panel cap

createProp("sim/custom/xap/An24_fuel/quant_1000_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/left_filter_block_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/right_filter_block_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_circle_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/left_fuel_press_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/right_fuel_press_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/left_pk_open_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/right_pk_open_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/left_chip_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/right_chip_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_lump1_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_lump2_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_lump3_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_lump4_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_left_angle", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_right_angle", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_left_count", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_right_count", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_left_count_rot", "float", 675);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_flow_right_count_rot", "float", 675);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_quant1_angle", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_quant2_angle", "float", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/fuel_quant_button", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/ru19_pk_open_lit", "int", 0);  -- vars for 2D panel
createProp("sim/custom/xap/An24_fuel/ru19_pk_close_lit", "int", 0);  -- vars for 2D panel

-- electrical part
createProp("sim/custom/xap/An24_fuel/fuel_pumps_cc", "float", 0);  -- fuel pumps current consumption
createProp("sim/custom/xap/An24_fuel/fuel_valves_cc", "float", 0);  -- fuel valves current consumption
createProp("sim/custom/xap/An24_fuel/fuel_circle_cc", "float", 0);  -- fuel valves current consumption
createProp("sim/custom/xap/An24_fuel/fuel_meter_cc", "float", 0);  -- fuel meters current consumption
createProp("sim/custom/xap/An24_fuel/fuel_flow_cc", "float", 0);  -- fuel meters current consumption

-----------------
-- start panel --
-----------------
createProp("sim/custom/xap/An24_start/fuel_start1", "int", 1);  -- fuel starters
createProp("sim/custom/xap/An24_start/fuel_start2", "int", 1);  -- fuel starters
createProp("sim/custom/xap/An24_start/fuel_start3", "int", 1);  -- fuel starters
-- engines part
createProp("sim/custom/xap/An24_start/eng_start_btn", "int", 0);  -- start selected engine
createProp("sim/custom/xap/An24_start/start_at_ground_cap", "int", 0);  -- select start mode cap
createProp("sim/custom/xap/An24_start/start_at_ground", "int", 0);  -- select start mode
createProp("sim/custom/xap/An24_start/sel_left_right", "int", 0);  -- select engine to start
createProp("sim/custom/xap/An24_start/eng_start_mode", "int", 0);  -- select start mode. start or fail start
createProp("sim/custom/xap/An24_start/eng_start_stop", "int", 0);  -- button for stop start process
createProp("sim/custom/xap/An24_start/left_temp_check", "int", 0);  -- select temp check mode
createProp("sim/custom/xap/An24_start/right_temp_check", "int", 0);  -- select temp check mode
createProp("sim/custom/xap/An24_start/left_prt24_on", "int", 1);  -- PRT24 on
createProp("sim/custom/xap/An24_start/right_prt24_on", "int", 1);  -- PRT24 on

createProp("sim/custom/xap/An24_start/apd_work_lit", "int", 0);  -- lamp for apd
createProp("sim/custom/xap/An24_start/pt29_work_lit", "int", 0);  -- lamp for ru19 starter
createProp("sim/custom/xap/An24_start/strip_lit", "int", 0);  -- lamp for ru19 strip
createProp("sim/custom/xap/An24_start/ru19_N1", "float", 0);  -- virtual N1 for RU19

createProp("sim/custom/xap/An24_start/ru19_air_start_btn", "int", 0);  -- start at flight button
createProp("sim/custom/xap/An24_start/ru19_ground_start_btn", "int", 0);  -- start on ground button
createProp("sim/custom/xap/An24_start/ru19_ground_start_cap", "int", 0);  -- start on ground button cap
createProp("sim/custom/xap/An24_start/ru19_start_mode", "int", 0);  -- select start mode. start or fail start
createProp("sim/custom/xap/An24_start/ru19_start_stop", "int", 0);  -- stop button for ru19
createProp("sim/custom/xap/An24_start/ru19_start_main_sw", "int", 0);  -- main switcher for ru19
createProp("sim/custom/xap/An24_start/ru19_start_main_sw_cap", "int", 0);  -- main switcher for ru19

createProp("sim/custom/xap/An24_start/starter_volt", "float", 0);  -- starter voltage for engines start
createProp("sim/custom/xap/An24_start/starter_amp", "float", 0);  -- starter amperage for engines start

-- cowl flaps
createProp("sim/custom/xap/An24_cowl/flap_switch_L", "int", 1);  -- cowl flap manipulator switch
createProp("sim/custom/xap/An24_cowl/flap_switch_R", "int", 1);  -- cowl flap manipulator switch


--view
createProp("sim/custom/xap/An24_view/switch_view", "int", 0) -- switcher point of view
createProp("sim/custom/xap/An24_view/switch_vib", "int", 1) -- switcher vibration on ground and critical AoA 1-on 0-off

------------------
-- gauges --
------------------
createProp("sim/custom/xap/An24_gauges/iv41_sw", "int", 1);    -- iv41 power switcher
createProp("sim/custom/xap/An24_gauges/iv41_test", "int", 0);    -- iv41 test button
createProp("sim/custom/xap/An24_gauges/noseweel", "int", -1);    -- nose weel switcher
createProp("sim/custom/xap/An24_gauges/gear_siren", "int", 0);  -- landing gear siren
createProp("sim/custom/xap/An24_gauges/flaps_siren", "int", 0); -- flaps siren
createProp("sim/custom/xap/An24_gauges/uvid_30_sw", "int", 1);  -- switcher for UVID altimeter
createProp("sim/custom/xap/An24_gauges/uvid_30_cc", "float", 0);  -- current consumption of UVID-30
createProp("sim/custom/xap/An24_gauges/feet_meter_sw", "int", 1);  -- switcher for UVID altimeter
createProp("sim/custom/xap/An24_gauges/feet_meter_cc", "float", 0);  -- current consumption of UVID-30
createProp("sim/custom/xap/An24_gauges/rv_2_sw", "int", 1);  -- switcher for rv-2 radio-altimeter
createProp("sim/custom/xap/An24_gauges/rv_2_cc", "float", 0);  -- current consumption of rv-2 radio-altimeter
createProp("sim/custom/xap/An24_gauges/eup1_sw", "int", 1);  -- switcher for eup1 turn coordinator
createProp("sim/custom/xap/An24_gauges/eup1_cc", "float", 0);  -- current consumption of eup1 turn coordinator
createProp("sim/custom/xap/An24_gauges/AGB_left", "int", 1);  -- switcher for left artificial horizon
createProp("sim/custom/xap/An24_gauges/AGD_left", "int", 1);  -- switcher for left artificial horizon
createProp("sim/custom/xap/An24_gauges/AGD_right", "int", 1);  -- switcher for right artificial horizon
createProp("sim/custom/xap/An24_gauges/AHZ_cc", "float", 0);  -- AHZs current consumption
createProp("sim/custom/xap/An24_gauges/bkk_sw", "int", 1);  -- roll control unit
createProp("sim/custom/xap/An24_gauges/bkk_sw_cap", "int", 0);  -- roll control unit cap
createProp("sim/custom/xap/An24_gauges/bkk_check_sw", "int", 1);  -- roll control unit
createProp("sim/custom/xap/An24_gauges/bkk_check_sw_cap", "int", 0);  -- roll control unit cap
createProp("sim/custom/xap/An24_gauges/eup53_cc", "float", 0);  -- CC for turn indicator
createProp("sim/custom/xap/An24_gauges/eup53_sw", "int", 1);  -- turn indicator switcher
createProp("sim/custom/xap/An24_gauges/GIK_curse", "float", 0);  -- corrected GIK curse for indicators
createProp("sim/custom/xap/An24_gauges/GIK_cc", "float", 0);  -- current of GIK
createProp("sim/custom/xap/An24_gauges/GIK_button", "int", 0);  -- GIK button for sync
createProp("sim/custom/xap/An24_gauges/GIK_sw", "int", 1);  -- GIK power switcher
createProp("sim/custom/xap/An24_gauges/gyro_curse", "float", 0);  -- gyro GIK curse for indicators
createProp("sim/custom/xap/An24_gauges/GPK_curse", "float", 0);  -- corrected GPK curse for indicators
createProp("sim/custom/xap/An24_gauges/GPK_corr", "float", 0);  -- correction for GPK, calculated by panel
createProp("sim/custom/xap/An24_gauges/ap_GPK_corr", "float", 0);  -- correction for GPK, calculated by panel
createProp("sim/custom/xap/An24_gauges/GPK_cc", "float", 0);  -- current of GPK
createProp("sim/custom/xap/An24_gauges/GPK_sw", "int", 1);  -- GPK power switcher
createProp("sim/custom/xap/An24_gauges/GPK_corr_sw", "int", 1);  -- GPK  correction switcher
createProp("sim/custom/xap/An24_gauges/GPK_corr_rot", "int", 0);  -- GPK  correction rotary
createProp("sim/custom/xap/An24_gauges/gyro2_curse", "float", 0);  -- gyro GPK curse for indicators
createProp("sim/custom/xap/An24_gauges/GPK_lat", "float", 0);  -- latitude, sat on GPK panel
createProp("sim/custom/xap/An24_gauges/GPK_lat_rotary", "float", 0);  -- rotary for latitude setting on GPK
createProp("sim/custom/xap/An24_gauges/auasp_cc", "float", 0);  -- AUASP current consumption
createProp("sim/custom/xap/An24_gauges/auasp_sw", "int", 1);  -- AUASP switcher
createProp("sim/custom/xap/An24_gauges/auasp_warning", "int", 0);  -- AUASP warning
createProp("sim/custom/xap/An24_gauges/auasp_button", "int", 0);  -- AUASP check button
createProp("sim/custom/xap/An24_gauges/ssos_cc", "float", 0);  -- ssos current consumption
createProp("sim/custom/xap/An24_gauges/ssos_sw", "int", 0);  -- ssos switcher
createProp("sim/custom/xap/An24_gauges/ssos_power_lit", "int", 0);  -- ssos power lamp
createProp("sim/custom/xap/An24_gauges/ssos_sw_cap", "int", 0);  -- ssos switcher cap
createProp("sim/custom/xap/An24_gauges/ssos_test_sw", "int", 0);  -- ssos test switcher
createProp("sim/custom/xap/An24_gauges/ssos_warning", "int", 0);  -- ssos warning
createProp("sim/custom/xap/An24_gauges/radioalt", "float", 0);  -- radio altitude for SSOS
createProp("sim/custom/xap/An24_gauges/radioalt_dh", "int", 0);  -- radio altitude is decision height
createProp("sim/custom/xap/An24_gauges/ark_vor", "int", 0);  -- ARK/VOR switcher
createProp("sim/custom/xap/An24_gauges/dme_on", "int", 1);  -- DME power switcher
createProp("sim/custom/xap/An24_gauges/dme_cc", "float", 0);  -- DME power consumption
createProp("sim/custom/xap/An24_gauges/uprt_cc", "float", 0);  -- UPRT power consumption
createProp("sim/custom/xap/An24_gauges/oil_lamp1", "int", 0);  -- low oil quantity
createProp("sim/custom/xap/An24_gauges/oil_lamp2", "int", 0);  -- low oil quantity
createProp("sim/custom/xap/An24_gauges/nosewheel_mode_lamp", "int", 0);  -- lamp of nosewheel mode
createProp("sim/custom/xap/An24_gauges/siren_button", "int", 0);  -- button for temporary OFF sirene
createProp("sim/custom/xap/An24_gauges/spu_power_sw", "int", 1);  -- spu power switch
createProp("sim/custom/xap/An24_gauges/spu_mode", "int", 3);  -- spu rotary mode
createProp("sim/custom/xap/An24_gauges/feet_meter_press", "float", 29.92);  -- feet meter pressure. in.Hg
createProp("sim/custom/xap/An24_gauges/torque_left", "float", 0);  -- torque pressure 
createProp("sim/custom/xap/An24_gauges/torque_right", "float", 0);  -- torque pressure 
createProp("sim/custom/xap/An24_gauges/high_vibro", "int", 0);  -- high vibration
createProp("sim/custom/xap/An24_gauges/gear_down", "int", 0);  -- all gears down
createProp("sim/custom/xap/An24_gauges/roll_high", "int", 0);  -- to much roll
createProp("sim/custom/xap/An24_gauges/SSOS_alarm", "int", 0);  -- SSOS alarm

-- KursMP system
createProp("sim/custom/xap/An24_gauges/obs1_fromto", "int", 0);  -- obs from-to switcher
createProp("sim/custom/xap/An24_gauges/obs2_fromto", "int", 0);  -- obs from-to switcher
createProp("sim/custom/xap/An24_gauges/obs1_fromto_lit", "int", 0);  -- obs from-to lights. 0 = off, 1 = to, 2 = from
createProp("sim/custom/xap/An24_gauges/obs2_fromto_lit", "int", 0);  -- obs from-to lights
createProp("sim/custom/xap/An24_gauges/curs_mp1_sw", "int", 1);  -- KursMP power switcher
createProp("sim/custom/xap/An24_gauges/curs_mp2_sw", "int", 1);  -- KursMP power switcher
createProp("sim/custom/xap/An24_gauges/curs_mp_cc", "float", 0);  -- KursMP current consumption
createProp("sim/custom/xap/An24_gauges/k1_flag", "int", 1);  -- flag for course on left kppm
createProp("sim/custom/xap/An24_gauges/k2_flag", "int", 1);  -- flag for course on right kppm
createProp("sim/custom/xap/An24_gauges/g1_flag", "int", 1);  -- flag for glideslope on left kppm
createProp("sim/custom/xap/An24_gauges/g2_flag", "int", 1);  -- flag for glideslope on right kppm
createProp("sim/custom/xap/An24_gauges/curs_1", "float", 0);  -- KursMP course for left kppm
createProp("sim/custom/xap/An24_gauges/curs_2", "float", 0);  -- KursMP course for right kppm
createProp("sim/custom/xap/An24_gauges/glide_1", "float", 0);  -- KursMP glide for left kppm
createProp("sim/custom/xap/An24_gauges/glide_2", "float", 0);  -- KursMP glide for right kppm
createProp("sim/custom/xap/An24_gauges/sp_ils", "int", 1);  -- switcher between SP-50 and ILS system
createProp("sim/custom/xap/An24_gauges/nav_select", "int", 3);  -- selector between NAV1 and NAV2
createProp("sim/custom/xap/An24_gauges/vor_1", "float", 0);  -- VOR bearing
createProp("sim/custom/xap/An24_gauges/vor_2", "float", 0);  -- VOR bearing
createProp("sim/custom/xap/An24_gauges/mrp_cc", "float", 0);  -- marker reciver cc
createProp("sim/custom/xap/An24_gauges/mrp_mode", "int", 0);  -- marker reciver mode


-- transponder
createProp("sim/custom/xap/An24_sq/digit_1", "int", 0);  -- digit 1 for animation
createProp("sim/custom/xap/An24_sq/digit_2", "int", 0);  -- digit 2 for animation
createProp("sim/custom/xap/An24_sq/digit_3", "int", 0);  -- digit 3 for animation
createProp("sim/custom/xap/An24_sq/digit_4", "int", 0);  -- digit 4 for animation
createProp("sim/custom/xap/An24_sq/emerg", "int", 0);  -- emergency button
createProp("sim/custom/xap/An24_sq/sq_emerg_cap", "int", 0);  -- emergency button cap
createProp("sim/custom/xap/An24_sq/sq_sw", "int", 1);  -- power switcher
createProp("sim/custom/xap/An24_sq/sq_mode", "int", 0);  -- mode switcher
createProp("sim/custom/xap/An24_sq/sq_cc", "float", 0);  -- mode switcher

-- radiocompas
createProp("sim/custom/xap/An24_ark/ark1_button", "int", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark1_mode", "int", 1);  -- mode
createProp("sim/custom/xap/An24_ark/ark1_tune_fix", "int", 0);  -- mode
createProp("sim/custom/xap/An24_ark/ark1_band", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_band_fix", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_tune", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_fine_tune", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_ant_sw", "int", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark1_cc", "float", 0);  -- current
createProp("sim/custom/xap/An24_ark/ark1_angle", "float", 0);  -- result angle for needle
createProp("sim/custom/xap/An24_ark/ark1_signal", "float", 0);  -- result signal
createProp("sim/custom/xap/An24_ark/ark1_cw", "int", 1);  -- phone-CW switch. 1 = CW

createProp("sim/custom/xap/An24_ark/ark1_need_freq", "int", 0);  -- need freq
createProp("sim/custom/xap/An24_ark/ark1_band_need", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_tune_need", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark1_fine_tune_need", "int", 0);  -- knob

createProp("sim/custom/xap/An24_ark/ark2_button", "int", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark2_mode", "int", 1);  -- mode
createProp("sim/custom/xap/An24_ark/ark2_tune_fix", "int", 0);  -- mode
createProp("sim/custom/xap/An24_ark/ark2_band", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark2_band_fix", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark2_tune", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark2_fine_tune", "int", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark2_ant_sw", "int", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark2_cc", "float", 0);  -- buttons
createProp("sim/custom/xap/An24_ark/ark2_angle", "float", 0);  -- result angle for needle
createProp("sim/custom/xap/An24_ark/ark2_signal", "float", 0);  -- result signal
createProp("sim/custom/xap/An24_ark/ark2_cw", "int", 1);  -- phone-CW switch. 1 = CW

createProp("sim/custom/xap/An24_ark/ark2_need_freq", "int", 0);  -- need freq
createProp("sim/custom/xap/An24_ark/ark2_band_need", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark2_tune_need", "int", 0);  -- knob
createProp("sim/custom/xap/An24_ark/ark2_fine_tune_need", "int", 0);  -- knob


----------------
-- autopilot --
----------------
-- sources
createProp("sim/custom/xap/An24_ap/indicated_roll", "float", 0);  -- roll from AHZ
createProp("sim/custom/xap/An24_ap/indicated_pitch", "float", 0);  -- pitch from AHZ
createProp("sim/custom/xap/An24_ap/curse_gik", "float", 0);  -- curse diff from KPPM gauge -- CHECK this var!!!
createProp("sim/custom/xap/An24_ap/curse_gpk", "float", 0);  -- curse diff from KPPM gauge
createProp("sim/custom/xap/An24_ap/curse_zk", "float", 0);  -- curse diff from ZK2 gauge
createProp("sim/custom/xap/An24_ap/ap_power_cc", "float", 0);  -- autopilot power consumption
-- switchers
createProp("sim/custom/xap/An24_ap/ap_power", "int", 1);  -- power of AP
createProp("sim/custom/xap/An24_ap/ap_trim", "int", 1);  -- use trimmer of AP
createProp("sim/custom/xap/An24_ap/ap_ON", "int", 0);  -- main button for engage AP
createProp("sim/custom/xap/An24_ap/ap_kv", "int", 0);  -- button for altitude hold
createProp("sim/custom/xap/An24_ap/ap_horizont", "int", 0);  -- button to set horizontal position of plane
createProp("sim/custom/xap/An24_ap/ap_curse_stab", "int", 2);  -- switcher for curse stab. turn/GPK/GIK
createProp("sim/custom/xap/An24_ap/ap_pitch", "int", 0);  -- pitch control
createProp("sim/custom/xap/An24_ap/ap_pitch_sw", "int", 1);  -- engage pitch control
createProp("sim/custom/xap/An24_ap/ap_roll", "float", 0);  -- roll knob
-- lights
createProp("sim/custom/xap/An24_ap/ap_ready_lit", "int", 0);  -- ready light
createProp("sim/custom/xap/An24_ap/ap_on_lit", "int", 0);  -- AP engaged light
createProp("sim/custom/xap/An24_ap/ap_kv_lit", "int", 0);  -- alt stab engaged
createProp("sim/custom/xap/An24_ap/ap_up_lit", "int", 0);  -- AP feels UP forse on stab
createProp("sim/custom/xap/An24_ap/ap_down_lit", "int", 0);  -- AP feels DOWN forse on stab
createProp("sim/custom/xap/An24_ap/ap_ail_fail_lit", "int", 0);  -- aileron trim failed lamp
createProp("sim/custom/xap/An24_ap/ap_elev_fail_lit", "int", 0);  -- elevator trim failed lamp
-- controls
createProp("sim/custom/xap/An24_ap/ap_roll_diff", "float", 0);  -- difference between needed and current roll (bank)
createProp("sim/custom/xap/An24_ap/ap_pitch_diff", "float", 0);  -- difference between needed and current pitch
createProp("sim/custom/xap/An24_ap/ap_hdg_diff", "float", 0);  -- difference between needed and current heading
createProp("sim/custom/xap/An24_ap/ap_roll_power", "int", 0); -- power for aileron mechanic
createProp("sim/custom/xap/An24_ap/ap_pitch_power", "int", 0);  -- power for elevator mechanic
createProp("sim/custom/xap/An24_ap/ap_hdg_power", "int", 0);  -- power for rudder mechanic

createProp("sim/custom/xap/An24_ap/ap_roll_comm", "float", 0);  -- ap commanded roll position
createProp("sim/custom/xap/An24_ap/ap_pitch_comm", "float", 0);  -- ap commanded pitch position
createProp("sim/custom/xap/An24_ap/ap_yaw_comm", "float", 0);  -- ap commanded yaw position
createProp("sim/custom/xap/An24_ap/ap_yaw_spd", "float", 0);  -- ap commanded yaw speed

createProp("sim/custom/xap/An24_ap/ap_mech_off", "int", 0);  -- ap mechanic off
createProp("sim/custom/xap/An24_ap/ap_mech_off_cap", "int", 0);  -- ap mechanic off
-----------------
-- prop logic --
-----------------
createProp("sim/custom/xap/An24_prop/pitch_stop", "int", 0);  -- set up pitch mid stop
createProp("sim/custom/xap/An24_prop/pitch_stop_cap", "int", 1);  -- cap for set up pitch mid stop
createProp("sim/custom/xap/An24_prop/feather1_test1", "int", 0);  -- left prop feather test by IKM
createProp("sim/custom/xap/An24_prop/feather2_test1", "int", 0);  -- right prop feather test by IKM
createProp("sim/custom/xap/An24_prop/feather1_test2", "int", 0);  -- left prop feather test by reverse
createProp("sim/custom/xap/An24_prop/feather2_test2", "int", 0);  -- right prop feather test by reverse
createProp("sim/custom/xap/An24_prop/feather_test_cap", "int", 0); -- cap for feather tests
createProp("sim/custom/xap/An24_prop/feather1_button", "int", 0);  -- left prop feather test by IKM
createProp("sim/custom/xap/An24_prop/feather2_button", "int", 0);  -- right prop feather test by IKM
createProp("sim/custom/xap/An24_prop/pitch_stop_set", "int", 0);  -- set up pitch mid stop

-----------------------------------
-- anti-ice and air cond systems --
-----------------------------------
createProp("sim/custom/xap/An24_ice/rio_sw", "int", 0);  -- switcher for turn on ice detector
createProp("sim/custom/xap/An24_ice/window_ht_sw", "int", 0);  -- switcher for turn on window heat
createProp("sim/custom/xap/An24_ice/wing_ht_sw", "int", 0);  -- switcher for turn on wing heat
createProp("sim/custom/xap/An24_ice/prop_ht_sw", "int", 0);  -- switcher for turn on prop heat
createProp("sim/custom/xap/An24_ice/engine_ht_sw", "int", 0);  -- switcher for turn on engine heat
createProp("sim/custom/xap/An24_ice/pitot1_sw", "int", 0);  -- switcher for turn on pitot heat
createProp("sim/custom/xap/An24_ice/pitot2_sw", "int", 0);  -- switcher for turn on pitot heat
createProp("sim/custom/xap/An24_ice/aa_main_cc", "float", 0);  -- current consumption on main bus
createProp("sim/custom/xap/An24_ice/aa_emerg_cc", "float", 0);  -- current consumption on emerg bus
createProp("sim/custom/xap/An24_ice/aa_115_cc", "float", 0);  -- current consumption on ac 115v bus
createProp("sim/custom/xap/An24_ice/aoa_ht_sw", "int", 0);  -- switcher for turn on AOA heat

createProp("sim/custom/xap/An24_ice/wing_heat_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/engine_heat_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/prop_left_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/prop_right_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/pitot1_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/pitot2_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/aoa_heat_lit", "int", 0);  -- for 2D panel

createProp("sim/custom/xap/An24_ice/pitot1_test_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/pitot2_test_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/aoa_heat_test_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/rio_heat_lit", "int", 0);  -- for 2D panel

createProp("sim/custom/xap/An24_ice/ice_left_eng_lit", "int", 0);  -- for 2D panel
createProp("sim/custom/xap/An24_ice/ice_right_eng_lit", "int", 0);  -- for 2D panel

createProp("sim/custom/xap/An24_ice/thermo_angle", "float", 0);  -- for 2D panel

createProp("sim/custom/xap/An24_ice/test_btn", "int", 0);  -- for 2D panel

-----------------
-- fire system --
-----------------
createProp("sim/custom/xap/An24_fire/fire_main_switcher", "int", 1);  -- main switcher for fire system.
createProp("sim/custom/xap/An24_fire/fire_left_wing_btn", "int", 0);  -- fire in left wing button
createProp("sim/custom/xap/An24_fire/fire_left_wing_lit", "int", 0);  -- fire in left wing light
createProp("sim/custom/xap/An24_fire/fire_right_wing_btn", "int", 0);  -- fire in right wing button
createProp("sim/custom/xap/An24_fire/fire_right_wing_lit", "int", 0);  -- fire in right wing light
createProp("sim/custom/xap/An24_fire/fire_left_nacelle_btn", "int", 0);  -- fire in left nacelle button
createProp("sim/custom/xap/An24_fire/fire_left_nacelle_lit", "int", 0);  -- fire in left nacelle light
createProp("sim/custom/xap/An24_fire/fire_right_nacelle_btn", "int", 0);  -- fire in right nacelle button
createProp("sim/custom/xap/An24_fire/fire_right_nacelle_lit", "int", 0);  -- fire in right nacelle light
createProp("sim/custom/xap/An24_fire/fire_ru19_btn", "int", 0);  -- fire in ru19 button
createProp("sim/custom/xap/An24_fire/fire_ru19_lit", "int", 0);  -- fire in ru19 light

createProp("sim/custom/xap/An24_fire/fire_left_eng_lit", "int", 0);  -- fire in left engine light
createProp("sim/custom/xap/An24_fire/fire_right_eng_lit", "int", 0);  -- fire in right engine light

createProp("sim/custom/xap/An24_fire/ext_left_ready_lit", "int", 0);  -- left engine extinguisher ready
createProp("sim/custom/xap/An24_fire/ext_right_ready_lit", "int", 0);  -- right engine extinguisher ready
createProp("sim/custom/xap/An24_fire/ext_first_ready_lit", "int", 0);  -- furst turn extinguisher ready
createProp("sim/custom/xap/An24_fire/ext_second_ready_lit", "int", 0);  -- second turn extinguisher ready

createProp("sim/custom/xap/An24_fire/fire_left_eng_ext", "int", 0);  -- button for left engine fire extinguisher
createProp("sim/custom/xap/An24_fire/fire_left_eng_ext_cap", "int", 0);  -- cap for button for left engine fire extinguisher

createProp("sim/custom/xap/An24_fire/fire_right_eng_ext", "int", 0);  -- button for right engine fire extinguisher
createProp("sim/custom/xap/An24_fire/fire_right_eng_ext_cap", "int", 0);  -- cap for button for right engine fire extinguisher

createProp("sim/custom/xap/An24_fire/fire_second_ext", "int", 0);  -- button for second turn fire extinguisher
createProp("sim/custom/xap/An24_fire/fire_second_ext_cap", "int", 0);  -- cap for button for second turn fire extinguisher

createProp("sim/custom/xap/An24_fire/fire_warinig", "int", 0);  -- warning of fire

createProp("sim/custom/xap/An24_fire/fire_cc", "float", 0);  -- system cc

-------------------
-- radar logic --
-------------------
createProp("sim/custom/xap/An24_rls/rls_power_sw", "int", 1);  -- power switch
createProp("sim/custom/xap/An24_rls/rls_power_cc", "float", 0);  -- power consumption
createProp("sim/custom/xap/An24_rls/rls_scan_spd", "int", 50);  -- scan speed 1 - 10
createProp("sim/custom/xap/An24_rls/rls_scan_spd_up", "int", 0);  -- button pressed
createProp("sim/custom/xap/An24_rls/rls_scan_spd_down", "int", 0);  -- button pressed
createProp("sim/custom/xap/An24_rls/rls_mode", "int", 0);  -- radar mode. 0 - ready, 1 - meteo, 2 - slip
createProp("sim/custom/xap/An24_rls/rls_mode_lamp", "int", 0);  -- radar mode. 0 - ready, 1 - meteo, 2 - slip, 3 - none
createProp("sim/custom/xap/An24_rls/rls_bright", "float", 1);  -- overall brightness of monitor
createProp("sim/custom/xap/An24_rls/rls_contr", "float", 1);  -- overall contrast of monitor
createProp("sim/custom/xap/An24_rls/rls_signs", "float", 1);  -- overall brightness of signs on monitor


--------------------
-- trimm logic --
--------------------
createProp("sim/custom/xap/An24_trimm/rudd_sw", "int", 0);  -- rudder trimm switch
createProp("sim/custom/xap/An24_trimm/ail_sw", "int", 0);  -- aileron trimm switch
--createProp("sim/custom/xap/An24_trimm/rudd_center_lit", "int", 0);  -- rudder trimm at center light
--createProp("sim/custom/xap/An24_trimm/ail_center_lit", "int", 0);  --aileron trimm at center light
--createProp("sim/custom/xap/An24_trimm/rudd_trimm_off_lit", "int", 0);  -- rudder trimm ovned by AP
--createProp("sim/custom/xap/An24_trimm/ail_trimm_off_lit", "int", 0);  -- aileron trimm ovned by AP

--------------------
-- pressurisation --
--------------------
createProp("sim/custom/xap/An24_skv/bleed1_sw", "int", 1);  -- bleedair left
createProp("sim/custom/xap/An24_skv/bleed2_sw", "int", 1);  -- bleedair right
createProp("sim/custom/xap/An24_skv/dump_cap", "int", 0);  -- dump all cap
createProp("sim/custom/xap/An24_skv/dump_sw", "int", 0);  -- dump all switch
createProp("sim/custom/xap/An24_skv/skv_siren", "int", 0);  -- siren work
createProp("sim/custom/xap/An24_skv/skv_siren_alarm", "int", 0);  -- siren sound
--------------------
-- outer covers --
--------------------
createProp("sim/custom/xap/An24_covers/left_eng_main", "int", 1);  -- left engine main cover
createProp("sim/custom/xap/An24_covers/left_eng_ext", "int", 1);  -- left engine exhaust cover
createProp("sim/custom/xap/An24_covers/right_eng_main", "int", 1);  -- right engine main cover
createProp("sim/custom/xap/An24_covers/right_eng_ext", "int", 1);  -- right engine exhaust cover
createProp("sim/custom/xap/An24_covers/ru19_eng_ext", "int", 1);  -- ru19 engine exhaust cover
createProp("sim/custom/xap/An24_covers/antiice_left", "int", 1);  -- left anti-ice detector cover
createProp("sim/custom/xap/An24_covers/antiice_right", "int", 1);  -- right anti-ice detector cover
createProp("sim/custom/xap/An24_covers/rockets", "int", 1);  -- rockets cover
createProp("sim/custom/xap/An24_covers/pitot_1", "int", 1);  -- pitot 1
createProp("sim/custom/xap/An24_covers/pitot_2", "int", 1);  -- pitot 2
createProp("sim/custom/xap/An24_covers/pitot_3", "int", 1);  -- pitot 3
createProp("sim/custom/xap/An24_covers/grounding", "int", 1);  -- grounding wire
createProp("sim/custom/xap/An24_covers/gear_blocks", "int", 1);  -- gear blocks

--------------------
-- misc animation --
--------------------
createProp("sim/custom/xap/An24_misc/vent_1", "float", 0);  -- ventilator
createProp("sim/custom/xap/An24_misc/vent_2", "float", 0);  -- ventilator
createProp("sim/custom/xap/An24_misc/vent_3", "float", 0);  -- ventilator
createProp("sim/custom/xap/An24_misc/vent_4", "float", 0);  -- ventilator

createProp("sim/custom/xap/An24_misc/vent_1_sw", "int", 0);  -- ventilator switch
createProp("sim/custom/xap/An24_misc/vent_2_sw", "int", 0);  -- ventilator switch
createProp("sim/custom/xap/An24_misc/vent_3_sw", "int", 0);  -- ventilator switch
createProp("sim/custom/xap/An24_misc/vent_4_sw", "int", 0);  -- ventilator switch

createProp("sim/custom/xap/An24_misc/ag1_roll", "float", 0);  -- ag plane roll
createProp("sim/custom/xap/An24_misc/ag2_roll", "float", 0);  -- ag plane roll

createProp("sim/custom/xap/An24_misc/virt_rud1", "float", 0);  -- virtual rud
createProp("sim/custom/xap/An24_misc/virt_rud2", "float", 0);  -- virtual rud
createProp("sim/custom/xap/An24_misc/virt_rud3", "float", 0);  -- virtual rud

createProp("sim/custom/xap/An24_misc/aoa_sensor_angle", "float", 0);  -- angle of AOA sensor

createProp("sim/custom/xap/An24_misc/rud_close", "int", 1);  -- rud closeup for minimum at flight
createProp("sim/custom/xap/An24_misc/rud_close_ru19", "int", 1);  -- rud closeup for minimum at flight
createProp("sim/custom/xap/An24_misc/rud_close_pos", "int", 0);  -- rud closeup position for minimum at flight

createProp("sim/custom/xap/An24_misc/hide_yokes", "int", 0);  -- hide yokes in cockpit

createProp("sim/custom/xap/An24_misc/nav_light_sw", "int", 1);  -- nav lights and beacons switch
createProp("sim/custom/xap/An24_misc/lan_light_sw", "int", 0);  -- nav lights and beacons switch
createProp("sim/custom/xap/An24_misc/lan_light_open_sw", "int", 0);  -- nav lights and beacons switch
createProp("sim/custom/xap/An24_misc/nav_light", "float", 0);  -- nav light can shine
createProp("sim/custom/xap/An24_misc/beacon_light", "float", 0);  -- beacon light ratio
createProp("sim/custom/xap/An24_misc/nav_light_cc", "float", 0);  -- light current consumption
createProp("sim/custom/xap/An24_misc/bec_light_cc", "float", 0);  -- light current consumption
createProp("sim/custom/xap/An24_misc/lan_light_cc", "float", 0);  -- light current consumption
createProp("sim/custom/xap/An24_misc/cockpit_red", "float", 0);  -- red cockpit light rotary
createProp("sim/custom/xap/An24_misc/cockpit_spot1", "float", 0);  -- cockpit spotlight rotary
createProp("sim/custom/xap/An24_misc/cockpit_spot2", "float", 0);  -- cockpit spotlight rotary
createProp("sim/custom/xap/An24_misc/cockpit_panel", "int", 0);  -- cockpit panel
createProp("sim/custom/xap/An24_misc/cockpit_light_cc", "float", 0);  -- cockpit panel
-----------------------------
-- create subpanels --
-----------------------------
createProp("sim/custom/xap/An24_panels/nav1_subpanel", "int", 0);  -- nav1 panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/nav2_subpanel", "int", 0);  -- nav2 panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/electropanel_subpanel", "int", 0);  -- electropanel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/fuel_subpanel", "int", 0);  -- fuel_panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/left_subpanel", "int", 0);  -- left panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/ap_panel_subpanel", "int", 0);  -- ap_panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/right_subpanel", "int", 0);  -- right_panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/nl10m_subpanel", "int", 0);  -- nl10m_panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/radio_subpanel", "int", 0);  -- radio_panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/service_subpanel", "int", 0);  -- service_panel panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/payload_subpanel", "int", 0);  -- payload panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/options_subpanel", "int", 0);  -- options panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/main_menu_subpanel", "int", 1);  -- main menu panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/map_subpanel", "int", 0);  -- map panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/info_subpanel", "int", 0);  -- info panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/camera_subpanel", "int", 0);  -- camera panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/rsbn_subpanel", "int", 0);  -- rsbn panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/nas1_subpanel", "int", 0);  -- nas1 panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/uphone_subpanel", "int", 0);  -- uphone panel. 0 = OFF, 1 = ON
createProp("sim/custom/xap/An24_panels/fplan_subpanel", "int", 0);  -- uphone panel. 0 = OFF, 1 = ON

------------------------------
-- aircraft settings --
------------------------------
createProp("sim/custom/xap/An24_set/real_fuel_meter", "int", 1);  -- real fuel meter will show less fuel amount, then it's really is
createProp("sim/custom/xap/An24_set/real_ahz", "int", 1);  -- real ahz has errors and needs to be corrected
createProp("sim/custom/xap/An24_set/real_fire", "int", 1);  -- fire will affect wings and nearest mech
createProp("sim/custom/xap/An24_set/real_startup", "int", 1);  -- when start the engines a lot of thing must to be done
createProp("sim/custom/xap/An24_set/active_camera", "int", 1);  -- use of moveing camera
createProp("sim/custom/xap/An24_set/real_generators", "int", 1);  -- generators can fail if overload
createProp("sim/custom/xap/An24_set/real_gears", "int", 1);  -- gears can fail to retract or even brake
createProp("sim/custom/xap/An24_set/real_brakes", "int", 1);  -- brakes can overheat and fail
createProp("sim/custom/xap/An24_set/real_tyres", "int", 1);  -- tyres can blow if too much brakes
createProp("sim/custom/xap/An24_set/hide_GPS", "int", 1);  -- by default GPS is hided
createProp("sim/custom/xap/An24_set/hide_Garmin", "int", 1);  -- by default Garmin is hided
createProp("sim/custom/xap/An24_set/switch_rud", "int", 1);  -- switch or hold rud stopors
createProp("sim/custom/xap/An24_set/real_fuel", "int", 1);  -- switch for real fuel system or FSE compability
createProp("sim/custom/xap/An24_set/north_GPK", "int", 1);  -- GPK mode for north hemisphere
createProp("sim/custom/xap/An24_set/black_box", "int", 0);  -- flight data recording
------------------------------
-- RSBN --
------------------------------
createProp("sim/custom/xap/An24_rsbn/dataset", "int", 1); -- dataset, 0:CIS 1:USSR
createProp("sim/custom/xap/An24_rsbn/channel", "int", 0);
createProp("sim/custom/xap/An24_rsbn/receive", "int", 0);
createProp("sim/custom/xap/An24_rsbn/lat", "float", 0);
createProp("sim/custom/xap/An24_rsbn/lon", "float", 0);
createProp("sim/custom/xap/An24_rsbn/elev", "float", 0);
createProp("sim/custom/xap/An24_rsbn/defl", "float", 0);
createProp("sim/custom/xap/An24_rsbn/flag", "int", 0);
createProp("sim/custom/xap/An24_rsbn/rsbn_cc", "float", 0);  -- RSBN current consumption
------------------------------
-- NAS-1 --
------------------------------
createProp("sim/custom/xap/An24_nas1/nas1_cc", "float", 0);  -- NAS current consumption
createProp("sim/custom/xap/An24_nas1/N_needle", "float", 0);  -- NAS Nortneedle
createProp("sim/custom/xap/An24_nas1/E_needle", "float", 0);  -- NAS Eastneedle
createProp("sim/custom/xap/An24_nas1/counter", "float", 0);  -- NAS counterswitch
createProp("sim/custom/xap/An24_nas1/mode1", "float", 0);  -- NAS mode1
createProp("sim/custom/xap/An24_nas1/mode2", "float", 0);  -- NAS mode2
createProp("sim/custom/xap/An24_nas1/map_angle", "float", 0);  -- NAS map
createProp("sim/custom/xap/An24_nas1/water", "float", 0);  -- NAS water
createProp("sim/custom/xap/An24_nas1/DISS", "float", 1);
createProp("sim/custom/xap/An24_nas1/windangle", "float", 0);
createProp("sim/custom/xap/An24_nas1/windspeed", "float", 0);


-- window size issue for panels
defineProperty("window_height",globalPropertyi("sim/graphics/view/window_height"))
local coef = get(window_height) / 1024
if coef > 1 then coef = 1 end  -- set initial coefficient for float panel's size - make 'em smaller, if screen resolution less then 1024 by height.

defineProperty("closeImage", loadImage("close.png"))  -- close cross image

-- add nav1 subpanel
nav_panel1 = subpanel {
    position = { 40, 0, 532 * coef, 631 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "nav_panel1";
    components = {
		nav_panel_2d_1 {
         position = { 0, 0, 532 * coef, 631 * coef },
         };
		 textureLit {
		 position = {(532 - 16) * coef, (631 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add nav2 subpanel
nav_panel2 = subpanel {
    position = { 40, 0, 493 * coef, 687 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "nav_panel2";
    components = {
		nav_panel_2d_2 {
         position = { 0, 0, 493 * coef, 687 * coef },
         };
		 textureLit {
		 position = {(493 - 16) * coef, (687 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add electric subpanel
electropanel = subpanel {
    position = { 40, 0, 512 * coef, 870 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "electropanel";
    components = {
		electric_panel_2d {
         position = { 0, 0, 512 * coef, 870 * coef },
         };
		 textureLit {
		 position = {(512 - 16) * coef, (870 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add fuel subpanel
fuel_panel = subpanel {
    position = { 40, 0, 512 * coef, 725 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "fuel_panel";
    components = {
		fuel_panel_2d {
         position = { 0, 0, 512 * coef, 725 * coef },
         };
		 textureLit {
		 position = {(512 - 16) * coef, (725 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add left subpanel
left_panel = subpanel {
    position = { 40, 0, 983 * coef, 512 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "left_panel";
    components = {
		left_panel_2d {
         position = { 0, 0, 983 * coef, 512 * coef },
         };
		 oil_ind {
			position = {575 * coef, 360 * coef, 60 * coef, 120 * coef},
		},
		 textureLit {
		 position = {(983 - 16) * coef, (512 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add autopilot subpanel
ap_panel = subpanel {
    position = { 40, 0, 512 * coef, 380 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "ap_panel";
    components = {
		ap_panel_2d {
         position = { 0, 0, 512 * coef, 380 * coef },
         };
		 textureLit {
		 position = {(512 - 16) * coef, (380 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add autopilot subpanel
right_panel = subpanel {
    position = { 40, 0, 825 * coef, 430 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "right_panel";
    components = {
		right_panel_2d {
         position = { 0, 0, 825 * coef, 430 * coef },
         };
		 textureLit {
		 position = {(825 - 16) * coef, (430 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add NL-10m subpanel
nl10m_panel = subpanel {
    position = { 40, 0, 1280 * coef, 330 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "nl10m_panel";
    components = {
		nl10m {
         position = { 0, 0, 1280 * coef, 330 * coef },
         };
		 textureLit {
		 position = {(1280 - 16) * coef, (330 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add radio subpanel
radio_panel = subpanel {
    position = { 40, 0, 1015 * coef, 630 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "radio_panel";
    components = {
		radio_panel_2d {
         position = { 0, 0, 1015 * coef, 630 * coef },
         };
		 textureLit {
		 position = {(1015 - 16) * coef, (630 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add service subpanel
service_panel = subpanel {
    position = { 40, 0, 512 * coef, 512 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "service_panel";
    components = {
		service_panel_2d {
         position = { 0, 0, 512 * coef, 512 * coef },
         };
		 textureLit {
		 position = {(512 - 16) * coef, (512 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add map subpanel
map_panel = subpanel {
    position = { 40, 0, 530, 530 };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "map_panel";
    components = {
		map {
         position = { 0, 0, 530, 530 },
         };
	};
}

-- add payload subpanel
payload = subpanel {
    position = { 40, 0, 710 * coef, 990 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "payload";
    components = {
		payload_panel {
         position = { 0, 0, 710 * coef, 990 * coef },
         };
	textureLit {
		 position = {(710 - 16) * coef, (990 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add info subpanel
info_panel = subpanel {
    position = { 40, 470, 227, 256  };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "info_panel";
    components = {
		info_panel_2d {
         position = { 0, 0, 227, 256 },
         };
	textureLit {
		 position = {(227 - 16), (256 - 16), 16, 16},
		 image = get(closeImage),
		 };
	};
}

-- add options subpanel
options = subpanel {
    position = { 40, 20, 562 * coef, 512 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "options";
    components = {
		settings {
         position = { 0, 0, 562 * coef, 512 * coef },
         };
		textureLit {
		 position = {(562 - 16) * coef, (512 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}

-- add cam subpanel
camera = subpanel {
    position = { 40, 20, 256 * coef , 240 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "camera";
    components = {
		camera_panel {
         position = { 0, 0, 256 * coef, 240 * coef  },
         };
		textureLit {
		 position = {(256 - 16) * coef , (240 - 16) * coef , 16 * coef , 16 * coef },
		 image = get(closeImage),
		 };
	};
}

rsbn = subpanel {
    position = { 40, 20, 1024 * coef , 724 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "rsbn";
    components = {
		rsbn {
         position = { 0, 0, 1024 * coef, 724 * coef  },
         };
		textureLit {
 		 position = {(1024 - 16) * coef , (724 - 16) * coef , 16 * coef , 16 * coef },
		 image = get(closeImage),
		 };
	};
}
nas1 = subpanel {
    position = { 40, 20, 1024 * coef , 557 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "nas1";
    components = {
		nas1 {
         position = { 0, 0, 1024 * coef, 557 * coef  },
         };
		textureLit {
 		 position = {(1024 - 16) * coef , (557 - 16) * coef , 16 * coef , 16 * coef },
		 image = get(closeImage),
		 };
	};
}
uphone = subpanel {
    position = { 40, 20, 241 * coef , 446 * coef };
    noBackground = true;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "uphone";
    components = {
		UPhone {
         position = { 0, 0, 241 * coef, 446 * coef  },
         };
		textureLit {
 		 position = {(241 - 16) * coef , (446 - 16) * coef , 16 * coef , 16 * coef },
		 image = get(closeImage),
		 };
	};
}

flightplan = subpanel {
    position = { 40, 0, 473 * coef, 338 * coef };
    noBackground = false;
    noClose = true;
	movable = true;
	resizeble = true;
	resizeProportional = true;
	savePosition = true;
	name = "flightplan";
    components = {
		flightplan {
         position = { 0, 0, 473 * coef, 338 * coef },
         };
	textureLit {
		 position = {(473 - 16) * coef, (338 - 16) * coef, 16 * coef, 16 * coef},
		 image = get(closeImage),
		 };
	};
}


-- add menu subpanel
main_menu = subpanel {
    position = { 0, 100, 32, 485 };
    noBackground = true;
    noClose = true;
    noResize = true;
	movable = false;
	resizeble = false;
	resizeProportional = true;
	savePosition = false;
	name = "main_menu";
    components = {
		menu_panel {
         position = { 0, 0, 32, 485 },
		--panel_1 = main_menu,
		panel_2 = nav_panel1,
		panel_3 = nav_panel2,
		panel_4 = electropanel,
		panel_5 = fuel_panel,
		panel_6 = left_panel,
		panel_7 = right_panel,
		panel_8 = ap_panel,
		panel_9 = radio_panel,
		panel_10 = service_panel,
		panel_11 = payload,
		panel_12 = nl10m_panel,
		panel_13 = map_panel,
		panel_14 = options,
		panel_15 = info_panel,
		panel_16 = camera,
		panel_17 = rsbn,
		panel_18 = nas1,
		panel_19 = uphone,
		panel_20 = flightplan,

         };
	};
}

components = {

--------------------------
-- aircraft logic --
--------------------------

KLN90_enabler {},
parshukovupdate {},		
parshukovupdatesound {},
fmod_sound {},
call_ground {},
rsbn_logic {},
time_logic {},
flight_controls{},
batteries_logic {},
generators_logic {},
bus_counter {},
bus_logic {},
hydraulic_logic {},
gear_logic {},
flaps_logic {},
fuel_logic {},
gyro {},  -- gyro for GIK
gik_logic {},
gyro { -- gyro for GPK
	bus_DC_27_volt = globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"),
	switch = globalPropertyf("sim/custom/xap/An24_gauges/GPK_sw"),
	gyro_cc = globalPropertyf("sim/custom/xap/An24_gauges/GPK_cc"),
	fail = globalPropertyf("sim/operation/failures/rel_cop_dgy"),
	gyro_curse = globalPropertyf("sim/custom/xap/An24_gauges/gyro2_curse"),
	},
engine_logic {},
ap28_logic {},
ap_mech {},
misc_sounds {},
crew_bm {},
crew_nav {},
start_logic {},
fire_logic {},
siren_logic {},
noseweel_logic {},
aero_extra {},
view {},
flap_aero {},
failures {},
light_logic{},
vent {},

panel_logic {
	panel_1 = main_menu,
	panel_2 = nav_panel1,
	panel_3 = nav_panel2,
	panel_4 = electropanel,
	panel_5 = fuel_panel,
	panel_6 = left_panel,
	panel_7 = right_panel,
	panel_8 = ap_panel,
	panel_9 = radio_panel,
	panel_10 = service_panel,
	panel_11 = payload,
	panel_12 = nl10m_panel,
	panel_13 = map_panel,
	panel_14 = options,
	panel_15 = info_panel,
	panel_16 = camera,
	panel_17 = rsbn,
	panel_18 = nas1,
	panel_19 = uphone,
	panel_20 = flightplan,

},
prop_anim {},

--------------------------
-- aircraft panels --
--------------------------
msrp {
		position = {0, 0, 2048, 2048},
		},

electric_panel_3d {
		position = {0, 0, 2048, 2048},
		},

hydraulic_panel_3d {

		position = {0, 0, 2048, 2048},

		},

fuel_panel_3d {
		position = {0, 0, 2048, 2048},
		},

prop_logic {
	position = {0, 0, 2048, 2048},
		},

brake_logic {
		position = {0, 0, 2048, 2048},
		},

misc_clickables {
		position = {0, 0, 2048, 2048},
		},

misc_lamps {
		position = {0, 0, 2048, 2048},
		},
ssos {
		position = {0, 0, 2048, 2048},
		},

gear_panel {
		position = {16, 543, 169, 82},
		},

ap28_panel {
		position = {0, 0, 2048, 2048},
		},

antiice {
		position = {0, 0, 2048, 2048},
		},

mrp {
		position = {0, 0, 2048, 2048},
		},

engine_fuel {
		position = {0, 0, 2048, 2048},
		},

start_panel_3d {
		position = {0, 0, 2048, 2048},
		},

fire_panel_3d {
		position = {0, 0, 2048, 2048},
		},

trimm_logic {
		position = {0, 0, 2048, 2048},
		},

iv41 {
		position = {0, 0, 2048, 2048},
		},

skv {
		position = {0, 0, 2048, 2048},
		},

radar_panel {
		position = {0, 0, 2048, 2048},
		},

fake {
		position = {0, 0, 2048, 2048},
		},
		
cowl_flaps {
		position = {0, 0, 2048, 2048},
		},

----------------------------
-- captain's panel gauges --
----------------------------

vd_10 {
		position = {200, 1847, 200, 200},
		},

kus_730 {
		position = {400, 1847, 200, 200},
		},

var_30 {
		position = {601, 1847, 200, 200},
		},

feet_meter {
		position = {1801, 1847, 200, 200},
		},

rv_2 	{
		position = {801, 1847, 200, 200},
		},

achs1 	{
		position = {801, 1046, 200, 200},
		},

art_horizons {
		position = {0, 0, 2048, 2048},
		},

kppm 	{
		position = {1, 1647, 200, 200},
		--SC_dref = "sim/custom/xap/An24_gauges/scale_angle_1_smartcopilot",
		--ap_curse = globalPropertyf("sim/custom/xap/An24_ap/curse_kppm"),
		},

zk2 	{
		position = {401, 1647, 200, 200},
		--ap_curse = globalPropertyf("sim/custom/xap/An24_ap/curse_kppm"),
		},

transponder {
		position = {1346, 649, 58, 51},

		},

ark11 {
		position = {453, 457, 240, 200},
		},

radiocompas {
		position = {600, 1648, 200, 200},
		},

ark_meter {
		position = {601, 848, 100, 100},
		},

com_set {
		position = {328, 360, 80, 80},
		},

com_set {
		position = {328, 268, 80, 80},
		frequency = globalPropertyi("sim/cockpit2/radios/actuators/com2_frequency_hz")
		},

dme_set {
		position = {420, 360, 80, 80},
		},

dme {
		position = {601, 1248, 200, 200},
		},

oil_ind {
		position = {4, 847, 100, 200},
		},

spu {
		position = {1005, 660, 140, 180},
		},

----------------------------
-- copilot's panel gauges --
----------------------------
kus_730 {
		position = {1402, 1447, 200, 200},
		ias = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_copilot"),
		},

var_30 {
		position = {1, 1246, 200, 200},
		vvi = globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_copilot"),
		},

uvid_30 {
		position = {401, 1247, 200, 200},
		},

eup_53 {
		position = {201, 1048, 200, 200},
		},

kppm {
		position = {1, 1047, 200, 200},
		scale_angle_smartcopilot = globalPropertyf("sim/custom/xap/An24_gauges/scale_angle_2_smartcopilot"),
		rotate_dir_smartcopilot = globalPropertyi("sim/custom/xap/An24_gauges/rotate_dir_2_smartcopilot"),
		sc_curse_angle = globalPropertyf("sim/custom/xap/An24_gauges/sc_KPPM_2_curse_angle"),
		hor_def = globalPropertyf("sim/custom/xap/An24_gauges/curs_2"),
		vert_def = globalPropertyf("sim/custom/xap/An24_gauges/glide_2"),
		curs_flag = globalPropertyf("sim/custom/xap/An24_gauges/k2_flag"),
		glide_flag = globalPropertyf("sim/custom/xap/An24_gauges/g2_flag"),
		},

gpk_logic {
		position = {1595, 842, 400, 400},
		},

gpk_panel {
		position = {0, 0, 2048, 2048},
		},

ark11 {
		position = {210, 457, 240, 200},
		dev_num = 1,
		ark_need_freq = globalPropertyi("sim/custom/xap/An24_ark/ark2_need_freq"),
		radio = globalPropertyi("sim/cockpit2/radios/actuators/adf2_frequency_hz"),
		adf = globalPropertyf("sim/cockpit2/radios/indicators/adf2_relative_bearing_deg"),
		fail = globalPropertyi("sim/operation/failures/rel_adf2"),

		audio_selection = globalPropertyi("sim/cockpit2/radios/actuators/audio_selection_adf2"),
		cw_sw = globalPropertyi("sim/custom/xap/An24_ark/ark2_cw"),

		ark_band_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_band_need"),
		ark_tune_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune_need"),
		ark_fine_tune_need = globalPropertyi("sim/custom/xap/An24_ark/ark2_fine_tune_need"),
		button = globalPropertyi("sim/custom/xap/An24_ark/ark2_button"),
		ark_mode = globalPropertyi("sim/custom/xap/An24_ark/ark2_mode"),
		ark_band = globalPropertyi("sim/custom/xap/An24_ark/ark2_band"),
		band_fix = globalPropertyi("sim/custom/xap/An24_ark/ark2_band_fix"),
		ark_tune = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune"),
		tune_fix = globalPropertyi("sim/custom/xap/An24_ark/ark2_tune_fix"),
		ark_fine_tune = globalPropertyi("sim/custom/xap/An24_ark/ark2_fine_tune"),
		ant_sw = globalPropertyi("sim/custom/xap/An24_ark/ark2_ant_sw"),

		res_angle = globalPropertyf("sim/custom/xap/An24_ark/ark2_angle"),
		res_signal = globalPropertyf("sim/custom/xap/An24_ark/ark2_signal"),

		bus27 = globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt"),
		ark_cc = globalPropertyf("sim/custom/xap/An24_ark/ark2_cc"),
		},

radiocompas_big {
		position = {1600, 1247, 400, 400},
		},

ark_meter {
		position = {701, 848, 100, 100},
		signal = globalPropertyf("sim/custom/xap/An24_ark/ark2_signal"),
		},
-------------------------
-- center panel gauges --
-------------------------
ite2 {
		position = {802, 1448, 200, 200},
		},

tsa15 {
		position = {1001, 1647, 200, 200},
		},

uprt2	{
		position = {1401, 1647, 200, 200},
		},

emi3	{
		position = {1601, 1647, 200, 200},
		},

emi3	{
		position = {1801, 1647, 200, 200},
		fuel_p = globalPropertyf("sim/cockpit2/engine/indicators/fuel_pressure_psi[1]"),
		oil_p = globalPropertyf("sim/cockpit2/engine/indicators/oil_pressure_psi[1]"),
		oil_t = globalPropertyf("sim/cockpit2/engine/indicators/oil_temperature_deg_C[1]"),

		},

emi3_ru19	{
		position = {801, 1647, 200, 200},
		},

tg2a	{
		position = {1, 1447, 200, 200},
		},

tg2a	{
		position = {201, 1447, 200, 200},
		--EGT = globalPropertyf("sim/cockpit2/engine/indicators/EGT_deg_C[1]"),
		temp_check = globalPropertyi("sim/custom/xap/An24_start/right_temp_check"),
		egt_fail = globalPropertyi("sim/operation/failures/rel_EGT_ind_1"),
		uprt = globalPropertyf("sim/custom/xap/An24_misc/virt_rud2"),
		N1 = globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]"),
		eng_work = globalPropertyi("sim/flightmodel2/engines/engine_is_burning_fuel[1]"),
		engine_on_fire = globalPropertyi("sim/operation/failures/rel_engfir1"),  -- engine on fire
		eng_power = globalPropertyf("sim/flightmodel/engine/ENGN_power[1]"),
		},

term	{
		position = {1201, 1647, 200, 200},
		},

dim100	{
		position = {401, 1447, 200, 200},
		ikm = globalPropertyf("sim/custom/xap/An24_gauges/torque_left"),
		},

dim100	{
		position = {601, 1447, 200, 200},
		torq = globalPropertyf("sim/cockpit2/engine/indicators/torque_n_mtr[1]"),
		ikm = globalPropertyf("sim/custom/xap/An24_gauges/torque_right"),
		},

uap14 	{
		position = {201, 1647, 200, 200},
		},

var_10	{
		position = {801, 1247, 200, 200},
		},

upvd15	{
		position = {1001, 1247, 200, 200},
		},

radar {
		position = {217, -51, 256, 300},
		},

cowl_flap_ind {
		position = {404, 848, 200, 200},
		},
-----------------------
-- navigator's panel --
-----------------------

ush 	{
		position = {1701, 548, 300, 300},
		},

nav_kursmp_set {
		position = {417, 648, 170, 170},
		},

nav_kursmp_set {
		position = {617, 648, 170, 170},
		frequency = globalPropertyf("sim/cockpit2/radios/actuators/nav2_frequency_hz"),
		},

obs_kursmp_set {
		position = {0, 648, 200, 200},
		},

obs_kursmp_set {
		position = {200, 648, 200, 200},
		obs = globalPropertyf("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot"),
		fromto = globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto"),
		fromto_lit = globalPropertyi("sim/custom/xap/An24_gauges/obs2_fromto_lit"),
		},

curs_mp {
		position = {800, 648, 200, 200},
		},


map {
		position = {1514, 5, 530, 530},
		},
	
		KLN90 {},		
		KLN90_panel { 
					position = { 908, 8, 588, 188 } 
		},
	

}

local filenew
function prefslight_save()
	

end

function onAvionicsDone()
	
end