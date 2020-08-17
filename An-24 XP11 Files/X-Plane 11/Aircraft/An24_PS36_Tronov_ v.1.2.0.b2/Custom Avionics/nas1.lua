size = {1024, 557}

defineProperty("bg", loadImage("NAS1.dds", 0, 0, 1024, 557))

defineProperty("northneedle", loadImage("NAS1.dds", 32, 863, 17, 141)) 
defineProperty("eastneedle", loadImage("NAS1.dds", 48, 863, 17, 141)) 
defineProperty("curse_needle", loadImage("needles.dds", 218, 70, 87, 179))
defineProperty("needle_1", loadImage("NAS1.dds", 463, 783, 23, 237))
defineProperty("needle_2", loadImage("NAS1.dds", 403, 839, 28, 177))

defineProperty("northoverlay", loadImage("NAS1.dds", 0, 562, 35, 35))
defineProperty("eastoverlay", loadImage("NAS1.dds", 0, 598, 35, 35))
defineProperty("overlay", loadImage("NAS1.dds", 0, 634, 35, 35))
defineProperty("windoverlay", loadImage("NAS1.dds", 142, 608, 90, 116))
defineProperty("windoverlay2", loadImage("NAS1.dds", 0, 762, 42, 42))

defineProperty("delta_needle", loadImage("NAS1.dds", 205, 830, 25, 146))
defineProperty("map_needle", loadImage("kppm.dds", -0.5, 0.5, 196, 196))

defineProperty("speed_needle", loadImage("NAS1.dds", 252, 830, 11, 56))

defineProperty("yellow", loadImage("NAS1.dds", 0, 691, 263, 17))
defineProperty("large_scale", loadImage("NAS1.dds", 896, 558, 128, 128))
defineProperty("checker", loadImage("NAS1.dds", 791, 597, 40, 16))

defineProperty("rotary", loadImage("rot_switch.dds"))
defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))

