size = {1024, 724}

defineProperty("bg", loadImage("rsbn.dds", 0, 0, 1024, 724))
defineProperty("rotary", loadImage("rot_switch.dds"))
defineProperty("detailed", loadImage("rsbn.dds", 0, 731, 150, 150))
defineProperty("glass_cap", loadImage("rsbn.dds", 11, 895, 78, 32))

defineProperty("digitsImage", loadImage("white_digit_strip.png", 0, 0, 16, 196))
defineProperty("needle1", loadImage("needles.dds", 311, 73, 18, 173))
defineProperty("needle2", loadImage("rsbn.dds", 205, 774, 22, 158))

defineProperty("green_led", loadImage("leds.dds", 20, 0, 20, 20)) 
defineProperty("red_led", loadImage("leds.dds", 40, 0, 20, 20)) 

defineProperty("tmb_up", loadImage("tumbler_up.dds"))
defineProperty("tmb_dn", loadImage("tumbler_down.dds"))



defineProperty("lat", globalPropertyf("sim/flightmodel/position/latitude"))
defineProperty("lon", globalPropertyf("sim/flightmodel/position/longitude"))
defineProperty("alt", globalPropertyf("sim/flightmodel/position/elevation"))
defineProperty("TAS", globalPropertyf("sim/flightmodel/position/true_airspeed"))


defineProperty("rsbn_channel", globalPropertyi("sim/custom/xap/An24_rsbn/channel"))
defineProperty("rsbn_receive", globalPropertyi("sim/custom/xap/An24_rsbn/receive"))
defineProperty("rsbn_lat", globalPropertyf("sim/custom/xap/An24_rsbn/lat"))
defineProperty("rsbn_lon", globalPropertyf("sim/custom/xap/An24_rsbn/lon"))
defineProperty("rsbn_elev", globalPropertyf("sim/custom/xap/An24_rsbn/elev"))
defineProperty("rsbn_deflection", globalPropertyf("sim/custom/xap/An24_rsbn/defl"))
defineProperty("rsbn_flag", globalPropertyi("sim/custom/xap/An24_rsbn/flag"))

defineProperty("rsbn_subpanel", globalPropertyi("sim/custom/xap/An24_panels/rsbn_subpanel"))
defineProperty("rsbn_cc", globalPropertyf("sim/custom/xap/An24_rsbn/rsbn_cc"))
defineProperty("bus_DC_27_volt", globalPropertyf("sim/custom/xap/An24_power/bus_DC_27_volt_emerg")) 
defineProperty("bus_AC_115_volt", globalPropertyf("sim/custom/xap/An24_power/bus_AC_115_volt")) 
defineProperty("frame_time", globalPropertyf("sim/custom/xap/An24_time/frame_time")) -- time for frames

local channel1 = 0
local channel2 = 0
local channel = 0
local orbit = 0
local azimut = 0
local azimut2 = 0
local lat1 = 0
local lon1 = 0
local lat2 = 0
local lon2 = 0
local lat3 = 0
local lon3 = 0
local elev = 0
local mode = 0
--0:off 1:azi.to 2:azi.from 3:orbi.left 4:orbi.right 5:zpu

local set_orbit = 0
local set_azimut = 0
local set_ZPU = 0
local set_targetangle = 0
local set_targetdist = 0
local XTK = 0
local SRP_azimut = 0
local SRP_orbit = 0
local range = 0

local red_lamp = 0
local green_lamp = 0
local power = 0
local power_sw = 0
local angle1 = 0
local angle2 = 0
local angle3 = 0
local angle4 = 0
local angle5 = 0

local last_angle1 = 0
local last_angle2 = 0
local last_angle3 = 0
local last_angle4 = 0
local last_angle5 = 0

local v1 = 0
local v2 = 0

function update()

if channel1 < 0 then
channel1 = 0
elseif channel1 > 40 then
channel1 = 40
end
if channel2 < 0 then
channel2 = 0
elseif channel2 > 9 then
channel2 = 9
end
channel = channel1 + channel2
set(rsbn_channel, channel)
if mode < 0 then
mode = 0
elseif mode > 5 then
mode = 5
end


if set_orbit < 0 then
set_orbit = 0
end
if set_targetdist < 0 then
set_targetdist = 0
end
if set_azimut > 360 then
set_azimut = set_azimut - 360
elseif set_azimut < 0 then
set_azimut = set_azimut + 360
end
if set_ZPU > 360 then
set_ZPU = set_ZPU - 360
elseif set_ZPU < 0 then
set_ZPU = set_ZPU + 360
end
if set_targetangle > 360 then
set_targetangle = set_targetangle - 360
elseif set_targetangle < 0 then
set_targetangle = set_targetangle + 360
end



	if power == 1 and get(rsbn_receive) == 1 then v1 = azimut + (math.random() - 0.49999) * 2 
	elseif power == 1 then v1 = v1 + (math.random() - 0.3) * 2
	end
	
	if v1 > 180 then v1 = v1 - 360
	elseif v1 < -180 then v1 = v1 + 360 end
	
	if power == 1 and get(rsbn_receive) == 1 then v2 = azimut2 + (math.random() - 0.49999) * 2 
	elseif power == 1 then v2 = v2 + (math.random() - 0.3) * 2
	end
	
	if v2 > 180 then v2 = v2 - 360
	elseif v2 < -180 then v2 = v2 + 360 end

	local passed = get(frame_time)
