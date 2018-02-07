size = {205, 305}

defineProperty("bg", loadImage("UConvert.dds", 0, 0, 205, 305))
defineProperty("selection", loadImage("UConvert.dds", 5, 315, 48, 20))
defineProperty("digitsImage", loadImage("UPhone.dds", 493, 0, 14, 280))
defineProperty("kg", loadImage("UConvert.dds", 17, 110, 46, 18))
defineProperty("lb", loadImage("UConvert.dds", 17, 140, 46, 18))
defineProperty("km", loadImage("UConvert.dds", 80, 110, 46, 18))
defineProperty("nm", loadImage("UConvert.dds", 80, 140, 46, 18))
defineProperty("mps", loadImage("UConvert.dds", 143, 110, 46, 18))
defineProperty("fpm", loadImage("UConvert.dds", 143, 140, 46, 18))


local input = 10
local output = 10
local unit = 0



function update()
if input < 0 then
input = 0
elseif input > 99900 then
input = 99900
end

if unit == 0 then
output = input * 2.2046
elseif unit == 1 then
output = input * 0.4536
elseif unit == 2 then
output = input * 0.54
elseif unit == 3 then
output = input * 1.852
elseif unit == 4 then
output = input * 196.850
elseif unit == 5 then
output = input * 0.00508
end
end

--0: KG 1:LB 2:KM 3:NM 4:MPS 5:FPM

components = {
	textureLit {
		position = {0, 0, 205, 305},
		image = get(bg),
		visible = true
	},
	
	clickable {
		position = {5, 229, 27, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input - 100
		elseif unit == 2 or unit == 3 then
		input = input - 10
		elseif unit == 4 then
		input = input - 1
		elseif unit == 5 then
		input = input - 1000
		end
		return true
		end   
	},
	
	clickable {
		position = {45, 229, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateleft.png")
		},  
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input - 10
		elseif unit == 2 or unit == 3 then
		input = input - 1
		elseif unit == 4 then
		input = input - 0.1
		elseif unit == 5 then
		input = input - 100
		end
		return true
		end   
	},
	
	clickable {
		position = {140, 229, 20, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input + 10
		elseif unit == 2 or unit == 3 then
		input = input + 1
		elseif unit == 4 then
		input = input + 0.1
		elseif unit == 5 then
		input = input + 100
		end
		return true
		end  
	},
	
	clickable {
		position = {173, 229, 27, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("rotateright.png")
		},  
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input + 100
		elseif unit == 2 or unit == 3 then
		input = input + 10
		elseif unit == 4 then
		input = input + 1
		elseif unit == 5 then
		input = input + 1000
		end
		return true
		end  
	},
	
	--select unit
	--kg
	clickable {
		position = {16, 175, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		onMouseClick = function()
		if unit == 2 or unit == 3 then
		input = input * 10
		elseif unit == 4 then
		input = input * 100
		elseif unit == 5 then
		input = input
		end
		unit = 0
		return true
		end  
	},
	textureLit {
		position = {16, 175, 48, 20},
		image = get(selection),
		visible = function()
		return unit == 0
		end,
	},
	--lb
	clickable {
		position = {16, 145, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		onMouseClick = function()
		if unit == 2 or unit == 3 then
		input = input * 10
		elseif unit == 4 then
		input = input * 100
		elseif unit == 5 then
		input = input
		end
		unit = 1
		return true
		end  
	},
	
	textureLit {
		position = {16, 145, 48, 20},
		image = get(selection),
		visible = function()
		return unit == 1
		end,
	},
	--km
	clickable {
		position = {79, 175, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input / 10
		elseif unit == 4 then
		input = input * 10
		elseif unit == 5 then
		input = input / 10
		end
		unit = 2
		return true
		end  
	},
	textureLit {
		position = {79, 175, 48, 20 },
		image = get(selection),
		visible = function()
		return unit == 2
		end,
	},
	--nm
	clickable {
		position = {79, 145, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input / 10
		elseif unit == 4 then
		input = input * 10
		elseif unit == 5 then
		input = input / 10
		end
		unit = 3
		return true
		end  
	},
	textureLit {
		position = {79, 145, 48, 20 },
		image = get(selection),
		visible = function()
		return unit == 3
		end,
	},
	--mps
	clickable {
		position = {142, 175, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  		
		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input / 100
		elseif unit == 2 or unit == 3 then
		input = input / 10
		elseif unit == 5 then
		input = input / 100
		end
		unit = 4
		return true
		end  
	},
	textureLit {
		position = {142, 175, 48, 20 },
		image = get(selection),
		visible = function()
		return unit == 4
		end,
	},
	--fpm
	clickable {
		position = {142, 145, 48, 20 },
		
		cursor = { 
			x = 16, 
			y = 32,  
			width = 16, 
			height = 16, 
			shape = loadImage("clickable.png")
		},  

		onMouseClick = function()
		if unit == 0 or unit == 1 then
		input = input
		elseif unit == 2 or unit == 3 then
		input = input * 10
		elseif unit == 4 then
		input = input * 100
		end
		unit = 5
		return true
		end  
	},
	textureLit {
		position = {142, 145, 48, 20 },
		image = get(selection),
		visible = function()
		return unit == 5
		end,
	},
	
	--input and output
	digitstapeLit {
		position = { 71, 229, 63, 22},
		image = digitsImage;
		digits = 6;
		allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
		value = function()
		return input
		end;
	},
	
	
	digitstapeLit {
		position = { 71, 62, 63, 22},
		image = digitsImage;
		digits = 6;
		allowNonRound = true;
		showLeadingZeros = false;
		fractional = 1;
		value = function()
		return output
		end;
	},

	--output unit
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(lb),
		visible = function()
		return unit == 0
		end,
	},
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(kg),
		visible = function()
		return unit == 1
		end,
	},
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(nm),
		visible = function()
		return unit == 2
		end,
	},
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(km),
		visible = function()
		return unit == 3
		end,
	},
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(fpm),
		visible = function()
		return unit == 4
		end,
	},
	textureLit {
		position = {144, 63, 46, 18 },
		image = get(mps),
		visible = function()
		return unit == 5
		end,
	},
	
	textureLit {
		position = {143, 62, 48, 20 },
		image = get(selection),
		visible = true
	},
}
