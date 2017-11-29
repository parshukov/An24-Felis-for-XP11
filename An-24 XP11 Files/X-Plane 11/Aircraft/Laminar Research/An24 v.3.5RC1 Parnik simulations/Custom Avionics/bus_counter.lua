-- this is script for count currents on buses

-- property table
defineProperty("bus_DC_27_amp", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_amp"))  -- currents on busses
defineProperty("bus_DC_27_amp_emerg", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_amp_emerg")) 
defineProperty("bus_AC_36_amp", globalPropertyf("sim/custom/xap/An24_power/bus_AC_36_amp")) 
defineProperty("bus_AC_115_amp", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_amp")) 
-- source logic
-- defineProperty("main_on_emerg", globalPropertyi("sim/custom/xap/An24_power/main_on_emerg"))  -- main bus connected to emergency bus
defineProperty("DC_source", globalPropertyi("sim/custom/xap/An24_power/DC_source"))  -- source for DC27v bus. 0 = none, 1 = STG1, 2 = STG2, 3 = GS24, 4 = bat. left gen by default
defineProperty("AC_source", globalPropertyi("sim/custom/xap/An24_power/AC_source"))  -- source for AC115 bus. 1 when generators, 2 when inverter
defineProperty("inv_PT1000_1", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_1"))  -- inverters
defineProperty("inv_PT1000_2", globalPropertyi("sim/custom/xap/An24_power/inv_PT1000_2"))

-- current consumption
defineProperty("bat_amp_cc", globalPropertyf("sim/custom/xap/An24_power/bat_amp_cc")) -- if batteries are charging, they take current instead of give it. = 0 when bat is source
defineProperty("stg1_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg1_amp_cc"))  -- generator current consumption as starter, initial 0A
defineProperty("stg2_amp_cc", globalPropertyf("sim/custom/xap/An24_power/stg2_amp_cc")) 
defineProperty("gs24_amp_cc", globalPropertyf("sim/custom/xap/An24_power/gs24_amp_cc")) 
defineProperty("hydro_emerg_pump_cc", globalPropertyf("sim/custom/xap/An24_hydro/pump_cc")) -- emergency hydraulic pump consumption
defineProperty("fuel_pumps_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_pumps_cc")) -- fuel pumps current consumption
defineProperty("fuel_valves_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_valves_cc")) -- fuel valves current consumption
defineProperty("fuel_circle_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_circle_cc")) -- fuel circle valve current consumption
defineProperty("fuel_meter_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_meter_cc")) -- fuel meters current consumption
defineProperty("fuel_flow_cc", globalPropertyf("sim/custom/xap/An24_fuel/fuel_flow_cc")) 
defineProperty("uvid_30_cc", globalPropertyf("sim/custom/xap/An24_gauges/uvid_30_cc"))  -- current consumption of UVID-30
defineProperty("feet_meter_cc", globalPropertyf("ssim/custom/xap/An24_gauges/feet_meter_cc")) -- current consumption of UVID-30
defineProperty("AHZ_cc", globalPropertyf("sim/custom/xap/An24_gauges/AHZ_cc"))  -- consumption of artificial horizons
defineProperty("eup53_cc", globalPropertyf("sim/custom/xap/An24_gauges/eup53_cc")) -- current consumption of turn coordinator
defineProperty("GIK_cc", globalPropertyf("sim/custom/xap/An24_gauges/GIK_cc")) -- current consumption of GIK
defineProperty("GPK_cc", globalPropertyf("sim/custom/xap/An24_gauges/GPK_cc")) -- current consumption of GPK
defineProperty("aa_main_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_main_cc")) 
defineProperty("aa_emerg_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_emerg_cc"))
defineProperty("aa_115_cc", globalPropertyf("sim/custom/xap/An24_ice/aa_115_cc")) 
defineProperty("ap_power_cc", globalPropertyf("sim/custom/xap/An24_ap/ap_power_cc"))
defineProperty("ark1_cc", globalPropertyf("sim/custom/xap/An24_ark/ark1_cc"))
defineProperty("ark2_cc", globalPropertyf("sim/custom/xap/An24_ark/ark2_cc"))
defineProperty("curs_mp_cc", globalPropertyf("sim/custom/xap/An24_gauges/curs_mp_cc"))
defineProperty("dme_cc", globalPropertyf("sim/custom/xap/An24_gauges/dme_cc")) 
defineProperty("fire_cc", globalPropertyf("sim/custom/xap/An24_fire/fire_cc")) 
defineProperty("flap_cc", globalPropertyf("sim/custom/xap/An24_hydro/flap_cc")) 
defineProperty("mrp_cc", globalPropertyf("sim/custom/xap/An24_gauges/mrp_cc"))
defineProperty("rv2_cc", globalPropertyf("sim/custom/xap/An24_gauges/rv_2_cc"))
defineProperty("ssos_cc", globalPropertyf("sim/custom/xap/An24_gauges/ssos_cc")) 
defineProperty("sq_cc", globalPropertyf("sim/custom/xap/An24_sq/sq_cc"))
defineProperty("auasp_cc", globalPropertyf("sim/custom/xap/An24_gauges/auasp_cc"))
defineProperty("uprt_cc", globalPropertyf("sim/custom/xap/An24_gauges/uprt_cc"))
defineProperty("nav_light_cc", globalPropertyf("sim/custom/xap/An24_misc/nav_light_cc")) -- light current consumption
defineProperty("bec_light_cc", globalPropertyf("sim/custom/xap/An24_misc/bec_light_cc")) -- light current consumption
defineProperty("lan_light_cc", globalPropertyf("sim/custom/xap/An24_misc/lan_light_cc")) -- light current consumption
defineProperty("rls_power_cc", globalPropertyf("sim/custom/xap/An24_rls/rls_power_cc")) -- RLS
defineProperty("rsbn_cc", globalPropertyf("sim/custom/xap/An24_rsbn/rsbn_cc"))
defineProperty("nas1_cc", globalPropertyf("sim/custom/xap/An24_nas1/nas1_cc"))