if passed > 0 then
	-- needle 1 smooth
   	local delta1 = v1 - last_angle1
    if delta1 > 180 then delta1 = delta1 - 360
    elseif delta1 < -180 then delta1 = delta1 + 360 end
    angle1 = angle1 + 2 * delta1 * passed
    if angle1 > 180 then angle1 = angle1 - 360
    elseif angle1 < -180 then angle1 = angle1 + 360 end
	
   
	local delta2 = v2 - last_angle2
    if delta2 > 180 then delta2 = delta2 - 360
    elseif delta2 < -180 then delta2 = delta2 + 360 end
    angle2 = angle2 + 2 * delta2 * passed
    if angle2 > 180 then angle2 = angle2 - 360
    elseif angle2 < -180 then angle2 = angle2 + 360 end	

	local delta3 = set_azimut - last_angle3
    if delta3 > 180 then delta3 = delta3 - 360
    elseif delta3 < -180 then delta3 = delta3 + 360 end
    angle3 = angle3 + 15 * delta3 * passed
    if angle3 > 180 then angle3 = angle3 - 360
    elseif angle3 < -180 then angle3 = angle3 + 360 end	

		local delta4 = set_ZPU - last_angle4
    if delta4 > 180 then delta4 = delta4 - 360
    elseif delta4 < -180 then delta4 = delta4 + 360 end
    angle4 = angle4 + 15 * delta4 * passed
    if angle4 > 180 then angle4 = angle4 - 360
    elseif angle4 < -180 then angle4 = angle4 + 360 end	

		local delta5 = set_targetangle - last_angle5
    if delta5 > 180 then delta5 = delta5 - 360
    elseif delta5 < -180 then delta5 = delta5 + 360 end
    angle5 = angle5 + 15 * delta5 * passed
    if angle5 > 180 then angle5 = angle5 - 360
    elseif angle5 < -180 then angle5 = angle5 + 360 end	

	
end
	last_angle1 = angle1
	last_angle2 = angle2
	last_angle3 = angle3
	last_angle4 = angle4
	last_angle5 = angle5


--handle power
	local power27 = get(bus_DC_27_volt) > 21
	if power27 and get(bus_AC_115_volt) > 110 and power_sw == 1 then
		power = 1
	else 
		power = 0
	end
	set(rsbn_cc, power * 3)


--if we got something, we do the calculations much more often than the logic script
if get(rsbn_receive) == 1 and power == 1 then

lat1 = get(lat) * math.pi / 180 
lon1 = get(lon) * math.pi / -180 
lat2 = get(rsbn_lat)
lon2 = get(rsbn_lon)
elev = get(rsbn_elev)

--orbit = (2 * math.asin(math.sqrt((math.sin((lat1 - lat2) / 2)) ^ 2 + math.cos(lat1) * math.cos(lat2) * (math.sin((lon1 - lon2) / 2)) ^ 2))) * 180 * 60 / math.pi *  1852 + get(alt) - elev
azimut = math.mod(math.atan2(math.sin(lon1 - lon2) * math.cos(lat2), math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(lon1 - lon2)) + math.pi, 2 * math.pi)
orbit = (2 * math.asin(math.sqrt((math.sin((lat1 - lat2) / 2)) ^ 2 + math.cos(lat1) * math.cos(lat2) * (math.sin((lon1 - lon2) / 2)) ^ 2)))

if azimut < 0 then
azimut = azimut + 2 * math.pi
end
--are we out of range?
range = 3.57 * math.sqrt(get(alt)) * 1000
orbit =orbit * 10800 / math.pi *  1852

if orbit > range or orbit < get(alt) then
	set(rsbn_receive, 0)
end

orbit = math.sqrt(orbit ^ 2 + (get(alt) - elev)^2)

azimut = ( azimut * 180 / math.pi )
azimut2 = ( azimut - math.floor(azimut/10) * 10 ) * 36


--are we out of range?


--KPPM outputs
--azimut
if mode == 0 then
XTK = 0
elseif mode == 1 or mode == 2 then

XTK = math.sin( ( set_azimut - azimut ) * math.pi / 180) * ( orbit / 1000 )