defineProperty("deg1", globalPropertyf("sim/flightmodel/position/psi"))
defineProperty("deg2", globalPropertyf("sim/flightmodel/position/hpath"))
defineProperty("TAS", globalPropertyf("sim/flightmodel/position/true_airspeed"))
defineProperty("GS", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("pitch", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll", globalPropertyf("sim/flightmodel/position/phi"))
defineProperty("waves", globalPropertyf("sim/weather/wave_amplitude"))


defineProperty("rls_power_cc", globalPropertyf("sim/custom/xap/An24_rls/rls_power_cc"))


defineProperty("GPK_course", globalPropertyf("sim/custom/xap/An24_gauges/GPK_curse"))
defineProperty("elevation", globalPropertyf("sim/flightmodel/position/elevation"))
defineProperty("height", globalPropertyf("sim/flightmodel/position/y_agl"))

defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 

defineProperty("run_time", globalPropertyf("sim/time/total_running_time_sec"))
defineProperty("nas1_subpanel", globalPropertyi("sim/custom/xap/An24_panels/nas1_subpanel"))
defineProperty("nas1_cc", globalPropertyf("sim/custom/xap/An24_nas1/nas1_cc"))
defineProperty("dst1", globalPropertyf("sim/custom/xap/An24_nas1/N_needle"))
defineProperty("dst2", globalPropertyf("sim/custom/xap/An24_nas1/E_needle"))
defineProperty("counter", globalPropertyf("sim/custom/xap/An24_nas1/counter"))
defineProperty("mode1", globalPropertyf("sim/custom/xap/An24_nas1/mode1"))
defineProperty("mode2", globalPropertyf("sim/custom/xap/An24_nas1/mode2"))
defineProperty("map_angle", globalPropertyf("sim/custom/xap/An24_nas1/map_angle"))
defineProperty("water", globalPropertyf("sim/custom/xap/An24_nas1/water"))
defineProperty("DISS", globalPropertyf("sim/custom/xap/An24_nas1/DISS"))
defineProperty("winddelta", globalPropertyf("sim/custom/xap/An24_nas1/windangle"))
defineProperty("windspeed", globalPropertyf("sim/custom/xap/An24_nas1/windspeed"))


--local get(dst1) = 0
--local get(dst2) = 0
local diff = 0
local slip = 0
local speed = 0
local over_land = 0
local memory = 0
local windN = 0
local windE = 0
local slipneedle = 0
local preset1 = 0
local preset2 = 0
local presetangle = 0
local power1 = 0
local power2 = 0


--local get(mode1) = 0
--0:off 1:on 2:Memory 3:High
--local get(mode2) = 0
--0:land 1:sea 2:Contr1 3:contr2
local timer = get(run_time)

local windangle = 0

function update()
--automatic switching into memory mode
if get(mode1) == 3 and get(DISS) == 1 then
if get(pitch) > 10 or get(roll) > 10 or get(pitch) < -10 or get(roll) < -10 or get(rls_power_cc) < 1.5 then
memory = 1
else
memory = 0
end
elseif get(mode1) == 2 then
memory = 1
else
memory = 0
end

--when flying over sea, the groundspeed is different
over_land = math.abs( get (elevation) - get (height) - 3 )
if over_land > 1.1 then
over_land = 1
elseif over_land < 0.5 then
over_land = 0
else
over_land = ( over_land - 0.5 ) * 5 / 3
end

set(water, over_land)

--if the waves are to small, the radar signal is invalid
if over_land < 1 and get(waves) < 0.1 and get(mode1) == 3 and get(DISS) == 1 then
memory = 1
end

if presetangle > 359 then
presetangle = presetangle - 360
elseif presetangle < 0 then
presetangle = presetangle + 360
end

if get(map_angle) > 360 then
set(map_angle, get(map_angle) - 360)
elseif get(map_angle) < 0 then
set(map_angle, get(map_angle) + 360)
end

if get(windspeed) > 170 then
set(windspeed, get(windspeed) - 175)
elseif get(windspeed) < 0 then
set(windspeed, get(windspeed) + 175)
end

if get(winddelta) > 360 then
set(winddelta, get(winddelta) - 360)
elseif get(winddelta) < 0 then
set(winddelta, get(winddelta) + 360)
end

if get(mode1) < 0 then
set(mode1, 0)
elseif get(mode1) > 3 then
set(mode1, 3)
end

if get(mode2) < 0 then
set(mode2, 0)
elseif get(mode2) > 3 then
set(mode2, 3)
end


--handle power
local power27 = get(bus_DC_27_volt) > 21
if power27 and get(bus_AC_115_volt) > 110 then
if get(counter) == 1 then
power1 = 1
else power1 = 0 end
if get(DISS) == 0 then
power2 = 1
else
if get(mode1) == 1 or get(mode1) == 2 then
power2 = 1
elseif get(mode1) == 3 then
power2 = 3
else power2 = 0 end
end
else 
power1 = 0
power2 = 0
end
set(nas1_cc, (power1 + power2) * 3)


--THESE CALCULATION ARE DONE EVERY 0.05 SEC!
if get(run_time) > timer then
--get(DISS) mode
if get(DISS) == 1 and power2 > 0 then
--high mode: GS and slip are provide by the radar

if get(mode1) < 2 then
slip = 0
speed = 0
end


--get(DISS) all systems nominal
if get(mode1) == 3 and memory == 0 then
if get(mode2) == 0 then
speed = get(GS) * ( 1 - 0.025 * math.abs( over_land - 1 ) )
elseif get(mode2) == 1 then
speed = get(GS) * ( 1 + 0.025 * over_land )
end
slip = ( get(deg2) - get(deg1) )
end

--test modes
if get(mode1) == 3 and get(mode2) == 2 then
speed = 176.4
slip = 0
elseif get(mode1) == 3 and get(mode2) == 3 then
speed = 279.7
slip = 9
end

--In ANU (Automatic navigation device) we use TAS and windgauge to calculate path
elseif get(DISS) == 0 and power2 > 0 then
windangle = (get(map_angle) + get(winddelta)) * math.pi / 180
if windangle > 2 * math.pi then
windangle = windangle - 2 * math.pi
end
speed = math.sqrt ( ( get(windspeed) / 3.6 ) ^ 2 + get(TAS) ^ 2 - 2 * get(windspeed) / 3.6 * get(TAS) * math.cos(get(GPK_course) * ( math.pi / 180 ) - windangle ))
slip = math.atan2 ( get(windspeed) / 3.6 * math.sin (get(GPK_course) * ( math.pi / 180 ) - windangle ), get(TAS) - get(windspeed) / 3.6 * math.cos(get(GPK_course) * ( math.pi / 180 ) - windangle)) * 180 / math.pi
--no power? no indications!
else
speed = 0
slip = 0
end

if slip < -180 then 
slip = slip + 360 
elseif slip > 180 then
slip = slip - 360
end


diff = ( get(GPK_course) + slip - get(map_angle) ) * math.pi / 180

--now we calculate the deviation
if get(counter) == 1 and power1 == 1 then
set(dst1, get(dst1) + ( math.cos(diff) * speed / 20000 ))
set(dst2, get(dst2) + ( math.sin(diff) * speed / 20000 ))
end

timer = timer + 0.05

--slip needs to be limited for the gauge
slipneedle = slip * 6
if slipneedle < -120 then
slipneedle = -120
elseif slipneedle > 120 then
slipneedle = 120
end

end

end

components = {
	needle {
		position = { 873, 440, 60, 60 },
		image = get(large_scale),
		angle = function() 
		return get(dst1) / -13.8889
		end,
		visible = true
	},
	texture {
		image = get(overlay),
		position = {854, 144, 60, 36},
		visible = true
	},
	texture {
		image = get(checker),
		position = {859, 149, 40, 16},
		visible = function()
		return memory == 1
		end,
	},
	texture {
		position = {0, 0, 1024, 557},
		image = get(bg),
		visible = true
	},

	switch {
		position = { 114, 261, 20, 80},
		state = function()
		return get(counter) ~= 0
		end,
		btnOn = get(tmb_up),
		btnOff = get(tmb_dn),
		onMouseClick = function()
		if get(counter) ~= 0 then
		set(counter, 0)
		else
		set(counter, 1)
		end
		return true;
		end
	},
	switch {
		position = { 892, 261, 20, 80},
		state = function()
		return get(DISS) ~= 0
		end,
		btnOn = get(tmb_up),
		btnOff = get(tmb_dn),
		onMouseClick = function()
		if get(DISS) ~= 0 then
		set(DISS, 0)
		else
		set(DISS, 1)
		end
		return true;
		end
	},
	--map angle
	needle {
		position = { 16, 357, 168, 168 },
		image = get(curse_needle),
		angle = function() 
		return get(map_angle)
		end,
		visible = true
	}, 
	texture {
		position = {82, 421, 35, 35},
		image = get(overlay),
		visible = true
	},
	clickable {
		position = {178, 430, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(map_angle, get(map_angle) - 2)
		return true
		end  
	},
	clickable {
		position = {202, 430, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(map_angle, get(map_angle) + 2)
		return true
		end  
	},
	--big needle north
	needle {
		position = { 233, 293, 237, 237 },
		image = get(needle_1),
		angle = function() 
		return get(dst1) / 0.0027778
		end,
		visible = true
	},  
	needle {
		position = { 285, 343, 136, 136 },
		image = get(needle_2),
		angle = function() 
		return get(dst1) / 0.27778
		end,
		visible = true
	}, 
	clickable {
		position = {464, 400, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) - 0.010)
		return true
		end  
	},	
	clickable {
		position = {488, 400, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) + 0.010)
		return true
		end  
	},
	clickable {
		position = {476, 422, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) + 1)
		return true
		end  
	},
	clickable {
		position = {476, 378, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) - 1)
		return true
		end  
	},
	texture {
		position = {334, 393, 35, 35},
		image = get(northoverlay),
		visible = true
	},
	--big needle east

	needle {
		position = { 518, 293, 237, 237 },
		image = get(needle_1),
		angle = function() 
		return get(dst2) / 0.0027778
		end,
		visible = true
	},
	needle {
		position = { 570, 343, 136, 136 },
		image = get(needle_2),
		angle = function() 
		return get(dst2) / 0.27778
		end,
		visible = true
	},  
	clickable {
		position = {750, 400, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) - 0.010)
		return true
		end  
	},	
	clickable {
		position = {774, 400, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) + 0.010)
		return true
		end  
	},
	clickable {
		position = {762, 422, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) + 1)
		return true
		end  
	},
	clickable {
		position = {762, 378, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) - 1)
		return true
		end  
	},
	texture {
		position = {620, 393, 35, 35},
		image = get(eastoverlay),
		visible = true
	},
	--combined
	needle {
		position = { 819, 356, 168, 168 },
		image = get(eastneedle),
		angle = function() 
		return get(dst2) / 2.7778
		end,
		visible = true
	}, 
	needle {
		position = { 819, 356, 168, 168 },
		image = get(northneedle),
		angle = function() 
		return get(dst1) / 2.7778
		end,
		visible = true
	},  
	texture {
		position = {886, 421, 35, 35},
		image = get(overlay),
		visible = true
	},
	clickable {
		position = {982, 443, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) - 10)
		return true
		end  
	},
	clickable {
		position = {1006, 443, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst1, get(dst1) + 10)
		return true
		end  
	},
	clickable {
		position = {982, 419, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) - 10)
		return true
		end  
	},
	clickable {
		position = {1006, 419, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(dst2, get(dst2) + 10)
		return true
		end  
	},
	--TAS and slip
	digitstape {
		position = { 850, 53, 56, 17},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		--	fractional = 0;
		showSign = false;
		value = function()
		return speed * 3.6
		end;
		visible = true
	},
	needle {
		position = { 796, 35, 168, 168 },
		image = get(curse_needle),
		angle = function() 
		return slipneedle
		end,
		visible = true
	}, 
	texture {
		position = {861, 101, 35, 35},
		image = get(overlay),
		visible = true
	},
	--wind
	needle {
		position = { 549, 34, 168, 168 },
		image = get(map_needle),
		angle = function() 
		return -get(map_angle)
		end,
		visible = true
	},
	needle {
		position = { 560, 46, 146, 146 },
		image = get(delta_needle),
		angle = function() 
		return get(winddelta)
		end,
		visible = true
	}, 	
	texture {
		position = {587, 74, 90, 116},
		image = get(windoverlay),
		visible = true
	},
	needle {
		position = { 603, 91, 56, 56 },
		image = get(speed_needle),
		angle = function() 
		return get(windspeed) * 360 / 175 - 50
		end,
		visible = true
	}, 
	texture {
		position = {609, 98, 42, 42},
		image = get(windoverlay2),
		visible = true
	},
	--set windangle
	clickable {
		position = {710, 106, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(winddelta, get(winddelta) - 2)

		return true
		end  
	},
	clickable {
		position = {734, 106, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(winddelta, get(winddelta) + 2)
		return true
		end  
	},
	--set get(windspeed)
	clickable {
		position = {610, 99, 20, 40 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
				set(windspeed, get(windspeed) - 5)
		return true
		end  
	},
	clickable {
		position = {634, 99, 20, 40 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
				set(windspeed, get(windspeed) + 5)
		return true
		end  
	},
	--Mode panel
	needle {
		position = {71, 5, 120, 120},
		image = get(rotary),
		angle = function()
		return get(mode1) * 40 - 60
		end
	},	
	clickable {
		position = {18, 25, 110, 110 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(mode1, get(mode1) - 1)


		return true
		end  
	},	
	clickable {
		position = {132, 25, 110, 110 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(mode1, get(mode1) + 1)

		return true
		end  
	},	
	needle {
		position = {305, 5, 120, 120},
		image = get(rotary),
		angle = function()
		return get(mode2) * 40 - 60
		end
	},	
	clickable {
		position = {253, 25, 110, 110 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set(mode2, get(mode2) - 1)

		return true
		end  
	},	
	clickable {
		position = {368, 25, 110, 110 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set(mode2, get(mode2) + 1)


		return true
		end  
	},	
	textureLit {
		image = get(green_led),
		position = {45, 188, 32, 32},
		visible = function()
		return get(mode1) > 0 and power2 > 0
		end,
	},
	textureLit {
		image = get(red_led),
		position = {444, 188, 32, 32},
		visible = function()
		return get(mode1) == 3 and power2 > 0
		end,
	},
	--preset map angle
	clickable {
		position = {82, 421, 35, 35},
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		set(map_angle, presetangle)
		return true
		end  
	},
	digitstape {
		position = { 82, 534, 42, 17},
		image = digitsImage;
		digits = 3;
		allowNonRound = false;
		showLeadingZeros = true;
		--	fractional = 0;
		showSign = false;
		value = function()
		return presetangle
		end;
		visible = function()
		if presetangle == 0 then return false
		else return true end
		end
	},
	clickable {
		position = {82, 534, 42, 17 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		presetangle = 0
		return true
		end  
	},	
	clickable {
		position = {16, 500, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		presetangle = presetangle - 1
		return true
		end  
	},	
	clickable {
		position = {165, 500, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		presetangle = presetangle + 1
		return true
		end  
	},	
	
	--preset get(dst1)
	clickable {
		position = {334, 393, 35, 35},
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
				set(dst1, preset1)
		return true
		end  
	},
	digitstape {
		position = { 334, 534, 56, 17},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		fractional = 1;
		showSign = true;
		value = function()
		return preset1
		end;
		visible = function()
		if preset1 == 0  then return false
		else return true end
		end
	},
	clickable {
		position = {334, 534, 56, 17 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		preset1 = 0
		return true
		end  
	},	
	clickable {
		position = {240, 494, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		preset1 = preset1 - 0.1
		return true
		end  
	},	
	clickable {
		position = {442, 494, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		preset1 = preset1 + 0.1
		return true
		end  
	},	
	--preset get(dst2)
	clickable {
		position = {620, 393, 35, 35},
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
						set(dst2, preset2)

		return true
		end  
	},
	digitstape {
		position = { 620, 534, 56, 17},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		fractional = 1;
		showSign = true;
		value = function()
		return preset2
		end;
		visible = function()
		if preset2 == 0  then return false
		else return true end
		end
	},
	clickable {
		position = {620, 534, 56, 17 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		preset2 = 0
		return true
		end  
	},	
	clickable {
		position = {526, 494, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		preset2 = preset2 - 0.1
		return true
		end  
	},	
	clickable {
		position = {728, 494, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		preset2 = preset2 + 0.1
		return true
		end  
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
		set(nas1_subpanel, 0 )
		return true
		end
	},	
}