-- calculations every frame
function update()
	-- local counters	
	local DC27_amp = 0
	local DC27_emerg_amp = 0
	local AC36_amp = 0
	local AC115_amp = 0
	--print(get(stg1_amp_cc), get(stg2_amp_cc))
	
	-- AC 115v counter
	AC115_amp = get(fuel_meter_cc) + get(fuel_flow_cc) + get(uvid_30_cc) + get(feet_meter_cc) + get(aa_115_cc) + get(ap_power_cc) + get(ark1_cc) + get(ark2_cc) + get(curs_mp_cc)
	AC115_amp = AC115_amp + get(rv2_cc) + get(ssos_cc) + get(auasp_cc) + get(rls_power_cc) + get(rsbn_cc) + get(nas1_cc)
	
	-- AC 36v counter
	AC36_amp = get(AHZ_cc) * 2 + get(GIK_cc) + get(GPK_cc) + get(ap_power_cc) + get(rls_power_cc)
	
	-- DC 27 emerg volt calculations
	DC27_emerg_amp = get(hydro_emerg_pump_cc) + get(fuel_valves_cc) + AC36_amp * 0.8 * get(inv_PT1000_2) + get(uvid_30_cc) + get(AHZ_cc) * 2
	DC27_emerg_amp = DC27_emerg_amp + get(GIK_cc) + get(aa_emerg_cc) + get(ark1_cc) + get(curs_mp_cc) + get(eup53_cc) + get(fire_cc) + get(flap_cc)
	DC27_emerg_amp = DC27_emerg_amp + get(mrp_cc) + get(rv2_cc) + get(sq_cc) + get(nav_light_cc) + get(gs24_amp_cc) + get(rsbn_cc) + get(nas1_cc)
	
	-- DC 27 volt calculations
	DC27_amp = get(fuel_pumps_cc) + get(fuel_circle_cc) + get(fuel_meter_cc) + get(feet_meter_cc) + get(rls_power_cc)
	DC27_amp = DC27_amp + get(bat_amp_cc) + get(stg1_amp_cc) + get(stg2_amp_cc) + DC27_emerg_amp + AC36_amp * 0.8 * get(inv_PT1000_1) -- while normal work, emergency bus work with main
	DC27_amp = DC27_amp + get(GPK_cc) + get(aa_main_cc) + get(ark2_cc) + get(dme_cc) + get(auasp_cc) + get(uprt_cc) + get(bec_light_cc) + get(lan_light_cc)
	if get(AC_source) == 3 then DC27_amp = DC27_amp + AC115_amp * 0.25 end

	
	
	-- set calculated values
	set(bus_DC_27_amp, DC27_amp)
	set(bus_DC_27_amp_emerg, DC27_emerg_amp)
	set(bus_AC_36_amp, AC36_amp)
	set(bus_AC_115_amp, AC115_amp)
	
end