--orbit
elseif mode == 3 or mode == 4 then
XTK = ( orbit - set_orbit ) / 1000
--SRP
elseif mode ==5 then
lat3 = math.asin(math.sin(lat2) * math.cos(set_targetdist / 1850 * math.pi / 10800) + math.cos(lat2) * math.sin(set_targetdist / 1850 * math.pi / 10800) * math.cos(set_targetangle * math.pi / 180))
if (math.cos(lat3) == 0) then
lon3 = lon2
else
lon3 = math.mod(lon2 - math.asin(math.sin(set_targetangle * math.pi / 180) * math.sin(set_targetdist / 1850 * math.pi / 10800) / math.cos(lat3)) + math.pi, 2 * math.pi) - math.pi
end
SRP_azimut = math.mod(math.atan2(math.sin(lon1 - lon3) * math.cos(lat3), math.cos(lat1) * math.sin(lat3) - math.sin(lat1) * math.cos(lat3) * math.cos(lon1 - lon3)), 2 * math.pi)
SRP_orbit = (2 * math.asin(math.sqrt((math.sin((lat1 - lat3) / 2)) ^ 2 + math.cos(lat1) * math.cos(lat3) * (math.sin((lon1 - lon3) / 2)) ^ 2)))
if SRP_azimut < 0 then
SRP_azimut = SRP_azimut + 2 * math.pi
end
SRP_azimut = ( SRP_azimut * 180 / math.pi )
SRP_orbit = math.sqrt((SRP_orbit * 10800 / math.pi *  1852)^2 + (get(alt) - elev)^2)

XTK = math.sin( ( set_ZPU - SRP_azimut ) * math.pi / 180) * ( SRP_orbit / 1000 )
end
if mode == 2 or mode == 4 then
XTK = -XTK
end

--2.35 = 4th dot == 5KM
if XTK < 5 and  XTK > -5 then
XTK = XTK * 0.47
elseif XTK > 5 and XTK < 10 then
XTK = XTK * 0.03 + 2.2
elseif XTK < -5 and XTK > -10 then
XTK = XTK * 0.03 - 2.2
elseif XTK > 10 then
XTK = 2.5
else
XTK = -2.5
end

set(rsbn_flag, 1)

set(rsbn_deflection, XTK)

if orbit < ( get(TAS) * 3.6 / 30 * 1000) then
green_lamp = 1
else
green_lamp = 0
end
if ( set_azimut - azimut ) < 1.1 and ( set_azimut - azimut ) > -1.1 and ( orbit - set_orbit ) < 1100 and ( orbit - set_orbit ) > -1100 then
red_lamp = 1
else
red_lamp = 0
end

end
if get(rsbn_receive) ~= 1 then
set(rsbn_flag, 0)
set(rsbn_deflection, 0)
red_lamp = 0
green_lamp = 0
end
end

components = {
	needle {
		position = {636, 135, 150, 150},
		image = get(detailed),
		angle = function()
		return (angle3 - math.floor(angle3 / 10) * 10) * -36
		end
	},
	needle {
		position = {454, 554, 150, 150},
		image = get(detailed),
		angle = function()
		return (angle4 - math.floor(angle4 / 10) * 10) * -36
		end
	},
	needle {
		position = {647, 554, 150, 150},
		image = get(detailed),
		angle = function()
		return (angle5 - math.floor(angle5 / 10) * 10) * -36
		end
	},	
	texture {
		position = {0, 0, 1024, 724},
		image = get(bg),
		visible = true
	},

	--change channel
	needle {
		position = {133, 225, 82, 82},
		image = get(rotary),
		angle = function()
		return channel1 * 4.5 - 90
		end
	},
	clickable {
		position = {131, 225, 41, 82 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		channel1 = channel1 - 10
		return true
		end 
	},	
	
	clickable {
		position = {176, 225, 41, 82 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		channel1 = channel1 + 10
		return true
		end  
	},	
	needle {
		position = {133, 108, 82, 82},
		image = get(rotary),
		angle = function()
		return channel2 * 30 - 60
		end
	},
	clickable {
		position = {131, 108, 41, 82 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		channel2 = channel2 - 1
		return true
		end 
	},	
	
	clickable {
		position = {176, 108, 41, 82 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		channel2 = channel2 + 1
		return true
		end  
	},	
	needle {
		position = {347, 113, 164, 164},
		image = get(rotary),
		angle = function()
		if mode < 5 then return mode * 180 / 7 - 90
		else return 45 end
		end
	},
	clickable {
		position = {345, 146, 82, 164 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		mode = mode - 1
		return true
		end 
	},	
	
	clickable {
		position = {431, 146, 82, 164 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		mode = mode + 1
		return true
		end  
	},	
--power on	
	switch {
		position = { 380, 20, 25, 100},
		state = function()
		return power_sw ~= 0
		end,
		btnOn = get(tmb_up),
		btnOff = get(tmb_dn),
		onMouseClick = function()
		if power_sw ~= 0 then
		power_sw = 0
		else
		power_sw = 1
		end
		return true;
		end
	},
	--set azimuth
	clickable {
		position = {661, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut - 10
		return true
		end 
	},	
	
	clickable {
		position = {737, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut + 10
		return true
		end  
	},	
	clickable {
		position = {687, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut - 1
		return true
		end 
	},	
	
	clickable {
		position = {711, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut + 1
		return true
		end  
	},
	clickable {
		position = {687, 70, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut - 0.1
		return true
		end 
	},	
	
	clickable {
		position = {711, 70, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_azimut = set_azimut + 0.1
		return true
		end  
	},	
	needle {
		position = {664, 167, 93, 93},
		image = get(needle2),
		angle = function()
		return set_azimut
		end
	},
	--set orbit
	clickable {
		position = {888, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_orbit = set_orbit - 500
		return true
		end 
	},	
	
	clickable {
		position = {912, 100, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_orbit = set_orbit + 500
		return true
		end  
	},
	digitstape {
		position = { 841, 178, 140, 35},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		fractional = 1;
		showSign = false;
		value = function()
		return set_orbit / 1000
		end;
		visible = true
	},	
	texture { 
		position = { 837, 177, 148, 37 },
		image = get(glass_cap)
	},
	--red lamps
	textureLit {
		image = get(red_led),
		position = {825, 256, 32, 32},
		visible = function()
		return (get(rsbn_receive) == 0 or get(rsbn_receive) == -1) and power == 1
		end,
	},
	textureLit {
		image = get(red_led),
		position = {958, 256, 32, 32},
		visible = function()
		return (get(rsbn_receive) == 0 or get(rsbn_receive) == -1) and power == 1
		end,
	},
	--set ZPU
	clickable {
		position = {470, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU - 10
		return true
		end 
	},	
	
	clickable {
		position = {556, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU + 10
		return true
		end  
	},	
	clickable {
		position = {504, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU - 1
		return true
		end 
	},	
	
	clickable {
		position = {528, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU + 1
		return true
		end  
	},	
	clickable {
		position = {504, 487, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU - 0.1
		return true
		end 
	},	
	
	clickable {
		position = {528, 487, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_ZPU = set_ZPU + 0.1
		return true
		end  
	},	
	needle {
		position = {482, 586, 93, 93},
		image = get(needle2),
		angle = function()
		return set_ZPU
		end
	},
	--set target angle
	clickable {
		position = {696, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle - 1
		return true
		end 
	},	
	
	clickable {
		position = {720, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle + 1
		return true
		end  
	},	
	clickable {
		position = {696, 487, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle - 0.1
		return true
		end 
	},	
	
	clickable {
		position = {720, 487, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle + 0.1
		return true
		end  
	},	
	clickable {
		position = {670, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle - 10
		return true
		end 
	},	
	
	clickable {
		position = {746, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_targetangle = set_targetangle + 10
		return true
		end  
	},	
	needle {
		position = {675, 586, 93, 93},
		image = get(needle2),
		angle = function()
		return set_targetangle
		end
	},
	--set target distance
	clickable {
		position = {883, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  

		onMouseClick = function()
		set_targetdist = set_targetdist - 500
		return true
		end 
	},	
	
	clickable {
		position = {907, 517, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  

		onMouseClick = function()
		set_targetdist = set_targetdist + 500
		return true
		end  
	},	
	digitstape {
		position = { 837, 620, 140, 35},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		fractional = 1;
		showSign = false;
		value = function()
		return set_targetdist / 1000
		end;
		visible = true
	},	
	texture { 
		position = { 833, 619, 148, 37 },
		image = get(glass_cap)
	},
	--PPDA
	digitstape {
		position = { 166, 624, 61, 17},
		image = digitsImage;
		digits = 4;
		allowNonRound = false;
		showLeadingZeros = true;
		fractional = 1;
		showSign = false;
		value = function()
		return orbit / 1000
		end;
		visible = true
	},	
	needle {
		position = { 112, 509, 169, 169 },
		image = get(needle2),
		angle = function() 
		return angle1
		end,
		visible = true
	}, 
	needle {
		position = { 129, 527, 135, 135 },
		image = get(needle1),
		angle = function() 
		return angle2
		end,
		visible = true
	}, 
	textureLit {
		image = get(green_led),
		position = {82, 412, 32, 32},
		visible = function()
		return green_lamp == 1 and power == 1
		end,
	},
	textureLit {
		image = get(red_led),
		position = {278, 412, 32, 32},
		visible = function()
		return red_lamp == 1 and power == 1
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
		set(rsbn_subpanel, 0 )
		return true
		end
	},
}
